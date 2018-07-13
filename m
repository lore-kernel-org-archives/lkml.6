Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DATE_IN_PAST_24_48,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3447CECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEE4A208D6
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="nQboSrkT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE4A208D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732009AbeGNXFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 19:05:03 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58058 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731530AbeGNXFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 19:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=0Sf9t4YY0VqOgGXdaUjSUOgSbMk2kJdVGofyxxH9aDI=; b=nQboSrkTJY4g
        t4rIatoDCQF4fJgbZ8VIvUrtjTAn8xTYgK1V7JVIrNtCJkk6We6Tgx8WKk9fm9Iwy5ww65bAc3EKF
        jmY1D1AYjPTZEuFBX4Wq22LhOUezuPWv0Wjl1nkT/Gzrv/DNAhmgXf/eFeWodPcNQT6M5G1qRQC2L
        sNrUE=;
Received: from host86-174-189-173.range86-174.btcentralplus.com ([86.174.189.173] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1feTH5-0006hr-6P; Sat, 14 Jul 2018 22:44:23 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 162C444007A; Fri, 13 Jul 2018 16:10:12 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: allow soc-core to pick up name prefixes from component nodes" to the asoc tree
In-Reply-To:  <20180713125043.13242-3-jbrunet@baylibre.com>
Message-Id: <20180713151012.162C444007A@finisterre.ee.mobilebroadband>
Date:   Fri, 13 Jul 2018 16:10:12 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: allow soc-core to pick up name prefixes from component nodes

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From aefba45539bc4868c1fae336410aec907ee0882a Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 13 Jul 2018 14:50:43 +0200
Subject: [PATCH] ASoC: allow soc-core to pick up name prefixes from component
 nodes

When the component does not match the configuration table provided
by the card, let soc-core check the component node for a name prefix

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 00bd58d167dd..3be0310d5c81 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1193,15 +1193,27 @@ void snd_soc_remove_dai_link(struct snd_soc_card *card,
 }
 EXPORT_SYMBOL_GPL(snd_soc_remove_dai_link);
 
+static void soc_set_of_name_prefix(struct snd_soc_component *component)
+{
+	struct device_node *component_of_node = component->dev->of_node;
+	const char *str;
+	int ret;
+
+	if (!component_of_node && component->dev->parent)
+		component_of_node = component->dev->parent->of_node;
+
+	ret = of_property_read_string(component_of_node, "sound-name-prefix",
+				      &str);
+	if (!ret)
+		component->name_prefix = str;
+}
+
 static void soc_set_name_prefix(struct snd_soc_card *card,
 				struct snd_soc_component *component)
 {
 	int i;
 
-	if (card->codec_conf == NULL)
-		return;
-
-	for (i = 0; i < card->num_configs; i++) {
+	for (i = 0; i < card->num_configs && card->codec_conf; i++) {
 		struct snd_soc_codec_conf *map = &card->codec_conf[i];
 		struct device_node *component_of_node = component->dev->of_node;
 
@@ -1213,8 +1225,14 @@ static void soc_set_name_prefix(struct snd_soc_card *card,
 		if (map->dev_name && strcmp(component->name, map->dev_name))
 			continue;
 		component->name_prefix = map->name_prefix;
-		break;
+		return;
 	}
+
+	/*
+	 * If there is no configuration table or no match in the table,
+	 * check if a prefix is provided in the node
+	 */
+	soc_set_of_name_prefix(component);
 }
 
 static int soc_probe_component(struct snd_soc_card *card,
-- 
2.18.0

