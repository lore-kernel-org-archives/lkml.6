Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9223FC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D60421477
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cx7+jb0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D60421477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeJMB1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:36082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeJMB1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:27:02 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 521892077C;
        Fri, 12 Oct 2018 17:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539366804;
        bh=dEYbNONSKBvuOQkevEa86ChpTfk8xvzr5l2a4w2Z31Q=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=Cx7+jb0+RDv+OGwctjogP/yteW490Mi0uI/dulbpkwhJtf2dQZJEz+1NBLlNGQOi+
         PkkG3PY7iC3dgCeS36qQl/XR15VJiNvceuNGTusG3IgenSnMicAFf9gdmWdr8u73s4
         cq7CLEqYkAn04lmM2BK9iz+xz5moNlOuzLMoML1k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180920095727.11868-5-weiyi.lu@mediatek.com>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, Weiyi Lu <weiyi.lu@mediatek.com>
References: <20180920095727.11868-1-weiyi.lu@mediatek.com>
 <20180920095727.11868-5-weiyi.lu@mediatek.com>
Message-ID: <153936680359.5275.14901579706860255114@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 3/3] clk: mediatek: mt2712: add pll reference support
Date:   Fri, 12 Oct 2018 10:53:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Weiyi Lu (2018-09-20 02:57:27)
> For some MT2712 projects, audpll could select another reference
> clock source if there exists an extra Crystal Oscillators than
> the default clk26m XTAL.
> Declare with the property "mediatek,refclk-aud" to switch
> the audpll reference clock.
> And also support to modify the reference clock of all PLL with
> property "mediatek,refclk" instead of the default source "clk26m".
> =

> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk=
-mt2712.c
> index e36f4aab634d..2a4db1718089 100644
> --- a/drivers/clk/mediatek/clk-mt2712.c
> +++ b/drivers/clk/mediatek/clk-mt2712.c
[...]
> +       size_t i;
> +       u32 r;
> +
> +       base =3D of_iomap(node, 0);
> +       if (base) {
> +               sel_addr =3D base + 0x40;
> +       } else {
> +               pr_err("%s(): ioremap failed\n", __func__);
> +               return;
> +       }

Nitpick: Write this as

	base =3D of_iomap();
	if (!base)
		return;
	sel_addr =3D base + 0x40;

> +
> +       rc =3D of_parse_phandle_with_args(node, "mediatek,refclk",
> +                       "#clock-cells", 0, &refclk);
> +       if (!rc) {
> +               of_property_read_string(refclk.np, "clock-output-names",
> +                               &refclk_name);
> +               for (i =3D 0; i < num_plls; i++)
> +                       plls[i].parent_name =3D refclk_name;

Use of_clk_parent_fill()?

> +       }
> +
> +       rc =3D of_parse_phandle_with_args(node, "mediatek,refclk-aud",
> +                       "#clock-cells", 0, &refclk_aud);

This is odd. Is this a custom 'clocks' property? What's going on here?
Why can't we use assigned clock parents for this?

> +       if (!rc) {
> +               of_property_read_string(refclk_aud.np, "clock-output-name=
s",
> +                               &refclk_aud_name);
> +               if (strcmp(refclk_name, refclk_aud_name)) {
> +                       plls[CLK_APMIXED_APLL1].parent_name =3D refclk_au=
d_name;
> +                       plls[CLK_APMIXED_APLL2].parent_name =3D refclk_au=
d_name;
> +                       r =3D readl(sel_addr) | 0x60000;
> +               } else {
> +                       r =3D readl(sel_addr) & ~0x60000;
> +               }
> +
> +               writel(r, sel_addr);
> +       }
> +}
> +
