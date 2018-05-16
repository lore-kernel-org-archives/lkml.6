Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750935AbeEPOsg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 10:48:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750749AbeEPOsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 10:48:35 -0400
Date: Wed, 16 May 2018 17:48:26 +0300
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Roman Gushchin <guro@fb.com>
Cc: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: cgroup: memcontrol: add basic test for socket
 accounting
References: <1526470089-27010-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180516140332.GA19754@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516140332.GA19754@castle.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18051614-0020-0000-0000-0000041DDAF4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051614-0021-0000-0000-000042B2F85E
Message-Id: <20180516144826.GB23563@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805160150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 03:04:08PM +0100, Roman Gushchin wrote:
> Hi Mike!
> 
> On Wed, May 16, 2018 at 02:28:09PM +0300, Mike Rapoport wrote:
> > The test verifies that with active TCP traffic memory.current and
> > memory.stat.sock have similar values.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > ---
> >  tools/testing/selftests/cgroup/test_memcontrol.c | 184 +++++++++++++++++++++++
> >  1 file changed, 184 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/cgroup/test_memcontrol.c b/tools/testing/selftests/cgroup/test_memcontrol.c
> > index beae06c9c899..0efdb1009175 100644
> > --- a/tools/testing/selftests/cgroup/test_memcontrol.c
> > +++ b/tools/testing/selftests/cgroup/test_memcontrol.c
> > @@ -9,6 +9,12 @@
> >  #include <sys/stat.h>
> >  #include <sys/types.h>
> >  #include <unistd.h>
> > +#include <sys/socket.h>
> > +#include <sys/wait.h>
> > +#include <arpa/inet.h>
> > +#include <netinet/in.h>
> > +#include <netdb.h>
> > +#include <errno.h>
> >  
> >  #include "../kselftest.h"
> >  #include "cgroup_util.h"
> > @@ -772,6 +778,183 @@ static int test_memcg_oom_events(const char *root)
> >  	return ret;
> >  }
> >  
> > +struct tcp_server_args {
> > +	unsigned short port;
> > +	int ctl[2];
> > +};
> > +
> > +static int tcp_server(const char *cgroup, void *arg)
> > +{
> > +	struct tcp_server_args *srv_args = arg;
> > +	struct sockaddr_in6 saddr = { 0 };
> > +	socklen_t slen = sizeof(saddr);
> > +	int sk, client_sk, ctl_fd, yes = 1, ret = -1;
> > +
> > +	close(srv_args->ctl[0]);
> > +	ctl_fd = srv_args->ctl[1];
> > +
> > +	saddr.sin6_family = AF_INET6;
> > +	saddr.sin6_addr = in6addr_any;
> > +	saddr.sin6_port = htons(srv_args->port);
> > +
> > +	sk = socket(AF_INET6, SOCK_STREAM, 0);
> > +	if (sk < 0)
> > +		return ret;
> > +
> > +	if (setsockopt(sk, SOL_SOCKET, SO_REUSEADDR, &yes, sizeof(yes)) < 0)
> > +		goto cleanup;
> > +
> > +	if (bind(sk, (struct sockaddr *)&saddr, slen)) {
> > +		write(ctl_fd, &errno, sizeof(errno));
> > +		goto cleanup;
> > +	}
> > +
> > +	if (listen(sk, 1))
> > +		goto cleanup;
> > +
> > +	ret = 0;
> > +	if (write(ctl_fd, &ret, sizeof(ret)) != sizeof(ret)) {
> > +		ret = -1;
> > +		goto cleanup;
> > +	}
> > +
> > +	client_sk = accept(sk, NULL, NULL);
> > +	if (client_sk < 0)
> > +		goto cleanup;
> > +
> > +	ret = -1;
> > +	for (;;) {
> > +		uint8_t buf[0x100000];
> > +
> > +		if (write(client_sk, buf, sizeof(buf)) <= 0) {
> > +			if (errno == ECONNRESET)
> > +				ret = 0;
> > +			break;
> > +		}
> > +	}
> > +
> > +	close(client_sk);
> > +
> > +cleanup:
> > +	close(sk);
> > +	return ret;
> > +}
> > +
> > +static int tcp_client(const char *cgroup, unsigned short port)
> > +{
> > +	const char server[] = "localhost";
> > +	struct addrinfo *ai;
> > +	char servport[6];
> > +	int retries = 0x10; /* nice round number */
> > +	int sk, ret;
> > +
> > +	snprintf(servport, sizeof(servport), "%hd", port);
> > +	ret = getaddrinfo(server, servport, NULL, &ai);
> > +	if (ret)
> > +		return ret;
> > +
> > +	sk = socket(ai->ai_family, ai->ai_socktype, ai->ai_protocol);
> > +	if (sk < 0)
> > +		goto free_ainfo;
> > +
> > +	ret = connect(sk, ai->ai_addr, ai->ai_addrlen);
> > +	if (ret < 0)
> > +		goto close_sk;
> > +
> > +	ret = KSFT_FAIL;
> > +	while (retries--) {
> > +		uint8_t buf[0x100000];
> > +		long current, sock;
> > +
> > +		if (read(sk, buf, sizeof(buf)) <= 0)
> > +			goto close_sk;
> > +
> > +		current = cg_read_long(cgroup, "memory.current");
> > +		if (current < 0)
> > +			goto close_sk;
> > +
> > +		sock = cg_read_key_long(cgroup, "memory.stat", "sock ");
> > +		if (sock < 0)
> > +			goto close_sk;
> > +
> > +		if (values_close(current, sock, 3)) {
> > +			ret = KSFT_PASS;
> > +			break;
> > +		}
> 
> The test is flapping (at least on my dev machine) because of this condition.
> 
> I believe it's because of the batching we're using on the page charge path.
> So, in theory, it should be possible to calculate the maximum difference
> like num_cpus * PAGE_SIZE * batch_size.

I afraid it's more complex and timing sensitive
 
> Alternatively, just bump allowed error percentage :)

so I'll bump the error percentage :)
 
> > +	}
> > +
> > +close_sk:
> > +	close(sk);
> 
> It would be great to check that sock and current are getting 0 values
> after we're closing the socket.
 
Hmm, here it's also timing sensitive. I can see that sock is reliably
getting 0 if I check it after the server exits. But current usually remains
small but still !0.
 
> Thanks!
> 

-- 
Sincerely yours,
Mike.
