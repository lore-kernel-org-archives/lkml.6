Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F7EC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48BC220855
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EIVbEhV5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfAUIau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:30:50 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728554AbfAUIat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=lUXa8TKYTWwiVoFEB59+4Xq3RtYVOyUJ2dCrT/YnWEE=; b=EIVbEhV5K2cchUORGpp1F11H3
        Dtqhj3aIhEqVJ6cr9fijkOEeo299enoqDL6tW2IYxiAUIHkguMlmx/I4+NMkGMIUvMSqNnDw6/ZBS
        FHHx/PgH6h/zNKwXiBxfXa8DBR5CvxcFxxYwSXG1wXnsYy4EJZwR3dXSwjlzsaqLjMMOco3XWmqIT
        /Gu8EaXH4SPxm94WAqW55Iuz5foX7JXE7A/fPEfOzVW6Ztr4+FbJPpLIZYj8GX6jY2GZkYQS/eZfR
        Hu25gXqBliZeU4aJ/WChsUyXNjWq94R/aj8w8uL5rCfxKByVt9NV2t0IBDsUaFJUXEVhfNFMCxN+s
        xmbaNnvYg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1glUyk-0005Pq-Os; Mon, 21 Jan 2019 08:30:46 +0000
Date:   Mon, 21 Jan 2019 00:30:46 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Liam Mark <lmark@codeaurora.org>, sumit.semwal@linaro.org,
        arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        afd@ti.com, john.stultz@linaro.org
Subject: Re: [PATCH 3/4] dma-buf: add support for mapping with dma mapping
 attributes
Message-ID: <20190121083046.GD12420@infradead.org>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-4-git-send-email-lmark@codeaurora.org>
 <20190119102527.GA17723@infradead.org>
 <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae73c39-9049-bcf6-775f-b0817ba0ec5f@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 08:50:41AM -0800, Laura Abbott wrote:
> > And who is going to decide which ones to pass?  And who documents
> > which ones are safe?
> > 
> > I'd much rather have explicit, well documented dma-buf flags that
> > might get translated to the DMA API flags, which are not error checked,
> > not very well documented and way to easy to get wrong.
> > 
> 
> I'm not sure having flags in dma-buf really solves anything
> given drivers can use the attributes directly with dma_map
> anyway, which is what we're looking to do. The intention
> is for the driver creating the dma_buf attachment to have
> the knowledge of which flags to use.

Well, there are very few flags that you can simply use for all calls of
dma_map*.  And given how badly these flags are defined I just don't want
people to add more places where they indirectly use these flags, as
it will be more than enough work to clean up the current mess.

What flag(s) do you want to pass this way, btw?  Maybe that is where
the problem is.
