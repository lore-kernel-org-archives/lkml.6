Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3378ECDFBB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 11:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B3F520875
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 11:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFTaDbbx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B3F520875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeGVMwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 08:52:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34516 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbeGVMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 08:52:01 -0400
Received: by mail-ed1-f66.google.com with SMTP id h1-v6so13405760eds.1;
        Sun, 22 Jul 2018 04:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fx7hot6tyaRr0YE8x2MpqOVrYz/SCkpEcmGVKAmt7xk=;
        b=qFTaDbbxBIqaQtbsarm4gFGZGi6SwK68rwBIRXFxbMSYZPHTxzzuFIWVlE+MQNUsnI
         e8phqHYUVysOzdD49VLX81ncH33pg+isFBsAIAuR3trcnclvQVZ1OcoIxuH0UjrhiybZ
         9ATjV3DAh41jvzjfLFhI874Aetj9ZUelnpFZFbn1MAmfIUeBEPWP3GCx45dU6fdD/9rG
         TT5TL6fhGYPYupCoaM4SlAQIZVaqFap3m5CRehmTj8EhUZXG+q6oUHdvsLkAVq/+XIw9
         ix2i5ErgQeDCvQ4nLBw/qHuXi1FQo0OrczEys3IQt7uMOqr2Iap3az9vglAFTZHdrISi
         7UZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fx7hot6tyaRr0YE8x2MpqOVrYz/SCkpEcmGVKAmt7xk=;
        b=og8djDUnVJbrFudyf2gl9dfAuRKmKSG04gCdmvUKmtDRcCeSBcVAnkZzHGRJhRnGzp
         RJcl78dSLB9pNSuk7BirVOAnXT5NN91gP8KJQW/WINue8E/sq+y7nromecnuKch0TW7e
         eNiELo8WZ0AqVrkS+fptT+flu1/YO3jRc+5OGfVqlnx/pK/nP82l7jfh1tJ97mFWcWA3
         l/QWMwQTkPQEQ0D2+u1amXAaPAUCsTR7mBE9GSTtd7EjaVV94zobpc13stzwF+S6P/7r
         g0yFWfh/Js9TdTHmEp0LQzLMFEDAJf32N+JmN2iOFiPiC7qgu3ptjAAaE8tidQjrUoM7
         1aFg==
X-Gm-Message-State: AOUpUlGhgS63Xz5EEIlNLKftStbQwd8703u3NJo2cX2waodsEGEMZa5G
        0aCjwtBTjw5Eu8DsEFDWTWo=
X-Google-Smtp-Source: AAOMgpeDSmgBWOq5q0wSsdE8hj+kgdBIqWpycdB4eg4YKEKd5IpHwB0wYYCQJ92Vn1WXMtASZysmUg==
X-Received: by 2002:a50:f145:: with SMTP id z5-v6mr10229944edl.0.1532260532857;
        Sun, 22 Jul 2018 04:55:32 -0700 (PDT)
