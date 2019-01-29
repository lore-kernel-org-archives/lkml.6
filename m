Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFB2C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D04F621848
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548785358;
	bh=VkDWohIUenCSmi9fACRiHhRgqBorJR6nclSPdr+2RTs=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=szeYrTpKip5QIxTgI8yIVQih2H/boAl2rCv1DppidkwpUMiWzZpmWKNg1KQ/MW6Wn
	 KndEccPBIj5quui+JoqZyoNDjBpSLCQY2bvbxf3gnaXtXRFrpvPhY7PzTijnfdPnrG
	 sBJFsQ7sGtV6ORTmyjtPfhKorpvDLr5dbxH0qaUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfA2SJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 13:09:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfA2SJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 13:09:16 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00DC2084A;
        Tue, 29 Jan 2019 18:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548785355;
        bh=VkDWohIUenCSmi9fACRiHhRgqBorJR6nclSPdr+2RTs=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=f9qXvm99ZMZhTWgYI1q+gleMChm6HixUeTL9EhMS7/Ws+3CqA28jh6ILM43noIppx
         VFIXZ1qDRS5A8Xmdux7V/zADLocuzbQcRjGuVSbZiGcH54yidfAdTD8R+pzpyRN4d1
         nlmX2oStBM3gx99tICOIhZHDiYUDIoap8uWseBmM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 14/14] clk: meson: rework and clean drivers dependencies
References: <20190128180430.28689-1-jbrunet@baylibre.com> <20190128180430.28689-15-jbrunet@baylibre.com>
User-Agent: alot/0.8
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190128180430.28689-15-jbrunet@baylibre.com>
Message-ID: <154878535502.136743.7217447718652873910@swboyd.mtv.corp.google.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Date:   Tue, 29 Jan 2019 10:09:15 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-01-28 10:04:30)
> Initially, the meson clock directory only hosted 2 controllers drivers,
> for meson8 and gxbb. At the time, both used the same set of clock drivers
> so managing the dependencies was not a big concern.
>=20
> Since this ancient time, entropy did its job, controllers with different
> requirement and specific clock drivers have been added. Unfortunately, we
> did not do a great job at managing the dependencies between the
> controllers and the different clock drivers. Some drivers, such as
> clk-phase or vid-pll-div, are compiled even if they are useless on the
> target (meson8). As we are adding new controllers, we need to be able to
> pick a driver w/o pulling the whole thing.
>=20
> The patch aims to clean things up by:
> * providing a dedicated CONFIG_ for each clock drivers
> * allowing clock drivers to be compiled as a modules, if possible
> * stating explicitly which drivers are required by each controller.
>=20
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Sounds good to me.

> diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
> index 2b9490dd9878..8baec10a49a1 100644
> --- a/drivers/clk/meson/Makefile
> +++ b/drivers/clk/meson/Makefile
> @@ -2,12 +2,17 @@
>  # Makefile for Meson specific clk
>  #
> =20

Add a comment here that these are all the clk library parts or something
like that?

> -obj-$(CONFIG_COMMON_CLK_AMLOGIC) +=3D clk-pll.o clk-mpll.o clk-phase.o v=
id-pll-div.o
> -obj-$(CONFIG_COMMON_CLK_AMLOGIC) +=3D clk-input.o clk-dualdiv.o
> -obj-$(CONFIG_COMMON_CLK_AMLOGIC_AUDIO) +=3D sclk-div.o
> -obj-$(CONFIG_COMMON_CLK_MESON_AO) +=3D meson-aoclk.o
> +obj-$(CONFIG_COMMON_CLK_MESON_INPUT) +=3D clk-input.o
> +obj-$(CONFIG_COMMON_CLK_MESON_REGMAP) +=3D clk-regmap.o
> +obj-$(CONFIG_COMMON_CLK_MESON_DUALDIV) +=3D clk-dualdiv.o
> +obj-$(CONFIG_COMMON_CLK_MESON_MPLL) +=3D clk-mpll.o
> +obj-$(CONFIG_COMMON_CLK_MESON_PHASE) +=3D clk-phase.o
> +obj-$(CONFIG_COMMON_CLK_MESON_PLL) +=3D clk-pll.o
> +obj-$(CONFIG_COMMON_CLK_MESON_SCLK_DIV) +=3D sclk-div.o
> +obj-$(CONFIG_COMMON_CLK_MESON_VID_PLL_DIV) +=3D vid-pll-div.o
> +obj-$(CONFIG_COMMON_CLK_MESON_AO_CLKC) +=3D meson-aoclk.o
> +

And maybe add a comment here indicating that SoC drivers go below?

>  obj-$(CONFIG_COMMON_CLK_MESON8B) +=3D meson8b.o
> -obj-$(CONFIG_COMMON_CLK_GXBB)   +=3D gxbb.o gxbb-aoclk.o
> -obj-$(CONFIG_COMMON_CLK_AXG)    +=3D axg.o axg-aoclk.o
> -obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)     +=3D axg-audio.o
> -obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)  +=3D clk-regmap.o
> +obj-$(CONFIG_COMMON_CLK_GXBB) +=3D gxbb.o gxbb-aoclk.o
> +obj-$(CONFIG_COMMON_CLK_AXG) +=3D axg.o axg-aoclk.o
> +obj-$(CONFIG_COMMON_CLK_AXG_AUDIO) +=3D axg-audio.o

And sort them by config name alphanumerically?

