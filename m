Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021C0C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D033208B9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PFWoDJ9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D033208B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeH0WAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:00:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34914 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=N+yGY5lAfeau7xIMpn+MNIIYVS/C9VlEH63oItTbuW4=; b=PFWoDJ9x2EbPS/QkWhWM6enur
        IkdHzkeYZW0Kyy5X15UQyR4V4EoYugeWeOnKz39XUxXLOhJjbyAYrKcUaANxIMB3FHfx8YBHdCUxW
        xoQFzvWVW7jeU3j0Mw2rNAeBpMJwFB5Tn+K/5J31IPL62/6iIfLz/qNjMRdI6PSSPkBqZZZcq5JaH
        IQpMSXtgT3GqKln8HoqjU4M3GnQAPHb1mN5dAY1SUkIPfcAbrE2cmLLjEhppxkww/eVTktsvpbDUu
        arU3SYicyEZ6yNNpLF4oJ+h1NKbfBSRykX+YUaRe6iFbx6sYJURrJf1YhzhOMqEBcQsFppJ1ofVrW
        VckQ9ctqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fuM0l-0006pQ-AS; Mon, 27 Aug 2018 18:13:11 +0000
Date:   Mon, 27 Aug 2018 11:13:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.19-rc1
Message-ID: <20180827181311.GA24778@infradead.org>
References: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
 <20180827134459.GA16094@roeck-us.net>
 <20180827154641.GA17201@infradead.org>
 <20180827171152.GA2705@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827171152.GA2705@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 10:11:52AM -0700, Guenter Roeck wrote:
> When building sparc32 images, this results in the following
> error.
> 
> drivers/base/platform.c: In function 'setup_pdev_archdata':
> drivers/base/platform.c:235:22: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
>    pdev->dev.dma_mask = &pdev->dma_mask;
> 
> pdev->dev.dma_mask is u64 *, pdev->dma_mask is dma_addr_t which in turn
> is either u32 or u64 depending on the architecture.

Yes, I've fixed this up to be a u64.

> 
> > +++ b/include/linux/platform_device.h
> > @@ -25,6 +25,7 @@ struct platform_device {
> >  	int		id;
> >  	bool		id_auto;
> >  	struct device	dev;
> > +	dma_addr_t	dma_mask;
> 
> ... so this will have to be u64, or the pointer in struct device would
> have to be fixed.
> 
> However, even changing the definition to u64 does not help: The warnings
> are still reported. This is because setup_pdev_archdata() is not called
> for any of the affected devices. That is kind of interesting since it
> means that arch_setup_pdev_archdata() won't be called for those devices
> either.

Yeah, this is odd.  I'll need some more time to figure out where
the platform devices for sbus are allocated.
