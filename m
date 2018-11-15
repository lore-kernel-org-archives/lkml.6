Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C8BC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B42220825
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UwpypDHH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B42220825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732963AbeKOTxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:53:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33271 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbeKOTxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:53:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id u9-v6so20453866wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=cFkBvcAplJC6nmdc3QF15N00kkjLnDBYHi/fgtwAks0=;
        b=UwpypDHH2b9IlOYOGRUoF7f29zv9U429aCoUaeFBk3ugCPHkLmmZFfd9+Ro62YI0Se
         jmH/J5mAMQmomKrBA9ZkZz/NdaYt4VxFOuhE7abARDeOYGoU/qSDT/qigNE2bX8TKmDH
         iHZDUyBJ5hCX1GCYeNYL9eap1bA/3NQrOTYNfFJ8Um+n9NzSNV3eLjdr4MANwSPysWH3
         ykycZdPaiWhP+Lc20ZPXKl4wuBCL0klamjiQchJXurtH1Wtqyepvr+cpXXh1SMUrgmzV
         4/R/4+GLyL0JK3z5FBR/5jUVqVFP4HWBUHyq3ONmpakPHWY7WnIaiAM/52/ulyL63wdz
         wbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=cFkBvcAplJC6nmdc3QF15N00kkjLnDBYHi/fgtwAks0=;
        b=SqN44Tb7j50G+RI3NyyuYBorJ1WtfC3s+gsIWDjHlwR2vIDDTpWd1RnPiPuTtJ/iza
         bTj+DRGsPI3ax5d7k/RyDoNAjcaFdJU2AcHxs4Qh4hUEamH0wyeoQ7Ekf0j6MqRwWFh1
         vb39z9sSdZ60AzxCDN6r4F/cxv7ujoDawj//9cUpFT/yyydei+SrDH17XBpZ/YW3O2IO
         2qZKdpcb9XkCVvPhOUX0Hf1Xw+rDDtlyqbIKzAf9VZ6sxFiut9qJ+eIxccfoxPqKA2zK
         NI1TmN/zGRe/H2zzCzaJlzirHxHDl+LH4Sw8Kshtzrlk+3JuSUGHQt42ncu7O0FD6Ggy
         m7oA==
X-Gm-Message-State: AGRZ1gIiSBqesQ8NyWyM2p6lvb/8IVJY1o5+xom5srWLHzU1x13kTxTx
        swtEN6Y4CWc+PWisJVAVganl6w==
X-Google-Smtp-Source: AJdET5dejrY50v8mNrsloMnJ5dEmExjrJyG8xoNgpOQG7aIuKeuGBU/JWqh4RDVlBiT9mcdZAm8f2A==
X-Received: by 2002:adf:9022:: with SMTP id h31-v6mr5089266wrh.297.1542275177566;
        Thu, 15 Nov 2018 01:46:17 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id l17-v6sm19635330wrb.86.2018.11.15.01.46.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 01:46:16 -0800 (PST)
Message-ID: <223b47cc5077db7176e5d8c013f1a76091c3d70c.camel@baylibre.com>
Subject: Re: [RFC v1 7/7] clk: meson: meson8b: allow changing the CPU clock
 tree
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        narmstrong@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org
Date:   Thu, 15 Nov 2018 10:46:15 +0100
In-Reply-To: <20181114225725.2821-8-martin.blumenstingl@googlemail.com>
References: <20181114225725.2821-1-martin.blumenstingl@googlemail.com>
         <20181114225725.2821-8-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-11-14 at 23:57 +0100, Martin Blumenstingl wrote:
> Currently all clocks in the CPU clock tree are marked as read-only
> (using the corresponding _ro_ clk_ops). This was correct since changing
> the clock tree could cause the system to lock up.
> Switch all clocks to their corresponding clk_ops variant which is not
> read-only to allow changing the CPU clock tree since the bug which
> locked up the system is now fixed (by switching the CPU clock temporary
> to run off XTAL while changing the CPU clock tree).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index c06a1a7faa4c..b3bdc7e05441 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -203,7 +203,7 @@ static struct clk_regmap meson8b_sys_pll_dco = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "sys_pll_dco",
> -		.ops = &meson_clk_pll_ro_ops,
> +		.ops = &meson_clk_pll_ops,
>  		.parent_names = (const char *[]){ "xtal" },
>  		.num_parents = 1,
>  	},
> @@ -218,7 +218,7 @@ static struct clk_regmap meson8b_sys_pll = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "sys_pll",
> -		.ops = &clk_regmap_divider_ro_ops,
> +		.ops = &clk_regmap_divider_ops,
>  		.parent_names = (const char *[]){ "sys_pll_dco" },
>  		.num_parents = 1,
>  		.flags = CLK_SET_RATE_PARENT,
> @@ -552,7 +552,7 @@ static struct clk_regmap meson8b_cpu_in_sel = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "cpu_in_sel",
> -		.ops = &clk_regmap_mux_ro_ops,
> +		.ops = &clk_regmap_mux_ops,
>  		.parent_names = (const char *[]){ "xtal", "sys_pll" },
>  		.num_parents = 2,
>  		.flags = (CLK_SET_RATE_PARENT |
> @@ -606,7 +606,7 @@ static struct clk_regmap meson8b_cpu_scale_div = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "cpu_scale_div",
> -		.ops = &clk_regmap_divider_ro_ops,
> +		.ops = &clk_regmap_divider_ops,
>  		.parent_names = (const char *[]){ "cpu_in_sel" },
>  		.num_parents = 1,
>  		.flags = CLK_SET_RATE_PARENT,
> @@ -623,7 +623,7 @@ static struct clk_regmap meson8b_cpu_scale_out_sel = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "cpu_scale_out_sel",
> -		.ops = &clk_regmap_mux_ro_ops,
> +		.ops = &clk_regmap_mux_ops,
>  		/*
>  		 * NOTE: We are skipping the parent with value 0x2 (which is
>  		 * "cpu_div3") because it results in a duty cycle of 33% which
> @@ -646,7 +646,7 @@ static struct clk_regmap meson8b_cpu_clk = {
>  	},
>  	.hw.init = &(struct clk_init_data){
>  		.name = "cpu_clk",
> -		.ops = &clk_regmap_mux_ro_ops,
> +		.ops = &clk_regmap_mux_ops,
>  		.parent_names = (const char *[]){ "xtal",
>  						  "cpu_scale_out_sel" },
>  		.num_parents = 2,

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>

