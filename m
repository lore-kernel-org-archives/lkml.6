Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CA3ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F44C2147E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QVXffLfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F44C2147E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbeGMDAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:00:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732923AbeGMDAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=upsDaVYr4rZ3D+LarCC6C9YldBYSxICBHoISUkIto7k=; b=QVXffLfu/nrxlC2ufp2TytjxG
        sxEB4Umc5ix6bU3L71diuDtEzq0KD80Pwsv8QppHRBVO+736N4cAIB+nfpfzDPBNYMAB11PQTTwHL
        hT70WGcx8IfJU7EVf7PAVJ2GOMxA12B/GfOyFqqd7zX4v4IkyN4dcECEteGcENQ6NLPbi8PGVrnoJ
        Uh9qWmGEEW2i2QGdN4COPx85zPWGHfnNxNlTDjmKsTQg1T3zIr8SsCIcsBzB1o1DVSLA3LzaaehIv
        pN7zmRDdM/GTjuHyKs3oAGaxe9LV7emXkUGe6Z1PoIBkon23BKzMyJOPVNJr4MXbsOhVlvyTeWo5Z
        p7FVNGMOA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdo7n-0006LR-ET; Fri, 13 Jul 2018 02:48:03 +0000
Date:   Thu, 12 Jul 2018 19:48:03 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     jiangyiwen <jiangyiwen@huawei.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, Ron Minnich <rminnich@sandia.gov>,
        linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net
Subject: Re: [V9fs-developer] [PATCH v2 3/6] 9p: Replace the fidlist with an
 IDR
Message-ID: <20180713024803.GA2860@bombadil.infradead.org>
References: <20180711210225.19730-1-willy@infradead.org>
 <20180711210225.19730-4-willy@infradead.org>
 <5B4808FE.7010500@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B4808FE.7010500@huawei.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 10:05:50AM +0800, jiangyiwen wrote:
> > @@ -908,30 +908,29 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
> >  {
> >  	int ret;
> >  	struct p9_fid *fid;
> > -	unsigned long flags;
> >  
> >  	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
> >  	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);
> >  	if (!fid)
> >  		return NULL;
> >  
> > -	ret = p9_idpool_get(clnt->fidpool);
> > -	if (ret < 0)
> > -		goto error;
> > -	fid->fid = ret;
> > -
> >  	memset(&fid->qid, 0, sizeof(struct p9_qid));
> >  	fid->mode = -1;
> >  	fid->uid = current_fsuid();
> >  	fid->clnt = clnt;
> >  	fid->rdir = NULL;
> > -	spin_lock_irqsave(&clnt->lock, flags);
> > -	list_add(&fid->flist, &clnt->fidlist);
> > -	spin_unlock_irqrestore(&clnt->lock, flags);
> > +	fid->fid = 0;
> >  
> > -	return fid;
> > +	idr_preload(GFP_KERNEL);
> 
> It is best to use GFP_NOFS instead, or else it may cause some
> unpredictable problem, because when out of memory it will
> reclaim memory from v9fs.

Earlier in this function, fid was allocated with GFP_KERNEL:

> >  	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);


> > +	spin_lock_irq(&clnt->lock);
> > +	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
> > +			GFP_NOWAIT);
> > +	spin_unlock_irq(&clnt->lock);
> 
> use spin_lock instead, clnt->lock is not used in irq context.

I don't think that's right.  What about p9_fid_destroy?  It was already
using spin_lock_irqsave(), so I just assumed that whoever wrote that
code at least considered that it might be called from interrupt context.

Also consider p9_free_req() which shares the same lock.  We could get
rid of clnt->lock altogether as there's a lock embedded in each IDR,
but that'll introduce an unwanted dependence on the RDMA tree in this
merge window.

> > @@ -1095,14 +1086,11 @@ void p9_client_destroy(struct p9_client *clnt)
> >  
> >  	v9fs_put_trans(clnt->trans_mod);
> >  
> > -	list_for_each_entry_safe(fid, fidptr, &clnt->fidlist, flist) {
> > +	idr_for_each_entry(&clnt->fids, fid, id) {
> >  		pr_info("Found fid %d not clunked\n", fid->fid);
> >  		p9_fid_destroy(fid);
> >  	}
> >  
> > -	if (clnt->fidpool)
> > -		p9_idpool_destroy(clnt->fidpool);
> > -
> 
> I suggest add idr_destroy in the end.

Why?  p9_fid_destroy calls idr_remove() for each fid, so it'll already
be empty.

Thanks for all the review, to everyone who's submitted review.  This is
a really healthy community.
