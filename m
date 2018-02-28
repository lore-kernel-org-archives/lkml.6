Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932277AbeB1Qrz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:47:55 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:37466 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752636AbeB1Qry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:47:54 -0500
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH] drm/sun4i: Fix dclk_set_phase
Date: Wed, 28 Feb 2018 17:46:53 +0100
Message-Id: <1519836413-35023-1-git-send-email-giulio.benetti@micronovasrl.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phase value is not shifted before writing.

Shift left of 28 bits to fit right bits

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
index 023f39b..e36004f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -132,10 +132,13 @@ static int sun4i_dclk_get_phase(struct clk_hw *hw)
 static int sun4i_dclk_set_phase(struct clk_hw *hw, int degrees)
 {
 	struct sun4i_dclk *dclk = hw_to_dclk(hw);
+	u32 val = degrees / 120;
+
+	val <<= 28;
 
 	regmap_update_bits(dclk->regmap, SUN4I_TCON0_IO_POL_REG,
 			   GENMASK(29, 28),
-			   degrees / 120);
+			   val);
 
 	return 0;
 }
-- 
2.7.4
