Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966556AbeEJQK3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 12:10:29 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45762 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964877AbeEJQK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 12:10:27 -0400
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: linux-next: build warning after merge of the nfsd tree
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20180510152410.GB29678@fieldses.org>
Date: Thu, 10 May 2018 12:10:18 -0400
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <401FFD11-BAF8-4C2E-8596-0BA734C8EDD5@oracle.com>
References: <20180510104213.31c41377@canb.auug.org.au>
 <4A03C3E8-6DBA-4FDA-A5C3-46D9E678FC02@oracle.com>
 <20180510152410.GB29678@fieldses.org>
To: Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8888 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805100152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4AGAWs4012043



> On May 10, 2018, at 11:24 AM, Bruce Fields <bfields@fieldses.org> wrote:
> 
> On Thu, May 10, 2018 at 10:21:05AM -0400, Chuck Lever wrote:
>> 
>> 
>>> On May 9, 2018, at 8:42 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>> 
>>> Hi all,
>>> 
>>> After merging the nfsd tree, today's linux-next build (powerpc
>>> ppc64_defconfig) produced this warning:
>>> 
>>> net/sunrpc/xprtrdma/svc_rdma_transport.c: In function 'rdma_listen_handler':
>>> net/sunrpc/xprtrdma/svc_rdma_transport.c:299:23: warning: unused variable 'rdma' [-Wunused-variable]
>>> struct svcxprt_rdma *rdma = cma_id->context;
>>>                      ^~~~
>> 
>> Needs to be wrapped with "#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)"
>> Would you like me to send a patch?
> 
> Any objection to saving the #if and just going back to writing out
> cma_id->context there?

LGTM

That's not really very useful information anyway, but I decided
to leave this stuff mostly as-is for now. I plan to do something
to fix races between disconnect and device removal at some point.


> I've done that in my tree.
> 
> --b.
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index ca9001d73456..05edb18f8ca3 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -544,7 +544,6 @@ static int rdma_listen_handler(struct rdma_cm_id *cma_id,
> 			       struct rdma_cm_event *event)
> {
> 	struct sockaddr *sap = (struct sockaddr *)&cma_id->route.addr.src_addr;
> -	struct svcxprt_rdma *rdma = cma_id->context;
> 	int ret = 0;
> 
> 	trace_svcrdma_cm_event(event, sap);
> @@ -552,7 +551,7 @@ static int rdma_listen_handler(struct rdma_cm_id *cma_id,
> 	switch (event->event) {
> 	case RDMA_CM_EVENT_CONNECT_REQUEST:
> 		dprintk("svcrdma: Connect request on cma_id=%p, xprt = %p, "
> -			"event = %s (%d)\n", cma_id, rdma,
> +			"event = %s (%d)\n", cma_id, cma_id->context,
> 			rdma_event_msg(event->event), event->event);
> 		handle_connect_req(cma_id, &event->param.conn);
> 		break;

--
Chuck Lever
