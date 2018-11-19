Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EEB0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458B520823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BrpOBvZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458B520823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbeKTIQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:16:47 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15645 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730748AbeKTIQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:16:47 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf3304a0000>; Mon, 19 Nov 2018 13:51:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 19 Nov 2018 13:51:06 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 19 Nov 2018 13:51:06 -0800
Received: from [10.26.11.92] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 19 Nov
 2018 21:51:04 +0000
Subject: Re: [PATCH v1 3/4] ARM: tegra: Restore memory arbitration on resume
 from LP1 on Tegra30+
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-4-digetx@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <48dc61a4-7dd0-5f0e-33e0-43c7833e8a37@nvidia.com>
Date:   Mon, 19 Nov 2018 21:51:01 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180830185404.7224-4-digetx@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542664266; bh=6/0e+I4rU1OLAnDUGVUgzMoaE2+QBiApl/qN2KabI2o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BrpOBvZacvll0TJJn5AU2QnD+2FN9vqbT7lzdsRJrVi38TtFU632AY/TQM6TAWxQd
         Ud4gXgZBgzgK/WcEaY8kRkkRLodu+hNnNcyYmVkM3yFICrVnrQNEFqJOrmVbtg0bLo
         QEcBHzb0/LJzx5xyAskahCrVshSzjAsK7D9HoMMcs0Vq+5BqdTBrzyG8gjT6duqxYa
         FAKVDYD2e0V1HNHwu3J/zzoPnEeDg55+KUfZAT/cfG783nUurkESloPqTqtjQVXaMf
         IASnQ0RF5BMq2D+v0ZpXjoSdVP2joxQSz+Axm3uVaD8UKzGqljWPvnOSVoXBd70+Bj
         W7MbCAF4WLPKA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/08/2018 19:54, Dmitry Osipenko wrote:
> The external memory arbitration configuration is getting reset after
> memory entering into self-refresh mode, it shall be restored on the
> exit. Note that MC_EMEM_ARB_CFG register is shadowed and latching
> happens on the EMC timing update. This fixes 2x GPU performance
> degradation after resuming from LP1 on Tegra30.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/iomap.h         |  9 +++++++++
>  arch/arm/mach-tegra/sleep-tegra30.S | 21 +++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/mach-tegra/iomap.h b/arch/arm/mach-tegra/iomap.h
> index 9e5b2f869fc8..9bc291e76887 100644
> --- a/arch/arm/mach-tegra/iomap.h
> +++ b/arch/arm/mach-tegra/iomap.h
> @@ -79,15 +79,24 @@
>  #define TEGRA_PMC_BASE			0x7000E400
>  #define TEGRA_PMC_SIZE			SZ_256
>  
> +#define TEGRA_MC_BASE			0x7000F000
> +#define TEGRA_MC_SIZE			SZ_1K
> +
>  #define TEGRA_EMC_BASE			0x7000F400
>  #define TEGRA_EMC_SIZE			SZ_1K
>  
> +#define TEGRA114_MC_BASE		0x70019000
> +#define TEGRA114_MC_SIZE		SZ_4K
> +
>  #define TEGRA_EMC0_BASE			0x7001A000
>  #define TEGRA_EMC0_SIZE			SZ_2K
>  
>  #define TEGRA_EMC1_BASE			0x7001A800
>  #define TEGRA_EMC1_SIZE			SZ_2K
>  
> +#define TEGRA124_MC_BASE		0x70019000
> +#define TEGRA124_MC_SIZE		SZ_4K
> +
>  #define TEGRA124_EMC_BASE		0x7001B000
>  #define TEGRA124_EMC_SIZE		SZ_2K
>  
> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
> index 99ac9c6dcf7c..828f6c37afde 100644
> --- a/arch/arm/mach-tegra/sleep-tegra30.S
> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
> @@ -44,6 +44,8 @@
>  #define EMC_XM2VTTGENPADCTRL		0x310
>  #define EMC_XM2VTTGENPADCTRL2		0x314
>  
> +#define MC_EMEM_ARB_CFG			0x90
> +
>  #define PMC_CTRL			0x0
>  #define PMC_CTRL_SIDE_EFFECT_LP0 (1 << 14) /* enter LP0 when CPU pwr gated */
>  
> @@ -418,6 +420,22 @@ _pll_m_c_x_done:
>  	movweq	r0, #:lower16:TEGRA124_EMC_BASE
>  	movteq	r0, #:upper16:TEGRA124_EMC_BASE
>  
> +	cmp	r10, #TEGRA30
> +	moveq	r2, #0x20
> +	movweq	r4, #:lower16:TEGRA_MC_BASE
> +	movteq	r4, #:upper16:TEGRA_MC_BASE
> +	cmp	r10, #TEGRA114
> +	moveq	r2, #0x34
> +	movweq	r4, #:lower16:TEGRA114_MC_BASE
> +	movteq	r4, #:upper16:TEGRA114_MC_BASE
> +	cmp	r10, #TEGRA124
> +	moveq	r2, #0x20
> +	movweq	r4, #:lower16:TEGRA124_MC_BASE
> +	movteq	r4, #:upper16:TEGRA124_MC_BASE
> +
> +	ldr	r1, [r5, r2]		@ restore MC_EMEM_ARB_CFG
> +	str	r1, [r4, #MC_EMEM_ARB_CFG]
> +
>  exit_self_refresh:
>  	ldr	r1, [r5, #0xC]		@ restore EMC_XM2VTTGENPADCTRL
>  	str	r1, [r0, #EMC_XM2VTTGENPADCTRL]
> @@ -546,6 +564,7 @@ tegra30_sdram_pad_address:
>  	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
>  	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
>  	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
> +	.word	TEGRA_MC_BASE + MC_EMEM_ARB_CFG				@0x20
>  tegra30_sdram_pad_address_end:
>  
>  tegra114_sdram_pad_address:
> @@ -562,6 +581,7 @@ tegra114_sdram_pad_address:
>  	.word	TEGRA_EMC1_BASE + EMC_AUTO_CAL_INTERVAL			@0x28
>  	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL			@0x2c
>  	.word	TEGRA_EMC1_BASE + EMC_XM2VTTGENPADCTRL2			@0x30
> +	.word	TEGRA114_MC_BASE + MC_EMEM_ARB_CFG			@0x34
>  tegra114_sdram_pad_adress_end:
>  
>  tegra124_sdram_pad_address:
> @@ -573,6 +593,7 @@ tegra124_sdram_pad_address:
>  	.word	TEGRA_PMC_BASE + PMC_IO_DPD_STATUS			@0x14
>  	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_CLK_SOURCE_MSELECT	@0x18
>  	.word	TEGRA_CLK_RESET_BASE + CLK_RESET_SCLK_BURST		@0x1c
> +	.word	TEGRA124_MC_BASE + MC_EMEM_ARB_CFG			@0x20
>  tegra124_sdram_pad_address_end:
>  
>  tegra30_sdram_pad_size:
> 

Acked-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>


-- 
nvpublic
