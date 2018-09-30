Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081E2C43143
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56E8206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 02:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56E8206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeI3JRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 05:17:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34066 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727153AbeI3JRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 05:17:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 456FFFA953BD;
        Sun, 30 Sep 2018 10:46:32 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Sun, 30 Sep 2018 10:46:28 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <broonie@kernel.org>
CC:     <joe@perches.com>, <perex@perex.cz>, <tiwai@suse.com>,
        <lgirdwood@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] ASoC: wm8731: Fix a unused function gcc warning
Date:   Sun, 30 Sep 2018 10:33:56 +0800
Message-ID: <1538274836-26057-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following compile warning:

sound/soc/codecs/wm8731.c:575:12: warning: 'wm8731_request_supplies' defined but not used [-Wunused-function]
sound/soc/codecs/wm8731.c:600:12: warning: 'wm8731_hw_init' defined but not used [-Wunused-function]

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
v1->v2:
 -  Move the declaration of wm8731_supply_names into the #if block 
    unused function has been wrapped to decrease the #if block definition. 

 sound/soc/codecs/wm8731.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 7c8fad8..9399103 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -36,12 +36,6 @@
 #include "wm8731.h"
 
 #define WM8731_NUM_SUPPLIES 4
-static const char *wm8731_supply_names[WM8731_NUM_SUPPLIES] = {
-	"AVDD",
-	"HPVDD",
-	"DCVDD",
-	"DBVDD",
-};
 
 /* codec private data */
 struct wm8731_priv {
@@ -572,6 +566,14 @@ static int wm8731_startup(struct snd_pcm_substream *substream,
 	.symmetric_rates = 1,
 };
 
+#if defined(CONFIG_I2C) || defined(CONFIG_SPI_MASTER)
+static const char *wm8731_supply_names[WM8731_NUM_SUPPLIES] = {
+	"AVDD",
+	"HPVDD",
+	"DCVDD",
+	"DBVDD",
+};
+
 static int wm8731_request_supplies(struct device *dev,
 		struct wm8731_priv *wm8731)
 {
@@ -627,6 +629,7 @@ static int wm8731_hw_init(struct device *dev, struct wm8731_priv *wm8731)
 
 	return ret;
 }
+#endif
 
 static const struct snd_soc_component_driver soc_component_dev_wm8731 = {
 	.set_bias_level		= wm8731_set_bias_level,
-- 
1.7.12.4

