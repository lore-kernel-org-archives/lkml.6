Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07111C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D37D520870
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 07:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfBAHiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 02:38:25 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:50298 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726699AbfBAHiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 02:38:23 -0500
X-UUID: d1915af8cd2048639bd3369a966e8bf7-20190201
X-UUID: d1915af8cd2048639bd3369a966e8bf7-20190201
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2014124702; Fri, 01 Feb 2019 15:38:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 1 Feb 2019 15:38:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 1 Feb 2019 15:38:15 +0800
From:   <michael.kao@mediatek.com>
To:     =Zhang Rui <rui.zhang@intel.com>,
        =Eduardo Valentin <edubezval@gmail.com>,
        =Daniel Lezcano <daniel.lezcano@linaro.org>,
        =Rob Herring <robh+dt@kernel.org>,
        =Mark Rutland <mark.rutland@arm.com>,
        =Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH 5/7] thermal: mediatek: add flag for bank selection
Date:   Fri, 1 Feb 2019 15:38:11 +0800
Message-ID: <1549006693-11659-6-git-send-email-michael.kao@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
References: <1549006693-11659-1-git-send-email-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 027EB64FBB3869FDCF181AFF62097238AF185DCA77FCC315B65135C61F187A8B2000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

For past ic designs, the thermal controller should select banks before
reading the thermal sensor.
And the new ic design architecture removes this mechanism.

Signed-off-by: Michael Kao <michael.kao@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index e5cf3f4..3e97638 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -213,6 +213,7 @@ struct mtk_thermal_data {
 	const int cali_val;
 	const int num_controller;
 	const int *controller_offset;
+	bool need_switch_bank;
 	struct thermal_bank_cfg bank_data[];
 };
 
@@ -327,6 +328,7 @@ struct mtk_thermal {
 	.cali_val = MT8173_CALIBRATION,
 	.num_controller = MT8173_NUM_CONTROLLER,
 	.controller_offset = mt8173_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 2,
@@ -365,6 +367,7 @@ struct mtk_thermal {
 	.cali_val = MT2701_CALIBRATION,
 	.num_controller = MT2701_NUM_CONTROLLER,
 	.controller_offset = mt2701_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 3,
@@ -394,6 +397,7 @@ struct mtk_thermal {
 	.cali_val = MT2712_CALIBRATION,
 	.num_controller = MT2712_NUM_CONTROLLER,
 	.controller_offset = mt2712_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 4,
@@ -417,6 +421,7 @@ struct mtk_thermal {
 	.cali_val = MT7622_CALIBRATION,
 	.num_controller = MT7622_NUM_CONTROLLER,
 	.controller_offset = mt7622_tc_offset,
+	.need_switch_bank = true,
 	.bank_data = {
 		{
 			.num_sensors = 1,
@@ -463,12 +468,14 @@ static void mtk_thermal_get_bank(struct mtk_thermal_bank *bank)
 	struct mtk_thermal *mt = bank->mt;
 	u32 val;
 
-	mutex_lock(&mt->lock);
+	if (mt->conf->need_switch_bank) {
+		mutex_lock(&mt->lock);
 
-	val = readl(mt->thermal_base + PTPCORESEL);
-	val &= ~0xf;
-	val |= bank->id;
-	writel(val, mt->thermal_base + PTPCORESEL);
+		val = readl(mt->thermal_base + PTPCORESEL);
+		val &= ~0xf;
+		val |= bank->id;
+		writel(val, mt->thermal_base + PTPCORESEL);
+	}
 }
 
 /**
@@ -481,7 +488,8 @@ static void mtk_thermal_put_bank(struct mtk_thermal_bank *bank)
 {
 	struct mtk_thermal *mt = bank->mt;
 
-	mutex_unlock(&mt->lock);
+	if (mt->conf->need_switch_bank)
+		mutex_unlock(&mt->lock);
 }
 
 /**
-- 
1.9.1

