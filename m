Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC497C43444
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3B9206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 07:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZmtwED6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729935AbeLPHT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 02:19:57 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:45964 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeLPHT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 02:19:57 -0500
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BE0159;
        Sun, 16 Dec 2018 08:19:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1544944795;
        bh=GlI1ornDKN5A9uyJrQzjbO3L8p4TZ2Gy4NMVF/JdkKM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZmtwED6SfBbwrPMbf20qbG55N0htoxD/jet+13BtXmM2CQaGF8Wlz1C7YeGR7YVMi
         lT9XwODK5UQiUr61NoLslamTrm/BdVJ/oLDxeSZl7ST3QN9Ipxjx0CcKB84HllepRX
         bp8qO+/YcvqER9Kh4JJf2xSXi8P3LIfJKVKoJQ/o=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Alexey Firago <alexey_firago@mentor.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] clk: vc5: Initialize src in vc5_mux_set_parent()
Date:   Sun, 16 Dec 2018 09:20:44 +0200
Message-ID: <2374057.Z2vKcv2BoK@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <20181214214959.162744-1-sboyd@kernel.org>
References: <20181214214959.162744-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Friday, 14 December 2018 23:49:59 EET Stephen Boyd wrote:
> It seems that it may be possible to get to the regmap update call
> without ever initializing this variable, so just set it to 0 to be safe.

This can't happen as the probe() function would have failed first. I'd thus 
add a comment to explain that the goal is only to silence a compiler warning.

> Cc: Marek Vasut <marek.vasut+renesas@gmail.com>
> Cc: Alexey Firago <alexey_firago@mentor.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: linux-renesas-soc@vger.kernel.org
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/clk/clk-versaclock5.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index 5b393e711e94..026f76276933 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -246,7 +246,7 @@ static int vc5_mux_set_parent(struct clk_hw *hw, u8
> index) struct vc5_driver_data *vc5 =
>  		container_of(hw, struct vc5_driver_data, clk_mux);
>  	const u8 mask = VC5_PRIM_SRC_SHDN_EN_XTAL | VC5_PRIM_SRC_SHDN_EN_CLKIN;
> -	u8 src;
> +	u8 src = 0;
> 
>  	if ((index > 1) || !vc5->clk_mux_ins)
>  		return -EINVAL;


-- 
Regards,

Laurent Pinchart



