Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEACC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD2020868
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h07XVut3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfAEDoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:44:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40695 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfAEDoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:44:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so19159624pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 19:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BptV2iFNr4xHDN41X6VWddSCH370seEpMUkhkf52G3c=;
        b=h07XVut3mEAxepqQmWNgugFBeImLGlhffuOXug1z7/NH/nX1D3jasDlUG2JCYBikDA
         eZX9qnWiLiq4Kb9qL5jI73FPptaq4GxFLPsba5Kt6p64V7dhHiuQxH7rScqSV9rEzW90
         Naw4FByqsbQupBRH0uKL8ijVk6UFAT6uImsQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BptV2iFNr4xHDN41X6VWddSCH370seEpMUkhkf52G3c=;
        b=Gfbw4MAZCGg/klnKe4TTXUWSFoTIhvvyWxoRY8duJcz592wTqBp6Yirl7DitFMpceZ
         IOnLEXY+bATp6t/0Oob1ncM6+kDymbpYoarrC/hWpaSPSzJe5KDIaTOY0s1Qt/1Zl/5M
         XtCzHvyxCxD/rAFdLQfC5VRzArqLeZwM6FKEwEAbPFU91OPUDjib0YtczJdNGusVwpfW
         sIw9vtNWPfvmT6P/1XsLJ4xZLI8s7vAMAercq4qRY+9Ex2siSjixDPmZrV2sMxpt83cM
         HZKDyzXa7tn3H7Z/N7Wvpx244zFWm08zPGBQq8c/BHcjXSA/E2jENaJI54aZO0V3gg+y
         yiAQ==
X-Gm-Message-State: AJcUukenMw1ZsFHyYoCan7V5ATNsbmfX8RlhukgB78WFcz4lDeukRbFn
        ax0Cnpy/7qCeS623SL3bB5fp
X-Google-Smtp-Source: ALg8bN5fA8djUv4KgT2riH4poizkAX4vevK/gU4bQmMyeXHXPNW+25aP2Hg5vWE5nsqHfaQj+v8MMQ==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr3738960pgh.265.1546659863658;
        Fri, 04 Jan 2019 19:44:23 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id f67sm112991455pff.29.2019.01.04.19.44.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 19:44:23 -0800 (PST)
Date:   Sat, 5 Jan 2019 09:14:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Li Yu <liyu65@hisilicon.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, dmaengine@vger.kernel.org,
        Guodong Xu <guodong.xu@linaro.org>
Subject: Re: [PATCH 4/8 v2] dma: k3dma: Delete axi_config
Message-ID: <20190105034415.GC2477@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-5-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546635388-13795-5-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 12:56:24PM -0800, John Stultz wrote:
> From: Li Yu <liyu65@hisilicon.com>
> 
> Axi_config controls whether DMA resources can be accessed in non-secure
> mode, such as linux kernel. The register should be set by the bootloader
> stage and depends on the device.
> 
> Thus, this patch removes axi_config from k3dma driver.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Li Yu <liyu65@hisilicon.com>
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> [jstultz: Minor tweaks to commit message]
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/k3dma.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index df61406..b2060bf 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -52,8 +52,6 @@
>  #define CX_SRC			0x814
>  #define CX_DST			0x818
>  #define CX_CFG			0x81c
> -#define AXI_CFG			0x820
> -#define AXI_CFG_DEFAULT		0x201201
>  
>  #define CX_LLI_CHAIN_EN		0x2
>  #define CX_CFG_EN		0x1
> @@ -168,7 +166,6 @@ static void k3_dma_set_desc(struct k3_dma_phy *phy, struct k3_desc_hw *hw)
>  	writel_relaxed(hw->count, phy->base + CX_CNT0);
>  	writel_relaxed(hw->saddr, phy->base + CX_SRC);
>  	writel_relaxed(hw->daddr, phy->base + CX_DST);
> -	writel_relaxed(AXI_CFG_DEFAULT, phy->base + AXI_CFG);
>  	writel_relaxed(hw->config, phy->base + CX_CFG);
>  }
>  
> -- 
> 2.7.4
> 
