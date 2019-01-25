Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690C8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42853218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 14:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfAYOcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 09:32:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48174 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbfAYOcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 09:32:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 28249A78;
        Fri, 25 Jan 2019 06:32:19 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 184303F5C1;
        Fri, 25 Jan 2019 06:32:17 -0800 (PST)
Date:   Fri, 25 Jan 2019 14:32:15 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     will.deacon@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] arm64: Kconfig.platforms: fix warning unmet direct
 dependencies
Message-ID: <20190125143215.GE25901@arrakis.emea.arm.com>
References: <20190115191839.13823-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115191839.13823-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 08:18:39PM +0100, Anders Roxell wrote:
> When ARCH_MXC get enabled, ARM64_ERRATUM_845719 will be selected and
> this warning will happen when COMPAT isn't set.
> 
> WARNING: unmet direct dependencies detected for ARM64_ERRATUM_845719
>   Depends on [n]: COMPAT [=n]
>   Selected by [y]:
>   - ARCH_MXC [=y]
> 
> Rework to add 'if COMPAT' before ARM64_ERRATUM_845719 gets selected,
> since ARM64_ERRATUM_845719 depends on COMPAT.
> 
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  arch/arm64/Kconfig.platforms | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 251ecf34cb02..d4faca775d9c 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -145,7 +145,7 @@ config ARCH_MVEBU
>  config ARCH_MXC
>  	bool "ARMv8 based NXP i.MX SoC family"
>  	select ARM64_ERRATUM_843419
> -	select ARM64_ERRATUM_845719
> +	select ARM64_ERRATUM_845719 if COMPAT
>  	help
>  	  This enables support for the ARMv8 based SoCs in the
>  	  NXP i.MX family.

Actually, do we need to select the errata workarounds explicitly? That
seems to be the only case where we do it (commit 930507c18304, "arm64:
add basic Kconfig symbols for i.MX8"). They are default y, so we
shouldn't need to force them on.

-- 
Catalin
