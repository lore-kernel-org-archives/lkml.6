Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D04C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52F8A2084A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 12:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MffiXvQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F8A2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732971AbeGKM4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 08:56:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41154 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeGKM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 08:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=DI0JlLfOsUYkXVK2q0VUAzsD6xYqZqtR0psnDJjQvPc=; b=MffiXvQehfPl/lZmbKuEJwCX5
        WS4k2/LAmNZeQasGJrqQn63eFCjhhQL1jsdhn8ydYE7odwPrDxxdac+TDXg2DIP45446SBStgzSzq
        JZw13EF3wjMF/zhEtdpnWAAFzj/EjIoICMTeY8k5zcwg1sW8oDb+nZhWV8TWrvOG+eeZyYckxuNOf
        w1VrHjgU0ZtH+PP2DjMOeFjXIRLKNzsLgOn/UD24jn3vPoV4hkKHJbdaoE/wESLgnviAm1mmadJaT
        WQQpg0nnr/X/iMl0QEM1nQpwTMmA8UA2Hl/3kXsIZg85nwwOcgXMN4WbdqCkK36cRur0iE/+myo/G
        pu71aUsng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fdEbU-0008Ha-5p; Wed, 11 Jul 2018 12:52:20 +0000
Date:   Wed, 11 Jul 2018 05:52:19 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ron Minnich <rminnich@sandia.gov>
Subject: Re: [V9fs-developer] [PATCH 2/6] 9p: Replace the fidlist with an IDR
Message-ID: <20180711125219.GA23640@bombadil.infradead.org>
References: <20180628132629.3148-1-willy@infradead.org>
 <20180628132629.3148-3-willy@infradead.org>
 <20180711124038.GB835@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180711124038.GB835@nautica>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 02:40:38PM +0200, Dominique Martinet wrote:
> Matthew Wilcox wrote on Thu, Jun 28, 2018:
> > diff --git a/net/9p/client.c b/net/9p/client.c
> > index f8d58b0852fe..bbab82f22c20 100644
> > --- a/net/9p/client.c
> > +++ b/net/9p/client.c
> > @@ -908,30 +908,27 @@ static struct p9_fid *p9_fid_create(struct p9_client *clnt)
> > -	ret = p9_idpool_get(clnt->fidpool);
> > -	if (ret < 0)
> > -		goto error;
> > -	fid->fid = ret;
> > -
...
> > +	idr_preload(GFP_KERNEL);
> > +	spin_lock_irq(&clnt->lock);
> > +	ret = idr_alloc_u32(&clnt->fids, fid, &fid->fid, UINT_MAX, GFP_NOWAIT);
> 
> There's also a P9_NOFID that we shouldn't use, so the max here should be
> P9_NOFID - 1

Happy to fix that.  It shouldn't actually happen, of course.  I can't
imagine us having 4 billion FIDs in use at once.

> That aside this introduces a change of behaviour that fid used to be
> alloc'd linearily from 0 which no longer holds true, that breaks one
> serveur (nfs-ganesha just returns ERANGE) but others seem to handle this
> just fine so they'll just need to fix that server.
> max aside this looks good.

I don't understand your assertion that this is a change of behaviour.
The implementation of p9_idpool_get() uses idr_alloc(), not
idr_alloc_cyclic(), so I don't believe I've changed which FID would
be allocated.
