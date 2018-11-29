Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3BEC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46DF120989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 00:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lTvpvEqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DF120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbeK2LpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 06:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:51472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbeK2LpU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 06:45:20 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1BBFD20832;
        Thu, 29 Nov 2018 00:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543452110;
        bh=mNn4j0DrF7UFW+rjHZiqbyYTmZ6HMSXM5VWr/goC1/w=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=lTvpvEqD9hcF+SeYn77z3LqaL8ZfNhW2j4S4mFy4sVyXKH5Rbc96h7yanB/7rYq72
         DYVsNQWCRXkIpqSQHaTpz+T1sFNEcYpuTK6/5YUB4XGjUlO6XeLNPyPd1oeijCzNwP
         ZgA6ON7zbnhG7LQZR8imkJ8dP+D5ssuJuvVo78yQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
References: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <154345210894.88331.8277410833858111600@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v13 0/5] Add i.MX8MQ clock driver
Date:   Wed, 28 Nov 2018 16:41:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-11-13 08:19:56)
> Here is a link to the 12th version:
> https://lkml.org/lkml/2018/11/7/642
> =

> Changes since v12:
>  * replaced the division in clk_pll_recalc_rate in clk-frac
>    with do_div as suggested by Stephen
> =

> Abel Vesa (2):
>   clk: imx: Add imx composite clock
>   clk: imx: Add clock driver for i.MX8MQ CCM
> =

> Lucas Stach (3):
>   dt-bindings: add binding for i.MX8MQ CCM
>   clk: imx: add fractional PLL output clock
>   clk: imx: Add SCCG PLL type
> =


I had to apply this set of fixes to silence sparse and smatch warnings
about things that are not right. Please take a look over things and see
if it's sane.

diff --git a/drivers/clk/imx/clk-composite-8m.c b/drivers/clk/imx/clk-compo=
site-8m.c
index bcd31d889584..6d9d3714b4df 100644
--- a/drivers/clk/imx/clk-composite-8m.c
+++ b/drivers/clk/imx/clk-composite-8m.c
@@ -127,8 +127,8 @@ struct clk *imx8m_clk_composite_flags(const char *name,
 					int num_parents, void __iomem *reg,
 					unsigned long flags)
 {
-	struct clk_hw *hw =3D NULL, *mux_hw =3D NULL;
-	struct clk_hw *div_hw =3D NULL, *gate_hw =3D NULL;
+	struct clk_hw *hw =3D ERR_PTR(-ENOMEM), *mux_hw;
+	struct clk_hw *div_hw, *gate_hw;
 	struct clk_divider *div =3D NULL;
 	struct clk_gate *gate =3D NULL;
 	struct clk_mux *mux =3D NULL;
diff --git a/drivers/clk/imx/clk-frac-pll.c b/drivers/clk/imx/clk-frac-pll.c
index a3732be5ad7f..98726206f3c4 100644
--- a/drivers/clk/imx/clk-frac-pll.c
+++ b/drivers/clk/imx/clk-frac-pll.c
@@ -14,6 +14,8 @@
 #include <linux/slab.h>
 #include <linux/bitfield.h>
 =

+#include "clk.h"
+
 #define PLL_CFG0		0x0
 #define PLL_CFG1		0x4
 =

@@ -214,7 +216,7 @@ struct clk *imx_clk_frac_pll(const char *name, const ch=
ar *parent_name,
 	ret =3D clk_hw_register(NULL, hw);
 	if (ret) {
 		kfree(pll);
-		return ERR_CAST(hw);
+		return ERR_PTR(ret);
 	}
 =

 	return hw->clk;
diff --git a/drivers/clk/imx/clk-sccg-pll.c b/drivers/clk/imx/clk-sccg-pll.c
index 4666b96bdb3f..ee7752bace89 100644
--- a/drivers/clk/imx/clk-sccg-pll.c
+++ b/drivers/clk/imx/clk-sccg-pll.c
@@ -249,7 +249,7 @@ struct clk *imx_clk_sccg_pll(const char *name,
 	ret =3D clk_hw_register(NULL, hw);
 	if (ret) {
 		kfree(pll);
-		return ERR_CAST(hw);
+		return ERR_PTR(ret);
 	}
 =

 	return hw->clk;
