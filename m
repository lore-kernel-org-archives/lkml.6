Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27833C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3FB52086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 11:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJQ5pWvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3FB52086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbeKFVFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:05:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38028 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730519AbeKFVFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:05:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id d10-v6so13109818wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 03:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/lsk1upCs1OyAE2EgU4g575DScGKAGYgfvHwM4h+f/g=;
        b=TJQ5pWvJUkbFBt7A5tRbFNfw5r0VIwJdiXtmjFHBgnBUmgzeh4XGSA7aUoXjlAOKbV
         k/ZoBVgw0ayDOg6RqXXjMyfuSigO91va4V9dWbh8iEzNt9zFvuNYqgO7fiITcUXw6JWv
         WgWvAD4Jf1j11exceSea4RIJi063+7JWz1/2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/lsk1upCs1OyAE2EgU4g575DScGKAGYgfvHwM4h+f/g=;
        b=G02zhenFCv4ST0T4k8hr/TcBXy95HKeszggKrGxzEheXQrpg95HmPe2cPnNqZbrVA2
         n2JFQdXSuHNLs7niVhjiCDyXoo2UiYgFiOzaX+69fOkyYUqQOO8+TGSHD2iGhzyuCm59
         eYebD2k03QT4gOOOtIihCuhqRcd7PLnsQ8DgzhgiSyT2P3RzOAgXkaaJGftdJoY5MElM
         FimZIRvS84pC2Xc9qdlzIEha8I9KceTISy9ERK3quPlZ6ALAPhxWC7glNzYv5Jo1MMdY
         MMW+6C/hLGkiJT2//mlGgOl4S42+S22rN9QUArosSBL+CtxjtFYoEBVslcbum0UE8JzN
         tfxw==
X-Gm-Message-State: AGRZ1gK9MAGN2XFm+M+nMk/urx0Ldm48t1Jcsx5BT5pM3RVYEOZ4cXr9
        f576oZBcTVcqm4yGNcLuzNDirQ==
X-Google-Smtp-Source: AJdET5fWR0a+xzYUonbaHeEYQ/4gCWVth8MbKYIxpDmTMXVsGyjRTo7vmzawrQuW3FBLbUIoVnBQHg==
X-Received: by 2002:adf:90af:: with SMTP id i44-v6mr21594130wri.77.1541504461969;
        Tue, 06 Nov 2018 03:41:01 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b5-v6sm1990114wma.17.2018.11.06.03.41.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Nov 2018 03:41:01 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     bgoswami@codeaurora.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        rohitkr@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] ASoC: qdsp6: q6asm-dai: Only add routing once.
Date:   Tue,  6 Nov 2018 11:38:56 +0000
Message-Id: <20181106113857.19737-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181106113857.19737-1-srinivas.kandagatla@linaro.org>
References: <20181106113857.19737-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

q6asm routing gets added multiple times as part of dai probe.
Move this to q6routing routes which has those widgets defined, this also
fixes the issue where these are added each time at dai probe.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 33 --------------------------------
 sound/soc/qcom/qdsp6/q6routing.c | 19 ++++++++++++++++++
 2 files changed, 19 insertions(+), 33 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index a16c71c03058..86115de5c1b2 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -122,7 +122,6 @@ static struct snd_pcm_hardware q6asm_dai_hardware_playback = {
 			.rate_max =	48000,				\
 		},							\
 		.name = "MultiMedia"#num,				\
-		.probe = fe_dai_probe,					\
 		.id = MSM_FRONTEND_DAI_MULTIMEDIA##num,			\
 	}
 
@@ -511,38 +510,6 @@ static void q6asm_dai_pcm_free(struct snd_pcm *pcm)
 	}
 }
 
-static const struct snd_soc_dapm_route afe_pcm_routes[] = {
-	{"MM_DL1",  NULL, "MultiMedia1 Playback" },
-	{"MM_DL2",  NULL, "MultiMedia2 Playback" },
-	{"MM_DL3",  NULL, "MultiMedia3 Playback" },
-	{"MM_DL4",  NULL, "MultiMedia4 Playback" },
-	{"MM_DL5",  NULL, "MultiMedia5 Playback" },
-	{"MM_DL6",  NULL, "MultiMedia6 Playback" },
-	{"MM_DL7",  NULL, "MultiMedia7 Playback" },
-	{"MM_DL7",  NULL, "MultiMedia8 Playback" },
-	{"MultiMedia1 Capture", NULL, "MM_UL1"},
-	{"MultiMedia2 Capture", NULL, "MM_UL2"},
-	{"MultiMedia3 Capture", NULL, "MM_UL3"},
-	{"MultiMedia4 Capture", NULL, "MM_UL4"},
-	{"MultiMedia5 Capture", NULL, "MM_UL5"},
-	{"MultiMedia6 Capture", NULL, "MM_UL6"},
-	{"MultiMedia7 Capture", NULL, "MM_UL7"},
-	{"MultiMedia8 Capture", NULL, "MM_UL8"},
-
-};
-
-static int fe_dai_probe(struct snd_soc_dai *dai)
-{
-	struct snd_soc_dapm_context *dapm;
-
-	dapm = snd_soc_component_get_dapm(dai->component);
-	snd_soc_dapm_add_routes(dapm, afe_pcm_routes,
-				ARRAY_SIZE(afe_pcm_routes));
-
-	return 0;
-}
-
-
 static const struct snd_soc_component_driver q6asm_fe_dai_component = {
 	.name		= DRV_NAME,
 	.ops		= &q6asm_dai_ops,
diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index c6b51571be94..d61b8404f7da 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -909,6 +909,25 @@ static const struct snd_soc_dapm_route intercon[] = {
 	{"MM_UL6", NULL, "MultiMedia6 Mixer"},
 	{"MM_UL7", NULL, "MultiMedia7 Mixer"},
 	{"MM_UL8", NULL, "MultiMedia8 Mixer"},
+
+	{"MM_DL1",  NULL, "MultiMedia1 Playback" },
+	{"MM_DL2",  NULL, "MultiMedia2 Playback" },
+	{"MM_DL3",  NULL, "MultiMedia3 Playback" },
+	{"MM_DL4",  NULL, "MultiMedia4 Playback" },
+	{"MM_DL5",  NULL, "MultiMedia5 Playback" },
+	{"MM_DL6",  NULL, "MultiMedia6 Playback" },
+	{"MM_DL7",  NULL, "MultiMedia7 Playback" },
+	{"MM_DL8",  NULL, "MultiMedia8 Playback" },
+
+	{"MultiMedia1 Capture", NULL, "MM_UL1"},
+	{"MultiMedia2 Capture", NULL, "MM_UL2"},
+	{"MultiMedia3 Capture", NULL, "MM_UL3"},
+	{"MultiMedia4 Capture", NULL, "MM_UL4"},
+	{"MultiMedia5 Capture", NULL, "MM_UL5"},
+	{"MultiMedia6 Capture", NULL, "MM_UL6"},
+	{"MultiMedia7 Capture", NULL, "MM_UL7"},
+	{"MultiMedia8 Capture", NULL, "MM_UL8"},
+
 };
 
 static int routing_hw_params(struct snd_pcm_substream *substream,
-- 
2.19.1

