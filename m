Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934752AbeCELgl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 06:36:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50699 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933518AbeCELf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 06:35:59 -0500
X-UUID: 9eead6b81be04468ae99cf3b94758673-20180305
From: Zhiyong Tao <zhiyong.tao@mediatek.com>
To: <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>
CC: <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <hongkun.cao@mediatek.com>,
        <biao.huang@mediatek.com>, <yt.shen@mediatek.com>,
        <hongzhou.yang@mediatek.com>, <erin.lo@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH v3 3/4] pinctrl: add mt2712 pinctrl driver
Date: Mon, 5 Mar 2018 19:35:44 +0800
Message-ID: <1520249745-6757-4-git-send-email-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520249745-6757-1-git-send-email-zhiyong.tao@mediatek.com>
References: <1520249745-6757-1-git-send-email-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit includes mt2712 pinctrl driver.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt2712.c     |  632 ++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h | 1967 +++++++++++++++++++++++++
 4 files changed, 2607 insertions(+)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt2712.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 3e59874..862c5db 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -32,6 +32,13 @@ config PINCTRL_MT8127
 	select PINCTRL_MTK
 
 # For ARMv8 SoCs
+config PINCTRL_MT2712
+	bool "MediaTek MT2712 pin control"
+	depends on OF
+	depends on ARM64 || COMPILE_TEST
+	default ARM64 && ARCH_MEDIATEK
+	select PINCTRL_MTK
+
 config PINCTRL_MT7622
 	bool "MediaTek MT7622 pin control"
 	depends on OF
diff --git a/drivers/pinctrl/mediatek/Makefile b/drivers/pinctrl/mediatek/Makefile
index ed7d2b2..7959e77 100644
--- a/drivers/pinctrl/mediatek/Makefile
+++ b/drivers/pinctrl/mediatek/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PINCTRL_MTK)	+= pinctrl-mtk-common.o
 
 # SoC Drivers
 obj-$(CONFIG_PINCTRL_MT2701)	+= pinctrl-mt2701.o
