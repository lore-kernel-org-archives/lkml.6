Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DEEC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C078820868
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0AQvGl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfAEDu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:50:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38097 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfAEDu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:50:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so18255147plb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 19:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O269jUdPN+3EG0hedM++PAwMUq4QPvNGB1txVuUOML0=;
        b=I0AQvGl7agIDtsP9PvGslDQ7ikjbg79L53k9pFTEKzqAwDMg3ZvyO3ww4Oz2gHCaDn
         IsXVh0VOvvhF7mH2ZNurUgB+2Spo0tG1x/vR9xMwK2JXYhzeMieD3IaASBCR4b+Y9Z6p
         tBNCehr5ny++zDCpbVy6Lc/71ybQe09kEWmh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O269jUdPN+3EG0hedM++PAwMUq4QPvNGB1txVuUOML0=;
        b=MmOifVsSFF9wt0n0iUbUQdd9jMm1aXmkbPAO54cB+SyLCg7KykvJdoWX4/In8SWI5l
         tORPU5M+TAlTpDrxLlQecp89Kt6d/CANPH99ayF26CCx8iOO8pUCEOWo1Cfh0k7S/ZTx
         O5e4qsrqBi/lM7anjjnzq9nDGRCM/ACMpeec3rz/izqaTEVoqutH6UQH7SU/zZ6oC54W
         4YAOE8H/XRjO1heD5Ps/ObcHq2A8kwe6poFKMtCXgE7isrt4RGDSMdEozx8eIlKNjmZp
         uJPQO5Rd8/6ga2JZaWmHXtqUdMsFZdaXoEd61/q/Ha7LniZHeq2kIou/mP8EiK5eOgAG
         kuAQ==
X-Gm-Message-State: AJcUukf+xMG1WzT6wiUMjJ+6/hoowEA7GRk6/cNqK01KoDktJ3OTjoNl
        JRdgTKVacRCeaT+e0pXBnPcc
X-Google-Smtp-Source: ALg8bN5Om/M38HtocYXgZC34BOZ25spUwLcbzKqXGdiTAQGYKZLzTjcuOO54/lv/42H4PQ07ctEHAQ==
X-Received: by 2002:a17:902:7614:: with SMTP id k20mr53960506pll.285.1546660227443;
        Fri, 04 Jan 2019 19:50:27 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id r12sm75124955pgv.83.2019.01.04.19.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 19:50:26 -0800 (PST)
Date:   Sat, 5 Jan 2019 09:20:18 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 7/8 v2] arm64: dts: hi3660: Add hisi asp dma device
Message-ID: <20190105035018.GE2477@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-8-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546635388-13795-8-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 12:56:27PM -0800, John Stultz wrote:
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
> 
> Add asp-dma device to hi3660 dts
> 
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> v2: Removed undocumented bindings
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index aaa2b04..df4e96d 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -569,6 +569,16 @@
>  			dma-type = "hi3660_dma";
>  		};
>  
> +		asp_dmac: dma-controller@e804b000 {
> +			compatible = "hisilicon,hisi-pcm-asp-dma-1.0";
> +			reg = <0x0 0xe804b000 0x0 0x1000>;
> +			#dma-cells = <1>;
> +			dma-channels = <16>;
> +			dma-requests = <32>;
> +			interrupts = <GIC_SPI 216 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "asp_dma_irq";
> +		};
> +
>  		rtc0: rtc@fff04000 {
>  			compatible = "arm,pl031", "arm,primecell";
>  			reg = <0x0 0Xfff04000 0x0 0x1000>;
> -- 
> 2.7.4
> 
