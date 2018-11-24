Return-Path: <SRS0=c/ts=OD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708F5C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8F82086B
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Nov 2018 11:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U5KrbeDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8F82086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeKXV6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Nov 2018 16:58:14 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34345 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeKXV6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Nov 2018 16:58:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so4403851pfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Nov 2018 03:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUOy4aZ8sMVe6+qMyVL/vM/qr2CuqdP0B3o/v6hxFfA=;
        b=U5KrbeDOayGafnMfZXHDTR3LraAngU/khaaLGQjGG+XqRtz9DveBKxB+XPxxNm9VR3
         i5iRRVls3kacbYHg5DVKSkzrZczpdjzvRX7sVMsL9RBQxNHsiTy27dqctMXPIH3tD16P
         n9oktsOcJgfAuRgvhgXYLuRcjWeYUWGX6BY3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IUOy4aZ8sMVe6+qMyVL/vM/qr2CuqdP0B3o/v6hxFfA=;
        b=WW0LfzXvRiR5tl1C4L5EDmVmLpqCizQG5mXwbeco7lXb99Vt9w+y9MZp/KdcgkaqPN
         qw52bkKOC6jqe5sAROp8A4vi2Z+LVns1aL6QrcEZ9o8kn69oqdI59mLaCqlknZqdyQqO
         08Cu2Fo450B9+ywFOtymqdO0WrwnzSJdx3vK0SNkGvRFIBY9McUdSvO8gv2reVdhuiDo
         MUy16qYVenqax6VSXyyg3YRaP5NmeONv/ziO/7+KWuHEP1FUXq+IyuWRQCXe8xB2bHWa
         gzqTmWZE9jacgx0XYDP03k2RgFjF0dHvSo8TGK7mK1gb4UTkq7uI7lmAf15S5Pl/DmdK
         A/JA==
X-Gm-Message-State: AA+aEWbnT6tHnNkec8sEUTNjTmPAhIcqhDxc4cF+1XPyjNyhUyUz4wBf
        SO8f1G1NPaRTdiLc7DVbME4g7jZM2YU=
X-Google-Smtp-Source: AFSGD/UXLFP+4DfOkj/HXVi9bk2s07ptBhhw4EXV5ZjjjP3YnudAyj4pVUKVHaXdLZlj19y3rW5i0Q==
X-Received: by 2002:a63:2744:: with SMTP id n65mr17384088pgn.65.1543057802205;
        Sat, 24 Nov 2018 03:10:02 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id v124-v6sm25098580pfb.182.2018.11.24.03.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Nov 2018 03:10:01 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, oder_chiou@realtek.com,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 1/4] ASoC: qcom: sdm845: Add board specific dapm widgets
Date:   Sat, 24 Nov 2018 19:09:45 +0800
Message-Id: <20181124110948.209019-1-cychiang@chromium.org>
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

