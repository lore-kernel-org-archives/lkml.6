Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFDFDC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DC42184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 01:54:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfAXByN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 20:54:13 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:36604 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbfAXByN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 20:54:13 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 4CB4A5C0FB6; Thu, 24 Jan 2019 02:53:52 +0100 (CET)
Date:   Thu, 24 Jan 2019 02:53:52 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Steve Wise <swise@opengridcomputing.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Nicholas Mc Guire <hofrat@osadl.org>,
        Doug Ledford <dledford@redhat.com>,
        Raju Rangoju <rajur@chelsio.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] iw_cxgb4: drop check - dead code
Message-ID: <20190124015352.GA30939@osadl.at>
References: <1547947633-10515-1-git-send-email-hofrat@osadl.org>
 <20190123183008.GA15698@ziepe.ca>
 <91af1982-e309-476e-cfa4-2f6ef1ee598b@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91af1982-e309-476e-cfa4-2f6ef1ee598b@opengridcomputing.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 12:45:11PM -0600, Steve Wise wrote:
> 
> 
> On 1/23/2019 12:30 PM, Jason Gunthorpe wrote:
> > On Sun, Jan 20, 2019 at 02:27:13AM +0100, Nicholas Mc Guire wrote:
> >> The kmalloc is called with  | __GFP_NOFAIL  so there is no point in
> >> checking the return value - it either returns valid storage or it would
> >> hang/terminate there. But it is not possible to say if the use of
> >> __GFP_NOFAIL is really needed and the check should be removed or
> >> vice-versa (use of __GFP_NOFAIL should be only in exceptional
> >> cases as I understand it and alloc_srq_queue() is called in quite
> >> a few places)
> >> In either way it would need fixing.
> >>
> >> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> >> Fixes: 6a0b6174d35a ("rdma/cxgb4: Add support for kernel mode SRQ's")
> >> ---
> > 
> > Steve? It seems weird to have NOFAIL and then have an error unwind
> > path, what is the deal here?
> > 
> >> diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> >> index 917ce5c..c2a12ba 100644
> >> --- a/drivers/infiniband/hw/cxgb4/qp.c
> >> +++ b/drivers/infiniband/hw/cxgb4/qp.c
> >> @@ -2597,8 +2597,6 @@ static int alloc_srq_queue(struct c4iw_srq *srq, struct c4iw_dev_ucontext *uctx,
> >>  	wr_len = sizeof(*res_wr) + sizeof(*res);
> >>  
> >>  	skb = alloc_skb(wr_len, GFP_KERNEL | __GFP_NOFAIL);
> >> -	if (!skb)
> >> -		goto err_free_queue;
> >>  	set_wr_txq(skb, CPL_PRIORITY_CONTROL, 0);
> >>  
> >>  	res_wr = (struct fw_ri_res_wr *)__skb_put(skb, wr_len);
> >> -- 
> >> 2.1.4
> >>
> 
> The other queue allocations in qp.c don't use __GFP_NOFAIL.  So either
> leave it and remove the error check as per this patch, or remove the
> NOFAIL and leave the check.
> 
> I suggest you remove the __GFP_NOFAIL, since I have a recollection that
> using it was frowned upon.  In this case, if there is no memory
> available it is reasonable to return that error to the user creating the
> srq...
>
thanks for taking care of this - I simply did not have enough
context to decide if there would be some special reason
for this allocation to need __GFP_NOFAIL - keeping its use
to a minimum though is the best solution.

thx!
hofrat
