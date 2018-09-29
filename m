Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16146C64E93
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB87420880
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 10:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB87420880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbeI2Q7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 12:59:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727756AbeI2Q7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 12:59:44 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8TAThUN033619
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 06:31:49 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mt5d53fk5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 06:31:49 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Sat, 29 Sep 2018 11:31:47 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 29 Sep 2018 11:31:43 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w8TAVgj360227646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 29 Sep 2018 10:31:42 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1112FA4040;
        Sat, 29 Sep 2018 13:31:22 +0100 (BST)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2EDEA4051;
        Sat, 29 Sep 2018 13:31:20 +0100 (BST)
Received: from rapoport-lnx (unknown [9.148.207.35])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 29 Sep 2018 13:31:20 +0100 (BST)
Date:   Sat, 29 Sep 2018 13:31:39 +0300
From:   Mike Rapoport <rppt@linux.vnet.ibm.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        Zi Yan <zi.yan@cs.rutgers.edu>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kselftest@vger.kernel.org, Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/3] userfaultfd: selftest: generalize read and poll
References: <20180929084311.15600-1-peterx@redhat.com>
 <20180929084311.15600-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180929084311.15600-3-peterx@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18092910-4275-0000-0000-000002C29B2C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18092910-4276-0000-0000-000037CDA123
Message-Id: <20180929103138.GB6429@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809290111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 29, 2018 at 04:43:10PM +0800, Peter Xu wrote:
> We do very similar things in read and poll modes, but we're copying the
> codes around.  Share the codes properly on reading the message and
> handling the page fault to make the code cleaner.  Meanwhile this solves
> previous mismatch of behaviors between the two modes on that the old
> code:
> 
> - did not check EAGAIN case in read() mode
> - ignored BOUNCE_VERIFY check in read() mode
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/vm/userfaultfd.c | 76 +++++++++++++-----------
>  1 file changed, 42 insertions(+), 34 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
> index 2a84adaf8cf8..f79706f13ce7 100644
> --- a/tools/testing/selftests/vm/userfaultfd.c
> +++ b/tools/testing/selftests/vm/userfaultfd.c
> @@ -449,6 +449,42 @@ static int copy_page(int ufd, unsigned long offset)
>  	return __copy_page(ufd, offset, false);
>  }
> 
> +static int uffd_read_msg(int ufd, struct uffd_msg *msg)
> +{
> +	int ret = read(uffd, msg, sizeof(*msg));
> +
> +	if (ret != sizeof(*msg)) {
> +		if (ret < 0)

I'd appreciate curly brace here

> +			if (errno == EAGAIN)
> +				return 1;
> +			else
> +				perror("blocking read error"), exit(1);
> +		else

and here

> +				fprintf(stderr, "short read\n"), exit(1);
> +	}
> +
> +	return 0;
> +}
> +
> +/* Return 1 if page fault handled by us; otherwise 0 */
> +static int uffd_handle_page_fault(struct uffd_msg *msg)
> +{
> +	unsigned long offset;
> +
> +	if (msg->event != UFFD_EVENT_PAGEFAULT)
> +		fprintf(stderr, "unexpected msg event %u\n",
> +			msg->event), exit(1);
> +
> +	if (bounces & BOUNCE_VERIFY &&
> +	    msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
> +		fprintf(stderr, "unexpected write fault\n"), exit(1);
> +
> +	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
> +	offset &= ~(page_size-1);
> +
> +	return copy_page(uffd, offset);
> +}
> +
>  static void *uffd_poll_thread(void *arg)
>  {
>  	unsigned long cpu = (unsigned long) arg;
> @@ -456,7 +492,6 @@ static void *uffd_poll_thread(void *arg)
>  	struct uffd_msg msg;
>  	struct uffdio_register uffd_reg;
>  	int ret;
> -	unsigned long offset;
>  	char tmp_chr;
>  	unsigned long userfaults = 0;
> 
> @@ -480,25 +515,15 @@ static void *uffd_poll_thread(void *arg)
>  		if (!(pollfd[0].revents & POLLIN))
>  			fprintf(stderr, "pollfd[0].revents %d\n",
>  				pollfd[0].revents), exit(1);
> -		ret = read(uffd, &msg, sizeof(msg));
> -		if (ret < 0) {
> -			if (errno == EAGAIN)
> -				continue;
> -			perror("nonblocking read error"), exit(1);
> -		}
> +		if (uffd_read_msg(uffd, &msg))
> +			continue;
>  		switch (msg.event) {
>  		default:
>  			fprintf(stderr, "unexpected msg event %u\n",
>  				msg.event), exit(1);
>  			break;
>  		case UFFD_EVENT_PAGEFAULT:
> -			if (msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
> -				fprintf(stderr, "unexpected write fault\n"), exit(1);
> -			offset = (char *)(unsigned long)msg.arg.pagefault.address -
> -				area_dst;
> -			offset &= ~(page_size-1);
> -			if (copy_page(uffd, offset))
> -				userfaults++;
> +			userfaults += uffd_handle_page_fault(&msg);
>  			break;
>  		case UFFD_EVENT_FORK:
>  			close(uffd);
> @@ -526,8 +551,6 @@ static void *uffd_read_thread(void *arg)
>  {
>  	unsigned long *this_cpu_userfaults;
>  	struct uffd_msg msg;
> -	unsigned long offset;
> -	int ret;
> 
>  	this_cpu_userfaults = (unsigned long *) arg;
>  	*this_cpu_userfaults = 0;
> @@ -536,24 +559,9 @@ static void *uffd_read_thread(void *arg)
>  	/* from here cancellation is ok */
> 
>  	for (;;) {
> -		ret = read(uffd, &msg, sizeof(msg));
> -		if (ret != sizeof(msg)) {
> -			if (ret < 0)
> -				perror("blocking read error"), exit(1);
> -			else
> -				fprintf(stderr, "short read\n"), exit(1);
> -		}
> -		if (msg.event != UFFD_EVENT_PAGEFAULT)
> -			fprintf(stderr, "unexpected msg event %u\n",
> -				msg.event), exit(1);
> -		if (bounces & BOUNCE_VERIFY &&
> -		    msg.arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
> -			fprintf(stderr, "unexpected write fault\n"), exit(1);
> -		offset = (char *)(unsigned long)msg.arg.pagefault.address -
> -			 area_dst;
> -		offset &= ~(page_size-1);
> -		if (copy_page(uffd, offset))
> -			(*this_cpu_userfaults)++;
> +		if (uffd_read_msg(uffd, &msg))
> +			continue;
> +		(*this_cpu_userfaults) += uffd_handle_page_fault(&msg);
>  	}
>  	return (void *)NULL;
>  }
> -- 
> 2.17.1
> 

-- 
Sincerely yours,
Mike.

