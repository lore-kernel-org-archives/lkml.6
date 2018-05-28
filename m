Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161815AbeE1Kd5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:33:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161296AbeE1Kdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:33:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 170/329] drm/sun4i: Fix dclk_set_phase
Date: Mon, 28 May 2018 12:01:39 +0200
Message-Id: <20180528100256.561341894@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

[ Upstream commit e64b6afa98f3629d0c0c46233bbdbe8acdb56f06 ]

Phase value is not shifted before writing.

Shift left of 28 bits to fit right bits

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1519836413-35023-1-git-send-email-giulio.benetti@micronovasrl.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sun4i/sun4i_dotclock.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
+++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
@@ -129,10 +129,13 @@ static int sun4i_dclk_get_phase(struct c
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
