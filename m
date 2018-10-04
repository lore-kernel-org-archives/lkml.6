Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1155C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E92E2082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E92E2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJDX0Q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:26:16 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45949 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727415AbeJDX0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:26:16 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id DDFE920787; Thu,  4 Oct 2018 18:32:12 +0200 (CEST)
Received: from localhost (LFbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.bootlin.com (Postfix) with ESMTPSA id AC15620719;
        Thu,  4 Oct 2018 18:32:12 +0200 (CEST)
Date:   Thu, 4 Oct 2018 18:20:04 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] clk: sunxi-ng: enable so-said LDOs for A64 SoC's
 pll-mipi clock
Message-ID: <20181004162004.dstnrzyaqryenfj3@flea>
References: <20181002122911.22094-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181002122911.22094-1-icenowy@aosc.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Tue, Oct 02, 2018 at 08:29:11PM +0800, Icenowy Zheng wrote:
> In the user manual of A64 SoC, the bit 22 and 23 of pll-mipi control
> register is called "LDO{1,2}_EN", and according to the BSP source code
> from Allwinner , the LDOs are enabled during the clock's enabling
> process.
> 
> The clock failed to generate output if the two LDOs are not enabled.
> 
> Add the two bits to the clock's gate bits, so that the LDOs are enabled
> when the PLL is enabled.
> 
> Fixes: c6a0637460c2 ("clk: sunxi-ng: Add A64 clocks")
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> As PLL-MIPI is not used before 4.20~5.0, I decide not to target this patch
> on stable/mainline kernels.
> 
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> index 5f80eb018014..f7d297368eb2 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
> @@ -162,7 +162,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_gpu_clk, "pll-gpu",
>  #define SUN50I_A64_PLL_MIPI_REG		0x040
>  
>  static struct ccu_nkm pll_mipi_clk = {
> -	.enable		= BIT(31),
> +	.enable		= BIT(31) | BIT(23) | BIT(22),

Adding a comment on why those are needed in addition to the enable bit
would be great :)

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
