Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDADECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E724C2081D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E724C2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbeKEDnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:43:35 -0500
Received: from mailoutvs53.siol.net ([185.57.226.244]:47128 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387432AbeKEDne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:43:34 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 4F0CC52126B;
        Sun,  4 Nov 2018 19:27:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id jXw0uIsmYZEw; Sun,  4 Nov 2018 19:27:39 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id CB24D521270;
        Sun,  4 Nov 2018 19:27:38 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 5211052126B;
        Sun,  4 Nov 2018 19:27:36 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net,
        stable@vger.kernel.org
Subject: [PATCH v3 03/28] clk: sunxi-ng: Use u64 for calculation of NM rate
Date:   Sun,  4 Nov 2018 19:26:40 +0100
Message-Id: <20181104182705.18047-4-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allwinner H6 SoC has multiplier N range between 1 and 254. Since parent
rate is 24MHz, intermediate result when calculating final rate easily
overflows 32 bit variable.

Because of that, introduce function for calculating clock rate which
uses 64 bit variable for intermediate result.

Fixes: 6174a1e24b0d ("clk: sunxi-ng: Add N-M-factor clock support")
Fixes: ee28648cb2b4 ("clk: sunxi-ng: Remove the use of rational computati=
ons")

CC: <stable@vger.kernel.org>
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_nm.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_nm.c b/drivers/clk/sunxi-ng/ccu_nm.=
c
index 6fe3c14f7b2d..424d8635b053 100644
--- a/drivers/clk/sunxi-ng/ccu_nm.c
+++ b/drivers/clk/sunxi-ng/ccu_nm.c
@@ -19,6 +19,17 @@ struct _ccu_nm {
 	unsigned long	m, min_m, max_m;
 };
=20
+static unsigned long ccu_nm_calc_rate(unsigned long parent,
+				      unsigned long n, unsigned long m)
+{
+	u64 rate =3D parent;
+
+	rate *=3D n;
+	do_div(rate, m);
+
+	return rate;
+}
+
 static void ccu_nm_find_best(unsigned long parent, unsigned long rate,
 			     struct _ccu_nm *nm)
 {
@@ -28,7 +39,8 @@ static void ccu_nm_find_best(unsigned long parent, unsi=
gned long rate,
=20
 	for (_n =3D nm->min_n; _n <=3D nm->max_n; _n++) {
 		for (_m =3D nm->min_m; _m <=3D nm->max_m; _m++) {
-			unsigned long tmp_rate =3D parent * _n  / _m;
+			unsigned long tmp_rate =3D ccu_nm_calc_rate(parent,
+								  _n, _m);
=20
 			if (tmp_rate > rate)
 				continue;
@@ -100,7 +112,7 @@ static unsigned long ccu_nm_recalc_rate(struct clk_hw=
 *hw,
 	if (ccu_sdm_helper_is_enabled(&nm->common, &nm->sdm))
 		rate =3D ccu_sdm_helper_read_rate(&nm->common, &nm->sdm, m, n);
 	else
-		rate =3D parent_rate * n / m;
+		rate =3D ccu_nm_calc_rate(parent_rate, n, m);
=20
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /=3D nm->fixed_post_div;
@@ -149,7 +161,7 @@ static long ccu_nm_round_rate(struct clk_hw *hw, unsi=
gned long rate,
 	_nm.max_m =3D nm->m.max ?: 1 << nm->m.width;
=20
 	ccu_nm_find_best(*parent_rate, rate, &_nm);
-	rate =3D *parent_rate * _nm.n / _nm.m;
+	rate =3D ccu_nm_calc_rate(*parent_rate, _nm.n, _nm.m);
=20
 	if (nm->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /=3D nm->fixed_post_div;
--=20
2.19.1

