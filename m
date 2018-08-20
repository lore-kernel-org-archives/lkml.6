Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C2BC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2B62152D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 06:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gCv2HkzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2B62152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbeHTJhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 05:37:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48082 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeHTJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 05:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ty1i59lLQIOumb6ra5mWlyUebheLVKRTqb0SYJxYM1k=; b=gCv2HkzRPvOdZF2wEKvWEi7PY
        tsHXB5U0Zwvpr7bWFAbEBn1sGh4FGaLooZpBMaK0hzw5SYwRyVCx6hKjv2t3lm3rlm50aRpoVz19N
        06VbTglJWFJ3w3k8BBjGR4hg1Oga1NCrFo6nlqIr8C22cQ7zuijrrfeOpwiv1nVb1iM765Y3ryK1Z
        qrdwxUIwjyuKJrf9WESCcBh9PyCf35Hf7rh4HvomMGMIApFn4Fo6ejFgwP7jh7sO/YyYDiHXNEXk0
        eT+KS7mQ8fHcJE7i8YS17tgc1QfMSb16Ne3TthOmDTlWpEDxUh0S1x+E99a5bLats6hGGsW4X6zd5
        cYodpDHZg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1frdb4-0006Jq-9c; Mon, 20 Aug 2018 06:23:26 +0000
Date:   Sun, 19 Aug 2018 23:23:26 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     David Miller <davem@davemloft.net>
Cc:     brian.brooks@linaro.org, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, ymarkman@marvell.com,
        stefanc@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.topel@intel.com,
        brian.brooks@arm.com
Subject: Re: [PATCH] net: mvpp2: avoid bouncing buffers
Message-ID: <20180820062326.GA22222@infradead.org>
References: <20180820024730.9147-1-brian.brooks@linaro.org>
 <20180819.195505.1988137313680465320.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180819.195505.1988137313680465320.davem@davemloft.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 19, 2018 at 07:55:05PM -0700, David Miller wrote:
> From: Brian Brooks <brian.brooks@linaro.org>
> Date: Sun, 19 Aug 2018 21:47:30 -0500
> 
> > @@ -5126,6 +5126,12 @@ static int mvpp2_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	if (priv->hw_version == MVPP22) {
> > +		/* Platform code may have set dev->dma_mask to point
> > +		 * to dev->coherent_dma_mask, but we want to ensure
> > +		 * they take different values due to comment below.
> > +		 */
> > +		pdev->dev.dma_mask = &priv->dma_mask;
> 
> The platform code might be doing this exactly because it cannot support
> different coherent and streaming DMA masks.
> 
> Well, in any case, the platform code is doing it for a reason and
> overriding this in a "driver" of all places seems totally
> inappropriate and at best a layering violation.
> 
> I would rather you fix this in a way that involves well defined APIs
> that set the DMA masks or whatever to the values that you need, rather
> than going behind the platform code's back and changing the DMA mask
> pointer like this.

Agreed.  What platform do you see this issue on?
