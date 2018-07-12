Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9007C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F9E721479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 11:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F9E721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbeGLL0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 07:26:49 -0400
Received: from nautica.notk.org ([91.121.71.147]:48120 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbeGLL0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 07:26:48 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id C8E8FC009; Thu, 12 Jul 2018 13:17:41 +0200 (CEST)
Date:   Thu, 12 Jul 2018 13:17:26 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] 9p: Replace the fidlist with an IDR
Message-ID: <20180712111726.GA17774@nautica>
References: <20180711210225.19730-1-willy@infradead.org>
 <20180711210225.19730-4-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180711210225.19730-4-willy@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Wed, Jul 11, 2018:
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 389a2904b7b3..b89c7298267c 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -908,30 +908,29 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
>  {
>  	int ret;
>  	struct p9_fid *fid;
> -	unsigned long flags;
>  
>  	p9_debug(P9_DEBUG_FID, "clnt %p\n", clnt);
>  	fid = kmalloc(sizeof(struct p9_fid), GFP_KERNEL);
>  	if (!fid)
>  		return NULL;
>  
> -	ret = p9_idpool_get(clnt->fidpool);
> -	if (ret < 0)
> -		goto error;
> -	fid->fid = ret;
> -
>  	memset(&fid->qid, 0, sizeof(struct p9_qid));

Ah, I had missed that you didn't update this memset as you said in reply
to comment on v1.

Could you resend just this patch and either initialize fid->fid or use
kzalloc for the fid allocation?

>  	fid->mode = -1;
>  	fid->uid = current_fsuid();
>  	fid->clnt = clnt;
>  	fid->rdir = NULL;
> -	spin_lock_irqsave(&clnt->lock, flags);
> -	list_add(&fid->flist, &clnt->fidlist);
> -	spin_unlock_irqrestore(&clnt->lock, flags);
> +	fid->fid = 0;
>  
> -	return fid;
> +	idr_preload(GFP_KERNEL);
> +	spin_lock_irq(&clnt->lock);
> +	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, P9_NOFID - 1,
> +			GFP_NOWAIT);

If you do resend, alignment here was wrong.


Thanks,
-- 
Dominique Martinet
