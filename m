Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDC4C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D32A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 08:01:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D32A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbeLKIBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 03:01:55 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:33582 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726036AbeLKIBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 03:01:52 -0500
X-UUID: 05589f5ad45341589857077929822880-20181211
X-UUID: 05589f5ad45341589857077929822880-20181211
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1072666083; Tue, 11 Dec 2018 16:01:28 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 11 Dec 2018 16:01:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 11 Dec 2018 16:01:27 +0800
From:   Zhiyong Tao <zhiyong.tao@mediatek.com>
To:     <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <mark.rutland@arm.com>, <matthias.bgg@gmail.com>
CC:     <srv_heupstream@mediatek.com>, <liguo.zhang@mediatek.com>,
        <eddie.huang@mediatek.com>, <hongkun.cao@mediatek.com>,
        <biao.huang@mediatek.com>, <hongzhou.yang@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <erin.lo@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-gpio@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: [PATCH] pinctrl: add drive for I2C related pins on MT8183
Date:   Tue, 11 Dec 2018 16:01:23 +0800
Message-ID: <20181211080123.1397-2-zhiyong.tao@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20181211080123.1397-1-zhiyong.tao@mediatek.com>
References: <20181211080123.1397-1-zhiyong.tao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch provides the advanced drive for I2C used pins on MT8183.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8183.c        | 50 ++++++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 45 +++++++++++++++++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h | 13 ++++++
 drivers/pinctrl/mediatek/pinctrl-paris.c         | 20 ++++++++++
 4 files changed, 128 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index 6262fd3678ea..5244e1b27b1d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -472,6 +472,51 @@ static const struct mtk_pin_field_calc mt8183_pin_r1_range[] = {
 	PIN_FIELD_BASE(133, 133, 8, 0x0D0, 0x10, 13, 1),
 };
 
+static const struct mtk_pin_field_calc mt8183_pin_drv_en_dis_range[] = {
+	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 20, 1),
+	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 15, 1),
+	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 12, 1),
+	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 7, 1),
+	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 12, 1),
+	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 9, 1),
+	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 19, 1),
+	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 22, 1),
+	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 24, 1),
+	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 14, 1),
+	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 27, 1),
+	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 17, 1),
+};
+
+static const struct mtk_pin_field_calc mt8183_pin_drv_e0_range[] = {
+	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 21, 1),
+	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 16, 1),
+	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 13, 1),
+	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 8, 1),
+	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 13, 1),
+	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 10, 1),
+	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 20, 1),
+	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 23, 1),
+	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 25, 1),
+	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 15, 1),
+	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 28, 1),
+	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 18, 1),
+};
+
+static const struct mtk_pin_field_calc mt8183_pin_drv_e1_range[] = {
+	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 22, 1),
+	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 17, 1),
+	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 14, 1),
+	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 9, 1),
+	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 14, 1),
+	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 11, 1),
+	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 21, 1),
+	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 24, 1),
+	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 26, 1),
+	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 16, 1),
+	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 29, 1),
+	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 19, 1),
+};
+
 static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_MODE] = MTK_RANGE(mt8183_pin_mode_range),
 	[PINCTRL_PIN_REG_DIR] = MTK_RANGE(mt8183_pin_dir_range),
@@ -485,6 +530,9 @@ static const struct mtk_pin_reg_calc mt8183_reg_cals[PINCTRL_PIN_REG_MAX] = {
 	[PINCTRL_PIN_REG_PUPD] = MTK_RANGE(mt8183_pin_pupd_range),
 	[PINCTRL_PIN_REG_R0] = MTK_RANGE(mt8183_pin_r0_range),
 	[PINCTRL_PIN_REG_R1] = MTK_RANGE(mt8183_pin_r1_range),
+	[PINCTRL_PIN_REG_DRV_EN_DIS] = MTK_RANGE(mt8183_pin_drv_en_dis_range),
+	[PINCTRL_PIN_REG_DRV_E0] = MTK_RANGE(mt8183_pin_drv_e0_range),
+	[PINCTRL_PIN_REG_DRV_E1] = MTK_RANGE(mt8183_pin_drv_e1_range),
 };
 
 static const char * const mt8183_pinctrl_register_base_names[] = {
@@ -517,6 +565,8 @@ static const struct mtk_pin_soc mt8183_data = {
 	.drive_get = mtk_pinconf_drive_get_rev1,
 	.adv_pull_get = mtk_pinconf_adv_pull_get,
 	.adv_pull_set = mtk_pinconf_adv_pull_set,
+	.adv_drive_get = mtk_pinconf_adv_drive_get,
+	.adv_drive_set = mtk_pinconf_adv_drive_set,
 };
 
 static const struct of_device_id mt8183_pinctrl_of_match[] = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 4a9e0d4c2bbc..da024279ec59 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -668,3 +668,48 @@ int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
 
 	return 0;
 }
