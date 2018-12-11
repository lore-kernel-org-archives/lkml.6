Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CBCC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6EA20811
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 18:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZcblGBm/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA6EA20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbeLKSp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:45:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbeLKSp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 13:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=OFsjesJxwe0Vvh/qsKmn4MXZMHYRnB7GtkkpOsO61XI=; b=ZcblGBm/Tk8pwHw5+ww7dWvIO
        7rcL1m1gTmUPj9rERTMhZl++9JL4OqEX9uclu5Y5OoyXLfVlNPcBZ2xGQ9cy+xIuKvMAjKwBssqnc
        F0Cc28AwPe0liA4rjsDnQv04lEu3DbbcrKvNorM/+SksGl93+bQMuD8XWNNOCqUljBW+8xd3lsU43
        9TzaQvY6YSjDP1D5GOQzCWtXKcrA92p3V5em2j1ZXchfyE9VRB2shRhNk4iJ581x3JhToiuhT9Asu
        bq/R7ZYRSq4H/SbpAJVNNYn3rEth3OPdiKNhTri6fczikfxRQUbuwH6arXvglHV7dDNNN4iVfrflJ
        masn1Uh+A==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gWn2X-00073W-SE; Tue, 11 Dec 2018 18:45:53 +0000
Date:   Tue, 11 Dec 2018 10:45:53 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>, linux-aio@kvack.org,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] aio: Convert ioctx_table to XArray
Message-ID: <20181211184553.GH6830@bombadil.infradead.org>
References: <20181128183531.5139-1-willy@infradead.org>
 <09e3d156-66fc-ca17-efac-63f080a27a1d@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09e3d156-66fc-ca17-efac-63f080a27a1d@kernel.dk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2018 at 11:41:55AM -0700, Jens Axboe wrote:
> On Wed, Nov 28, 2018 at 11:35 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> >         rcu_read_lock();
> > -       table = rcu_dereference(mm->ioctx_table);
> > -
> > -       if (!table || id >= table->nr)
> > -               goto out;
> > -
> > -       ctx = rcu_dereference(table->table[id]);
> > +       ctx = xa_load(&mm->ioctx, id);
> >         if (ctx && ctx->user_id == ctx_id) {
> >                 if (percpu_ref_tryget_live(&ctx->users))
> >                         ret = ctx;
> >         }
> 
> Question on this part - do we need that RCU read lock around this now? I
> don't think we do.

I think we need the rcu read lock here to prevent ctx from being freed
under us by free_ioctx().
