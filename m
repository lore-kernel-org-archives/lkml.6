Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E12C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB3520844
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 11:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB3520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeIHPxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 11:53:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5661 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726443AbeIHPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 11:53:18 -0400
X-UUID: b6307c3d32c4430e9554deef7e3b9e30-20180908
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1696258006; Sat, 08 Sep 2018 19:07:41 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 8 Sep 2018 19:07:39 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 8 Sep 2018 19:07:40 +0800
From:   <sean.wang@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 03/22] pinctrl: mediatek: extend struct mtk_pin_field_calc to pinctrl-mtk-common-v2.c
Date:   Sat, 8 Sep 2018 19:07:19 +0800
Message-ID: <d43dc09d7ef45940ee14ecf546e939e39315a28f.1536404280.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This patch adds members sz_reg fixed in struct mtk_pin_field_calc

- The 'fixed' is used to represent the consecutive pins share the same
bits within the same register with the 1st pin so that it can largely
reduce the entry size a bit.

- The 'sz_reg' is used to indicate the range of bits we use in a register
  that may vary by SoC

The above changes make the code more generic and this is useful as there
might be other existing or future chips all use the same logic to access
their register set and then being a little more abstract could help in the
long run.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt7622.c        | 210 ++++++++++-------------
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |  17 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h |  25 +++
 3 files changed, 126 insertions(+), 126 deletions(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7622.c b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
index 224fc01..b9c1680 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7622.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7622.c
@@ -9,159 +9,129 @@
 #include "pinctrl-moore.h"
 
 static const struct mtk_pin_field_calc mt7622_pin_mode_range[] = {
-	{0, 0, 0x320, 0x10, 16, 4},
-	{1, 4, 0x3a0, 0x10,  16, 4},
-	{5, 5, 0x320, 0x10,  0, 4},
-	{6, 6, 0x300, 0x10,  4, 4},
-	{7, 7, 0x300, 0x10,  4, 4},
-	{8, 9, 0x350, 0x10,  20, 4},
-	{10, 10, 0x300, 0x10, 8, 4},
-	{11, 11, 0x300, 0x10, 8, 4},
-	{12, 12, 0x300, 0x10, 8, 4},
-	{13, 13, 0x300, 0x10, 8, 4},
-	{14, 15, 0x320, 0x10, 4, 4},
-	{16, 17, 0x320, 0x10, 20, 4},
-	{18, 21, 0x310, 0x10, 16, 4},
-	{22, 22, 0x380, 0x10, 16, 4},
-	{23, 23, 0x300,	0x10, 24, 4},
-	{24, 24, 0x300, 0x10, 24, 4},
-	{25, 25, 0x300, 0x10, 12, 4},
-	{25, 25, 0x300, 0x10, 12, 4},
-	{26, 26, 0x300, 0x10, 12, 4},
-	{27, 27, 0x300, 0x10, 12, 4},
-	{28, 28, 0x300, 0x10, 12, 4},
-	{29, 29, 0x300, 0x10, 12, 4},
-	{30, 30, 0x300, 0x10, 12, 4},
-	{31, 31, 0x300, 0x10, 12, 4},
-	{32, 32, 0x300, 0x10, 12, 4},
-	{33, 33, 0x300,	0x10, 12, 4},
-	{34, 34, 0x300,	0x10, 12, 4},
-	{35, 35, 0x300,	0x10, 12, 4},
-	{36, 36, 0x300, 0x10, 12, 4},
-	{37, 37, 0x300, 0x10, 20, 4},
-	{38, 38, 0x300, 0x10, 20, 4},
-	{39, 39, 0x300, 0x10, 20, 4},
-	{40, 40, 0x300, 0x10, 20, 4},
-	{41, 41, 0x300,	0x10, 20, 4},
-	{42, 42, 0x300, 0x10, 20, 4},
-	{43, 43, 0x300,	0x10, 20, 4},
-	{44, 44, 0x300, 0x10, 20, 4},
-	{45, 46, 0x300, 0x10, 20, 4},
-	{47, 47, 0x300,	0x10, 20, 4},
-	{48, 48, 0x300, 0x10, 20, 4},
-	{49, 49, 0x300, 0x10, 20, 4},
-	{50, 50, 0x300, 0x10, 20, 4},
-	{51, 70, 0x330, 0x10, 4, 4},
-	{71, 71, 0x300, 0x10, 16, 4},
-	{72, 72, 0x300, 0x10, 16, 4},
-	{73, 76, 0x310, 0x10, 0, 4},
-	{77, 77, 0x320, 0x10, 28, 4},
-	{78, 78, 0x320, 0x10, 12, 4},
-	{79, 82, 0x3a0, 0x10, 0, 4},
-	{83, 83, 0x350,	0x10, 28, 4},
-	{84, 84, 0x330, 0x10, 0, 4},
-	{85, 90, 0x360, 0x10, 4, 4},
-	{91, 94, 0x390, 0x10, 16, 4},
-	{95, 97, 0x380, 0x10, 20, 4},
-	{98, 101, 0x390, 0x10, 0, 4},
-	{102, 102, 0x360, 0x10, 0, 4},
+	PIN_FIELD(0, 0, 0x320, 0x10, 16, 4),
+	PIN_FIELD(1, 4, 0x3a0, 0x10, 16, 4),
+	PIN_FIELD(5, 5, 0x320, 0x10, 0, 4),
+	PINS_FIELD(6, 7, 0x300, 0x10, 4, 4),
+	PIN_FIELD(8, 9, 0x350, 0x10, 20, 4),
+	PINS_FIELD(10, 13, 0x300, 0x10, 8, 4),
+	PIN_FIELD(14, 15, 0x320, 0x10, 4, 4),
+	PIN_FIELD(16, 17, 0x320, 0x10, 20, 4),
+	PIN_FIELD(18, 21, 0x310, 0x10, 16, 4),
+	PIN_FIELD(22, 22, 0x380, 0x10, 16, 4),
+	PINS_FIELD(23, 24, 0x300, 0x10, 24, 4),
+	PINS_FIELD(25, 36, 0x300, 0x10, 12, 4),
+	PINS_FIELD(37, 50, 0x300, 0x10, 20, 4),
+	PIN_FIELD(51, 70, 0x330, 0x10, 4, 4),
+	PINS_FIELD(71, 72, 0x300, 0x10, 16, 4),
+	PIN_FIELD(73, 76, 0x310, 0x10, 0, 4),
+	PIN_FIELD(77, 77, 0x320, 0x10, 28, 4),
+	PIN_FIELD(78, 78, 0x320, 0x10, 12, 4),
+	PIN_FIELD(79, 82, 0x3a0, 0x10, 0, 4),
+	PIN_FIELD(83, 83, 0x350, 0x10, 28, 4),
+	PIN_FIELD(84, 84, 0x330, 0x10, 0, 4),
+	PIN_FIELD(85, 90, 0x360, 0x10, 4, 4),
+	PIN_FIELD(91, 94, 0x390, 0x10, 16, 4),
+	PIN_FIELD(95, 97, 0x380, 0x10, 20, 4),
+	PIN_FIELD(98, 101, 0x390, 0x10, 0, 4),
+	PIN_FIELD(102, 102, 0x360, 0x10, 0, 4),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_dir_range[] = {
-	{0, 102, 0x0, 0x10, 0, 1},
+	PIN_FIELD(0, 102, 0x0, 0x10, 0, 1),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_di_range[] = {
-	{0, 102, 0x200, 0x10, 0, 1},
+	PIN_FIELD(0, 102, 0x200, 0x10, 0, 1),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_do_range[] = {
-	{0, 102, 0x100, 0x10, 0, 1},
+	PIN_FIELD(0, 102, 0x100, 0x10, 0, 1),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_sr_range[] = {
-	{0, 31, 0x910, 0x10, 0, 1},
-	{32, 50, 0xa10, 0x10, 0, 1},
-	{51, 70, 0x810, 0x10, 0, 1},
-	{71, 72, 0xb10, 0x10, 0, 1},
-	{73, 86, 0xb10, 0x10, 4, 1},
-	{87, 90, 0xc10, 0x10, 0, 1},
-	{91, 102, 0xb10, 0x10, 18, 1},
+	PIN_FIELD(0, 31, 0x910, 0x10, 0, 1),
+	PIN_FIELD(32, 50, 0xa10, 0x10, 0, 1),
+	PIN_FIELD(51, 70, 0x810, 0x10, 0, 1),
+	PIN_FIELD(71, 72, 0xb10, 0x10, 0, 1),
+	PIN_FIELD(73, 86, 0xb10, 0x10, 4, 1),
+	PIN_FIELD(87, 90, 0xc10, 0x10, 0, 1),
+	PIN_FIELD(91, 102, 0xb10, 0x10, 18, 1),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_smt_range[] = {
-	{0, 31, 0x920, 0x10, 0, 1},
-	{32, 50, 0xa20, 0x10, 0, 1},
-	{51, 70, 0x820, 0x10, 0, 1},
-	{71, 72, 0xb20, 0x10, 0, 1},
-	{73, 86, 0xb20, 0x10, 4, 1},
-	{87, 90, 0xc20, 0x10, 0, 1},
-	{91, 102, 0xb20, 0x10, 18, 1},
+	PIN_FIELD(0, 31, 0x920, 0x10, 0, 1),
+	PIN_FIELD(32, 50, 0xa20, 0x10, 0, 1),
+	PIN_FIELD(51, 70, 0x820, 0x10, 0, 1),
+	PIN_FIELD(71, 72, 0xb20, 0x10, 0, 1),
+	PIN_FIELD(73, 86, 0xb20, 0x10, 4, 1),
+	PIN_FIELD(87, 90, 0xc20, 0x10, 0, 1),
+	PIN_FIELD(91, 102, 0xb20, 0x10, 18, 1),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_pu_range[] = {
-	{0, 31, 0x930, 0x10, 0, 1},
-	{32, 50, 0xa30, 0x10, 0, 1},
-	{51, 70, 0x830, 0x10, 0, 1},
-	{71, 72, 0xb30, 0x10, 0, 1},
-	{73, 86, 0xb30, 0x10, 4, 1},
-	{87, 90, 0xc30, 0x10, 0, 1},
-	{91, 102, 0xb30, 0x10, 18, 1},
+	PIN_FIELD(0, 31, 0x930, 0x10, 0, 1),
+	PIN_FIELD(32, 50, 0xa30, 0x10, 0, 1),
+	PIN_FIELD(51, 70, 0x830, 0x10, 0, 1),
+	PIN_FIELD(71, 72, 0xb30, 0x10, 0, 1),
+	PIN_FIELD(73, 86, 0xb30, 0x10, 4, 1),
+	PIN_FIELD(87, 90, 0xc30, 0x10, 0, 1),
+	PIN_FIELD(91, 102, 0xb30, 0x10, 18, 1),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_pd_range[] = {
-	{0, 31, 0x940, 0x10, 0, 1},
-	{32, 50, 0xa40, 0x10, 0, 1},
-	{51, 70, 0x840, 0x10, 0, 1},
-	{71, 72, 0xb40, 0x10, 0, 1},
-	{73, 86, 0xb40, 0x10, 4, 1},
-	{87, 90, 0xc40, 0x10, 0, 1},
-	{91, 102, 0xb40, 0x10, 18, 1},
+	PIN_FIELD(0, 31, 0x940, 0x10, 0, 1),
+	PIN_FIELD(32, 50, 0xa40, 0x10, 0, 1),
+	PIN_FIELD(51, 70, 0x840, 0x10, 0, 1),
+	PIN_FIELD(71, 72, 0xb40, 0x10, 0, 1),
+	PIN_FIELD(73, 86, 0xb40, 0x10, 4, 1),
+	PIN_FIELD(87, 90, 0xc40, 0x10, 0, 1),
+	PIN_FIELD(91, 102, 0xb40, 0x10, 18, 1),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_e4_range[] = {
-	{0, 31, 0x960, 0x10, 0, 1},
-	{32, 50, 0xa60, 0x10, 0, 1},
-	{51, 70, 0x860, 0x10, 0, 1},
-	{71, 72, 0xb60, 0x10, 0, 1},
-	{73, 86, 0xb60, 0x10, 4, 1},
-	{87, 90, 0xc60, 0x10, 0, 1},
-	{91, 102, 0xb60, 0x10, 18, 1},
+	PIN_FIELD(0, 31, 0x960, 0x10, 0, 1),
+	PIN_FIELD(32, 50, 0xa60, 0x10, 0, 1),
+	PIN_FIELD(51, 70, 0x860, 0x10, 0, 1),
+	PIN_FIELD(71, 72, 0xb60, 0x10, 0, 1),
+	PIN_FIELD(73, 86, 0xb60, 0x10, 4, 1),
+	PIN_FIELD(87, 90, 0xc60, 0x10, 0, 1),
+	PIN_FIELD(91, 102, 0xb60, 0x10, 18, 1),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_e8_range[] = {
-	{0, 31, 0x970, 0x10, 0, 1},
-	{32, 50, 0xa70, 0x10, 0, 1},
-	{51, 70, 0x870, 0x10, 0, 1},
-	{71, 72, 0xb70, 0x10, 0, 1},
-	{73, 86, 0xb70, 0x10, 4, 1},
-	{87, 90, 0xc70, 0x10, 0, 1},
-	{91, 102, 0xb70, 0x10, 18, 1},
+	PIN_FIELD(0, 31, 0x970, 0x10, 0, 1),
+	PIN_FIELD(32, 50, 0xa70, 0x10, 0, 1),
+	PIN_FIELD(51, 70, 0x870, 0x10, 0, 1),
+	PIN_FIELD(71, 72, 0xb70, 0x10, 0, 1),
+	PIN_FIELD(73, 86, 0xb70, 0x10, 4, 1),
+	PIN_FIELD(87, 90, 0xc70, 0x10, 0, 1),
+	PIN_FIELD(91, 102, 0xb70, 0x10, 18, 1),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_tdsel_range[] = {
-	{0, 31, 0x980, 0x4, 0, 4},
-	{32, 50, 0xa80, 0x4, 0, 4},
-	{51, 70, 0x880, 0x4, 0, 4},
-	{71, 72, 0xb80, 0x4, 0, 4},
-	{73, 86, 0xb80, 0x4, 16, 4},
-	{87, 90, 0xc80, 0x4, 0, 4},
-	{91, 102, 0xb88, 0x4, 8, 4},
+	PIN_FIELD(0, 31, 0x980, 0x4, 0, 4),
+	PIN_FIELD(32, 50, 0xa80, 0x4, 0, 4),
+	PIN_FIELD(51, 70, 0x880, 0x4, 0, 4),
+	PIN_FIELD(71, 72, 0xb80, 0x4, 0, 4),
+	PIN_FIELD(73, 86, 0xb80, 0x4, 16, 4),
+	PIN_FIELD(87, 90, 0xc80, 0x4, 0, 4),
+	PIN_FIELD(91, 102, 0xb88, 0x4, 8, 4),
 };
 
 static const struct mtk_pin_field_calc mt7622_pin_rdsel_range[] = {
-	{0, 31, 0x990, 0x4, 0, 6},
-	{32, 50, 0xa90, 0x4, 0, 6},
-	{51, 58, 0x890, 0x4, 0, 6},
-	{59, 60, 0x894, 0x4, 28, 6},
-	{61, 62, 0x894, 0x4, 16, 6},
-	{63, 66, 0x898, 0x4, 8, 6},
-	{67, 68, 0x89c, 0x4, 12, 6},
-	{69, 70, 0x89c, 0x4, 0, 6},
-	{71, 72, 0xb90, 0x4, 0, 6},
-	{73, 86, 0xb90, 0x4, 24, 6},
-	{87, 90, 0xc90, 0x4, 0, 6},
-	{91, 102, 0xb9c, 0x4, 12, 6},
+	PIN_FIELD(0, 31, 0x990, 0x4, 0, 6),
+	PIN_FIELD(32, 50, 0xa90, 0x4, 0, 6),
+	PIN_FIELD(51, 58, 0x890, 0x4, 0, 6),
+	PIN_FIELD(59, 60, 0x894, 0x4, 28, 6),
+	PIN_FIELD(61, 62, 0x894, 0x4, 16, 6),
+	PIN_FIELD(63, 66, 0x898, 0x4, 8, 6),
+	PIN_FIELD(67, 68, 0x89c, 0x4, 12, 6),
+	PIN_FIELD(69, 70, 0x89c, 0x4, 0, 6),
+	PIN_FIELD(71, 72, 0xb90, 0x4, 0, 6),
+	PIN_FIELD(73, 86, 0xb90, 0x4, 24, 6),
+	PIN_FIELD(87, 90, 0xc90, 0x4, 0, 6),
+	PIN_FIELD(91, 102, 0xb9c, 0x4, 12, 6),
 };
 
 static const struct mtk_pin_reg_calc mt7622_reg_cals[PINCTRL_PIN_REG_MAX] = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index a74c3ff..2a16804 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -54,19 +54,24 @@ static int mtk_hw_pin_field_lookup(struct mtk_pinctrl *hw, int pin,
 		return -EINVAL;
 	}
 
-	/* Caculated bits as the overall offset the pin is located at */
-	bits = c->s_bit + (pin - c->s_pin) * (c->x_bits);
+	/* Calculated bits as the overall offset the pin is located at,
+	 * if c->fixed is held, that determines the all the pins in the
+	 * range use the same field with the s_pin.
+	 */
+	bits = c->fixed ? c->s_bit : c->s_bit + (pin - c->s_pin) * (c->x_bits);
 
-	/* Fill pfd from bits and 32-bit register applied is assumed */
-	pfd->offset = c->s_addr + c->x_addrs * (bits / 32);
-	pfd->bitpos = bits % 32;
+	/* Fill pfd from bits. For example 32-bit register applied is assumed
+	 * when c->sz_reg is equal to 32.
+	 */
+	pfd->offset = c->s_addr + c->x_addrs * (bits / c->sz_reg);
+	pfd->bitpos = bits % c->sz_reg;
 	pfd->mask = (1 << c->x_bits) - 1;
 
 	/* pfd->next is used for indicating that bit wrapping-around happens
 	 * which requires the manipulation for bit 0 starting in the next
 	 * register to form the complete field read/write.
 	 */
-	pfd->next = pfd->bitpos + c->x_bits - 1 > 31 ? c->x_addrs : 0;
+	pfd->next = pfd->bitpos + c->x_bits > c->sz_reg ? c->x_addrs : 0;
 
 	return 0;
 }
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index b7800c9..f05c802 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -15,6 +15,26 @@
 #define MTK_DISABLE    0
 #define MTK_ENABLE     1
 
+#define PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit,	\
+			_x_bits, _sz_reg, _fixed) {			\
+		.s_pin = _s_pin,					\
+		.e_pin = _e_pin,					\
+		.s_addr = _s_addr,					\
+		.x_addrs = _x_addrs,					\
+		.s_bit = _s_bit,					\
+		.x_bits = _x_bits,					\
+		.sz_reg = _sz_reg,					\
+		.fixed = _fixed,					\
+	}
+
+#define PIN_FIELD(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit,	\
+		       _x_bits, 32, 0)
+
+#define PINS_FIELD(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit, _x_bits)	\
+	PIN_FIELD_CALC(_s_pin, _e_pin, _s_addr, _x_addrs, _s_bit,	\
+		       _x_bits, 32, 1)
+
 /* List these attributes which could be modified for the pin */
 enum {
 	PINCTRL_PIN_REG_MODE,
@@ -57,6 +77,9 @@ struct mtk_pin_field {
  * @s_bit:		the start bit for the first register within the range
  * @x_bits:		the bit distance between two consecutive pins within
  *			the range
+ * @sz_reg:		the size of bits in a register
+ * @fixed:		the consecutive pins share the same bits with the 1st
+ *			pin
  */
 struct mtk_pin_field_calc {
 	u16 s_pin;
@@ -65,6 +88,8 @@ struct mtk_pin_field_calc {
 	u8  x_addrs;
 	u8  s_bit;
 	u8  x_bits;
+	u8  sz_reg;
+	u8  fixed;
 };
 
 /* struct mtk_pin_reg_calc - the structure that holds all ranges used to
-- 
2.7.4

