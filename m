Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409EBC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26752085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N98nlgS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26752085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730631AbeKFVFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:05:55 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39515 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729728AbeKFVFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:05:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so11407679wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 03:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PhP0kUXnKuZ1XA394b7ZOzK19O6EUp0oVGwTe/CdNME=;
        b=N98nlgS6cFXbFHZJkOily95zFH9TJtslAAFWdua18PV+qkxjg1sGqaCBeltXAtCsZ2
         /H+SH0mC8Ifs07VQW6v8emJ+ymNMbD8u8TGVYpSNK8nt4+8FMTKXbC71R1lzAPKWICnF
         6RK0kKqEALBu7qaAHK7ikkfeBNCRl9P3WJU4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PhP0kUXnKuZ1XA394b7ZOzK19O6EUp0oVGwTe/CdNME=;
        b=qUsE/RHvm00D31jpzHt5j/rBwoL+UqANn4Zrl9N8bjK5H4YUidkoJfXmMPnsMZcg1B
         iF1JkXc2nFcEAk/GieGZatig+ANJnknajWWEzjT/vNwCawMC722xou1HwNP50kKviPf5
         oJQEfLxfVFg0++DKl/CJztCDDZ7tVhmWRR7FAf2oryefpXwdsqyMBMx3MgmuqAMsmlph
         AXn3Fyu5eD3iWUMHLEeQlPkEkgUgGHIUe8/KLbS5jGwSv1ea+WALXnCoXtyapQe2G9r8
         GdywXS/6PmWihH2jib9ScoNytgvh+R9jxdFN8J0NKo7ga4BvRKDKjXJqqCNcwKMbaL/I
         Rldg==
X-Gm-Message-State: AGRZ1gK6CzVP9HtiBoSzbUrSSrSmcn4fYd3llfgqke2wQ4GcG/BPJ4Vn
        /zOXeFcwaQi0s1U/lnyY4XPsJA==
X-Google-Smtp-Source: AJdET5d90WB5XJGpTU66TNOI2FugFsFaZ50dG/LIbDWfyirKiHM47LDQRnUC8LDsYLio2qShFU7aWQ==
X-Received: by 2002:a1c:c016:: with SMTP id q22-v6mr1734870wmf.151.1541504463136;
        Tue, 06 Nov 2018 03:41:03 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b5-v6sm1990114wma.17.2018.11.06.03.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 03:41:02 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        rohitkr@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/2] ASoC: qdsp6: q6afe-dai: Fix the dai widgets
Date:   Tue,  6 Nov 2018 11:38:57 +0000
Message-Id: <20181106113857.19737-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106113857.19737-1-srinivas.kandagatla@linaro.org>
References: <20181106113857.19737-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason the dapm widgets are incorrectly defined from the start,
Not sure how we ended up with such thing. Fix them now!

Without this fix the backend dais are always powered up even if there
is no active stream.

Reported-by: Jimmy Cheng-Yi Chiang <cychiang@google.com>
Reported-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe-dai.c | 208 +++++++++++++++----------------
 1 file changed, 104 insertions(+), 104 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe-dai.c b/sound/soc/qcom/qdsp6/q6afe-dai.c
