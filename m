Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E08AF20832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bdfFdrKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E08AF20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbeK1UBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:01:43 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38200 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeK1UBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:01:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id e5so17063842plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 01:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUOy4aZ8sMVe6+qMyVL/vM/qr2CuqdP0B3o/v6hxFfA=;
        b=bdfFdrKDZrKggQ4uqk3ZzKRghc+LFCQdp1DM6NVZyUt1YwGaQLdz4WDYMdXkpfRo28
         tI4mFgimoUggJKQI2Qj6KG9E8sJWDwXTs9A3LE5D6s/Dj3KqKViAuJBzRo0pMXFERH8V
         zo0T6fh2KGVVjMo7avspGBQkuAqDg1HkpkIrY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUOy4aZ8sMVe6+qMyVL/vM/qr2CuqdP0B3o/v6hxFfA=;
        b=qjf8kIN07r9YUNX/z6Znftw9nvjqDrKtdHBxoOOxSrECXAreTWrYx+nEOGxX/vsBJp
         Mei+lxtt4wXMJt6+MRLCmQsvEsjZ8QywQd2iBXbqIo7d6Cuz+kRnAq5GiwF2W6EXJN4Z
         DhSKGIcec7X+ELOFamumLTspmJBJ2rJL0gQsOImEEMKRE6ZPXbwTxUIaZTrRuP2HOEKv
         yRp1NHDoE6npLoOlS/IcSh8DarlzNTJkqaYC2YlPoRgQPo2+kroIowLQVbUQphQ237rH
         OIycaPNZQRuHr3msLg18yPfjpJhtrPcqzAu2l9Al5pdtD1gU8iQS3x/NkPgwqlNhweWu
         us7Q==
X-Gm-Message-State: AA+aEWbSJpUYq/u8CTSw/B/GirdiAp0cGVNlpZ4Qxw8cmLFpVqI+JM/5
        brn1AgmXmkzLqCVwPKeWixuSMEOfUKE=
X-Google-Smtp-Source: AFSGD/UlB7/+iwCyKUvjBqbaX6i2qOGc6R4dywm+eackpd9WbXVEwBwDBklbe7jgd11Yz8FA0oAInw==
X-Received: by 2002:a17:902:20c8:: with SMTP id v8mr17457296plg.319.1543395649008;
        Wed, 28 Nov 2018 01:00:49 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id i72sm11568607pfe.181.2018.11.28.01.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 01:00:47 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2 1/5] ASoC: qcom: sdm845: Add board specific dapm widgets
Date:   Wed, 28 Nov 2018 17:00:33 +0800
Message-Id: <20181128090037.257359-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add board specific dapm widgets so these widgets can be used
in the route.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 sound/soc/qcom/sdm845.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 58593db2ab151..95d8d4422dae0 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -212,6 +212,14 @@ static int sdm845_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 	return 0;
 }
 
+static const struct snd_soc_dapm_widget sdm845_snd_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
+	SND_SOC_DAPM_MIC("Int Mic", NULL),
+};
+
 static void sdm845_add_be_ops(struct snd_soc_card *card)
 {
 	struct snd_soc_dai_link *link;
@@ -243,6 +251,8 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 		goto data_alloc_fail;
 	}
 
+	card->dapm_widgets = sdm845_snd_widgets;
+	card->num_dapm_widgets = ARRAY_SIZE(sdm845_snd_widgets);
 	card->dev = dev;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

