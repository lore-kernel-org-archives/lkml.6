Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9780C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA16D20878
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA16D20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbeGKMpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:45:04 -0400
Received: from nautica.notk.org ([91.121.71.147]:41120 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbeGKMpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:45:04 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id EB7E8C009; Wed, 11 Jul 2018 14:40:53 +0200 (CEST)
Date:   Wed, 11 Jul 2018 14:40:38 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 2/6] 9p: Replace the fidlist with an IDR
Message-ID: <20180711124038.GB835@nautica>
References: <20180628132629.3148-1-willy@infradead.org>
 <20180628132629.3148-3-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180628132629.3148-3-willy@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote on Thu, Jun 28, 2018:
> diff --git a/net/9p/client.c b/net/9p/client.c
> index f8d58b0852fe..bbab82f22c20 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -908,30 +908,27 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
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
>  	fid->mode = -1;
>  	fid->uid = current_fsuid();
>  	fid->clnt = clnt;
>  	fid->rdir = NULL;
> -	spin_lock_irqsave(&clnt->lock, flags);
> -	list_add(&fid->flist, &clnt->fidlist);
> -	spin_unlock_irqrestore(&clnt->lock, flags);
>  
> -	return fid;
> +	idr_preload(GFP_KERNEL);
> +	spin_lock_irq(&clnt->lock);
> +	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, UINT_MAX, GFP_NOWAIT);

There's also a P9_NOFID that we shouldn't use, so the max here should be
P9_NOFID - 1

That aside this introduces a change of behaviour that fid used to be
alloc'd linearily from 0 which no longer holds true, that breaks one
serveur (nfs-ganesha just returns ERANGE) but others seem to handle this
just fine so they'll just need to fix that server.
max aside this looks good.

-- 
Dominique Martinet
