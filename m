Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E087ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719CC20825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 15:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 719CC20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeKIAxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 19:53:51 -0500
Received: from mail.skyhub.de ([5.9.137.197]:36006 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbeKIAxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 19:53:51 -0500
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HdXdkfrBTrFB; Thu,  8 Nov 2018 16:17:51 +0100 (CET)
Received: from zn.tnic (p200300EC2BD03D00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bd0:3d00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0E4CD1EC03C8;
        Thu,  8 Nov 2018 16:17:51 +0100 (CET)
Date:   Thu, 8 Nov 2018 16:17:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     linux@armlinux.org.uk, u.kleine-koenig@pengutronix.de,
        jlu@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 5/8] ARM: l2x0: add marvell,ecc-enable property for
 aurora
Message-ID: <20181108151743.GE7543@zn.tnic>
References: <20181029072535.31667-1-chris.packham@alliedtelesis.co.nz>
 <20181029072535.31667-6-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181029072535.31667-6-chris.packham@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 08:25:32PM +1300, Chris Packham wrote:
> The aurora cache on the Marvell Armada-XP SoC supports ECC protection
> for the L2 data arrays. Add a "marvell,ecc-enable" device tree property
> which can be used to enable this.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> [jlu@pengutronix.de: use aurora specific define AURORA_ACR_ECC_EN]
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/l2c2x0.txt | 2 ++
>  arch/arm/mm/cache-l2x0.c                         | 7 +++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> index fbe6cb21f4cf..15a84f0ba9f1 100644
> --- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
> +++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
> @@ -76,6 +76,8 @@ Optional properties:
>    specified to indicate that such transforms are precluded.
>  - arm,parity-enable : enable parity checking on the L2 cache (L220 or PL310).
>  - arm,parity-disable : disable parity checking on the L2 cache (L220 or PL310).
> +- marvell,ecc-enable : enable ECC protection on the L2 cache
> +- marvell,ecc-disable : disable ECC protection on the L2 cache
>  - arm,outer-sync-disable : disable the outer sync operation on the L2 cache.
>    Some core tiles, especially ARM PB11MPCore have a faulty L220 cache that
>    will randomly hang unless outer sync operations are disabled.
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index b70bee74750d..644f786e4fa9 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -1505,6 +1505,13 @@ static void __init aurora_of_parse(const struct device_node *np,
>  		mask |= AURORA_ACR_FORCE_WRITE_POLICY_MASK;
>  	}
>  
> +	if (of_property_read_bool(np, "marvell,ecc-enable")) {
> +		mask |= AURORA_ACR_ECC_EN;
> +		val |= AURORA_ACR_ECC_EN;
> +	} else if (of_property_read_bool(np, "marvell,ecc-disable")) {
> +		mask |= AURORA_ACR_ECC_EN;
> +	}
> +
>  	if (of_property_read_bool(np, "arm,parity-enable")) {
>  		mask |= AURORA_ACR_PARITY_EN;
>  		val |= AURORA_ACR_PARITY_EN;
> -- 

checkpatch complains here:

WARNING: DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
