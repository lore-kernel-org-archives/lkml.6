Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAC4C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5219524256
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="rV7L7/ZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5219524256
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbeFVNIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:08:42 -0400
Received: from kirsty.vergenet.net ([202.4.237.240]:43057 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeFVNIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:08:41 -0400
Received: from reginn.horms.nl (watermunt.horms.nl [80.127.179.77])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 74A7025BDAB;
        Fri, 22 Jun 2018 23:08:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1529672919; bh=HcSZm506gBDTjtM7u8Za9wT34uxKXISIlAd+/+n65uI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rV7L7/ZVdIYEQqofp79OwtRg/As4M10oyuZffV3dKEiKhfcC6ZdvYznloIML/aOUW
         tRIVfaf1TFsRZ9AGByBE05QPqWVe5/YRSfApdD6Uld/BHInqVRh7tNfu6GtUHUmvPL
         INBfx9mC/ZRaDdcorBapzZJMXI9nVmDQx9dw2ZD0=
Received: by reginn.horms.nl (Postfix, from userid 7100)
        id 2C517940461; Fri, 22 Jun 2018 15:08:37 +0200 (CEST)
Date:   Fri, 22 Jun 2018 15:08:37 +0200
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Chris Brandt <Chris.Brandt@renesas.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] arm: Replace "multiple platforms" by "common
 platform"
Message-ID: <20180622130830.xdglndk4xtr24yuv@verge.net.au>
References: <20180621155906.12821-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180621155906.12821-1-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:59:06PM +0200, Geert Uytterhoeven wrote:
> "ARM multiplatform" has actually two meanings:
>   1. It groups platforms that follow the "ARM multiplatform" software
>      framework,
>   2. It allows to build a single kernel that can be booted on multiple
>      platforms.
> 
> Currently support for XIP and/or NOMMU cannot be enabled on platforms
> that follow the "ARM multiplatform" framework, without duplicating their
> machine selection logic under a new Kconfig symbol.  As (in theory) all
> platforms can be used with XIP and/or NOMMU, this is not sustainable.
> 
> Hence clarify the meaning of ARCH_MULTIPLATFORM:
>   1. Replace "multiple platforms" by "common platform", as it allows to
>      select one or more platforms adhering to the common framework,
>   2. Note that a single kernel may not boot on all platforms if XIP or
>      NOMMU is enabled.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> References:
>   - "[PATCHv4 0/4] arm/versatile: no-MMU support"
>     (http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/584555.html)
> 
>   - "[PATCH 0/2] ARM: ARMv7 (with MMU) XIP without ARCH_MULTIPLATFORM"
>     (http://lists.infradead.org/pipermail/linux-arm-kernel/2017-February/486835.html)
> 
>  arch/arm/Kconfig | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 54eeb8d00bc62a9f..6b286c018cf748c7 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -329,7 +329,7 @@ choice
>  	default ARCH_MULTIPLATFORM if MMU
>  
>  config ARCH_MULTIPLATFORM
> -	bool "Allow multiple platforms to be selected"
> +	bool "Common platforms (\"multiplatform\")"
>  	depends on MMU
>  	select ARM_HAS_SG_CHAIN
>  	select ARM_PATCH_PHYS_VIRT
> @@ -342,6 +342,13 @@ config ARCH_MULTIPLATFORM
>  	select PCI_DOMAINS if PCI
>  	select SPARSE_IRQ
>  	select USE_OF
> +	help
> +	  Support for systems implemented using the common "multiplatform"
> +	  framework.
> +
> +	  Unless specialized options depending on intimate platform
> +	  details, like XIP or NOMMU, are enabled, this allows to build a
> +	  single kernel that boots on multiple platforms.

Hi Geert,

I wonder if this might be slightly clearer:

	  Unless specialized options that depend on intimate platform
	  details, such as XIP and NOMMU, are enabled, this allows building
	  a single kernel that boots on multiple platforms.

>  
>  config ARM_SINGLE_ARMV7M
>  	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
> -- 
> 2.17.1
> 