+
+int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, bool enable,
+			      u32 arg)
+{
+	int err;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, arg & 1);
+	if (err)
+		return 0;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_E1,
+			       !!(arg & 2));
+	if (err)
+		return 0;
+
+	arg = enable ? 1 : 0;
+
+	err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_DRV_EN_DIS, arg);
+
+	return err;
+}
+
+int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, u32 *val)
+{
+	u32 en, e0, e1;
+	int err;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_EN_DIS, &en);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E0, &e0);
+	if (err)
+		return err;
+
+	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV_E1, &e1);
+	if (err)
+		return err;
+
+	*val = (e0 | e1 << 1 | en << 2) & 0x7;
+
+	return 0;
+}
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
index 6d24522739d9..795a3b10d54e 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.h
@@ -63,6 +63,9 @@ enum {
 	PINCTRL_PIN_REG_IES,
 	PINCTRL_PIN_REG_PULLEN,
 	PINCTRL_PIN_REG_PULLSEL,
+	PINCTRL_PIN_REG_DRV_EN_DIS,
+	PINCTRL_PIN_REG_DRV_E0,
+	PINCTRL_PIN_REG_DRV_E1,
 	PINCTRL_PIN_REG_MAX,
 };
 
@@ -224,6 +227,11 @@ struct mtk_pin_soc {
 	int (*adv_pull_get)(struct mtk_pinctrl *hw,
 			    const struct mtk_pin_desc *desc, bool pullup,
 			    u32 *val);
+	int (*adv_drive_set)(struct mtk_pinctrl *hw,
+			     const struct mtk_pin_desc *desc, bool enable,
+			     u32 arg);
+	int (*adv_drive_get)(struct mtk_pinctrl *hw,
+			     const struct mtk_pin_desc *desc, u32 *val);
 
 	/* Specific driver data */
 	void				*driver_data;
@@ -287,5 +295,10 @@ int mtk_pinconf_adv_pull_set(struct mtk_pinctrl *hw,
 int mtk_pinconf_adv_pull_get(struct mtk_pinctrl *hw,
 			     const struct mtk_pin_desc *desc, bool pullup,
 			     u32 *val);
+int mtk_pinconf_adv_drive_set(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, bool enable,
+			     u32 arg);
+int mtk_pinconf_adv_drive_get(struct mtk_pinctrl *hw,
+			      const struct mtk_pin_desc *desc, u32 *val);
 
 #endif /* __PINCTRL_MTK_COMMON_V2_H */
diff --git a/drivers/pinctrl/mediatek/pinctrl-paris.c b/drivers/pinctrl/mediatek/pinctrl-paris.c
index d2179028f134..ef4ccaa59e55 100644
--- a/drivers/pinctrl/mediatek/pinctrl-paris.c
+++ b/drivers/pinctrl/mediatek/pinctrl-paris.c
@@ -20,12 +20,16 @@
 #define MTK_PIN_CONFIG_RDSEL	(PIN_CONFIG_END + 2)
 #define MTK_PIN_CONFIG_PU_ADV	(PIN_CONFIG_END + 3)
 #define MTK_PIN_CONFIG_PD_ADV	(PIN_CONFIG_END + 4)
+#define MTK_PIN_CONFIG_DRV_EN_ADV	(PIN_CONFIG_END + 5)
+#define MTK_PIN_CONFIG_DRV_DIS_ADV	(PIN_CONFIG_END + 6)
 
 static const struct pinconf_generic_params mtk_custom_bindings[] = {
 	{"mediatek,tdsel",	MTK_PIN_CONFIG_TDSEL,		0},
 	{"mediatek,rdsel",	MTK_PIN_CONFIG_RDSEL,		0},
 	{"mediatek,pull-up-adv", MTK_PIN_CONFIG_PU_ADV,		1},
 	{"mediatek,pull-down-adv", MTK_PIN_CONFIG_PD_ADV,	1},
+	{"mediatek,drive-enable-adv", MTK_PIN_CONFIG_DRV_EN_ADV,	2},
+	{"mediatek,drive-disable-adv", MTK_PIN_CONFIG_DRV_DIS_ADV,	2},
 };
 
 #ifdef CONFIG_DEBUG_FS
@@ -34,6 +38,8 @@ static const struct pin_config_item mtk_conf_items[] = {
 	PCONFDUMP(MTK_PIN_CONFIG_RDSEL, "rdsel", NULL, true),
 	PCONFDUMP(MTK_PIN_CONFIG_PU_ADV, "pu-adv", NULL, true),
 	PCONFDUMP(MTK_PIN_CONFIG_PD_ADV, "pd-adv", NULL, true),
+	PCONFDUMP(MTK_PIN_CONFIG_DRV_EN_ADV, "drive-enable-adv", NULL, true),
+	PCONFDUMP(MTK_PIN_CONFIG_DRV_DIS_ADV, "drive-disable-adv", NULL, true),
 };
 #endif
 
@@ -311,6 +317,20 @@ static int mtk_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
 			return -ENOTSUPP;
 		}
 		break;
+	case MTK_PIN_CONFIG_DRV_EN_ADV:
+	case MTK_PIN_CONFIG_DRV_DIS_ADV:
+		if (hw->soc->adv_drive_set) {
+			bool enable;
+
+			enable = param == MTK_PIN_CONFIG_DRV_EN_ADV;
+			err = hw->soc->adv_drive_set(hw, desc, enable,
+						    arg);
+			if (err)
+				return err;
+		} else {
+			return -ENOTSUPP;
+		}
+		break;
 	default:
 		err = -ENOTSUPP;
 	}
-- 
2.12.5

