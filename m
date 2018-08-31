Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8270EC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 231BE20837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 18:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OjFWAWAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231BE20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeHaW0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 18:26:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59854 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeHaW0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 18:26:24 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7VIHcMR098142;
        Fri, 31 Aug 2018 13:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535739458;
        bh=dbxrHUJ0bqWwZaXuwJPjNLy8Ag6o17YNdj3nBYa1u8M=;
        h=From:To:CC:Subject:Date;
        b=OjFWAWAJAaB3kpvz+NBOxZhZqG7MhTl3iEAEKo14WkNoY00xQydKMqTZwL2OETABs
         xZL1TejX1LknBNRjN486qMEOhLsdjqU5QAD4D+E4Y0exDRY9K97Dzhg588AykN3uO8
         MYKXm0SFEEG+piUbIDchuJahW0xLnsffk2P73vQs=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VIHcRH027200;
        Fri, 31 Aug 2018 13:17:38 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 13:17:38 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 13:17:38 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7VIHcvc027843;
        Fri, 31 Aug 2018 13:17:38 -0500
Received: from localhost (uda0226330.dhcp.ti.com [172.22.167.21])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w7VIHbx05368;
        Fri, 31 Aug 2018 13:17:38 -0500 (CDT)
From:   "Andrew F. Davis" <afd@ti.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        "Andrew F . Davis" <afd@ti.com>
Subject: [PATCH] ASoC: tlv320aic31xx: Remove regulator notification handling
Date:   Fri, 31 Aug 2018 13:17:37 -0500
Message-ID: <20180831181737.29516-1-afd@ti.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The notification handler sets the reset line but never re-enables it
as no one is listening for an enable event, this is certainly broken
and was most likely just copied from other CODECs, remove this code.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 sound/soc/codecs/tlv320aic31xx.c | 55 +-------------------------------
 1 file changed, 1 insertion(+), 54 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 7d87df518fed..f8d0f3ebed9c 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -147,11 +147,6 @@ static const char * const aic31xx_supply_names[] = {
 
 #define AIC31XX_NUM_SUPPLIES ARRAY_SIZE(aic31xx_supply_names)
 
-struct aic31xx_disable_nb {
-	struct notifier_block nb;
-	struct aic31xx_priv *aic31xx;
-};
-
 struct aic31xx_priv {
 	struct snd_soc_component *component;
 	u8 i2c_regs_status;
@@ -162,7 +157,6 @@ struct aic31xx_priv {
 	int micbias_vg;
 	struct aic31xx_pdata pdata;
 	struct regulator_bulk_data supplies[AIC31XX_NUM_SUPPLIES];
-	struct aic31xx_disable_nb disable_nb[AIC31XX_NUM_SUPPLIES];
 	unsigned int sysclk;
 	u8 p_div;
 	int rate_div_line;
@@ -1116,28 +1110,6 @@ static int aic31xx_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	return 0;
 }
 
-static int aic31xx_regulator_event(struct notifier_block *nb,
-				   unsigned long event, void *data)
-{
-	struct aic31xx_disable_nb *disable_nb =
-		container_of(nb, struct aic31xx_disable_nb, nb);
-	struct aic31xx_priv *aic31xx = disable_nb->aic31xx;
-
-	if (event & REGULATOR_EVENT_DISABLE) {
-		/*
-		 * Put codec to reset and as at least one of the
-		 * supplies was disabled.
-		 */
-		if (aic31xx->gpio_reset)
-			gpiod_set_value(aic31xx->gpio_reset, 1);
-
-		regcache_mark_dirty(aic31xx->regmap);
-		dev_dbg(aic31xx->dev, "## %s: DISABLE received\n", __func__);
-	}
-
-	return 0;
-}
-
 static int aic31xx_reset(struct aic31xx_priv *aic31xx)
 {
 	int ret = 0;
@@ -1263,26 +1235,12 @@ static int aic31xx_set_bias_level(struct snd_soc_component *component,
 static int aic31xx_codec_probe(struct snd_soc_component *component)
 {
 	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
-	int i, ret;
+	int ret;
 
 	dev_dbg(aic31xx->dev, "## %s\n", __func__);
 
 	aic31xx->component = component;
 
-	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++) {
-		aic31xx->disable_nb[i].nb.notifier_call =
-			aic31xx_regulator_event;
-		aic31xx->disable_nb[i].aic31xx = aic31xx;
-		ret = regulator_register_notifier(aic31xx->supplies[i].consumer,
-						  &aic31xx->disable_nb[i].nb);
-		if (ret) {
-			dev_err(component->dev,
-				"Failed to request regulator notifier: %d\n",
-				ret);
-			return ret;
-		}
-	}
-
 	regcache_cache_only(aic31xx->regmap, true);
 	regcache_mark_dirty(aic31xx->regmap);
 
@@ -1297,19 +1255,8 @@ static int aic31xx_codec_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-static void aic31xx_codec_remove(struct snd_soc_component *component)
-{
-	struct aic31xx_priv *aic31xx = snd_soc_component_get_drvdata(component);
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(aic31xx->supplies); i++)
-		regulator_unregister_notifier(aic31xx->supplies[i].consumer,
-					      &aic31xx->disable_nb[i].nb);
-}
-
 static const struct snd_soc_component_driver soc_codec_driver_aic31xx = {
 	.probe			= aic31xx_codec_probe,
-	.remove			= aic31xx_codec_remove,
 	.set_bias_level		= aic31xx_set_bias_level,
 	.controls		= common31xx_snd_controls,
 	.num_controls		= ARRAY_SIZE(common31xx_snd_controls),
-- 
2.18.0

