Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE96C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12055208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TRt+YZvm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12055208A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbeGaEZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:25:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48842 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeGaEZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Zr+F6RYVPgNL6IQ9BUEwEwrNpaBRlRdWz/krJo34lYI=; b=TRt+YZvmRcsTxoJw27uN//IK5
        CWL3ywCGocmTecZTj4eEaEcKfPggrckzhjLJNU57YczVU8dF/fmI+Q5HcLVAOu1C31YHl2R3KnaOU
        fLd474xgLf7WsFpbE2FrAOWRViVy2WMRtuti8Rd5mq52RNMgJjXBcbi89VdUvhkJAccF7LzcT8N8q
        0J7+MWr81uDbc99+x3yl8gy+geaVHatFkGgE2MWz/Oj946ANYVBYSgz0p1NSAA648reNflQ4wE2lM
        lrebxa1I6bxTwjRmVlir5OilU9eTwEHA3kPcX/LlUSNG1A7feOEGznhO8szO/iEBAFxfzNAZuYVlW
        k2vjpKzzg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fkKgd-0001GW-1Z; Tue, 31 Jul 2018 02:46:59 +0000
Date:   Mon, 30 Jul 2018 19:46:58 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net, Greg Kurz <groug@kaod.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] net/9p: add a per-client fcall kmem_cache
Message-ID: <20180731024658.GC19692@bombadil.infradead.org>
References: <20180730093101.GA7894@nautica>
 <1532943263-24378-1-git-send-email-asmadeus@codewreck.org>
 <1532943263-24378-2-git-send-email-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532943263-24378-2-git-send-email-asmadeus@codewreck.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 11:34:23AM +0200, Dominique Martinet wrote:
> -static int p9_fcall_alloc(struct p9_fcall *fc, int alloc_msize)
> +static int p9_fcall_alloc(struct p9_client *c, struct p9_fcall *fc,
> +			  int alloc_msize)
>  {
> -	fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
> +	if (c->fcall_cache && alloc_msize == c->msize)
> +		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
> +	else
> +		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);

Could you simplify this by initialising c->msize to 0 and then this
can simply be:

> +	if (alloc_msize == c->msize)
...

> +void p9_fcall_free(struct p9_client *c, struct p9_fcall *fc)
> +{
> +	/* sdata can be NULL for interrupted requests in trans_rdma,
> +	 * and kmem_cache_free does not do NULL-check for us
> +	 */
> +	if (unlikely(!fc->sdata))
> +		return;
> +
> +	if (c->fcall_cache && fc->capacity == c->msize)
> +		kmem_cache_free(c->fcall_cache, fc->sdata);
> +	else
> +		kfree(fc->sdata);
> +}

Is it possible for fcall_cache to be allocated before fcall_free is
called?  I'm concerned we might do this:

allocate message A
allocate message B
receive response A
allocate fcall_cache
receive response B

and then we'd call kmem_cache_free() for something allocated by kmalloc(),
which works with slab and slub, but doesn't work with slob (alas).

> @@ -980,6 +1000,9 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  	if (err)
>  		goto close_trans;
>  
> +	clnt->fcall_cache = kmem_cache_create("9p-fcall-cache", clnt->msize,
> +					      0, 0, NULL);
> +

If we have slab merging turned off, or we have two mounts from servers
with different msizes, we'll end up with two slabs called 9p-fcall-cache.
I'm OK with that, but are you?

