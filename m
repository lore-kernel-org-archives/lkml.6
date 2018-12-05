Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF42C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9FE20989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 21:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=verge.net.au header.i=@verge.net.au header.b="h9uds0kx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9FE20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verge.net.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeLEVVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 16:21:22 -0500
Received: from kirsty.vergenet.net ([202.4.237.240]:37588 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeLEVVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 16:21:21 -0500
Received: from penelope.horms.nl (unknown [64.124.208.80])
        by kirsty.vergenet.net (Postfix) with ESMTPA id 8157125B799;
        Thu,  6 Dec 2018 08:21:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=verge.net.au; s=mail;
        t=1544044878; bh=DqEGeITSxpnqE6zGx/SbDBIV0MME0AVggv0r59fWtCE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h9uds0kxoJlrrqoYqR9c8y3CDMWmmI1TGNJOtA6ULasLEwKWTfOSfLRM4PbNqzSVd
         N1ibunJFkVyeXI2DTB4HFjY/GiaxBdwdXfymVzbZ8chPfuBzyArxtjS5p7W7zeEicP
         Cfn7LUeoVU+pVN5BPK06Ql7ZxFiA190Ooc/Gba7U=
Received: by penelope.horms.nl (Postfix, from userid 7100)
        id 102CFE22BBB; Wed,  5 Dec 2018 13:21:17 -0800 (PST)
Date:   Wed, 5 Dec 2018 13:21:17 -0800
From:   Simon Horman <horms@verge.net.au>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] soc: renesas: rcar-sysc: Fix power domain control
 after system resume
Message-ID: <20181205212112.2ls6ta27ok3yiyco@verge.net.au>
References: <20181205153945.13767-1-geert+renesas@glider.be>
 <20181205153945.13767-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205153945.13767-5-geert+renesas@glider.be>
Organisation: Horms Solutions BV
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:39:45PM +0100, Geert Uytterhoeven wrote:
> To control power to a power domain, the System Controller (SYSC) needs
> the corresponding interrupt source to be enabled, but masked, to prevent
> the CPU from receiving it.
> 
> Currently this is handled in the driver's probe() routine, and set up
> for every domain present, even if it will not be controlled directly by
> SYSC (CPU domains are powered through the APMU on R-Car Gen2 and later).
> 
> On R-Car Gen3, PSCI powers down the SoC during system suspend, thus
> loosing any configured interrupt state.  Hence after system resume, power
> domains not controlled through the APMU (e.g. A3IR, A3VC, A3VP) fail to
> power up.

I corrected the spelling of losing when applying this patch.

> 
> Fix this by replacing the global interrupt setup in the probe() routine
> by a domain-specific interrupt setup in rcar_sysc_power(), where the
> domain's power is actually controlled.  This brings the code more in
> line with the flowchart in the Hardware User's Manual.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/soc/renesas/rcar-sysc.c | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/soc/renesas/rcar-sysc.c b/drivers/soc/renesas/rcar-sysc.c
> index 123e553510e826f5..0c80fab4f8de6bc8 100644
> --- a/drivers/soc/renesas/rcar-sysc.c
> +++ b/drivers/soc/renesas/rcar-sysc.c
> @@ -105,6 +105,15 @@ static int rcar_sysc_power(const struct rcar_sysc_ch *sysc_ch, bool on)
>  
>  	spin_lock_irqsave(&rcar_sysc_lock, flags);
>  
> +	/*
> +	 * The interrupt source needs to be enabled, but masked, to prevent the
> +	 * CPU from receiving it.
> +	 */
> +	iowrite32(ioread32(rcar_sysc_base + SYSCIMR) | isr_mask,
> +		  rcar_sysc_base + SYSCIMR);
> +	iowrite32(ioread32(rcar_sysc_base + SYSCIER) | isr_mask,
> +		  rcar_sysc_base + SYSCIER);
> +
>  	iowrite32(isr_mask, rcar_sysc_base + SYSCISCR);
>  
>  	/* Submit power shutoff or resume request until it was accepted */
> @@ -324,7 +333,6 @@ static int __init rcar_sysc_pd_init(void)
>  	const struct of_device_id *match;
>  	struct rcar_pm_domains *domains;
>  	struct device_node *np;
> -	u32 syscier, syscimr;
>  	void __iomem *base;
>  	unsigned int i;
>  	int error;
> @@ -363,24 +371,6 @@ static int __init rcar_sysc_pd_init(void)
>  	domains->onecell_data.num_domains = ARRAY_SIZE(domains->domains);
>  	rcar_sysc_onecell_data = &domains->onecell_data;
>  
> -	for (i = 0, syscier = 0; i < info->num_areas; i++)
> -		syscier |= BIT(info->areas[i].isr_bit);
> -
> -	/*
> -	 * Mask all interrupt sources to prevent the CPU from receiving them.
> -	 * Make sure not to clear reserved bits that were set before.
> -	 */
> -	syscimr = ioread32(base + SYSCIMR);
> -	syscimr |= syscier;
> -	pr_debug("%pOF: syscimr = 0x%08x\n", np, syscimr);
> -	iowrite32(syscimr, base + SYSCIMR);
> -
> -	/*
> -	 * SYSC needs all interrupt sources enabled to control power.
> -	 */
> -	pr_debug("%pOF: syscier = 0x%08x\n", np, syscier);
> -	iowrite32(syscier, base + SYSCIER);
> -
>  	for (i = 0; i < info->num_areas; i++) {
>  		const struct rcar_sysc_area *area = &info->areas[i];
>  		struct rcar_sysc_pd *pd;
> -- 
> 2.17.1
> 
