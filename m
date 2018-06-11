Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EqEIEmMFHlu+cwAAmS7hNA
	; Mon, 11 Jun 2018 05:16:09 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id F1ABC60792; Mon, 11 Jun 2018 05:16:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 547B3601D2;
	Mon, 11 Jun 2018 05:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 547B3601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753989AbeFKFQF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 01:16:05 -0400
Received: from mx.socionext.com ([202.248.49.38]:19718 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753909AbeFKFQD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 01:16:03 -0400
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Jun 2018 14:16:02 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 2E7736006F;
        Mon, 11 Jun 2018 14:16:02 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 11 Jun 2018 14:16:02 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id C09A740389;
        Mon, 11 Jun 2018 14:16:01 +0900 (JST)
Received: from aegis.e01.socionext.com (unknown [10.213.134.210])
        by yuzu.css.socionext.com (Postfix) with ESMTP id 940B1120139;
        Mon, 11 Jun 2018 14:16:01 +0900 (JST)
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v2 2/3] ASoC: simple-card: move hp and mic detection to soc_card probe
Date: Mon, 11 Jun 2018 14:15:58 +0900
Message-Id: <20180611051559.18082-2-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611051559.18082-1-suzuki.katsuhiro@socionext.com>
References: <20180611051559.18082-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves headphone and microphone detection to probe() of
snd_soc_card from init() of snd_soc_dai_link. This is because init()
is called (and an input device /dev/input/eventX is created too)
twice or above if simple card has two or more DAI links.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes from v1:
  - Newly added
---
 sound/soc/generic/simple-card.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 1bbd9e46bf2a..9eb26ee06892 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -149,14 +149,6 @@ static int asoc_simple_card_dai_init(struct snd_soc_pcm_runtime *rtd)
 	if (ret < 0)
 		return ret;
 
-	ret = asoc_simple_card_init_hp(rtd->card, &priv->hp_jack, PREFIX);
-	if (ret < 0)
-		return ret;
-
-	ret = asoc_simple_card_init_mic(rtd->card, &priv->mic_jack, PREFIX);
-	if (ret < 0)
-		return ret;
-
 	return 0;
 }
 
@@ -350,6 +342,22 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	return ret;
 }
 
+static int asoc_simple_soc_card_probe(struct snd_soc_card *card)
+{
+	struct simple_card_data *priv = snd_soc_card_get_drvdata(card);
+	int ret;
+
+	ret = asoc_simple_card_init_hp(card, &priv->hp_jack, NULL);
+	if (ret < 0)
+		return ret;
+
+	ret = asoc_simple_card_init_mic(card, &priv->mic_jack, NULL);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int asoc_simple_card_probe(struct platform_device *pdev)
 {
 	struct simple_card_data *priv;
@@ -385,6 +393,7 @@ static int asoc_simple_card_probe(struct platform_device *pdev)
 	card->dev		= dev;
 	card->dai_link		= priv->dai_link;
 	card->num_links		= num;
+	card->probe		= asoc_simple_soc_card_probe;
 
 	if (np && of_device_is_available(np)) {
 
-- 
2.17.1
