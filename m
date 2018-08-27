Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D653FC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AAE4208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svrl+bBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AAE4208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeH0U7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 16:59:22 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41426 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbeH0U7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 16:59:22 -0400
Received: by mail-oi0-f65.google.com with SMTP id k12-v6so28586279oiw.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FOduJP7uZPkSeGmomrOzf3gRax1fjxg0ERp2igguX5Q=;
        b=Svrl+bBlLOuOXeRvskABqRWRLXE5s9qz64lHU4cd6RPs4BFLZsWkE30YeH/Kb0ZLYD
         14fZkE7+3mu1ohZ+UFNnH4uzHZqeCIbUWDRqABrfbdeQv869L1UtFrmGBr4r/D2ILFTI
         8qspBriPcUfSHIwqQQU5cwZjAPVVuf9zYLto2AWgmTka07qnILHY/44Hvd4lD20k/GlJ
         gALlBnyt7oXEeIk6XHwlaX0zUCYsIoyrzAXKDo/ep5Qm+zdAwKxPCHalFSh+1ujaGIm9
         Kzt2DIl+Z9VKa1w36luD0CKLHIuW0calzhs3efPM1O1siuNWA3VPcS5qPjBUjSoBbTKD
         5t7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FOduJP7uZPkSeGmomrOzf3gRax1fjxg0ERp2igguX5Q=;
        b=WLwoWf3pcyZiebX8snF6g6jrE3GuX7pidxx6kteb4SK/0zYXrlEDhjoXFOz2ApxBuN
         be6nqEs4BpUlnCnb7SL05p0YN0BG0rREEE5bsYNP/T5SCI2x7JJ2IrBz6ptAZCs2f2pY
         8GyTtZ/wdJfI/c3mIMub6YI5nVkbQMxfSJjb50a4ZJhyPA5DCzupvlKVaVLbO7IKhPD1
         trnr65+SEuvHjj+mCiCoUIat1nwdmmTiqV0Ykum24ivqg5LV4Bfmi4NhmnGHrWNyuYw+
         fzSvB/esZVvhHsIjnxmuMT47Awegi8wAOWelX2m6CHcbbsLVJ3wgPYj0gIyjKlpbopX9
         +1KQ==
X-Gm-Message-State: APzg51Bh0u4yjVLRI0pT88TOLTe5mk3snT7syJZzVqhK+wLRD6YXjyOl
        +wbdwNkp4YpiLP4pyr5qjFK4qL+T
X-Google-Smtp-Source: ANB0Vdb/smAABG1KaD9f1jJ1lDcq/yoP/BMkLNwsBd6Z01jeVEczam4JFw8hHU4h1cibHmugzvOXIw==
X-Received: by 2002:aca:7513:: with SMTP id q19-v6mr12203953oic.13.1535389915235;
        Mon, 27 Aug 2018 10:11:55 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m7-v6sm10029920oia.32.2018.08.27.10.11.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 10:11:54 -0700 (PDT)
Date:   Mon, 27 Aug 2018 10:11:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 4.19-rc1
Message-ID: <20180827171152.GA2705@roeck-us.net>
References: <CA+55aFw9mxNPX6OtOp-aoUMdXSg=gBkQudGGamo__sh_ts_LdQ@mail.gmail.com>
 <20180827134459.GA16094@roeck-us.net>
 <20180827154641.GA17201@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180827154641.GA17201@infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 08:46:41AM -0700, Christoph Hellwig wrote:
> > sparc:
> > 
> > WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 esp_sbus_probe+0x408/0x6e8
> > WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 sparc_lance_probe_one+0x428/0x4f
> > 
> > Missing initialization of coherent_dma_mask in the respective drivers.
> > 
> > ---
> > Each platform driver instantiated through a devicetree node now generates
> > the following warning:
> > 
> > esp ffd38e00: DMA mask not set
> > 
> > It isn't a traceback so it may fly under the radar. There is nothing the
> > drivers can do about it; the message is generated by the core before the
> > driver probe function is called. No idea what a correct fix might be.
> 
> Both of these should probably be fixed by something like the patch
> below:
> 
> ---
> From 6294e0e330851ee06e66ab85b348f1d92d375d7a Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 27 Aug 2018 17:23:24 +0200
> Subject: driver core: initialize a default DMA mask for platform device
> 
> We still treat devices without a DMA mask as defaulting to 32-bits for
> both mask, but a few releases ago we've started warning about such
> cases, as they require special cases to work around this sloppyness.
> Add a dma_mask field to struct platform_object so that we can initialize
> the dma_mask pointer in struct device and initialize both masks to
> 32-bits by default.  Architectures can still override this in
> arch_setup_pdev_archdata if needed.
> 
> Note that the code looks a little odd with the various conditionals
> because we have to support platform_device structures that are
> statically allocated.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/base/platform.c         | 15 +++++++++++++--
>  include/linux/platform_device.h |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dff82a3c2caa..baf4b06cf2d9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -225,6 +225,17 @@ struct platform_object {
>  	char name[];
>  };
>  
> +static void setup_pdev_archdata(struct platform_device *pdev)
> +{
> +	if (!pdev->dev.coherent_dma_mask)
> +		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	if (!pdev->dma_mask)
> +		pdev->dma_mask = DMA_BIT_MASK(32);
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask = &pdev->dma_mask;

When building sparc32 images, this results in the following
error.

drivers/base/platform.c: In function 'setup_pdev_archdata':
drivers/base/platform.c:235:22: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
   pdev->dev.dma_mask = &pdev->dma_mask;

pdev->dev.dma_mask is u64 *, pdev->dma_mask is dma_addr_t which in turn
is either u32 or u64 depending on the architecture.

> +++ b/include/linux/platform_device.h
> @@ -25,6 +25,7 @@ struct platform_device {
>  	int		id;
>  	bool		id_auto;
>  	struct device	dev;
> +	dma_addr_t	dma_mask;

... so this will have to be u64, or the pointer in struct device would
have to be fixed.

However, even changing the definition to u64 does not help: The warnings
are still reported. This is because setup_pdev_archdata() is not called
for any of the affected devices. That is kind of interesting since it
means that arch_setup_pdev_archdata() won't be called for those devices
either.

Guenter
