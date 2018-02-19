Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932159AbeBSV5C (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 16:57:02 -0500
Received: from vern.gendns.com ([206.190.152.46]:33549 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932089AbeBSV5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 16:57:01 -0500
From: David Lechner <david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when bits_per_mux != 0
Date: Mon, 19 Feb 2018 15:57:07 -0600
Message-Id: <1519077427-30165-1-git-send-email-david@lechnology.com>
X-Mailer: git-send-email 2.7.4
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes pcs_request_gpio() in the pinctrl-single driver when
bits_per_mux != 0. It appears this was overlooked when the multiple
pins per register feature was added.

Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
Signed-off-by: David Lechner <david@lechnology.com>
---

v2 changes:
- don't wrap Fixes: line in commit message since it is a special machine-
  readable line.

There was some discussion in v1 about using DIV_ROUND_UP(), etc. macros, but
the consensus was to leave it as-is since it matches existing code and that
macros can be introduced in another patch.

 drivers/pinctrl/pinctrl-single.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index cec7537..a7c5eb3 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -391,9 +391,25 @@ static int pcs_request_gpio(struct pinctrl_dev *pctldev,
 			|| pin < frange->offset)
 			continue;
 		mux_bytes = pcs->width / BITS_PER_BYTE;
-		data = pcs->read(pcs->base + pin * mux_bytes) & ~pcs->fmask;
-		data |= frange->gpiofunc;
-		pcs->write(data, pcs->base + pin * mux_bytes);
+
+		if (pcs->bits_per_mux) {
+			int byte_num, offset, pin_shift;
+
+			byte_num = (pcs->bits_per_pin * pin) / BITS_PER_BYTE;
+			offset = (byte_num / mux_bytes) * mux_bytes;
+			pin_shift = pin % (pcs->width / pcs->bits_per_pin) *
+				    pcs->bits_per_pin;
+
+			data = pcs->read(pcs->base + offset);
+			data &= ~(pcs->fmask << pin_shift);
+			data |= frange->gpiofunc << pin_shift;
+			pcs->write(data, pcs->base + offset);
+		} else {
+			data = pcs->read(pcs->base + pin * mux_bytes);
+			data &= ~pcs->fmask;
+			data |= frange->gpiofunc;
+			pcs->write(data, pcs->base + pin * mux_bytes);
+		}
 		break;
 	}
 	return 0;
-- 
2.7.4
