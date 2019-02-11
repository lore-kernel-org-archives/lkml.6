Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A154C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FD0222B0
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="U20y8UF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbfBKN7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:59:46 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2350 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfBKN7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:59:44 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c617fad0000>; Mon, 11 Feb 2019 05:59:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 11 Feb 2019 05:59:43 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 11 Feb 2019 05:59:43 -0800
Received: from [10.25.73.17] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 11 Feb
 2019 13:59:40 +0000
Subject: Re: [PATCH] ARM: tegra: enforce PM requirement
To:     <linux@armlinux.org.uk>, <jhogan@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1549365418-26283-1-git-send-email-spujar@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <d78324ad-25de-a125-a1bd-6088f069ef58@nvidia.com>
Date:   Mon, 11 Feb 2019 19:29:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1549365418-26283-1-git-send-email-spujar@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549893549; bh=c2rYtvV9Y8Jv6429/xOpMhGVJpz09K9qJjWqjFbEOR4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=U20y8UF7OAfHuv5x2uYtxojMJ2zG6jzvqpbJj25AbouYWTZhiZO9ACdMmWMFaAAbG
         v+LkiQBThjc9IOnVtFCdRBs4TuzAOw24ODCHSuepLKhiBeytO+2H+wYIWzwJbPo3J+
         bqQlEysSE6GjegWwt2UUcHHhFgrO2WP/jBkBPXGRRHFoXiNLJL/63lBOsni6T3pV4r
         KPXa5YaOyBrBD0ivedcedAhrM8wdDQIqLwyJZzzWI2RaJ/IG4p7mUa2Zaoilvhv9r2
         rjpaHTncYW/wfTs8rfcOaD1uG/s7XjAd1uNi6R9lOVqBWzBCcf+nePQo+aeXmAZ//0
         0RTWYaq9pQnzA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/5/2019 4:46 PM, Sameer Pujar wrote:
> Drivers need to handle !PM case with work arounds for managing clocks
> and power explicitly, which is not really necessary when PM support on
> tegra is in good shape. In fact ARM 64-bit tegra platforms enforce PM
> support and there is no reason why this cannot be done for 32-bit.
>
> This patch selects PM unconditionally and drivers can rely on runtime
> PM framework for clock and power management.
>
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Jonathan Hunter <jonathanh@nvidia.com>
> ---
>   arch/arm/mach-tegra/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
> index 7f3b83e..51a8fa3 100644
> --- a/arch/arm/mach-tegra/Kconfig
> +++ b/arch/arm/mach-tegra/Kconfig
> @@ -10,6 +10,7 @@ menuconfig ARCH_TEGRA
>   	select HAVE_ARM_SCU if SMP
>   	select HAVE_ARM_TWD if SMP
>   	select PINCTRL
> +	select PM
>   	select PM_OPP
>   	select ARCH_HAS_RESET_CONTROLLER
>   	select RESET_CONTROLLER

Request for review comments or approval.

Thanks,
Sameer.

