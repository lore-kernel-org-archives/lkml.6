Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5KcwFbUzHlu8CgAAmS7hNA
	; Mon, 11 Jun 2018 08:32:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 48816607BB; Mon, 11 Jun 2018 08:32:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CA20D60385;
	Mon, 11 Jun 2018 08:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CA20D60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754227AbeFKIcu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:32:50 -0400
Received: from mx.socionext.com ([202.248.49.38]:23019 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754116AbeFKIcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:32:19 -0400
Received: from unknown (HELO kinkan-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 11 Jun 2018 17:32:17 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by kinkan-ex.css.socionext.com (Postfix) with ESMTP id 9C0DC1800E5;
        Mon, 11 Jun 2018 17:32:17 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 11 Jun 2018 17:32:17 +0900
Received: from yuzu.css.socionext.com (yuzu [172.31.8.45])
        by iyokan.css.socionext.com (Postfix) with ESMTP id 07F14403FD;
        Mon, 11 Jun 2018 17:32:17 +0900 (JST)
Received: from aegis.e01.socionext.com (unknown [10.213.134.210])
        by yuzu.css.socionext.com (Postfix) with ESMTP id D0B5D12013B;
        Mon, 11 Jun 2018 17:32:16 +0900 (JST)
From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH v3 3/3] ASoC: audio-graph-card: add hp and mic detect gpios same as simple-card
Date: Mon, 11 Jun 2018 17:32:14 +0900
Message-Id: <20180611083214.16858-3-suzuki.katsuhiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611083214.16858-1-suzuki.katsuhiro@socionext.com>
References: <20180611083214.16858-1-suzuki.katsuhiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds headphone and microphone jack detection gpios as same
as simple-card driver.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>

---

Changes from v2:
  - Nothing

Changes from v1:
  - Move changes of audio-graph-card to other patch
---
 sound/soc/generic/audio-graph-card.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index 1b6164249341..2baa60d3b3cc 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -21,7 +21,6 @@
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/string.h>
-#include <sound/jack.h>
 #include <sound/simple_card_utils.h>
 
 struct graph_card_data {
@@ -32,6 +31,8 @@ struct graph_card_data {
 		unsigned int mclk_fs;
 	} *dai_props;
 	unsigned int mclk_fs;
+	struct asoc_simple_jack hp_jack;
+	struct asoc_simple_jack mic_jack;
 	struct snd_soc_dai_link *dai_link;
 	struct gpio_desc *pa_gpio;
 };
@@ -278,6 +279,22 @@ static int asoc_graph_get_dais_count(struct device *dev)
 	return count;
 }
 
+static int asoc_graph_soc_card_probe(struct snd_soc_card *card)
+{
+	struct graph_card_data *priv = snd_soc_card_get_drvdata(card);
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
 static int asoc_graph_card_probe(struct platform_device *pdev)
 {
 	struct graph_card_data *priv;
@@ -319,6 +336,7 @@ static int asoc_graph_card_probe(struct platform_device *pdev)
 	card->num_links	= num;
 	card->dapm_widgets = asoc_graph_card_dapm_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(asoc_graph_card_dapm_widgets);
+	card->probe	= asoc_graph_soc_card_probe;
 
 	ret = asoc_graph_card_parse_of(priv);
 	if (ret < 0) {
-- 
2.17.1