Received: from dimapc.localnet (109-252-90-13.nat.spd-mgts.ru. [109.252.90.13])
        by smtp.gmail.com with ESMTPSA id d89-v6sm3405404edc.93.2018.07.22.04.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Jul 2018 04:55:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>, pdeschrijver@nvidia.com,
        jonathanh@nvidia.co, thierry.reding@gmail.com
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, pgaikwad@nvidia.com,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH 6/8] clk: tegra30: add 2d and 3d idle clocks
Date:   Sun, 22 Jul 2018 14:55:31 +0300
Message-ID: <1721645.6LMGIEI4vR@dimapc>
In-Reply-To: <20180720134532.13148-7-ben.dooks@codethink.co.uk>
References: <20180720134532.13148-1-ben.dooks@codethink.co.uk> <20180720134532.13148-7-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 20 July 2018 16:45:30 MSK Ben Dooks wrote:
> The 2D and 3D clocks have an IDLE field in bits 15:8 so add these
> clocks by making a 2D and 3D mux, and split the divider into the
> standard 2D/3D ones and 2D/3D idle clocks.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/clk/tegra/clk-id.h              |  4 ++++
>  drivers/clk/tegra/clk-tegra-periph.c    | 23 +++++++++++++++++++++--
>  drivers/clk/tegra/clk-tegra30.c         |  8 ++++++++
>  include/dt-bindings/clock/tegra30-car.h |  7 ++++++-
>  4 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/tegra/clk-id.h b/drivers/clk/tegra/clk-id.h
> index b616e33c5255..0d202a70ce66 100644
> --- a/drivers/clk/tegra/clk-id.h
> +++ b/drivers/clk/tegra/clk-id.h
> @@ -91,8 +91,12 @@ enum clk_id {
>  	tegra_clk_fuse_burn,
>  	tegra_clk_gpu,
>  	tegra_clk_gr2d,
> +	tegra_clk_gr2d_mux,
> +	tegra_clk_gr2d_idle,
>  	tegra_clk_gr2d_8,
>  	tegra_clk_gr3d,
> +	tegra_clk_gr3d_mux,
> +	tegra_clk_gr3d_idle,
>  	tegra_clk_gr3d_8,
>  	tegra_clk_hclk,
>  	tegra_clk_hda,
> diff --git a/drivers/clk/tegra/clk-tegra-periph.c
> b/drivers/clk/tegra/clk-tegra-periph.c index 47e5b1ac1a69..83967dac93f2
> 100644
> --- a/drivers/clk/tegra/clk-tegra-periph.c
> +++ b/drivers/clk/tegra/clk-tegra-periph.c
> @@ -263,6 +263,21 @@
>  		.flags = _flags,					\
>  	}
> 
> +#define GATE_DIV(_name, _parent_name, _offset,				\
> +		 _div_shift, _div_width, _div_frac_width, _div_flags,	\
> +			     _clk_num, _gate_flags,  _clk_id, _flags)	\
> +	{								\
> +		.name = _name,						\
> +		.clk_id = _clk_id,					\
> +		.offset = _offset,					\
> +		.p.parent_name =  _parent_name,				\
> +		.periph = TEGRA_CLK_PERIPH(0, 0, 0,			\
> +					   _div_shift, _div_width,	\
> +					   _div_frac_width, _div_flags, \
> +				_clk_num, _gate_flags, NULL, NULL),	\
> +		.flags = _flags						\
> +	}
> +
>  #define PLLP_BASE 0xa0
>  #define PLLP_MISC 0xac
>  #define PLLP_MISC1 0x680
> @@ -646,8 +661,12 @@ static struct tegra_periph_init_data periph_clks[] = {
>  	MUX("epp", mux_pllm_pllc_pllp_plla, CLK_SOURCE_EPP, 19, 0, 
tegra_clk_epp),
> MUX("host1x", mux_pllm_pllc_pllp_plla, CLK_SOURCE_HOST1X, 28, 0,
> tegra_clk_host1x), MUX("mpe", mux_pllm_pllc_pllp_plla, CLK_SOURCE_MPE, 60,
> 0, tegra_clk_mpe), -	MUX("2d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_2D, 
21,
> 0, tegra_clk_gr2d), -	MUX("3d", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 
24,
> 0, tegra_clk_gr3d), +	MUX("2d_mux", mux_pllm_pllc_pllp_plla, 
CLK_SOURCE_2D,
> 0, TEGRA_PERIPH_NO_DIV | TEGRA_PERIPH_NO_RESET | TEGRA_PERIPH_NO_GATE,
> tegra_clk_gr2d_mux), +	GATE_DIV("2d", "2d_mux", CLK_SOURCE_2D, 0, 8, 1,
> TEGRA_DIVIDER_ROUND_UP,21, 0, tegra_clk_gr2d, 0), +	GATE_DIV("2d_idle",
> "2d_mux", CLK_SOURCE_2D, 8, 8, 1, TEGRA_DIVIDER_ROUND_UP, 0,
> TEGRA_PERIPH_NO_GATE | TEGRA_PERIPH_NO_RESET, tegra_clk_gr2d_idle, 0),
> +	MUX("3d_mux", mux_pllm_pllc_pllp_plla, CLK_SOURCE_3D, 0,
> TEGRA_PERIPH_NO_DIV | TEGRA_PERIPH_NO_RESET | TEGRA_PERIPH_NO_GATE,
> tegra_clk_gr3d_mux), +	GATE_DIV("3d", "3d_mux", CLK_SOURCE_3D, 0, 8, 1,
> TEGRA_DIVIDER_ROUND_UP, 24, 0, tegra_clk_gr3d, 0), +	GATE_DIV("3d_idle",
> "3d_mux", CLK_SOURCE_3D, 8, 8, 1, TEGRA_DIVIDER_ROUND_UP, 0,
> TEGRA_PERIPH_NO_GATE | TEGRA_PERIPH_NO_RESET, tegra_clk_gr3d_idle, 0),
> INT8("vde", mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_VDE, 61, 0,
> tegra_clk_vde_8), INT8("vi", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI,
> 20, 0, tegra_clk_vi_8), INT8("vi", mux_pllm_pllc2_c_c3_pllp_plla_pllc4,
> CLK_SOURCE_VI, 20, 0, tegra_clk_vi_9), diff --git
> a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c index
> acfe661b2ae7..227d3643ecca 100644
> --- a/drivers/clk/tegra/clk-tegra30.c
> +++ b/drivers/clk/tegra/clk-tegra30.c
> @@ -658,8 +658,12 @@ static struct tegra_devclk devclks[] __initdata = {
>  	{ .dev_id = "mpe", .dt_id = TEGRA30_CLK_MPE },
>  	{ .dev_id = "host1x", .dt_id = TEGRA30_CLK_HOST1X },
>  	{ .dev_id = "3d", .dt_id = TEGRA30_CLK_GR3D },
> +	{ .dev_id = "3d", .con_id = "mux", .dt_id = TEGRA30_CLK_GR3D_MUX },
> +	{ .dev_id = "3d", .con_id = "idle", .dt_id = TEGRA30_CLK_GR3D_IDLE },
>  	{ .dev_id = "3d2", .dt_id = TEGRA30_CLK_GR3D2 },
>  	{ .dev_id = "2d", .dt_id = TEGRA30_CLK_GR2D },
> +	{ .dev_id = "2d", .con_id = "mux", .dt_id = TEGRA30_CLK_GR2D_MUX },
> +	{ .dev_id = "2d", .con_id = "idle", .dt_id = TEGRA30_CLK_GR2D_IDLE },
>  	{ .dev_id = "se", .dt_id = TEGRA30_CLK_SE },
>  	{ .dev_id = "mselect", .dt_id = TEGRA30_CLK_MSELECT },
>  	{ .dev_id = "tegra-nor", .dt_id = TEGRA30_CLK_NOR },
> @@ -762,6 +766,10 @@ static struct tegra_clk tegra30_clks[tegra_clk_max]
> __initdata = { [tegra_clk_host1x] = { .dt_id = TEGRA30_CLK_HOST1X, .present
> = true }, [tegra_clk_gr2d] = { .dt_id = TEGRA30_CLK_GR2D, .present = true
> }, [tegra_clk_gr3d] = { .dt_id = TEGRA30_CLK_GR3D, .present = true },
> +	[tegra_clk_gr2d_mux] = { .dt_id = TEGRA30_CLK_GR2D_MUX, .present = true
> }, +	[tegra_clk_gr3d_mux] = { .dt_id = TEGRA30_CLK_GR3D_MUX, .present =
> true }, +	[tegra_clk_gr2d_idle] = { .dt_id = TEGRA30_CLK_GR2D_IDLE,
> .present = true }, +	[tegra_clk_gr3d_idle] = { .dt_id =
> TEGRA30_CLK_GR3D_IDLE, .present = true }, [tegra_clk_mselect] = { .dt_id =
> TEGRA30_CLK_MSELECT, .present = true }, [tegra_clk_nor] = { .dt_id =
> TEGRA30_CLK_NOR, .present = true }, [tegra_clk_sdmmc1] = { .dt_id =
> TEGRA30_CLK_SDMMC1, .present = true }, diff --git

According to TRM, Tegra20 and Tegra114 have these "idle-mode" clock dividers 
as well. Why only T30 should have them?

> a/include/dt-bindings/clock/tegra30-car.h
> b/include/dt-bindings/clock/tegra30-car.h index 3c90f1535551..eda4ca60351e
> 100644
> --- a/include/dt-bindings/clock/tegra30-car.h
> +++ b/include/dt-bindings/clock/tegra30-car.h
> @@ -269,6 +269,11 @@
>  #define TEGRA30_CLK_AUDIO3_MUX 306
>  #define TEGRA30_CLK_AUDIO4_MUX 307
>  #define TEGRA30_CLK_SPDIF_MUX 308
> -#define TEGRA30_CLK_CLK_MAX 309
> +
> +#define TEGRA30_CLK_GR2D_MUX	309
> +#define TEGRA30_CLK_GR3D_MUX	310
> +#define TEGRA30_CLK_GR2D_IDLE	311
> +#define TEGRA30_CLK_GR3D_IDLE	312
> +#define TEGRA30_CLK_CLK_MAX 313
> 
>  #endif	/* _DT_BINDINGS_CLOCK_TEGRA30_CAR_H */

IIUC, that "idle-mode" divisor is just some kind of power-safe feature, is 
there any real use-case for these clocks? Why not to just pre-configure the 
"idle-mode" bits during the clocks initialization?