index 60ff4a2d3577..8f6c8fc073a9 100644
--- a/sound/soc/qcom/qdsp6/q6afe-dai.c
+++ b/sound/soc/qcom/qdsp6/q6afe-dai.c
@@ -1112,204 +1112,204 @@ static int q6afe_of_xlate_dai_name(struct snd_soc_component *component,
 }
 
 static const struct snd_soc_dapm_widget q6afe_dai_widgets[] = {
-	SND_SOC_DAPM_AIF_OUT("HDMI_RX", "HDMI Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_0_RX", "Slimbus Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_1_RX", "Slimbus1 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_2_RX", "Slimbus2 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_3_RX", "Slimbus3 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_RX", "Slimbus4 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_RX", "Slimbus5 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_RX", "Slimbus6 Playback", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_0_TX", "Slimbus Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_1_TX", "Slimbus1 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_2_TX", "Slimbus2 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_3_TX", "Slimbus3 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_4_TX", "Slimbus4 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_5_TX", "Slimbus5 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SLIMBUS_6_TX", "Slimbus6 Capture", 0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_MI2S_RX", "Quaternary MI2S Playback",
+	SND_SOC_DAPM_AIF_IN("HDMI_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_0_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_1_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_2_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_3_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_4_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_5_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("SLIMBUS_6_RX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_0_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_1_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_2_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_3_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_4_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_5_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_OUT("SLIMBUS_6_TX", NULL, 0, 0, 0, 0),
+	SND_SOC_DAPM_AIF_IN("QUAT_MI2S_RX", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_MI2S_TX", "Quaternary MI2S Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_MI2S_TX", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_MI2S_RX", "Tertiary MI2S Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_MI2S_RX", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_MI2S_TX", "Tertiary MI2S Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_MI2S_TX", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_RX", "Secondary MI2S Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_MI2S_RX", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_MI2S_TX", "Secondary MI2S Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_TX", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_MI2S_RX_SD1",
+	SND_SOC_DAPM_AIF_IN("SEC_MI2S_RX_SD1",
 			"Secondary MI2S Playback SD1",
 			0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRI_MI2S_RX", "Primary MI2S Playback",
+	SND_SOC_DAPM_AIF_IN("PRI_MI2S_RX", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRI_MI2S_TX", "Primary MI2S Capture",
+	SND_SOC_DAPM_AIF_OUT("PRI_MI2S_TX", NULL,
 						0, 0, 0, 0),
 
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_0", "Primary TDM0 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_1", "Primary TDM1 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_1", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_2", "Primary TDM2 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_2", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_3", "Primary TDM3 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_3", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_4", "Primary TDM4 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_4", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_5", "Primary TDM5 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_5", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_6", "Primary TDM6 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_6", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_RX_7", "Primary TDM7 Playback",
+	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_RX_7", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_0", "Primary TDM0 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_0", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_1", "Primary TDM1 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_1", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_2", "Primary TDM2 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_2", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_3", "Primary TDM3 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_3", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_4", "Primary TDM4 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_4", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_5", "Primary TDM5 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_5", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_6", "Primary TDM6 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_6", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("PRIMARY_TDM_TX_7", "Primary TDM7 Capture",
+	SND_SOC_DAPM_AIF_OUT("PRIMARY_TDM_TX_7", NULL,
 						0, 0, 0, 0),
 
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_0", "Secondary TDM0 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_1", "Secondary TDM1 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_1", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_2", "Secondary TDM2 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_2", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_3", "Secondary TDM3 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_3", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_4", "Secondary TDM4 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_4", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_5", "Secondary TDM5 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_5", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_6", "Secondary TDM6 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_6", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("SEC_TDM_RX_7", "Secondary TDM7 Playback",
+	SND_SOC_DAPM_AIF_IN("SEC_TDM_RX_7", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_0", "Secondary TDM0 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_0", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_1", "Secondary TDM1 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_1", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_2", "Secondary TDM2 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_2", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_3", "Secondary TDM3 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_3", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_4", "Secondary TDM4 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_4", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_5", "Secondary TDM5 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_5", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_6", "Secondary TDM6 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_6", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("SEC_TDM_TX_7", "Secondary TDM7 Capture",
+	SND_SOC_DAPM_AIF_OUT("SEC_TDM_TX_7", NULL,
 						0, 0, 0, 0),
 
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_0", "Tertiary TDM0 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_1", "Tertiary TDM1 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_1", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_2", "Tertiary TDM2 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_2", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_3", "Tertiary TDM3 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_3", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_4", "Tertiary TDM4 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_4", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_5", "Tertiary TDM5 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_5", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_6", "Tertiary TDM6 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_6", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("TERT_TDM_RX_7", "Tertiary TDM7 Playback",
+	SND_SOC_DAPM_AIF_IN("TERT_TDM_RX_7", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_0", "Tertiary TDM0 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_0", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_1", "Tertiary TDM1 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_1", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_2", "Tertiary TDM2 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_2", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_3", "Tertiary TDM3 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_3", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_4", "Tertiary TDM4 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_4", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_5", "Tertiary TDM5 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_5", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_6", "Tertiary TDM6 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_6", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("TERT_TDM_TX_7", "Tertiary TDM7 Capture",
+	SND_SOC_DAPM_AIF_OUT("TERT_TDM_TX_7", NULL,
 						0, 0, 0, 0),
 
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_0", "Quaternary TDM0 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_1", "Quaternary TDM1 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_1", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_2", "Quaternary TDM2 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_2", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_3", "Quaternary TDM3 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_3", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_4", "Quaternary TDM4 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_4", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_5", "Quaternary TDM5 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_5", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_6", "Quaternary TDM6 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_6", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_RX_7", "Quaternary TDM7 Playback",
+	SND_SOC_DAPM_AIF_IN("QUAT_TDM_RX_7", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_0", "Quaternary TDM0 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_0", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_1", "Quaternary TDM1 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_1", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_2", "Quaternary TDM2 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_2", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_3", "Quaternary TDM3 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_3", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_4", "Quaternary TDM4 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_4", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_5", "Quaternary TDM5 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_5", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_6", "Quaternary TDM6 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_6", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUAT_TDM_TX_7", "Quaternary TDM7 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUAT_TDM_TX_7", NULL,
 						0, 0, 0, 0),
 
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_0", "Quinary TDM0 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_0", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_1", "Quinary TDM1 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_1", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_2", "Quinary TDM2 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_2", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_3", "Quinary TDM3 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_3", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_4", "Quinary TDM4 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_4", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_5", "Quinary TDM5 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_5", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_6", "Quinary TDM6 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_6", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_RX_7", "Quinary TDM7 Playback",
+	SND_SOC_DAPM_AIF_IN("QUIN_TDM_RX_7", NULL,
 			     0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_0", "Quinary TDM0 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_0", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_1", "Quinary TDM1 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_1", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_2", "Quinary TDM2 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_2", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_3", "Quinary TDM3 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_3", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_4", "Quinary TDM4 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_4", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_5", "Quinary TDM5 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_5", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_6", "Quinary TDM6 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_6", NULL,
 						0, 0, 0, 0),
-	SND_SOC_DAPM_AIF_IN("QUIN_TDM_TX_7", "Quinary TDM7 Capture",
+	SND_SOC_DAPM_AIF_OUT("QUIN_TDM_TX_7", NULL,
 						0, 0, 0, 0),
 };
 
-- 
2.19.1