+obj-$(CONFIG_PINCTRL_MT2712)	+= pinctrl-mt2712.o
 obj-$(CONFIG_PINCTRL_MT8135)	+= pinctrl-mt8135.o
 obj-$(CONFIG_PINCTRL_MT8127)	+= pinctrl-mt8127.o
 obj-$(CONFIG_PINCTRL_MT7622)	+= pinctrl-mt7622.o
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
new file mode 100644
index 0000000..5595e90
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
@@ -0,0 +1,632 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/pinctrl/pinctrl.h>
+#include <linux/regmap.h>
+#include <linux/pinctrl/pinconf-generic.h>
+#include <dt-bindings/pinctrl/mt65xx.h>
+
+#include "pinctrl-mtk-common.h"
+#include "pinctrl-mtk-mt2712.h"
+
+static const struct mtk_pin_spec_pupd_set_samereg mt2712_spec_pupd[] = {
+	MTK_PIN_PUPD_SPEC_SR(18, 0xe50, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(19, 0xe60, 12, 11, 10),
+	MTK_PIN_PUPD_SPEC_SR(20, 0xe50, 5, 4, 3),
+	MTK_PIN_PUPD_SPEC_SR(21, 0xe60, 15, 14, 13),
+	MTK_PIN_PUPD_SPEC_SR(22, 0xe50, 8, 7, 6),
+	MTK_PIN_PUPD_SPEC_SR(23, 0xe70, 2, 1, 0),
+
+	MTK_PIN_PUPD_SPEC_SR(30, 0xf30, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(31, 0xf30, 6, 5, 4),
+	MTK_PIN_PUPD_SPEC_SR(32, 0xf30, 10, 9, 8),
+	MTK_PIN_PUPD_SPEC_SR(33, 0xf30, 14, 13, 12),
+	MTK_PIN_PUPD_SPEC_SR(34, 0xf40, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(35, 0xf40, 6, 5, 4),
+	MTK_PIN_PUPD_SPEC_SR(36, 0xf40, 10, 9, 8),
+	MTK_PIN_PUPD_SPEC_SR(37, 0xc40, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(38, 0xc60, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(39, 0xc60, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(40, 0xc60, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(41, 0xc60, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(42, 0xc60, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(43, 0xc60, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(44, 0xc60, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(45, 0xc60, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(46, 0xc50, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(47, 0xda0, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(48, 0xd90, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(49, 0xdf0, 14, 13, 12),
+	MTK_PIN_PUPD_SPEC_SR(50, 0xdf0, 10, 9, 8),
+	MTK_PIN_PUPD_SPEC_SR(51, 0xdf0, 6, 5, 4),
+	MTK_PIN_PUPD_SPEC_SR(52, 0xdf0, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(53, 0xd50, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(54, 0xd80, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(55, 0xe00, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(56, 0xd40, 2, 1, 0),
+
+	MTK_PIN_PUPD_SPEC_SR(63, 0xc80, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(64, 0xdb0, 14, 13, 12),
+	MTK_PIN_PUPD_SPEC_SR(65, 0xdb0, 6, 5, 4),
+	MTK_PIN_PUPD_SPEC_SR(66, 0xdb0, 10, 9, 8),
+	MTK_PIN_PUPD_SPEC_SR(67, 0xcd0, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(68, 0xdb0, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(69, 0xc90, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(70, 0xcc0, 2, 1, 0),
+
+	MTK_PIN_PUPD_SPEC_SR(89, 0xce0, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(90, 0xdd0, 14, 13, 12),
+	MTK_PIN_PUPD_SPEC_SR(91, 0xdd0, 10, 9, 8),
+	MTK_PIN_PUPD_SPEC_SR(92, 0xdd0, 6, 5, 4),
+	MTK_PIN_PUPD_SPEC_SR(93, 0xdd0, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(94, 0xd20, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(95, 0xcf0, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(96, 0xd30, 2, 1, 0),
+
+	MTK_PIN_PUPD_SPEC_SR(135, 0xe50, 11, 10, 9),
+	MTK_PIN_PUPD_SPEC_SR(136, 0xe50, 14, 13, 12),
+	MTK_PIN_PUPD_SPEC_SR(137, 0xe70, 5, 4, 3),
+	MTK_PIN_PUPD_SPEC_SR(138, 0xe70, 8, 7, 6),
+	MTK_PIN_PUPD_SPEC_SR(139, 0xe70, 11, 10, 9),
+	MTK_PIN_PUPD_SPEC_SR(140, 0xe70, 14, 13, 12),
+	MTK_PIN_PUPD_SPEC_SR(141, 0xe60, 2, 1, 0),
+	MTK_PIN_PUPD_SPEC_SR(142, 0xe60, 5, 4, 3)
+};
+
+static int mt2712_spec_pull_set(struct regmap *regmap, unsigned int pin,
+		unsigned char align, bool isup, unsigned int r1r0)
+{
+	return mtk_pctrl_spec_pull_set_samereg(regmap, mt2712_spec_pupd,
+		ARRAY_SIZE(mt2712_spec_pupd), pin, align, isup, r1r0);
+}
+
+static const struct mtk_pin_ies_smt_set mt2712_smt_set[] = {
+	MTK_PIN_IES_SMT_SPEC(0, 3, 0x900, 2),
+	MTK_PIN_IES_SMT_SPEC(4, 7, 0x900, 0),
+	MTK_PIN_IES_SMT_SPEC(8, 11, 0x900, 1),
+	MTK_PIN_IES_SMT_SPEC(12, 12, 0x8d0, 6),
+	MTK_PIN_IES_SMT_SPEC(13, 13, 0x8d0, 7),
+	MTK_PIN_IES_SMT_SPEC(14, 14, 0x8d0, 6),
+	MTK_PIN_IES_SMT_SPEC(15, 15, 0x8d0, 7),
+	MTK_PIN_IES_SMT_SPEC(18, 23, 0x8d0, 1),
+	MTK_PIN_IES_SMT_SPEC(24, 25, 0x8d0, 2),
+	MTK_PIN_IES_SMT_SPEC(26, 26, 0x8d0, 3),
+	MTK_PIN_IES_SMT_SPEC(27, 27, 0x8d0, 4),
+	MTK_PIN_IES_SMT_SPEC(28, 29, 0x8d0, 3),
+	MTK_PIN_IES_SMT_SPEC(30, 36, 0xf50, 13),
+	MTK_PIN_IES_SMT_SPEC(37, 37, 0xc40, 13),
+	MTK_PIN_IES_SMT_SPEC(38, 45, 0xc60, 13),
+	MTK_PIN_IES_SMT_SPEC(46, 46, 0xc50, 13),
+	MTK_PIN_IES_SMT_SPEC(47, 47, 0xda0, 13),
+	MTK_PIN_IES_SMT_SPEC(48, 48, 0xd90, 13),
+	MTK_PIN_IES_SMT_SPEC(49, 52, 0xd60, 13),
+	MTK_PIN_IES_SMT_SPEC(53, 53, 0xd50, 13),
+	MTK_PIN_IES_SMT_SPEC(54, 54, 0xd80, 13),
+	MTK_PIN_IES_SMT_SPEC(55, 55, 0xe00, 13),
+	MTK_PIN_IES_SMT_SPEC(56, 56, 0xd40, 13),
+	MTK_PIN_IES_SMT_SPEC(57, 62, 0x900, 3),
+	MTK_PIN_IES_SMT_SPEC(63, 63, 0xc80, 13),
+	MTK_PIN_IES_SMT_SPEC(64, 66, 0xca0, 13),
+	MTK_PIN_IES_SMT_SPEC(67, 67, 0xc80, 13),
+	MTK_PIN_IES_SMT_SPEC(68, 68, 0xca0, 13),
+	MTK_PIN_IES_SMT_SPEC(69, 69, 0xc90, 13),
+	MTK_PIN_IES_SMT_SPEC(70, 70, 0xc80, 13),
+	MTK_PIN_IES_SMT_SPEC(71, 74, 0x8d0, 8),
+	MTK_PIN_IES_SMT_SPEC(75, 77, 0x8d0, 9),
+	MTK_PIN_IES_SMT_SPEC(78, 81, 0x8d0, 10),
+	MTK_PIN_IES_SMT_SPEC(82, 88, 0x8d0, 9),
+	MTK_PIN_IES_SMT_SPEC(89, 89, 0xce0, 13),
+	MTK_PIN_IES_SMT_SPEC(90, 93, 0xd00, 13),
+	MTK_PIN_IES_SMT_SPEC(94, 94, 0xce0, 13),
+	MTK_PIN_IES_SMT_SPEC(95, 96, 0xcf0, 13),
+	MTK_PIN_IES_SMT_SPEC(97, 100, 0x8d0, 11),
+	MTK_PIN_IES_SMT_SPEC(101, 104, 0x8d0, 12),
+	MTK_PIN_IES_SMT_SPEC(105, 105, 0x8d0, 13),
+	MTK_PIN_IES_SMT_SPEC(106, 106, 0x8d0, 14),
+	MTK_PIN_IES_SMT_SPEC(107, 107, 0x8d0, 15),
+	MTK_PIN_IES_SMT_SPEC(108, 108, 0x8e0, 0),
+	MTK_PIN_IES_SMT_SPEC(109, 109, 0x8e0, 1),
+	MTK_PIN_IES_SMT_SPEC(110, 110, 0x8e0, 2),
+	MTK_PIN_IES_SMT_SPEC(111, 111, 0x8d0, 13),
+	MTK_PIN_IES_SMT_SPEC(112, 112, 0x8d0, 14),
+	MTK_PIN_IES_SMT_SPEC(113, 113, 0x8d0, 15),
+	MTK_PIN_IES_SMT_SPEC(114, 114, 0x8e0, 0),
+	MTK_PIN_IES_SMT_SPEC(115, 115, 0x8e0, 1),
+	MTK_PIN_IES_SMT_SPEC(116, 116, 0x8e0, 2),
+	MTK_PIN_IES_SMT_SPEC(117, 117, 0x8e0, 3),
+	MTK_PIN_IES_SMT_SPEC(118, 118, 0x8e0, 4),
+	MTK_PIN_IES_SMT_SPEC(119, 119, 0x8e0, 5),
+	MTK_PIN_IES_SMT_SPEC(120, 120, 0x8e0, 3),
+	MTK_PIN_IES_SMT_SPEC(121, 121, 0x8e0, 4),
+	MTK_PIN_IES_SMT_SPEC(122, 122, 0x8e0, 5),
+	MTK_PIN_IES_SMT_SPEC(123, 126, 0x8e0, 6),
+	MTK_PIN_IES_SMT_SPEC(127, 130, 0x8e0, 7),
+	MTK_PIN_IES_SMT_SPEC(131, 134, 0x8e0, 8),
+	MTK_PIN_IES_SMT_SPEC(135, 142, 0x8d0, 1),
+	MTK_PIN_IES_SMT_SPEC(143, 147, 0x8e0, 9),
+	MTK_PIN_IES_SMT_SPEC(148, 152, 0x8e0, 10),
+	MTK_PIN_IES_SMT_SPEC(153, 156, 0x8e0, 11),
+	MTK_PIN_IES_SMT_SPEC(157, 160, 0x8e0, 12),
+	MTK_PIN_IES_SMT_SPEC(161, 164, 0x8e0, 13),
+	MTK_PIN_IES_SMT_SPEC(165, 168, 0x8e0, 14),
+	MTK_PIN_IES_SMT_SPEC(169, 170, 0x8e0, 15),
+	MTK_PIN_IES_SMT_SPEC(171, 172, 0x8f0, 0),
+	MTK_PIN_IES_SMT_SPEC(173, 173, 0x8f0, 1),
+	MTK_PIN_IES_SMT_SPEC(174, 175, 0x8f0, 2),
+	MTK_PIN_IES_SMT_SPEC(176, 176, 0x8f0, 1),
+	MTK_PIN_IES_SMT_SPEC(177, 177, 0x8f0, 3),
+	MTK_PIN_IES_SMT_SPEC(178, 178, 0x8f0, 4),
+	MTK_PIN_IES_SMT_SPEC(179, 179, 0x8f0, 3),
+	MTK_PIN_IES_SMT_SPEC(180, 180, 0x8f0, 4),
+	MTK_PIN_IES_SMT_SPEC(181, 181, 0x8f0, 5),
+	MTK_PIN_IES_SMT_SPEC(182, 182, 0x8f0, 6),
+	MTK_PIN_IES_SMT_SPEC(183, 183, 0x8f0, 5),
+	MTK_PIN_IES_SMT_SPEC(184, 184, 0x8f0, 6),
+	MTK_PIN_IES_SMT_SPEC(185, 186, 0x8f0, 7),
+	MTK_PIN_IES_SMT_SPEC(187, 187, 0x8f0, 8),
+	MTK_PIN_IES_SMT_SPEC(188, 188, 0x8f0, 9),
+	MTK_PIN_IES_SMT_SPEC(189, 189, 0x8f0, 8),
+	MTK_PIN_IES_SMT_SPEC(190, 190, 0x8f0, 9),
+	MTK_PIN_IES_SMT_SPEC(191, 191, 0x8f0, 10),
+	MTK_PIN_IES_SMT_SPEC(192, 192, 0x8f0, 11),
+	MTK_PIN_IES_SMT_SPEC(193, 194, 0x8f0, 10),
+	MTK_PIN_IES_SMT_SPEC(195, 195, 0x8f0, 11),
+	MTK_PIN_IES_SMT_SPEC(196, 199, 0x8f0, 12),
+	MTK_PIN_IES_SMT_SPEC(200, 203, 0x8f0, 13),
+	MTK_PIN_IES_SMT_SPEC(204, 206, 0x8f0, 14),
+	MTK_PIN_IES_SMT_SPEC(207, 209, 0x8f0, 15)
+};
+
+static const struct mtk_pin_ies_smt_set mt2712_ies_set[] = {
+	MTK_PIN_IES_SMT_SPEC(0, 3, 0x8c0, 2),
+	MTK_PIN_IES_SMT_SPEC(4, 7, 0x8c0, 0),
+	MTK_PIN_IES_SMT_SPEC(8, 9, 0x8c0, 1),
+	MTK_PIN_IES_SMT_SPEC(10, 11, 0x8c0, 4),
+	MTK_PIN_IES_SMT_SPEC(12, 12, 0x890, 6),
+	MTK_PIN_IES_SMT_SPEC(13, 13, 0x890, 7),
+	MTK_PIN_IES_SMT_SPEC(14, 14, 0x890, 6),
+	MTK_PIN_IES_SMT_SPEC(15, 15, 0x890, 7),
+	MTK_PIN_IES_SMT_SPEC(18, 23, 0x890, 1),
+	MTK_PIN_IES_SMT_SPEC(24, 25, 0x890, 2),
+	MTK_PIN_IES_SMT_SPEC(26, 26, 0x890, 3),
+	MTK_PIN_IES_SMT_SPEC(27, 27, 0x890, 4),
+	MTK_PIN_IES_SMT_SPEC(28, 29, 0x890, 3),
+	MTK_PIN_IES_SMT_SPEC(30, 36, 0xf50, 14),
+	MTK_PIN_IES_SMT_SPEC(37, 37, 0xc40, 14),
+	MTK_PIN_IES_SMT_SPEC(38, 45, 0xc60, 14),
+	MTK_PIN_IES_SMT_SPEC(46, 46, 0xc50, 14),
+	MTK_PIN_IES_SMT_SPEC(47, 47, 0xda0, 14),
+	MTK_PIN_IES_SMT_SPEC(48, 48, 0xd90, 14),
+	MTK_PIN_IES_SMT_SPEC(49, 52, 0xd60, 14),
+	MTK_PIN_IES_SMT_SPEC(53, 53, 0xd50, 14),
+	MTK_PIN_IES_SMT_SPEC(54, 54, 0xd80, 14),
+	MTK_PIN_IES_SMT_SPEC(55, 55, 0xe00, 14),
+	MTK_PIN_IES_SMT_SPEC(56, 56, 0xd40, 14),
+	MTK_PIN_IES_SMT_SPEC(57, 62, 0x8c0, 3),
+	MTK_PIN_IES_SMT_SPEC(63, 63, 0xc80, 14),
+	MTK_PIN_IES_SMT_SPEC(64, 66, 0xca0, 14),
+	MTK_PIN_IES_SMT_SPEC(67, 68, 0xc80, 14),
+	MTK_PIN_IES_SMT_SPEC(69, 69, 0xc90, 14),
+	MTK_PIN_IES_SMT_SPEC(70, 70, 0xc80, 14),
+	MTK_PIN_IES_SMT_SPEC(71, 74, 0x890, 8),
+	MTK_PIN_IES_SMT_SPEC(75, 77, 0x890, 9),
+	MTK_PIN_IES_SMT_SPEC(78, 81, 0x890, 10),
+	MTK_PIN_IES_SMT_SPEC(82, 88, 0x890, 9),
+	MTK_PIN_IES_SMT_SPEC(89, 89, 0xce0, 14),
+	MTK_PIN_IES_SMT_SPEC(90, 93, 0xd00, 14),
+	MTK_PIN_IES_SMT_SPEC(94, 94, 0xce0, 14),
+	MTK_PIN_IES_SMT_SPEC(95, 96, 0xcf0, 14),
+	MTK_PIN_IES_SMT_SPEC(97, 100, 0x890, 11),
+	MTK_PIN_IES_SMT_SPEC(101, 104, 0x890, 12),
+	MTK_PIN_IES_SMT_SPEC(105, 105, 0x890, 13),
+	MTK_PIN_IES_SMT_SPEC(106, 106, 0x890, 14),
+	MTK_PIN_IES_SMT_SPEC(107, 107, 0x890, 15),
+	MTK_PIN_IES_SMT_SPEC(108, 108, 0x8a0, 0),
+	MTK_PIN_IES_SMT_SPEC(109, 109, 0x8a0, 1),
+	MTK_PIN_IES_SMT_SPEC(110, 110, 0x8a0, 2),
+	MTK_PIN_IES_SMT_SPEC(111, 111, 0x890, 13),
+	MTK_PIN_IES_SMT_SPEC(112, 112, 0x890, 14),
+	MTK_PIN_IES_SMT_SPEC(113, 113, 0x890, 15),
+	MTK_PIN_IES_SMT_SPEC(114, 114, 0x8a0, 0),
+	MTK_PIN_IES_SMT_SPEC(115, 115, 0x8a0, 1),
+	MTK_PIN_IES_SMT_SPEC(116, 116, 0x8a0, 2),
+	MTK_PIN_IES_SMT_SPEC(117, 117, 0x8a0, 3),
+	MTK_PIN_IES_SMT_SPEC(118, 118, 0x8a0, 4),
+	MTK_PIN_IES_SMT_SPEC(119, 119, 0x8a0, 5),
+	MTK_PIN_IES_SMT_SPEC(120, 120, 0x8a0, 3),
+	MTK_PIN_IES_SMT_SPEC(121, 121, 0x8a0, 4),
+	MTK_PIN_IES_SMT_SPEC(122, 122, 0x8a0, 5),
+	MTK_PIN_IES_SMT_SPEC(123, 126, 0x8a0, 6),
+	MTK_PIN_IES_SMT_SPEC(127, 130, 0x8a0, 7),
+	MTK_PIN_IES_SMT_SPEC(131, 135, 0x8a0, 8),
+	MTK_PIN_IES_SMT_SPEC(136, 142, 0x890, 1),
+	MTK_PIN_IES_SMT_SPEC(143, 147, 0x8a0, 9),
+	MTK_PIN_IES_SMT_SPEC(148, 152, 0x8a0, 10),
+	MTK_PIN_IES_SMT_SPEC(153, 156, 0x8a0, 11),
+	MTK_PIN_IES_SMT_SPEC(157, 160, 0x8a0, 12),
+	MTK_PIN_IES_SMT_SPEC(161, 164, 0x8a0, 13),
+	MTK_PIN_IES_SMT_SPEC(165, 168, 0x8a0, 14),
+	MTK_PIN_IES_SMT_SPEC(169, 170, 0x8a0, 15),
+	MTK_PIN_IES_SMT_SPEC(171, 172, 0x8b0, 0),
+	MTK_PIN_IES_SMT_SPEC(173, 173, 0x8b0, 1),
+	MTK_PIN_IES_SMT_SPEC(174, 175, 0x8b0, 2),
+	MTK_PIN_IES_SMT_SPEC(176, 176, 0x8b0, 1),
+	MTK_PIN_IES_SMT_SPEC(177, 177, 0x8b0, 3),
+	MTK_PIN_IES_SMT_SPEC(178, 178, 0x8b0, 4),
+	MTK_PIN_IES_SMT_SPEC(179, 179, 0x8b0, 3),
+	MTK_PIN_IES_SMT_SPEC(180, 180, 0x8b0, 4),
+	MTK_PIN_IES_SMT_SPEC(181, 181, 0x8b0, 5),
+	MTK_PIN_IES_SMT_SPEC(182, 182, 0x8b0, 6),
+	MTK_PIN_IES_SMT_SPEC(183, 183, 0x8b0, 5),
+	MTK_PIN_IES_SMT_SPEC(184, 184, 0x8b0, 6),
+	MTK_PIN_IES_SMT_SPEC(185, 186, 0x8b0, 7),
+	MTK_PIN_IES_SMT_SPEC(187, 187, 0x8b0, 8),
+	MTK_PIN_IES_SMT_SPEC(188, 188, 0x8b0, 9),
+	MTK_PIN_IES_SMT_SPEC(189, 189, 0x8b0, 8),
+	MTK_PIN_IES_SMT_SPEC(190, 190, 0x8b0, 9),
+	MTK_PIN_IES_SMT_SPEC(191, 191, 0x8b0, 10),
+	MTK_PIN_IES_SMT_SPEC(192, 192, 0x8b0, 11),
+	MTK_PIN_IES_SMT_SPEC(193, 194, 0x8b0, 10),
+	MTK_PIN_IES_SMT_SPEC(195, 195, 0x8b0, 11),
+	MTK_PIN_IES_SMT_SPEC(196, 199, 0x8b0, 12),
+	MTK_PIN_IES_SMT_SPEC(200, 203, 0x8b0, 13),
+	MTK_PIN_IES_SMT_SPEC(204, 206, 0x8b0, 14),
+	MTK_PIN_IES_SMT_SPEC(207, 209, 0x8b0, 15)
+};
+
+static int mt2712_ies_smt_set(struct regmap *regmap, unsigned int pin,
+		unsigned char align, int value, enum pin_config_param arg)
+{
+	if (arg == PIN_CONFIG_INPUT_ENABLE)
+		return mtk_pconf_spec_set_ies_smt_range(regmap, mt2712_ies_set,
+			ARRAY_SIZE(mt2712_ies_set), pin, align, value);
+	if (arg == PIN_CONFIG_INPUT_SCHMITT_ENABLE)
+		return mtk_pconf_spec_set_ies_smt_range(regmap, mt2712_smt_set,
+			ARRAY_SIZE(mt2712_smt_set), pin, align, value);
+	return -EINVAL;
+}
+
+static const struct mtk_drv_group_desc mt2712_drv_grp[] =  {
+	/* 0E4E8SR 4/8/12/16 */
+	MTK_DRV_GRP(4, 16, 1, 2, 4),
+	/* 0E2E4SR  2/4/6/8 */
+	MTK_DRV_GRP(2, 8, 1, 2, 2),
+	/* E8E4E2  2/4/6/8/10/12/14/16 */
+	MTK_DRV_GRP(2, 16, 0, 2, 2)
+};
+
+static const struct mtk_pin_drv_grp mt2712_pin_drv[] = {
+	MTK_PIN_DRV_GRP(0, 0xc10, 4, 0),
+	MTK_PIN_DRV_GRP(1, 0xc10, 4, 0),
+	MTK_PIN_DRV_GRP(2, 0xc10, 4, 0),
+	MTK_PIN_DRV_GRP(3, 0xc10, 4, 0),
+
+	MTK_PIN_DRV_GRP(4, 0xc00, 12, 0),
+	MTK_PIN_DRV_GRP(5, 0xc00, 12, 0),
+	MTK_PIN_DRV_GRP(6, 0xc00, 12, 0),
+	MTK_PIN_DRV_GRP(7, 0xc00, 12, 0),
+
+	MTK_PIN_DRV_GRP(8, 0xc10, 0, 0),
+	MTK_PIN_DRV_GRP(9, 0xc10, 0, 0),
+	MTK_PIN_DRV_GRP(10, 0xc10, 0, 0),
+	MTK_PIN_DRV_GRP(11, 0xc10, 0, 0),
+
+	MTK_PIN_DRV_GRP(12, 0xb60, 0, 0),
+
+	MTK_PIN_DRV_GRP(13, 0xb60, 4, 0),
+
+	MTK_PIN_DRV_GRP(14, 0xb60, 0, 0),
+
+	MTK_PIN_DRV_GRP(15, 0xb60, 4, 0),
+
+	MTK_PIN_DRV_GRP(18, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(19, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(20, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(21, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(22, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(23, 0xb40, 0, 1),
+
+	MTK_PIN_DRV_GRP(24, 0xb40, 4, 0),
+
+	MTK_PIN_DRV_GRP(25, 0xb40, 8, 0),
+
+	MTK_PIN_DRV_GRP(26, 0xb40, 12, 0),
+
+	MTK_PIN_DRV_GRP(27, 0xb50, 0, 0),
+
+	MTK_PIN_DRV_GRP(28, 0xb40, 12, 0),
+	MTK_PIN_DRV_GRP(29, 0xb40, 12, 0),
+
+	MTK_PIN_DRV_GRP(30, 0xf50, 8, 2),
+	MTK_PIN_DRV_GRP(31, 0xf50, 8, 2),
+	MTK_PIN_DRV_GRP(32, 0xf50, 8, 2),
+	MTK_PIN_DRV_GRP(33, 0xf50, 8, 2),
+	MTK_PIN_DRV_GRP(34, 0xf50, 8, 2),
+	MTK_PIN_DRV_GRP(35, 0xf50, 8, 2),
+	MTK_PIN_DRV_GRP(36, 0xf50, 8, 2),
+
+
+	MTK_PIN_DRV_GRP(37, 0xc40, 8, 2),
+
+	MTK_PIN_DRV_GRP(38, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(39, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(40, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(41, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(42, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(43, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(44, 0xc60, 8, 2),
+	MTK_PIN_DRV_GRP(45, 0xc60, 8, 2),
+
+	MTK_PIN_DRV_GRP(46, 0xc50, 8, 2),
+
+	MTK_PIN_DRV_GRP(47, 0xda0, 8, 2),
+
+	MTK_PIN_DRV_GRP(48, 0xd90, 8, 2),
+
+	MTK_PIN_DRV_GRP(49, 0xd60, 8, 2),
+	MTK_PIN_DRV_GRP(50, 0xd60, 8, 2),
+	MTK_PIN_DRV_GRP(51, 0xd60, 8, 2),
+	MTK_PIN_DRV_GRP(52, 0xd60, 8, 2),
+
+	MTK_PIN_DRV_GRP(53, 0xd50, 8, 2),
+
+	MTK_PIN_DRV_GRP(54, 0xd80, 8, 2),
+
+	MTK_PIN_DRV_GRP(55, 0xe00, 8, 2),
+
+	MTK_PIN_DRV_GRP(56, 0xd40, 8, 2),
+
+	MTK_PIN_DRV_GRP(63, 0xc80, 8, 2),
+
+	MTK_PIN_DRV_GRP(64, 0xca0, 8, 2),
+	MTK_PIN_DRV_GRP(65, 0xca0, 8, 2),
+	MTK_PIN_DRV_GRP(66, 0xca0, 8, 2),
+
+	MTK_PIN_DRV_GRP(67, 0xcd0, 8, 2),
+
+	MTK_PIN_DRV_GRP(68, 0xca0, 8, 2),
+
+	MTK_PIN_DRV_GRP(69, 0xc90, 8, 2),
+
+	MTK_PIN_DRV_GRP(70, 0xcc0, 8, 2),
+
+	MTK_PIN_DRV_GRP(71, 0xb60, 8, 1),
+	MTK_PIN_DRV_GRP(72, 0xb60, 8, 1),
+	MTK_PIN_DRV_GRP(73, 0xb60, 8, 1),
+	MTK_PIN_DRV_GRP(74, 0xb60, 8, 1),
+
+
+	MTK_PIN_DRV_GRP(75, 0xb60, 12, 1),
+	MTK_PIN_DRV_GRP(76, 0xb60, 12, 1),
+	MTK_PIN_DRV_GRP(77, 0xb60, 12, 1),
+
+	MTK_PIN_DRV_GRP(78, 0xb70, 0, 1),
+	MTK_PIN_DRV_GRP(79, 0xb70, 0, 1),
+	MTK_PIN_DRV_GRP(80, 0xb70, 0, 1),
+	MTK_PIN_DRV_GRP(81, 0xb70, 0, 1),
+
+	MTK_PIN_DRV_GRP(82, 0xb60, 12, 1),
+	MTK_PIN_DRV_GRP(83, 0xb60, 12, 1),
+	MTK_PIN_DRV_GRP(84, 0xb60, 12, 1),
+	MTK_PIN_DRV_GRP(85, 0xb60, 12, 1),
+	MTK_PIN_DRV_GRP(86, 0xb60, 12, 1),
+	MTK_PIN_DRV_GRP(87, 0xb60, 12, 1),
+	MTK_PIN_DRV_GRP(88, 0xb60, 12, 1),
+
+	MTK_PIN_DRV_GRP(89, 0xce0, 8, 2),
+
+	MTK_PIN_DRV_GRP(90, 0xd00, 8, 2),
+	MTK_PIN_DRV_GRP(91, 0xd00, 8, 2),
+	MTK_PIN_DRV_GRP(92, 0xd00, 8, 2),
+	MTK_PIN_DRV_GRP(93, 0xd00, 8, 2),
+
+	MTK_PIN_DRV_GRP(94, 0xd20, 8, 2),
+
+	MTK_PIN_DRV_GRP(95, 0xcf0, 8, 2),
+
+	MTK_PIN_DRV_GRP(96, 0xd30, 8, 2),
+
+	MTK_PIN_DRV_GRP(97, 0xb70, 4, 0),
+	MTK_PIN_DRV_GRP(98, 0xb70, 4, 0),
+	MTK_PIN_DRV_GRP(99, 0xb70, 4, 0),
+	MTK_PIN_DRV_GRP(100, 0xb70, 4, 0),
+
+	MTK_PIN_DRV_GRP(101, 0xb70, 8, 0),
+	MTK_PIN_DRV_GRP(102, 0xb70, 8, 0),
+	MTK_PIN_DRV_GRP(103, 0xb70, 8, 0),
+	MTK_PIN_DRV_GRP(104, 0xb70, 8, 0),
+
+	MTK_PIN_DRV_GRP(135, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(136, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(137, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(138, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(139, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(140, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(141, 0xb40, 0, 1),
+	MTK_PIN_DRV_GRP(142, 0xb40, 0, 1),
+
+	MTK_PIN_DRV_GRP(143, 0xba0, 12, 0),
+	MTK_PIN_DRV_GRP(144, 0xba0, 12, 0),
+	MTK_PIN_DRV_GRP(145, 0xba0, 12, 0),
+	MTK_PIN_DRV_GRP(146, 0xba0, 12, 0),
+	MTK_PIN_DRV_GRP(147, 0xba0, 12, 0),
+
+	MTK_PIN_DRV_GRP(148, 0xbb0, 0, 0),
+	MTK_PIN_DRV_GRP(149, 0xbb0, 0, 0),
+	MTK_PIN_DRV_GRP(150, 0xbb0, 0, 0),
+	MTK_PIN_DRV_GRP(151, 0xbb0, 0, 0),
+	MTK_PIN_DRV_GRP(152, 0xbb0, 0, 0),
+
+	MTK_PIN_DRV_GRP(153, 0xbb0, 4, 0),
+	MTK_PIN_DRV_GRP(154, 0xbb0, 4, 0),
+	MTK_PIN_DRV_GRP(155, 0xbb0, 4, 0),
+	MTK_PIN_DRV_GRP(156, 0xbb0, 4, 0),
+
+	MTK_PIN_DRV_GRP(157, 0xbb0, 8, 0),
+	MTK_PIN_DRV_GRP(158, 0xbb0, 8, 0),
+	MTK_PIN_DRV_GRP(159, 0xbb0, 8, 0),
+	MTK_PIN_DRV_GRP(160, 0xbb0, 8, 0),
+
+	MTK_PIN_DRV_GRP(161, 0xbb0, 12, 0),
+	MTK_PIN_DRV_GRP(162, 0xbb0, 12, 0),
+	MTK_PIN_DRV_GRP(163, 0xbb0, 12, 0),
+	MTK_PIN_DRV_GRP(164, 0xbb0, 12, 0),
+
+	MTK_PIN_DRV_GRP(165, 0xbc0, 0, 0),
+	MTK_PIN_DRV_GRP(166, 0xbc0, 0, 0),
+	MTK_PIN_DRV_GRP(167, 0xbc0, 0, 0),
+	MTK_PIN_DRV_GRP(168, 0xbc0, 0, 0),
+
+	MTK_PIN_DRV_GRP(169, 0xbc0, 4, 0),
+	MTK_PIN_DRV_GRP(170, 0xbc0, 4, 0),
+
+	MTK_PIN_DRV_GRP(171, 0xbc0, 8, 0),
+	MTK_PIN_DRV_GRP(172, 0xbc0, 8, 0),
+
+	MTK_PIN_DRV_GRP(173, 0xbc0, 12, 0),
+
+	MTK_PIN_DRV_GRP(174, 0xbd0, 0, 0),
+	MTK_PIN_DRV_GRP(175, 0xbd0, 0, 0),
+
+	MTK_PIN_DRV_GRP(176, 0xbc0, 12, 0),
+
+	MTK_PIN_DRV_GRP(177, 0xbd0, 4, 0),
+
+	MTK_PIN_DRV_GRP(178, 0xbd0, 8, 0),
+
+	MTK_PIN_DRV_GRP(179, 0xbd0, 4, 0),
+
+	MTK_PIN_DRV_GRP(180, 0xbd0, 8, 0),
+
+	MTK_PIN_DRV_GRP(181, 0xbd0, 12, 0),
+
+	MTK_PIN_DRV_GRP(182, 0xbe0, 0, 0),
+
+	MTK_PIN_DRV_GRP(183, 0xbd0, 12, 0),
+
+	MTK_PIN_DRV_GRP(184, 0xbe0, 0, 0),
+
+	MTK_PIN_DRV_GRP(185, 0xbe0, 4, 0),
+
+	MTK_PIN_DRV_GRP(186, 0xbe0, 8, 0),
+
+	MTK_PIN_DRV_GRP(187, 0xbe0, 12, 0),
+
+	MTK_PIN_DRV_GRP(188, 0xbf0, 0, 0),
+
+	MTK_PIN_DRV_GRP(189, 0xbe0, 12, 0),
+
+	MTK_PIN_DRV_GRP(190, 0xbf0, 0, 0),
+
+	MTK_PIN_DRV_GRP(191, 0xbf0, 4, 0),
+
+	MTK_PIN_DRV_GRP(192, 0xbf0, 8, 0),
+
+	MTK_PIN_DRV_GRP(193, 0xbf0, 4, 0),
+	MTK_PIN_DRV_GRP(194, 0xbf0, 4, 0),
+
+	MTK_PIN_DRV_GRP(195, 0xbf0, 8, 0),
+
+	MTK_PIN_DRV_GRP(196, 0xbf0, 12, 0),
+	MTK_PIN_DRV_GRP(197, 0xbf0, 12, 0),
+	MTK_PIN_DRV_GRP(198, 0xbf0, 12, 0),
+	MTK_PIN_DRV_GRP(199, 0xbf0, 12, 0),
+
+	MTK_PIN_DRV_GRP(200, 0xc00, 0, 0),
+	MTK_PIN_DRV_GRP(201, 0xc00, 0, 0),
+	MTK_PIN_DRV_GRP(202, 0xc00, 0, 0),
+	MTK_PIN_DRV_GRP(203, 0xc00, 0, 0),
+
+	MTK_PIN_DRV_GRP(204, 0xc00, 4, 0),
+	MTK_PIN_DRV_GRP(205, 0xc00, 4, 0),
+	MTK_PIN_DRV_GRP(206, 0xc00, 4, 0),
+
+	MTK_PIN_DRV_GRP(207, 0xc00, 8, 0),
+	MTK_PIN_DRV_GRP(208, 0xc00, 8, 0),
+	MTK_PIN_DRV_GRP(209, 0xc00, 8, 0),
+};
+
+static const struct mtk_pinctrl_devdata mt2712_pinctrl_data = {
+	.pins = mtk_pins_mt2712,
+	.npins = ARRAY_SIZE(mtk_pins_mt2712),
+	.grp_desc = mt2712_drv_grp,
+	.n_grp_cls = ARRAY_SIZE(mt2712_drv_grp),
+	.pin_drv_grp = mt2712_pin_drv,
+	.n_pin_drv_grps = ARRAY_SIZE(mt2712_pin_drv),
+	.spec_pull_set = mt2712_spec_pull_set,
+	.spec_ies_smt_set = mt2712_ies_smt_set,
+	.dir_offset = 0x0000,
+	.pullen_offset = 0x0100,
+	.pullsel_offset = 0x0200,
+	.dout_offset = 0x0300,
+	.din_offset = 0x0400,
+	.pinmux_offset = 0x0500,
+	.type1_start = 210,
+	.type1_end = 210,
+	.port_shf = 4,
+	.port_mask = 0xf,
+	.port_align = 4,
+	.eint_offsets = {
+		.name = "mt2712_eint",
+		.stat      = 0x000,
+		.ack       = 0x040,
+		.mask      = 0x080,
+		.mask_set  = 0x0c0,
+		.mask_clr  = 0x100,
+		.sens      = 0x140,
+		.sens_set  = 0x180,
+		.sens_clr  = 0x1c0,
+		.soft      = 0x200,
+		.soft_set  = 0x240,
+		.soft_clr  = 0x280,
+		.pol       = 0x300,
+		.pol_set   = 0x340,
+		.pol_clr   = 0x380,
+		.dom_en    = 0x400,
+		.dbnc_ctrl = 0x500,
+		.dbnc_set  = 0x600,
+		.dbnc_clr  = 0x700,
+		.port_mask = 0xf,
+		.ports     = 8,
+	},
+	.ap_num = 229,
+	.db_cnt = 40,
+};
+
+static int mt2712_pinctrl_probe(struct platform_device *pdev)
+{
+	return mtk_pctrl_init(pdev, &mt2712_pinctrl_data, NULL);
+}
+
+static const struct of_device_id mt2712_pctrl_match[] = {
+	{
+		.compatible = "mediatek,mt2712-pinctrl",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mt2712_pctrl_match);
+
+static struct platform_driver mtk_pinctrl_driver = {
+	.probe = mt2712_pinctrl_probe,
+	.driver = {
+		.name = "mediatek-mt2712-pinctrl",
+		.of_match_table = mt2712_pctrl_match,
+		.pm = &mtk_eint_pm_ops,
+	},
+};
+
+static int __init mtk_pinctrl_init(void)
+{
+	return platform_driver_register(&mtk_pinctrl_driver);
+}
+
+arch_initcall(mtk_pinctrl_init);
+
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
new file mode 100644
index 0000000..bcdf5d2
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt2712.h
@@ -0,0 +1,1967 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 MediaTek Inc.
+ * Author: Zhiyong Tao <zhiyong.tao@mediatek.com>
+ *
+ */
+#ifndef PINCTRL_MTK_MT2712_H
+#define PINCTRL_MTK_MT2712_H
+
+#include <linux/pinctrl/pinctrl.h>
+#include "pinctrl-mtk-common.h"
+
+static const struct mtk_desc_pin mtk_pins_mt2712[] = {
+	MTK_PIN(
+		PINCTRL_PIN(0, "EINT0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 6),
+		MTK_FUNCTION(0, "GPIO0"),
+		MTK_FUNCTION(1, "EINT0"),
+		MTK_FUNCTION(2, "MBIST_DIAG_SCANOUT"),
+		MTK_FUNCTION(3, "DSIA_TE"),
+		MTK_FUNCTION(4, "DSIC_TE"),
+		MTK_FUNCTION(5, "DIN_D3"),
+		MTK_FUNCTION(6, "PURE_HW_PROTECT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(1, "EINT1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 7),
+		MTK_FUNCTION(0, "GPIO1"),
+		MTK_FUNCTION(1, "EINT1"),
+		MTK_FUNCTION(2, "IR_IN"),
+		MTK_FUNCTION(3, "DSIB_TE"),
+		MTK_FUNCTION(4, "DSID_TE"),
+		MTK_FUNCTION(5, "DIN_D4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(2, "EINT2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 8),
+		MTK_FUNCTION(0, "GPIO2"),
+		MTK_FUNCTION(1, "EINT2"),
+		MTK_FUNCTION(2, "IR_IN"),
+		MTK_FUNCTION(3, "LCM_RST1"),
+		MTK_FUNCTION(5, "DIN_D5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(3, "EINT3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 9),
+		MTK_FUNCTION(0, "GPIO3"),
+		MTK_FUNCTION(1, "EINT3"),
+		MTK_FUNCTION(2, "IR_IN"),
+		MTK_FUNCTION(3, "LCM_RST0"),
+		MTK_FUNCTION(5, "DIN_D6")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(4, "PWM0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 10),
+		MTK_FUNCTION(0, "GPIO4"),
+		MTK_FUNCTION(1, "PWM0"),
+		MTK_FUNCTION(2, "DISP0_PWM"),
+		MTK_FUNCTION(3, "DISP1_PWM"),
+		MTK_FUNCTION(5, "DIN_CLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(5, "PWM1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 11),
+		MTK_FUNCTION(0, "GPIO5"),
+		MTK_FUNCTION(1, "PWM1"),
+		MTK_FUNCTION(2, "DISP1_PWM"),
+		MTK_FUNCTION(3, "DISP0_PWM"),
+		MTK_FUNCTION(5, "DIN_VSYNC")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(6, "PWM2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 12),
+		MTK_FUNCTION(0, "GPIO6"),
+		MTK_FUNCTION(1, "PWM2"),
+		MTK_FUNCTION(2, "DISP0_PWM"),
+		MTK_FUNCTION(3, "DISP1_PWM"),
+		MTK_FUNCTION(4, "DISP2_PWM"),
+		MTK_FUNCTION(5, "DIN_HSYNC")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(7, "PWM3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 13),
+		MTK_FUNCTION(0, "GPIO7"),
+		MTK_FUNCTION(1, "PWM3"),
+		MTK_FUNCTION(2, "DISP1_PWM"),
+		MTK_FUNCTION(3, "DISP0_PWM"),
+		MTK_FUNCTION(4, "LCM_RST2"),
+		MTK_FUNCTION(5, "DIN_D0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(8, "PWM4"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 14),
+		MTK_FUNCTION(0, "GPIO8"),
+		MTK_FUNCTION(1, "PWM4"),
+		MTK_FUNCTION(2, "DISP0_PWM"),
+		MTK_FUNCTION(3, "DISP1_PWM"),
+		MTK_FUNCTION(4, "DSIA_TE"),
+		MTK_FUNCTION(5, "DIN_D1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(9, "PWM5"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 15),
+		MTK_FUNCTION(0, "GPIO9"),
+		MTK_FUNCTION(1, "PWM5"),
+		MTK_FUNCTION(2, "DISP1_PWM"),
+		MTK_FUNCTION(3, "DISP0_PWM"),
+		MTK_FUNCTION(4, "DSIB_TE"),
+		MTK_FUNCTION(5, "DIN_D2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(10, "PWM6"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 16),
+		MTK_FUNCTION(0, "GPIO10"),
+		MTK_FUNCTION(1, "PWM6"),
+		MTK_FUNCTION(2, "DISP0_PWM"),
+		MTK_FUNCTION(3, "DISP1_PWM"),
+		MTK_FUNCTION(4, "LCM_RST0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(11, "PWM7"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 17),
+		MTK_FUNCTION(0, "GPIO11"),
+		MTK_FUNCTION(1, "PWM7"),
+		MTK_FUNCTION(2, "DISP1_PWM"),
+		MTK_FUNCTION(3, "DISP0_PWM"),
+		MTK_FUNCTION(4, "LCM_RST1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(12, "IDDIG_P0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(1, 22),
+		MTK_FUNCTION(0, "GPIO12"),
+		MTK_FUNCTION(1, "IDDIG_A"),
+		MTK_FUNCTION(5, "DIN_D7")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(13, "DRV_VBUS_P0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 43),
+		MTK_FUNCTION(0, "GPIO13"),
+		MTK_FUNCTION(1, "DRV_VBUS_A")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(14, "IDDIG_P1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(1, 44),
+		MTK_FUNCTION(0, "GPIO14"),
+		MTK_FUNCTION(1, "IDDIG_B")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(15, "DRV_VBUS_P1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 45),
+		MTK_FUNCTION(0, "GPIO15"),
+		MTK_FUNCTION(1, "DRV_VBUS_B")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(16, "DRV_VBUS_P2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 46),
+		MTK_FUNCTION(0, "GPIO16"),
+		MTK_FUNCTION(1, "DRV_VBUS_C")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(17, "DRV_VBUS_P3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 47),
+		MTK_FUNCTION(0, "GPIO17"),
+		MTK_FUNCTION(1, "DRV_VBUS_D")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(18, "KPROW0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 18),
+		MTK_FUNCTION(0, "GPIO18"),
+		MTK_FUNCTION(1, "KROW0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(19, "KPCOL0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 19),
+		MTK_FUNCTION(0, "GPIO19"),
+		MTK_FUNCTION(1, "KCOL0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(20, "KPROW1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 48),
+		MTK_FUNCTION(0, "GPIO20"),
+		MTK_FUNCTION(1, "KROW1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(21, "KPCOL1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 49),
+		MTK_FUNCTION(0, "GPIO21"),
+		MTK_FUNCTION(1, "KCOL1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(22, "KPROW2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 50),
+		MTK_FUNCTION(0, "GPIO22"),
+		MTK_FUNCTION(1, "KROW2"),
+		MTK_FUNCTION(2, "DISP1_PWM")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(23, "KPCOL2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 51),
+		MTK_FUNCTION(0, "GPIO23"),
+		MTK_FUNCTION(1, "KCOL2"),
+		MTK_FUNCTION(2, "DISP0_PWM")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(24, "CMMCLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 52),
+		MTK_FUNCTION(0, "GPIO24"),
+		MTK_FUNCTION(1, "CMMCLK"),
+		MTK_FUNCTION(7, "DBG_MON_A_1_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(25, "CM2MCLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 53),
+		MTK_FUNCTION(0, "GPIO25"),
+		MTK_FUNCTION(1, "CM2MCLK"),
+		MTK_FUNCTION(7, "DBG_MON_A_2_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(26, "PCM_TX"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 54),
+		MTK_FUNCTION(0, "GPIO26"),
+		MTK_FUNCTION(1, "PCM1_DO"),
+		MTK_FUNCTION(2, "MRG_TX"),
+		MTK_FUNCTION(3, "DAI_TX"),
+		MTK_FUNCTION(4, "MRG_RX"),
+		MTK_FUNCTION(5, "DAI_RX"),
+		MTK_FUNCTION(6, "PCM1_DI"),
+		MTK_FUNCTION(7, "DBG_MON_A_3_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(27, "PCM_CLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 55),
+		MTK_FUNCTION(0, "GPIO27"),
+		MTK_FUNCTION(1, "PCM1_CLK"),
+		MTK_FUNCTION(2, "MRG_CLK"),
+		MTK_FUNCTION(3, "DAI_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_A_4_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(28, "PCM_RX"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 56),
+		MTK_FUNCTION(0, "GPIO28"),
+		MTK_FUNCTION(1, "PCM1_DI"),
+		MTK_FUNCTION(2, "MRG_RX"),
+		MTK_FUNCTION(3, "DAI_RX"),
+		MTK_FUNCTION(4, "MRG_TX"),
+		MTK_FUNCTION(5, "DAI_TX"),
+		MTK_FUNCTION(6, "PCM1_DO"),
+		MTK_FUNCTION(7, "DBG_MON_A_5_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(29, "PCM_SYNC"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 57),
+		MTK_FUNCTION(0, "GPIO29"),
+		MTK_FUNCTION(1, "PCM1_SYNC"),
+		MTK_FUNCTION(2, "MRG_SYNC"),
+		MTK_FUNCTION(3, "DAI_SYNC"),
+		MTK_FUNCTION(7, "DBG_MON_A_6_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(30, "NCEB0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 58),
+		MTK_FUNCTION(0, "GPIO30"),
+		MTK_FUNCTION(1, "NCEB0"),
+		MTK_FUNCTION(2, "USB0_FT_SDA"),
+		MTK_FUNCTION(7, "DBG_MON_A_7_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(31, "NCEB1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 59),
+		MTK_FUNCTION(0, "GPIO31"),
+		MTK_FUNCTION(1, "NCEB1"),
+		MTK_FUNCTION(2, "USB1_FT_SCL"),
+		MTK_FUNCTION(7, "DBG_MON_A_8_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(32, "NF_DQS"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 60),
+		MTK_FUNCTION(0, "GPIO32"),
+		MTK_FUNCTION(1, "NF_DQS"),
+		MTK_FUNCTION(2, "USB1_FT_SDA"),
+		MTK_FUNCTION(7, "DBG_MON_A_9_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(33, "NWEB"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 61),
+		MTK_FUNCTION(0, "GPIO33"),
+		MTK_FUNCTION(1, "NWEB"),
+		MTK_FUNCTION(2, "USB2_FT_SCL"),
+		MTK_FUNCTION(7, "DBG_MON_A_10_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(34, "NREB"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 62),
+		MTK_FUNCTION(0, "GPIO34"),
+		MTK_FUNCTION(1, "NREB"),
+		MTK_FUNCTION(2, "USB2_FT_SDA"),
+		MTK_FUNCTION(7, "DBG_MON_A_11_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(35, "NCLE"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 63),
+		MTK_FUNCTION(0, "GPIO35"),
+		MTK_FUNCTION(1, "NCLE"),
+		MTK_FUNCTION(2, "USB3_FT_SCL"),
+		MTK_FUNCTION(7, "DBG_MON_A_12_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(36, "NALE"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 64),
+		MTK_FUNCTION(0, "GPIO36"),
+		MTK_FUNCTION(1, "NALE"),
+		MTK_FUNCTION(2, "USB3_FT_SDA"),
+		MTK_FUNCTION(7, "DBG_MON_A_13_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(37, "MSDC0E_CLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO37"),
+		MTK_FUNCTION(1, "MSDC0_CLK"),
+		MTK_FUNCTION(2, "USB0_FT_SCL"),
+		MTK_FUNCTION(7, "DBG_MON_A_0_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(38, "MSDC0E_DAT7"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO38"),
+		MTK_FUNCTION(1, "MSDC0_DAT7"),
+		MTK_FUNCTION(2, "NAND_ND7"),
+		MTK_FUNCTION(7, "DBG_MON_A_14_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(39, "MSDC0E_DAT6"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO39"),
+		MTK_FUNCTION(1, "MSDC0_DAT6"),
+		MTK_FUNCTION(2, "NAND_ND6"),
+		MTK_FUNCTION(7, "DBG_MON_A_15_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(40, "MSDC0E_DAT5"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO40"),
+		MTK_FUNCTION(1, "MSDC0_DAT5"),
+		MTK_FUNCTION(2, "NAND_ND5"),
+		MTK_FUNCTION(7, "DBG_MON_A_16_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(41, "MSDC0E_DAT4"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO41"),
+		MTK_FUNCTION(1, "MSDC0_DAT4"),
+		MTK_FUNCTION(2, "NAND_ND4"),
+		MTK_FUNCTION(7, "DBG_MON_A_17_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(42, "MSDC0E_DAT3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO42"),
+		MTK_FUNCTION(1, "MSDC0_DAT3"),
+		MTK_FUNCTION(2, "NAND_ND3"),
+		MTK_FUNCTION(7, "DBG_MON_A_18_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(43, "MSDC0E_DAT2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO43"),
+		MTK_FUNCTION(1, "MSDC0_DAT2"),
+		MTK_FUNCTION(2, "NAND_ND2"),
+		MTK_FUNCTION(7, "DBG_MON_A_19_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(44, "MSDC0E_DAT1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO44"),
+		MTK_FUNCTION(1, "MSDC0_DAT1"),
+		MTK_FUNCTION(2, "NAND_ND1"),
+		MTK_FUNCTION(7, "DBG_MON_A_20_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(45, "MSDC0E_DAT0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO45"),
+		MTK_FUNCTION(1, "MSDC0_DAT0"),
+		MTK_FUNCTION(2, "NAND_ND0"),
+		MTK_FUNCTION(7, "DBG_MON_A_21_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(46, "MSDC0E_CMD"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO46"),
+		MTK_FUNCTION(1, "MSDC0_CMD"),
+		MTK_FUNCTION(2, "NAND_NRNB"),
+		MTK_FUNCTION(7, "DBG_MON_A_22_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(47, "MSDC0E_DSL"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO47"),
+		MTK_FUNCTION(1, "MSDC0_DSL"),
+		MTK_FUNCTION(7, "DBG_MON_A_23_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(48, "MSDC0E_RSTB"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 142),
+		MTK_FUNCTION(0, "GPIO48"),
+		MTK_FUNCTION(1, "MSDC0_RSTB"),
+		MTK_FUNCTION(7, "DBG_MON_A_24_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(49, "MSDC3_DAT3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 65),
+		MTK_FUNCTION(0, "GPIO49"),
+		MTK_FUNCTION(1, "MSDC3_DAT3"),
+		MTK_FUNCTION(7, "DBG_MON_A_25_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(50, "MSDC3_DAT2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 66),
+		MTK_FUNCTION(0, "GPIO50"),
+		MTK_FUNCTION(1, "MSDC3_DAT2"),
+		MTK_FUNCTION(7, "DBG_MON_A_26_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(51, "MSDC3_DAT1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 67),
+		MTK_FUNCTION(0, "GPIO51"),
+		MTK_FUNCTION(1, "MSDC3_DAT1"),
+		MTK_FUNCTION(7, "DBG_MON_A_27_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(52, "MSDC3_DAT0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 68),
+		MTK_FUNCTION(0, "GPIO52"),
+		MTK_FUNCTION(1, "MSDC3_DAT0"),
+		MTK_FUNCTION(7, "DBG_MON_A_28_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(53, "MSDC3_CMD"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 69),
+		MTK_FUNCTION(0, "GPIO53"),
+		MTK_FUNCTION(1, "MSDC3_CMD"),
+		MTK_FUNCTION(7, "DBG_MON_A_29_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(54, "MSDC3_INS"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 20),
+		MTK_FUNCTION(0, "GPIO54"),
+		MTK_FUNCTION(1, "MSDC3_INS"),
+		MTK_FUNCTION(7, "DBG_MON_A_30_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(55, "MSDC3_DSL"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 70),
+		MTK_FUNCTION(0, "GPIO55"),
+		MTK_FUNCTION(1, "MSDC3_DSL"),
+		MTK_FUNCTION(7, "DBG_MON_A_31_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(56, "MSDC3_CLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 71),
+		MTK_FUNCTION(0, "GPIO56"),
+		MTK_FUNCTION(1, "MSDC3_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_A_32_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(57, "NOR_CS"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 72),
+		MTK_FUNCTION(0, "GPIO57"),
+		MTK_FUNCTION(1, "NOR_CS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(58, "NOR_CK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 73),
+		MTK_FUNCTION(0, "GPIO58"),
+		MTK_FUNCTION(1, "NOR_CK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(59, "NOR_IO0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 74),
+		MTK_FUNCTION(0, "GPIO59"),
+		MTK_FUNCTION(1, "NOR_IO0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(60, "NOR_IO1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 75),
+		MTK_FUNCTION(0, "GPIO60"),
+		MTK_FUNCTION(1, "NOR_IO1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(61, "NOR_IO2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 76),
+		MTK_FUNCTION(0, "GPIO61"),
+		MTK_FUNCTION(1, "NOR_IO2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(62, "NOR_IO3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 77),
+		MTK_FUNCTION(0, "GPIO62"),
+		MTK_FUNCTION(1, "NOR_IO3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(63, "MSDC1_CLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 78),
+		MTK_FUNCTION(0, "GPIO63"),
+		MTK_FUNCTION(1, "MSDC1_CLK"),
+		MTK_FUNCTION(2, "UDI_TCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(64, "MSDC1_DAT3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 79),
+		MTK_FUNCTION(0, "GPIO64"),
+		MTK_FUNCTION(1, "MSDC1_DAT3"),
+		MTK_FUNCTION(2, "UDI_TDI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(65, "MSDC1_DAT1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 80),
+		MTK_FUNCTION(0, "GPIO65"),
+		MTK_FUNCTION(1, "MSDC1_DAT1"),
+		MTK_FUNCTION(2, "UDI_TMS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(66, "MSDC1_DAT2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 81),
+		MTK_FUNCTION(0, "GPIO66"),
+		MTK_FUNCTION(1, "MSDC1_DAT2"),
+		MTK_FUNCTION(2, "UDI_TDO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(67, "MSDC1_PSW"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 82),
+		MTK_FUNCTION(0, "GPIO67"),
+		MTK_FUNCTION(2, "UDI_NTRST")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(68, "MSDC1_DAT0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 83),
+		MTK_FUNCTION(0, "GPIO68"),
+		MTK_FUNCTION(1, "MSDC1_DAT0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(69, "MSDC1_CMD"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 84),
+		MTK_FUNCTION(0, "GPIO69"),
+		MTK_FUNCTION(1, "MSDC1_CMD")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(70, "MSDC1_INS"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 85),
+		MTK_FUNCTION(0, "GPIO70")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(71, "GBE_TXD3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 86),
+		MTK_FUNCTION(0, "GPIO71"),
+		MTK_FUNCTION(1, "GBE_TXD3"),
+		MTK_FUNCTION(7, "DBG_MON_B_0_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(72, "GBE_TXD2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 87),
+		MTK_FUNCTION(0, "GPIO72"),
+		MTK_FUNCTION(1, "GBE_TXD2"),
+		MTK_FUNCTION(7, "DBG_MON_B_1_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(73, "GBE_TXD1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 88),
+		MTK_FUNCTION(0, "GPIO73"),
+		MTK_FUNCTION(1, "GBE_TXD1"),
+		MTK_FUNCTION(7, "DBG_MON_B_2_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(74, "GBE_TXD0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 89),
+		MTK_FUNCTION(0, "GPIO74"),
+		MTK_FUNCTION(1, "GBE_TXD0"),
+		MTK_FUNCTION(7, "DBG_MON_B_3_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(75, "GBE_TXC"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 90),
+		MTK_FUNCTION(0, "GPIO75"),
+		MTK_FUNCTION(1, "GBE_TXC"),
+		MTK_FUNCTION(7, "DBG_MON_B_4_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(76, "GBE_TXEN"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 91),
+		MTK_FUNCTION(0, "GPIO76"),
+		MTK_FUNCTION(1, "GBE_TXEN"),
+		MTK_FUNCTION(7, "DBG_MON_B_5_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(77, "GBE_TXER"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 92),
+		MTK_FUNCTION(0, "GPIO77"),
+		MTK_FUNCTION(1, "GBE_TXER"),
+		MTK_FUNCTION(7, "DBG_MON_B_6_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(78, "GBE_RXD3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 93),
+		MTK_FUNCTION(0, "GPIO78"),
+		MTK_FUNCTION(1, "GBE_RXD3"),
+		MTK_FUNCTION(7, "DBG_MON_B_7_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(79, "GBE_RXD2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 94),
+		MTK_FUNCTION(0, "GPIO79"),
+		MTK_FUNCTION(1, "GBE_RXD2"),
+		MTK_FUNCTION(7, "DBG_MON_B_8_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(80, "GBE_RXD1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 95),
+		MTK_FUNCTION(0, "GPIO80"),
+		MTK_FUNCTION(1, "GBE_RXD1"),
+		MTK_FUNCTION(7, "DBG_MON_B_9_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(81, "GBE_RXD0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 96),
+		MTK_FUNCTION(0, "GPIO81"),
+		MTK_FUNCTION(1, "GBE_RXD0"),
+		MTK_FUNCTION(7, "DBG_MON_B_10_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(82, "GBE_RXDV"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 97),
+		MTK_FUNCTION(0, "GPIO82"),
+		MTK_FUNCTION(1, "GBE_RXDV"),
+		MTK_FUNCTION(7, "DBG_MON_B_11_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(83, "GBE_RXER"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 98),
+		MTK_FUNCTION(0, "GPIO83"),
+		MTK_FUNCTION(1, "GBE_RXER"),
+		MTK_FUNCTION(7, "DBG_MON_B_12_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(84, "GBE_RXC"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 99),
+		MTK_FUNCTION(0, "GPIO84"),
+		MTK_FUNCTION(1, "GBE_RXC"),
+		MTK_FUNCTION(7, "DBG_MON_B_13_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(85, "GBE_MDC"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 100),
+		MTK_FUNCTION(0, "GPIO85"),
+		MTK_FUNCTION(1, "GBE_MDC"),
+		MTK_FUNCTION(7, "DBG_MON_B_14_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(86, "GBE_MDIO"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 101),
+		MTK_FUNCTION(0, "GPIO86"),
+		MTK_FUNCTION(1, "GBE_MDIO"),
+		MTK_FUNCTION(7, "DBG_MON_B_15_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(87, "GBE_COL"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 102),
+		MTK_FUNCTION(0, "GPIO87"),
+		MTK_FUNCTION(1, "GBE_COL"),
+		MTK_FUNCTION(7, "DBG_MON_B_16_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(88, "GBE_INTR"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 21),
+		MTK_FUNCTION(0, "GPIO88"),
+		MTK_FUNCTION(1, "GBE_INTR"),
+		MTK_FUNCTION(2, "GBE_CRS"),
+		MTK_FUNCTION(7, "DBG_MON_B_17_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(89, "MSDC2_CLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 103),
+		MTK_FUNCTION(0, "GPIO89"),
+		MTK_FUNCTION(1, "MSDC2_CLK"),
+		MTK_FUNCTION(7, "DBG_MON_B_18_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(90, "MSDC2_DAT3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 104),
+		MTK_FUNCTION(0, "GPIO90"),
+		MTK_FUNCTION(1, "MSDC2_DAT3"),
+		MTK_FUNCTION(7, "DBG_MON_B_19_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(91, "MSDC2_DAT2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 105),
+		MTK_FUNCTION(0, "GPIO91"),
+		MTK_FUNCTION(1, "MSDC2_DAT2"),
+		MTK_FUNCTION(7, "DBG_MON_B_20_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(92, "MSDC2_DAT1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 106),
+		MTK_FUNCTION(0, "GPIO92"),
+		MTK_FUNCTION(1, "MSDC2_DAT1"),
+		MTK_FUNCTION(7, "DBG_MON_B_21_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(93, "MSDC2_DAT0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 107),
+		MTK_FUNCTION(0, "GPIO93"),
+		MTK_FUNCTION(1, "MSDC2_DAT0"),
+		MTK_FUNCTION(7, "DBG_MON_B_22_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(94, "MSDC2_INS"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 108),
+		MTK_FUNCTION(0, "GPIO94"),
+		MTK_FUNCTION(7, "DBG_MON_B_23_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(95, "MSDC2_CMD"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 109),
+		MTK_FUNCTION(0, "GPIO95"),
+		MTK_FUNCTION(1, "MSDC2_CMD"),
+		MTK_FUNCTION(7, "DBG_MON_B_24_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(96, "MSDC2_PSW"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 110),
+		MTK_FUNCTION(0, "GPIO96"),
+		MTK_FUNCTION(7, "DBG_MON_B_25_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(97, "URXD4"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 111),
+		MTK_FUNCTION(0, "GPIO97"),
+		MTK_FUNCTION(1, "URXD4"),
+		MTK_FUNCTION(2, "UTXD4"),
+		MTK_FUNCTION(3, "MRG_CLK"),
+		MTK_FUNCTION(4, "PCM1_CLK"),
+		MTK_FUNCTION(5, "I2S_IQ2_SDQB"),
+		MTK_FUNCTION(6, "I2SO1_WS"),
+		MTK_FUNCTION(7, "DBG_MON_B_26_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(98, "URTS4"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 112),
+		MTK_FUNCTION(0, "GPIO98"),
+		MTK_FUNCTION(1, "URTS4"),
+		MTK_FUNCTION(2, "UCTS4"),
+		MTK_FUNCTION(3, "MRG_RX"),
+		MTK_FUNCTION(4, "PCM1_DI"),
+		MTK_FUNCTION(5, "I2S_IQ1_SDIB"),
+		MTK_FUNCTION(6, "I2SO1_MCK"),
+		MTK_FUNCTION(7, "DBG_MON_B_27_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(99, "UTXD4"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 113),
+		MTK_FUNCTION(0, "GPIO99"),
+		MTK_FUNCTION(1, "UTXD4"),
+		MTK_FUNCTION(2, "URXD4"),
+		MTK_FUNCTION(3, "MRG_SYNC"),
+		MTK_FUNCTION(4, "PCM1_SYNC"),
+		MTK_FUNCTION(5, "I2S_IQ0_SDQB"),
+		MTK_FUNCTION(6, "I2SO1_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_B_28_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(100, "UCTS4"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 114),
+		MTK_FUNCTION(0, "GPIO100"),
+		MTK_FUNCTION(1, "UCTS4"),
+		MTK_FUNCTION(2, "URTS4"),
+		MTK_FUNCTION(3, "MRG_TX"),
+		MTK_FUNCTION(4, "PCM1_DO"),
+		MTK_FUNCTION(5, "I2S_IQ0_SDIB"),
+		MTK_FUNCTION(6, "I2SO1_DO"),
+		MTK_FUNCTION(7, "DBG_MON_B_29_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(101, "URXD5"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 30),
+		MTK_FUNCTION(0, "GPIO101"),
+		MTK_FUNCTION(1, "URXD5"),
+		MTK_FUNCTION(2, "UTXD5"),
+		MTK_FUNCTION(3, "I2SO3_WS"),
+		MTK_FUNCTION(4, "TDMIN_LRCK"),
+		MTK_FUNCTION(6, "I2SO0_WS"),
+		MTK_FUNCTION(7, "DBG_MON_B_30_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(102, "URTS5"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 31),
+		MTK_FUNCTION(0, "GPIO102"),
+		MTK_FUNCTION(1, "URTS5"),
+		MTK_FUNCTION(2, "UCTS5"),
+		MTK_FUNCTION(3, "I2SO3_MCK"),
+		MTK_FUNCTION(4, "TDMIN_MCLK"),
+		MTK_FUNCTION(5, "IR_IN"),
+		MTK_FUNCTION(6, "I2SO0_MCK"),
+		MTK_FUNCTION(7, "DBG_MON_B_31_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(103, "UTXD5"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 32),
+		MTK_FUNCTION(0, "GPIO103"),
+		MTK_FUNCTION(1, "UTXD5"),
+		MTK_FUNCTION(2, "URXD5"),
+		MTK_FUNCTION(3, "I2SO3_BCK"),
+		MTK_FUNCTION(4, "TDMIN_BCK"),
+		MTK_FUNCTION(6, "I2SO0_BCK"),
+		MTK_FUNCTION(7, "DBG_MON_B_32_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(104, "UCTS5"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 33),
+		MTK_FUNCTION(0, "GPIO104"),
+		MTK_FUNCTION(1, "UCTS5"),
+		MTK_FUNCTION(2, "URTS5"),
+		MTK_FUNCTION(3, "I2SO0_DO1"),
+		MTK_FUNCTION(4, "TDMIN_DI"),
+		MTK_FUNCTION(5, "IR_IN"),
+		MTK_FUNCTION(6, "I2SO0_DO0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(105, "I2C_SDA0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 115),
+		MTK_FUNCTION(0, "GPIO105"),
+		MTK_FUNCTION(1, "SDA0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(106, "I2C_SDA1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 116),
+		MTK_FUNCTION(0, "GPIO106"),
+		MTK_FUNCTION(1, "SDA1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(107, "I2C_SDA2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 117),
+		MTK_FUNCTION(0, "GPIO107"),
+		MTK_FUNCTION(1, "SDA2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(108, "I2C_SDA3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 118),
+		MTK_FUNCTION(0, "GPIO108"),
+		MTK_FUNCTION(1, "SDA3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(109, "I2C_SDA4"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 119),
+		MTK_FUNCTION(0, "GPIO109"),
+		MTK_FUNCTION(1, "SDA4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(110, "I2C_SDA5"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 34),
+		MTK_FUNCTION(0, "GPIO110"),
+		MTK_FUNCTION(1, "SDA5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(111, "I2C_SCL0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 120),
+		MTK_FUNCTION(0, "GPIO111"),
+		MTK_FUNCTION(1, "SCL0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(112, "I2C_SCL1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 121),
+		MTK_FUNCTION(0, "GPIO112"),
+		MTK_FUNCTION(1, "SCL1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(113, "I2C_SCL2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 122),
+		MTK_FUNCTION(0, "GPIO113"),
+		MTK_FUNCTION(1, "SCL2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(114, "I2C_SCL3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 123),
+		MTK_FUNCTION(0, "GPIO114"),
+		MTK_FUNCTION(1, "SCL3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(115, "I2C_SCL4"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 124),
+		MTK_FUNCTION(0, "GPIO115"),
+		MTK_FUNCTION(1, "SCL4")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(116, "I2C_SCL5"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 35),
+		MTK_FUNCTION(0, "GPIO116"),
+		MTK_FUNCTION(1, "SCL5")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(117, "URXD0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 125),
+		MTK_FUNCTION(0, "GPIO117"),
+		MTK_FUNCTION(1, "URXD0"),
+		MTK_FUNCTION(2, "UTXD0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(118, "URXD1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 126),
+		MTK_FUNCTION(0, "GPIO118"),
+		MTK_FUNCTION(1, "URXD1"),
+		MTK_FUNCTION(2, "UTXD1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(119, "URXD2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 127),
+		MTK_FUNCTION(0, "GPIO119"),
+		MTK_FUNCTION(1, "URXD2"),
+		MTK_FUNCTION(2, "UTXD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(120, "UTXD0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 128),
+		MTK_FUNCTION(0, "GPIO120"),
+		MTK_FUNCTION(1, "UTXD0"),
+		MTK_FUNCTION(2, "URXD0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(121, "UTXD1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 129),
+		MTK_FUNCTION(0, "GPIO121"),
+		MTK_FUNCTION(1, "UTXD1"),
+		MTK_FUNCTION(2, "URXD1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(122, "UTXD2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 130),
+		MTK_FUNCTION(0, "GPIO122"),
+		MTK_FUNCTION(1, "UTXD2"),
+		MTK_FUNCTION(2, "URXD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(123, "URXD3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 131),
+		MTK_FUNCTION(0, "GPIO123"),
+		MTK_FUNCTION(1, "URXD3"),
+		MTK_FUNCTION(2, "UTXD3"),
+		MTK_FUNCTION(3, "PURE_HW_PROTECT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(124, "UTXD3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 132),
+		MTK_FUNCTION(0, "GPIO124"),
+		MTK_FUNCTION(1, "UTXD3"),
+		MTK_FUNCTION(2, "URXD3"),
+		MTK_FUNCTION(3, "PURE_HW_PROTECT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(125, "URTS3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 133),
+		MTK_FUNCTION(0, "GPIO125"),
+		MTK_FUNCTION(1, "URTS3"),
+		MTK_FUNCTION(2, "UCTS3"),
+		MTK_FUNCTION(3, "WATCH_DOG")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(126, "UCTS3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 134),
+		MTK_FUNCTION(0, "GPIO126"),
+		MTK_FUNCTION(1, "UCTS3"),
+		MTK_FUNCTION(2, "URTS3"),
+		MTK_FUNCTION(3, "SRCLKENA0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(127, "SPI2_CSN"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 135),
+		MTK_FUNCTION(0, "GPIO127"),
+		MTK_FUNCTION(1, "SPI_CS_2_"),
+		MTK_FUNCTION(2, "SPI_CS_1_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(128, "SPI2_MO"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 136),
+		MTK_FUNCTION(0, "GPIO128"),
+		MTK_FUNCTION(1, "SPI_MO_2_"),
+		MTK_FUNCTION(2, "SPI_SO_1_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(129, "SPI2_MI"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 137),
+		MTK_FUNCTION(0, "GPIO129"),
+		MTK_FUNCTION(1, "SPI_MI_2_"),
+		MTK_FUNCTION(2, "SPI_SI_1_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(130, "SPI2_CK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 138),
+		MTK_FUNCTION(0, "GPIO130"),
+		MTK_FUNCTION(1, "SPI_CK_2_"),
+		MTK_FUNCTION(2, "SPI_CK_1_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(131, "SPI3_CSN"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 139),
+		MTK_FUNCTION(0, "GPIO131"),
+		MTK_FUNCTION(1, "SPI_CS_3_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(132, "SPI3_MO"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 143),
+		MTK_FUNCTION(0, "GPIO132"),
+		MTK_FUNCTION(1, "SPI_MO_3_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(133, "SPI3_MI"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 144),
+		MTK_FUNCTION(0, "GPIO133"),
+		MTK_FUNCTION(1, "SPI_MI_3_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(134, "SPI3_CK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 145),
+		MTK_FUNCTION(0, "GPIO134"),
+		MTK_FUNCTION(1, "SPI_CK_3_")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(135, "KPROW3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 146),
+		MTK_FUNCTION(0, "GPIO135"),
+		MTK_FUNCTION(1, "KROW3"),
+		MTK_FUNCTION(2, "DSIC_TE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(136, "KPROW4"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 36),
+		MTK_FUNCTION(0, "GPIO136"),
+		MTK_FUNCTION(1, "KROW4"),
+		MTK_FUNCTION(2, "DSID_TE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(137, "KPCOL3"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 147),
+		MTK_FUNCTION(0, "GPIO137"),
+		MTK_FUNCTION(1, "KCOL3"),
+		MTK_FUNCTION(2, "DISP2_PWM")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(138, "KPCOL4"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 37),
+		MTK_FUNCTION(0, "GPIO138"),
+		MTK_FUNCTION(1, "KCOL4"),
+		MTK_FUNCTION(2, "LCM_RST2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(139, "KPCOL5"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 38),
+		MTK_FUNCTION(0, "GPIO139"),
+		MTK_FUNCTION(1, "KCOL5"),
+		MTK_FUNCTION(3, "DSIA_TE"),
+		MTK_FUNCTION(4, "PURE_HW_PROTECT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(140, "KPCOL6"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 39),
+		MTK_FUNCTION(0, "GPIO140"),
+		MTK_FUNCTION(1, "KCOL6"),
+		MTK_FUNCTION(2, "WATCH_DOG"),
+		MTK_FUNCTION(3, "LCM_RST1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(141, "KPROW5"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 40),
+		MTK_FUNCTION(0, "GPIO141"),
+		MTK_FUNCTION(1, "KROW5"),
+		MTK_FUNCTION(3, "LCM_RST0"),
+		MTK_FUNCTION(4, "PURE_HW_PROTECT")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(142, "KPROW6"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 41),
+		MTK_FUNCTION(0, "GPIO142"),
+		MTK_FUNCTION(1, "KROW6"),
+		MTK_FUNCTION(2, "SRCLKENA0"),
+		MTK_FUNCTION(3, "DSIB_TE")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(143, "JTDO_ICE"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 148),
+		MTK_FUNCTION(0, "GPIO143"),
+		MTK_FUNCTION(1, "JTDO_ICE"),
+		MTK_FUNCTION(3, "DFD_TDO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(144, "JTCK_ICE"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 149),
+		MTK_FUNCTION(0, "GPIO144"),
+		MTK_FUNCTION(1, "JTCK_ICE"),
+		MTK_FUNCTION(3, "DFD_TCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(145, "JTDI_ICE"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 150),
+		MTK_FUNCTION(0, "GPIO145"),
+		MTK_FUNCTION(1, "JTDI_ICE"),
+		MTK_FUNCTION(3, "DFD_TDI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(146, "JTMS_ICE"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 151),
+		MTK_FUNCTION(0, "GPIO146"),
+		MTK_FUNCTION(1, "JTMS_ICE"),
+		MTK_FUNCTION(3, "DFD_TMS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(147, "JTRSTB_ICE"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 152),
+		MTK_FUNCTION(0, "GPIO147"),
+		MTK_FUNCTION(1, "JTRST_B_ICE"),
+		MTK_FUNCTION(3, "DFD_NTRST")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(148, "GPIO148"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 153),
+		MTK_FUNCTION(0, "GPIO148"),
+		MTK_FUNCTION(1, "JTRSTB_CM4"),
+		MTK_FUNCTION(3, "DFD_NTRST")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(149, "GPIO149"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 154),
+		MTK_FUNCTION(0, "GPIO149"),
+		MTK_FUNCTION(1, "JTCK_CM4"),
+		MTK_FUNCTION(3, "DFD_TCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(150, "GPIO150"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 155),
+		MTK_FUNCTION(0, "GPIO150"),
+		MTK_FUNCTION(1, "JTMS_CM4"),
+		MTK_FUNCTION(3, "DFD_TMS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(151, "GPIO151"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 156),
+		MTK_FUNCTION(0, "GPIO151"),
+		MTK_FUNCTION(1, "JTDI_CM4"),
+		MTK_FUNCTION(3, "DFD_TDI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(152, "GPIO152"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 157),
+		MTK_FUNCTION(0, "GPIO152"),
+		MTK_FUNCTION(1, "JTDO_CM4"),
+		MTK_FUNCTION(3, "DFD_TDO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(153, "SPI0_CSN"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 158),
+		MTK_FUNCTION(0, "GPIO153"),
+		MTK_FUNCTION(1, "SPI_CS_0_"),
+		MTK_FUNCTION(2, "SRCLKENA0"),
+		MTK_FUNCTION(3, "UTXD0"),
+		MTK_FUNCTION(4, "I2SO0_DO1"),
+		MTK_FUNCTION(6, "TDMO0_DATA1"),
+		MTK_FUNCTION(7, "I2S_IQ2_SDQB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(154, "SPI0_MI"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 159),
+		MTK_FUNCTION(0, "GPIO154"),
+		MTK_FUNCTION(1, "SPI_MI_0_"),
+		MTK_FUNCTION(2, "SRCLKENA0"),
+		MTK_FUNCTION(3, "URXD0"),
+		MTK_FUNCTION(4, "I2SO0_DO0"),
+		MTK_FUNCTION(5, "I2SO1_DO"),
+		MTK_FUNCTION(6, "TDMO0_DATA"),
+		MTK_FUNCTION(7, "I2S_IQ1_SDIB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(155, "SPI0_CK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 160),
+		MTK_FUNCTION(0, "GPIO155"),
+		MTK_FUNCTION(1, "SPI_CK_0_"),
+		MTK_FUNCTION(2, "SC_APBIAS_OFF"),
+		MTK_FUNCTION(3, "UTXD1"),
+		MTK_FUNCTION(4, "I2SO0_BCK"),
+		MTK_FUNCTION(5, "I2SO1_BCK"),
+		MTK_FUNCTION(6, "TDMO0_BCK"),
+		MTK_FUNCTION(7, "I2S_IQ0_SDQB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(156, "SPI0_MO"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 161),
+		MTK_FUNCTION(0, "GPIO156"),
+		MTK_FUNCTION(1, "SPI_MO_0_"),
+		MTK_FUNCTION(2, "SC_APBIAS_OFF"),
+		MTK_FUNCTION(3, "URXD1"),
+		MTK_FUNCTION(4, "I2SO0_WS"),
+		MTK_FUNCTION(5, "I2SO1_WS"),
+		MTK_FUNCTION(6, "TDMO0_LRCK"),
+		MTK_FUNCTION(7, "I2S_IQ0_SDIB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(157, "SPI5_CSN"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 162),
+		MTK_FUNCTION(0, "GPIO157"),
+		MTK_FUNCTION(1, "SPI_CS_5_"),
+		MTK_FUNCTION(2, "LCM_RST0"),
+		MTK_FUNCTION(3, "UTXD2"),
+		MTK_FUNCTION(4, "I2SO0_MCK"),
+		MTK_FUNCTION(5, "I2SO1_MCK"),
+		MTK_FUNCTION(6, "TDMO0_MCLK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(158, "SPI5_MI"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 163),
+		MTK_FUNCTION(0, "GPIO158"),
+		MTK_FUNCTION(1, "SPI_MI_5_"),
+		MTK_FUNCTION(2, "DSIA_TE"),
+		MTK_FUNCTION(3, "URXD2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(159, "SPI5_MO"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 164),
+		MTK_FUNCTION(0, "GPIO159"),
+		MTK_FUNCTION(1, "SPI_MO_5_"),
+		MTK_FUNCTION(2, "DSIB_TE"),
+		MTK_FUNCTION(3, "UTXD3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(160, "SPI5_CK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 165),
+		MTK_FUNCTION(0, "GPIO160"),
+		MTK_FUNCTION(1, "SPI_CK_5_"),
+		MTK_FUNCTION(2, "LCM_RST1"),
+		MTK_FUNCTION(3, "URXD3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(161, "SPI1_CSN"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 166),
+		MTK_FUNCTION(0, "GPIO161"),
+		MTK_FUNCTION(1, "SPI_CS_1_"),
+		MTK_FUNCTION(2, "SPI_CS_4_"),
+		MTK_FUNCTION(4, "I2S_IQ2_SDQB"),
+		MTK_FUNCTION(5, "I2SO2_DO"),
+		MTK_FUNCTION(6, "TDMO0_DATA1"),
+		MTK_FUNCTION(7, "I2SO0_DO1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(162, "SPI1_SI"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 167),
+		MTK_FUNCTION(0, "GPIO162"),
+		MTK_FUNCTION(1, "SPI_SI_1_"),
+		MTK_FUNCTION(2, "SPI_MI_4_"),
+		MTK_FUNCTION(4, "I2S_IQ1_SDIB"),
+		MTK_FUNCTION(5, "I2SO2_BCK"),
+		MTK_FUNCTION(6, "TDMO0_DATA"),
+		MTK_FUNCTION(7, "I2SO0_DO0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(163, "SPI1_CK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 168),
+		MTK_FUNCTION(0, "GPIO163"),
+		MTK_FUNCTION(1, "SPI_CK_1_"),
+		MTK_FUNCTION(2, "SPI_CK_4_"),
+		MTK_FUNCTION(4, "I2S_IQ0_SDQB"),
+		MTK_FUNCTION(5, "I2SO2_WS"),
+		MTK_FUNCTION(6, "TDMO0_BCK"),
+		MTK_FUNCTION(7, "I2SO0_BCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(164, "SPI1_SO"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 169),
+		MTK_FUNCTION(0, "GPIO164"),
+		MTK_FUNCTION(1, "SPI_SO_1_"),
+		MTK_FUNCTION(2, "SPI_MO_4_"),
+		MTK_FUNCTION(4, "I2S_IQ0_SDIB"),
+		MTK_FUNCTION(5, "I2SO2_MCK"),
+		MTK_FUNCTION(6, "TDMO0_LRCK"),
+		MTK_FUNCTION(7, "I2SO0_WS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(165, "SPI4_CSN"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 170),
+		MTK_FUNCTION(0, "GPIO165"),
+		MTK_FUNCTION(1, "SPI_CS_4_"),
+		MTK_FUNCTION(2, "LCM_RST0"),
+		MTK_FUNCTION(3, "SPI_CS_1_"),
+		MTK_FUNCTION(4, "UTXD4"),
+		MTK_FUNCTION(5, "I2SO1_DO"),
+		MTK_FUNCTION(6, "TDMO0_MCLK"),
+		MTK_FUNCTION(7, "I2SO0_MCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(166, "SPI4_MI"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 171),
+		MTK_FUNCTION(0, "GPIO166"),
+		MTK_FUNCTION(1, "SPI_MI_4_"),
+		MTK_FUNCTION(2, "DSIA_TE"),
+		MTK_FUNCTION(3, "SPI_SI_1_"),
+		MTK_FUNCTION(4, "URXD4"),
+		MTK_FUNCTION(5, "I2SO1_BCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(167, "SPI4_MO"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 172),
+		MTK_FUNCTION(0, "GPIO167"),
+		MTK_FUNCTION(1, "SPI_MO_4_"),
+		MTK_FUNCTION(2, "DSIB_TE"),
+		MTK_FUNCTION(3, "SPI_SO_1_"),
+		MTK_FUNCTION(4, "UTXD5"),
+		MTK_FUNCTION(5, "I2SO1_WS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(168, "SPI4_CK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 173),
+		MTK_FUNCTION(0, "GPIO168"),
+		MTK_FUNCTION(1, "SPI_CK_4_"),
+		MTK_FUNCTION(2, "LCM_RST1"),
+		MTK_FUNCTION(3, "SPI_CK_1_"),
+		MTK_FUNCTION(4, "URXD5"),
+		MTK_FUNCTION(5, "I2SO1_MCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(169, "I2SI0_DATA"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 174),
+		MTK_FUNCTION(0, "GPIO169"),
+		MTK_FUNCTION(1, "I2SI0_DI"),
+		MTK_FUNCTION(2, "I2SI1_DI"),
+		MTK_FUNCTION(3, "I2SI2_DI"),
+		MTK_FUNCTION(4, "TDMIN_DI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(170, "I2SI0_LRCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 175),
+		MTK_FUNCTION(0, "GPIO170"),
+		MTK_FUNCTION(1, "I2SI0_WS"),
+		MTK_FUNCTION(2, "I2SI1_WS"),
+		MTK_FUNCTION(3, "I2SI2_WS"),
+		MTK_FUNCTION(4, "TDMIN_LRCK"),
+		MTK_FUNCTION(5, "TDMO0_DATA3"),
+		MTK_FUNCTION(6, "TDMO1_DATA3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(171, "I2SI0_MCLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 176),
+		MTK_FUNCTION(0, "GPIO171"),
+		MTK_FUNCTION(1, "I2SI0_MCK"),
+		MTK_FUNCTION(2, "I2SI1_MCK"),
+		MTK_FUNCTION(3, "I2SI2_MCK"),
+		MTK_FUNCTION(4, "TDMIN_MCLK"),
+		MTK_FUNCTION(5, "TDMO0_DATA2"),
+		MTK_FUNCTION(6, "TDMO1_DATA2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(172, "I2SI0_BCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 177),
+		MTK_FUNCTION(0, "GPIO172"),
+		MTK_FUNCTION(1, "I2SI0_BCK"),
+		MTK_FUNCTION(2, "I2SI1_BCK"),
+		MTK_FUNCTION(3, "I2SI2_BCK"),
+		MTK_FUNCTION(4, "TDMIN_BCK"),
+		MTK_FUNCTION(5, "TDMO0_DATA1"),
+		MTK_FUNCTION(6, "TDMO1_DATA1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(173, "I2SI2_DATA"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 178),
+		MTK_FUNCTION(0, "GPIO173"),
+		MTK_FUNCTION(1, "I2SI2_DI"),
+		MTK_FUNCTION(2, "I2SI0_DI"),
+		MTK_FUNCTION(3, "I2SI1_DI"),
+		MTK_FUNCTION(4, "PCM1_DI"),
+		MTK_FUNCTION(5, "TDMIN_DI"),
+		MTK_FUNCTION(6, "PCM1_DO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(174, "I2SI2_MCLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 179),
+		MTK_FUNCTION(0, "GPIO174"),
+		MTK_FUNCTION(1, "I2SI2_MCK"),
+		MTK_FUNCTION(2, "I2SI0_MCK"),
+		MTK_FUNCTION(3, "I2SI1_MCK"),
+		MTK_FUNCTION(4, "PCM1_DO"),
+		MTK_FUNCTION(5, "TDMIN_MCLK"),
+		MTK_FUNCTION(6, "PCM1_DI"),
+		MTK_FUNCTION(7, "I2S_IQ2_SDQB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(175, "I2SI2_BCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 180),
+		MTK_FUNCTION(0, "GPIO175"),
+		MTK_FUNCTION(1, "I2SI2_BCK"),
+		MTK_FUNCTION(2, "I2SI0_BCK"),
+		MTK_FUNCTION(3, "I2SI1_BCK"),
+		MTK_FUNCTION(4, "PCM1_CLK"),
+		MTK_FUNCTION(5, "TDMIN_BCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(176, "I2SI2_LRCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 181),
+		MTK_FUNCTION(0, "GPIO176"),
+		MTK_FUNCTION(1, "I2SI2_WS"),
+		MTK_FUNCTION(2, "I2SI0_WS"),
+		MTK_FUNCTION(3, "I2SI1_WS"),
+		MTK_FUNCTION(4, "PCM1_SYNC"),
+		MTK_FUNCTION(5, "TDMIN_LRCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(177, "I2SI1_DATA"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 182),
+		MTK_FUNCTION(0, "GPIO177"),
+		MTK_FUNCTION(1, "I2SI1_DI"),
+		MTK_FUNCTION(2, "I2SI0_DI"),
+		MTK_FUNCTION(3, "I2SI2_DI"),
+		MTK_FUNCTION(4, "TDMIN_DI")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(178, "I2SI1_BCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 183),
+		MTK_FUNCTION(0, "GPIO178"),
+		MTK_FUNCTION(1, "I2SI1_BCK"),
+		MTK_FUNCTION(2, "I2SI0_BCK"),
+		MTK_FUNCTION(3, "I2SI2_BCK"),
+		MTK_FUNCTION(4, "TDMIN_BCK"),
+		MTK_FUNCTION(5, "TDMO0_DATA3"),
+		MTK_FUNCTION(6, "TDMO1_DATA3")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(179, "I2SI1_LRCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 184),
+		MTK_FUNCTION(0, "GPIO179"),
+		MTK_FUNCTION(1, "I2SI1_WS"),
+		MTK_FUNCTION(2, "I2SI0_WS"),
+		MTK_FUNCTION(3, "I2SI2_WS"),
+		MTK_FUNCTION(4, "TDMIN_LRCK"),
+		MTK_FUNCTION(5, "TDMO0_DATA2"),
+		MTK_FUNCTION(6, "TDMO1_DATA2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(180, "I2SI1_MCLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 185),
+		MTK_FUNCTION(0, "GPIO180"),
+		MTK_FUNCTION(1, "I2SI1_MCK"),
+		MTK_FUNCTION(2, "I2SI0_MCK"),
+		MTK_FUNCTION(3, "I2SI2_MCK"),
+		MTK_FUNCTION(4, "TDMIN_MCLK"),
+		MTK_FUNCTION(5, "TDMO0_DATA1"),
+		MTK_FUNCTION(6, "TDMO1_DATA1"),
+		MTK_FUNCTION(7, "I2S_IQ2_SDIB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(181, "I2SO1_DATA0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 186),
+		MTK_FUNCTION(0, "GPIO181"),
+		MTK_FUNCTION(1, "I2SO1_DO"),
+		MTK_FUNCTION(2, "I2SO0_DO0"),
+		MTK_FUNCTION(3, "I2SO2_DO"),
+		MTK_FUNCTION(4, "DAI_TX"),
+		MTK_FUNCTION(5, "TDMIN_MCLK"),
+		MTK_FUNCTION(7, "I2S_IQ2_SDIA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(182, "I2SO1_BCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 187),
+		MTK_FUNCTION(0, "GPIO182"),
+		MTK_FUNCTION(1, "I2SO1_BCK"),
+		MTK_FUNCTION(2, "I2SO0_BCK"),
+		MTK_FUNCTION(3, "I2SO2_BCK"),
+		MTK_FUNCTION(4, "DAI_SYNC"),
+		MTK_FUNCTION(5, "TDMIN_BCK"),
+		MTK_FUNCTION(6, "TDMO0_DATA3"),
+		MTK_FUNCTION(7, "I2S_IQ2_BCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(183, "I2SO1_LRCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 188),
+		MTK_FUNCTION(0, "GPIO183"),
+		MTK_FUNCTION(1, "I2SO1_WS"),
+		MTK_FUNCTION(2, "I2SO0_WS"),
+		MTK_FUNCTION(3, "I2SO2_WS"),
+		MTK_FUNCTION(4, "DAI_CLK"),
+		MTK_FUNCTION(5, "TDMIN_DI"),
+		MTK_FUNCTION(6, "TDMO0_DATA2"),
+		MTK_FUNCTION(7, "I2S_IQ2_WS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(184, "I2SO1_MCLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 189),
+		MTK_FUNCTION(0, "GPIO184"),
+		MTK_FUNCTION(1, "I2SO1_MCK"),
+		MTK_FUNCTION(2, "I2SO0_MCK"),
+		MTK_FUNCTION(3, "I2SO2_MCK"),
+		MTK_FUNCTION(4, "DAI_RX"),
+		MTK_FUNCTION(5, "TDMIN_LRCK"),
+		MTK_FUNCTION(6, "TDMO0_DATA1"),
+		MTK_FUNCTION(7, "I2S_IQ2_SDQA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(185, "AUD_EXT_CK2"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 190),
+		MTK_FUNCTION(0, "GPIO185"),
+		MTK_FUNCTION(1, "AUD_EXT_CK2"),
+		MTK_FUNCTION(2, "AUD_EXT_CK1"),
+		MTK_FUNCTION(3, "I2SO1_DO"),
+		MTK_FUNCTION(4, "I2SI2_DI"),
+		MTK_FUNCTION(5, "MRG_RX"),
+		MTK_FUNCTION(6, "PCM1_DI"),
+		MTK_FUNCTION(7, "I2S_IQ0_SDQB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(186, "AUD_EXT_CK1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 191),
+		MTK_FUNCTION(0, "GPIO186"),
+		MTK_FUNCTION(1, "AUD_EXT_CK1"),
+		MTK_FUNCTION(2, "AUD_EXT_CK2"),
+		MTK_FUNCTION(3, "I2SO0_DO1"),
+		MTK_FUNCTION(4, "I2SI1_DI"),
+		MTK_FUNCTION(5, "MRG_TX"),
+		MTK_FUNCTION(6, "PCM1_DO"),
+		MTK_FUNCTION(7, "I2S_IQ0_SDIB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(187, "I2SO2_BCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 192),
+		MTK_FUNCTION(0, "GPIO187"),
+		MTK_FUNCTION(1, "I2SO2_BCK"),
+		MTK_FUNCTION(2, "I2SO0_BCK"),
+		MTK_FUNCTION(3, "I2SO1_BCK"),
+		MTK_FUNCTION(4, "PCM1_CLK"),
+		MTK_FUNCTION(5, "MRG_SYNC"),
+		MTK_FUNCTION(6, "TDMO1_DATA3"),
+		MTK_FUNCTION(7, "I2S_IQ0_BCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(188, "I2SO2_LRCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 193),
+		MTK_FUNCTION(0, "GPIO188"),
+		MTK_FUNCTION(1, "I2SO2_WS"),
+		MTK_FUNCTION(2, "I2SO0_WS"),
+		MTK_FUNCTION(3, "I2SO1_WS"),
+		MTK_FUNCTION(4, "PCM1_SYNC"),
+		MTK_FUNCTION(5, "MRG_CLK"),
+		MTK_FUNCTION(6, "TDMO1_DATA2"),
+		MTK_FUNCTION(7, "I2S_IQ0_WS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(189, "I2SO2_MCLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 194),
+		MTK_FUNCTION(0, "GPIO189"),
+		MTK_FUNCTION(1, "I2SO2_MCK"),
+		MTK_FUNCTION(2, "I2SO0_MCK"),
+		MTK_FUNCTION(3, "I2SO1_MCK"),
+		MTK_FUNCTION(4, "PCM1_DO"),
+		MTK_FUNCTION(5, "MRG_RX"),
+		MTK_FUNCTION(6, "TDMO1_DATA1"),
+		MTK_FUNCTION(7, "I2S_IQ0_SDQA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(190, "I2SO2_DATA0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 195),
+		MTK_FUNCTION(0, "GPIO190"),
+		MTK_FUNCTION(1, "I2SO2_DO"),
+		MTK_FUNCTION(2, "I2SO0_DO0"),
+		MTK_FUNCTION(3, "I2SO1_DO"),
+		MTK_FUNCTION(4, "PCM1_DI"),
+		MTK_FUNCTION(5, "MRG_TX"),
+		MTK_FUNCTION(6, "PCM1_DO"),
+		MTK_FUNCTION(7, "I2S_IQ0_SDIA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(191, "I2SO0_DATA1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 196),
+		MTK_FUNCTION(0, "GPIO191"),
+		MTK_FUNCTION(1, "I2SO0_DO1"),
+		MTK_FUNCTION(2, "I2SI0_DI"),
+		MTK_FUNCTION(3, "I2SI1_DI"),
+		MTK_FUNCTION(4, "I2SI2_DI"),
+		MTK_FUNCTION(5, "DAI_TX"),
+		MTK_FUNCTION(6, "I2S_IQ0_SDQB"),
+		MTK_FUNCTION(7, "I2S_IQ1_SDQB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(192, "I2SO0_MCLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 197),
+		MTK_FUNCTION(0, "GPIO192"),
+		MTK_FUNCTION(1, "I2SO0_MCK"),
+		MTK_FUNCTION(2, "I2SO1_MCK"),
+		MTK_FUNCTION(3, "I2SO2_MCK"),
+		MTK_FUNCTION(4, "USB4_FT_SCL"),
+		MTK_FUNCTION(5, "TDMO1_DATA3"),
+		MTK_FUNCTION(6, "I2S_IQ0_SDIB"),
+		MTK_FUNCTION(7, "I2S_IQ1_SDQA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(193, "I2SO0_DATA0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 198),
+		MTK_FUNCTION(0, "GPIO193"),
+		MTK_FUNCTION(1, "I2SO0_DO0"),
+		MTK_FUNCTION(2, "I2SO1_DO"),
+		MTK_FUNCTION(3, "I2SO2_DO"),
+		MTK_FUNCTION(4, "USB4_FT_SDA"),
+		MTK_FUNCTION(7, "I2S_IQ1_SDIA")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(194, "I2SO0_LRCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 199),
+		MTK_FUNCTION(0, "GPIO194"),
+		MTK_FUNCTION(1, "I2SO0_WS"),
+		MTK_FUNCTION(2, "I2SO1_WS"),
+		MTK_FUNCTION(3, "I2SO2_WS"),
+		MTK_FUNCTION(4, "USB5_FT_SCL"),
+		MTK_FUNCTION(5, "TDMO1_DATA2"),
+		MTK_FUNCTION(7, "I2S_IQ1_WS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(195, "I2SO0_BCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 200),
+		MTK_FUNCTION(0, "GPIO195"),
+		MTK_FUNCTION(1, "I2SO0_BCK"),
+		MTK_FUNCTION(2, "I2SO1_BCK"),
+		MTK_FUNCTION(3, "I2SO2_BCK"),
+		MTK_FUNCTION(4, "USB5_FT_SDA"),
+		MTK_FUNCTION(5, "TDMO1_DATA1"),
+		MTK_FUNCTION(7, "I2S_IQ1_BCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(196, "TDMO1_MCLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 201),
+		MTK_FUNCTION(0, "GPIO196"),
+		MTK_FUNCTION(1, "TDMO1_MCLK"),
+		MTK_FUNCTION(2, "TDMO0_MCLK"),
+		MTK_FUNCTION(3, "TDMIN_MCLK"),
+		MTK_FUNCTION(6, "I2SO0_DO1"),
+		MTK_FUNCTION(7, "I2S_IQ1_SDIB")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(197, "TDMO1_LRCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 202),
+		MTK_FUNCTION(0, "GPIO197"),
+		MTK_FUNCTION(1, "TDMO1_LRCK"),
+		MTK_FUNCTION(2, "TDMO0_LRCK"),
+		MTK_FUNCTION(3, "TDMIN_LRCK"),
+		MTK_FUNCTION(4, "TDMO0_DATA3"),
+		MTK_FUNCTION(5, "TDMO1_DATA3"),
+		MTK_FUNCTION(6, "I2SO3_MCK"),
+		MTK_FUNCTION(7, "TDMO1_DATA2")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(198, "TDMO1_BCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 203),
+		MTK_FUNCTION(0, "GPIO198"),
+		MTK_FUNCTION(1, "TDMO1_BCK"),
+		MTK_FUNCTION(2, "TDMO0_BCK"),
+		MTK_FUNCTION(3, "TDMIN_BCK"),
+		MTK_FUNCTION(4, "TDMO0_DATA2"),
+		MTK_FUNCTION(5, "TDMO1_DATA2"),
+		MTK_FUNCTION(6, "I2SO3_BCK"),
+		MTK_FUNCTION(7, "TDMO1_DATA1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(199, "TDMO1_DATA"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 204),
+		MTK_FUNCTION(0, "GPIO199"),
+		MTK_FUNCTION(1, "TDMO1_DATA"),
+		MTK_FUNCTION(2, "TDMO0_DATA"),
+		MTK_FUNCTION(3, "TDMIN_DI"),
+		MTK_FUNCTION(4, "TDMO0_DATA1"),
+		MTK_FUNCTION(5, "TDMO1_DATA1"),
+		MTK_FUNCTION(6, "I2SO3_WS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(200, "TDMO0_MCLK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 205),
+		MTK_FUNCTION(0, "GPIO200"),
+		MTK_FUNCTION(1, "TDMO0_MCLK"),
+		MTK_FUNCTION(2, "TDMO1_MCLK"),
+		MTK_FUNCTION(3, "PCM1_DI"),
+		MTK_FUNCTION(4, "TDMO0_MCLK"),
+		MTK_FUNCTION(5, "TDMO1_MCLK"),
+		MTK_FUNCTION(6, "MRG_TX"),
+		MTK_FUNCTION(7, "I2SO2_MCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(201, "TDMO0_LRCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 206),
+		MTK_FUNCTION(0, "GPIO201"),
+		MTK_FUNCTION(1, "TDMO0_LRCK"),
+		MTK_FUNCTION(2, "TDMO1_LRCK"),
+		MTK_FUNCTION(3, "PCM1_SYNC"),
+		MTK_FUNCTION(4, "TDMO0_LRCK"),
+		MTK_FUNCTION(5, "TDMO1_LRCK"),
+		MTK_FUNCTION(6, "MRG_RX"),
+		MTK_FUNCTION(7, "I2SO2_WS")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(202, "TDMO0_BCK"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 207),
+		MTK_FUNCTION(0, "GPIO202"),
+		MTK_FUNCTION(1, "TDMO0_BCK"),
+		MTK_FUNCTION(2, "TDMO1_BCK"),
+		MTK_FUNCTION(3, "PCM1_CLK"),
+		MTK_FUNCTION(4, "TDMO0_BCK"),
+		MTK_FUNCTION(5, "TDMO1_BCK"),
+		MTK_FUNCTION(6, "MRG_SYNC"),
+		MTK_FUNCTION(7, "I2SO2_BCK")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(203, "TDMO0_DATA"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 208),
+		MTK_FUNCTION(0, "GPIO203"),
+		MTK_FUNCTION(1, "TDMO0_DATA"),
+		MTK_FUNCTION(2, "TDMO1_DATA"),
+		MTK_FUNCTION(3, "PCM1_DO"),
+		MTK_FUNCTION(4, "TDMO0_DATA"),
+		MTK_FUNCTION(5, "TDMO1_DATA"),
+		MTK_FUNCTION(6, "MRG_CLK"),
+		MTK_FUNCTION(7, "I2SO2_DO")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(204, "PERSTB_P0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 209),
+		MTK_FUNCTION(0, "GPIO204"),
+		MTK_FUNCTION(1, "PERST_B_P0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(205, "CLKREQN_P0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 210),
+		MTK_FUNCTION(0, "GPIO205"),
+		MTK_FUNCTION(1, "CLKREQ_N_P0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(206, "WAKEEN_P0"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 211),
+		MTK_FUNCTION(0, "GPIO206"),
+		MTK_FUNCTION(1, "WAKE_EN_P0")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(207, "PERSTB_P1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 212),
+		MTK_FUNCTION(0, "GPIO207"),
+		MTK_FUNCTION(1, "PERST_B_P1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(208, "CLKREQN_P1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 213),
+		MTK_FUNCTION(0, "GPIO208"),
+		MTK_FUNCTION(1, "CLKREQ_N_P1")
+	),
+	MTK_PIN(
+		PINCTRL_PIN(209, "WAKEEN_P1"),
+		NULL, "mt2712",
+		MTK_EINT_FUNCTION(0, 214),
+		MTK_FUNCTION(0, "GPIO209"),
+		MTK_FUNCTION(1, "WAKE_EN_P1")
+	),
+};
+
+#endif /* __PINCTRL_MTK_MT2712_H */
-- 
1.9.1
