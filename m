Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05463C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56A9208DE
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 00:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gt6WnSeN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56A9208DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933362AbeGIAAU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 20:00:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:58982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932942AbeGIAAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 20:00:19 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CEC1208DE;
        Mon,  9 Jul 2018 00:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531094418;
        bh=cbLkPb4hRhS/paRa5WrZIXHD6GsmW5CXFIZ+u3MFcVY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Gt6WnSeNytorfR+Xk/Uve0XmiY7GQO4Zg4yZSqrecQgNVz8jUMa5n66yTCndXopGf
         AFcyUkKaYSYcTLo2JZ/8bW7+b0ouLQ+tOsaMYo9T2a6/jFy27uwm/u5QK3xxejLPcP
         TKM35Ald07Kom3KrzeCCI27r9Bce6GDijLUUfsLg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180617145539.4758-7-digetx@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180617145539.4758-1-digetx@gmail.com>
 <20180617145539.4758-7-digetx@gmail.com>
Message-ID: <153109441777.143105.8459253820659446035@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 6/8] clk: tegra20: Turn EMC clock gate into divider
Date:   Sun, 08 Jul 2018 17:00:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2018-06-17 07:55:37)
> Kernel should never gate the EMC clock as it causes immediate lockup, so
> removing clk-gate functionality doesn't affect anything. Turning EMC clk
> gate into divider allows to implement glitch-less EMC scaling, avoiding
> reparenting to a backup clock.
> =

> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---

Who's supposed to apply this? Me? Thierry? The "To:" line is not
useful when every maintainer is there.

> diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegr=
a20.c
> index cc857d4d4a86..2bd35418716a 100644
> --- a/drivers/clk/tegra/clk-tegra20.c
> +++ b/drivers/clk/tegra/clk-tegra20.c
> @@ -799,6 +798,31 @@ static struct tegra_periph_init_data tegra_periph_no=
div_clk_list[] =3D {
>         TEGRA_INIT_DATA_NODIV("disp2",  mux_pllpdc_clkm, CLK_SOURCE_DISP2=
, 30, 2, 26,  0, TEGRA20_CLK_DISP2),
>  };
>  =

> +static void __init tegra20_emc_clk_init(void)
> +{
> +       struct clk *clk;
> +
> +       clk =3D clk_register_mux(NULL, "emc_mux", mux_pllmcp_clkm,
> +                              ARRAY_SIZE(mux_pllmcp_clkm),
> +                              CLK_SET_RATE_NO_REPARENT,
> +                              clk_base + CLK_SOURCE_EMC,
> +                              30, 2, 0, &emc_lock);
> +
> +       clk =3D tegra_clk_register_mc("mc", "emc_mux", clk_base + CLK_SOU=
RCE_EMC,
> +                                   &emc_lock);
> +       clks[TEGRA20_CLK_MC] =3D clk;
> +
> +       /*
> +        * Note that 'emc_mux' source and 'emc' rate shouldn't be changed=
 at
> +        * the same time due to a HW bug, this won't happen because we're
> +        * defining 'emc_mux' and 'emc' as a distinct clocks.

s/ a//

