Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C8C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C3F20854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 18:27:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C3F20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387447AbeKEDne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 22:43:34 -0500
Received: from mailoutvs8.siol.net ([185.57.226.199]:47107 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387431AbeKEDnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 22:43:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id B710652126A;
        Sun,  4 Nov 2018 19:27:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id wN4M1pcLPRoh; Sun,  4 Nov 2018 19:27:36 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 4A46F521256;
        Sun,  4 Nov 2018 19:27:36 +0100 (CET)
Received: from localhost.localdomain (cpe1-8-82.cable.triera.net [213.161.8.82])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 840BB52126A;
        Sun,  4 Nov 2018 19:27:33 +0100 (CET)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     maxime.ripard@bootlin.com, wens@csie.org
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        airlied@linux.ie, architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, jernej.skrabec@siol.net
Subject: [PATCH v3 02/28] clk: sunxi-ng: Adjust MP clock parent rate when allowed
Date:   Sun,  4 Nov 2018 19:26:39 +0100
Message-Id: <20181104182705.18047-3-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181104182705.18047-1-jernej.skrabec@siol.net>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently MP clocks don't consider adjusting parent rate even if they
are allowed to do so. Such behaviour considerably lowers amount of
possible rates, which is very inconvenient when such clock is used for
pixel clock, for example.

In order to improve the situation, adjusting parent rate is considered
when allowed.

This code is inspired by clk_divider_bestdiv() function, which does
basically the same thing for different clock type.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_mp.c | 64 +++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_mp.c b/drivers/clk/sunxi-ng/ccu_mp.=
c
index 5d0af4051737..0357349eb767 100644
--- a/drivers/clk/sunxi-ng/ccu_mp.c
+++ b/drivers/clk/sunxi-ng/ccu_mp.c
@@ -40,6 +40,61 @@ static void ccu_mp_find_best(unsigned long parent, uns=
igned long rate,
 	*p =3D best_p;
 }
=20
+static unsigned long ccu_mp_find_best_with_parent_adj(struct clk_hw *hw,
+						      unsigned long *parent,
+						      unsigned long rate,
+						      unsigned int max_m,
+						      unsigned int max_p)
+{
+	unsigned long parent_rate_saved;
+	unsigned long parent_rate, now;
+	unsigned long best_rate =3D 0;
+	unsigned int _m, _p, div;
+	unsigned long maxdiv;
+
+	parent_rate_saved =3D *parent;
+
+	/*
+	 * The maximum divider we can use without overflowing
+	 * unsigned long in rate * m * p below
+	 */
+	maxdiv =3D max_m * max_p;
+	maxdiv =3D min(ULONG_MAX / rate, maxdiv);
+
+	for (_p =3D 1; _p <=3D max_p; _p <<=3D 1) {
+		for (_m =3D 1; _m <=3D max_m; _m++) {
+			div =3D _m * _p;
+
+			if (div > maxdiv)
+				break;
+
+			if (rate * div =3D=3D parent_rate_saved) {
+				/*
+				 * It's the most ideal case if the requested
+				 * rate can be divided from parent clock without
+				 * needing to change parent rate, so return the
+				 * divider immediately.
+				 */
+				*parent =3D parent_rate_saved;
+				return rate;
+			}
+
+			parent_rate =3D clk_hw_round_rate(hw, rate * div);
+			now =3D parent_rate / div;
+
+			if (now <=3D rate && now > best_rate) {
+				best_rate =3D now;
+				*parent =3D parent_rate;
+
+				if (now =3D=3D rate)
+					return rate;
+			}
+		}
+	}
+
+	return best_rate;
+}
+
 static unsigned long ccu_mp_round_rate(struct ccu_mux_internal *mux,
 				       struct clk_hw *hw,
 				       unsigned long *parent_rate,
@@ -56,8 +111,13 @@ static unsigned long ccu_mp_round_rate(struct ccu_mux=
_internal *mux,
 	max_m =3D cmp->m.max ?: 1 << cmp->m.width;
 	max_p =3D cmp->p.max ?: 1 << ((1 << cmp->p.width) - 1);
=20
-	ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
-	rate =3D *parent_rate / p / m;
+	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
+		ccu_mp_find_best(*parent_rate, rate, max_m, max_p, &m, &p);
+		rate =3D *parent_rate / p / m;
+	} else {
+		rate =3D ccu_mp_find_best_with_parent_adj(hw, parent_rate, rate,
+							max_m, max_p);
+	}
=20
 	if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV)
 		rate /=3D cmp->fixed_post_div;
--=20
2.19.1

