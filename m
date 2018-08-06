Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA54C4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6D7C21A06
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 10:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WDBK0uoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D7C21A06
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729625AbeHFMXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 08:23:06 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36872 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbeHFMXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 08:23:06 -0400
Received: by mail-wm0-f47.google.com with SMTP id n11-v6so13659903wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2UJshgPncflTf0mELFPhzj1uJJWjpDZDUbchqymcVK4=;
        b=WDBK0uoDaj2hPC0F6y6qlu79ydhuFvKZWH1qeRS9yu7jXnC6nc+IX1Jgndw+L22akA
         yun0X7LJw+CUd3uHgZOuceUBGUuMIjXzThegoW7DQuTFx8C7tQe34YNxouYwzu+1+QBy
         IqOW2oiv7ckHTRbc121viNqW1zCQ0M0i49p9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2UJshgPncflTf0mELFPhzj1uJJWjpDZDUbchqymcVK4=;
        b=clO6Q1HD/0FJtUkDZ0w4uHcgLMPTa1SqVXkAlZRrhJcp408Db6WHt+HvOTSUFAPMBs
         SJD6VELS0Cn4hLWWtweLO1yEkHzZCQYO4Gz4NhLMSIBqNx9zho+wn0AscPPgQByYpVSl
         cH/FnC6nvioFaonvUJiBSImRN4Rxp1BcJ6oJ+nfsLa/S8Nasx9cgmxpzG8uRxg5jQykG
         KKsDhAF/vWF/O18ln9+D5YmbQjw5qfpHu5wY27tgwNVO90oO5KCN6glGHK5CQSzEmxYy
         gzLGwtrSIKpwdg0nN7cAwp+OksdVbf93Y0sG2AjC8cN/dcedTBhh/t5hUv0oYpGYaqiV
         obEw==
X-Gm-Message-State: AOUpUlFlNKZr4U1T4q7H2s7ZrS1y4xv2o/mx6iEwMTfzZsKenuMA6L/M
        78pstoBL3/PkYpHGfqqyaKYqbQ==
X-Google-Smtp-Source: AAOMgpcFFb2/BuxL/WIQFXYH/gHgzA8Gu3ObX2w96d61VPqsXoBp3yJBEfYWVlFEVkrQbTykUxNtWg==
X-Received: by 2002:a1c:af0c:: with SMTP id y12-v6mr10735126wme.87.1533550483122;
        Mon, 06 Aug 2018 03:14:43 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id s2-v6sm8095644wrw.52.2018.08.06.03.14.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Aug 2018 03:14:42 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/5] ASoC: qcom: make common.c as proper module
Date:   Mon,  6 Aug 2018 11:12:05 +0100
Message-Id: <20180806101209.15167-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
References: <20180806101209.15167-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts common helper functions in to proper module
and also fixes below warning.

WARNING: sound/soc/qcom/snd-soc-sdm845: 'qcom_snd_parse_of' exported twice.
Previous export was in sound/soc/qcom/snd-soc-apq8096.ko

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/Kconfig  | 5 +++++
 sound/soc/qcom/Makefile | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
index 5f03312ef007..2a4c912d1e48 100644
--- a/sound/soc/qcom/Kconfig
+++ b/sound/soc/qcom/Kconfig
@@ -41,6 +41,9 @@ config SND_SOC_APQ8016_SBC
           APQ8016 SOC-based systems.
           Say Y if you want to use audio devices on MI2S.
 
+config SND_SOC_QCOM_COMMON
+	tristate
+
 config SND_SOC_QDSP6_COMMON
 	tristate
 
@@ -86,6 +89,7 @@ config SND_SOC_MSM8996
 	tristate "SoC Machine driver for MSM8996 and APQ8096 boards"
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
 	help
           Support for Qualcomm Technologies LPASS audio block in
           APQ8096 SoC-based systems.
@@ -95,6 +99,7 @@ config SND_SOC_SDM845
 	tristate "SoC Machine driver for SDM845 boards"
 	depends on QCOM_APR
 	select SND_SOC_QDSP6
+	select SND_SOC_QCOM_COMMON
 	help
 	  To add support for audio on Qualcomm Technologies Inc.
 	  SDM845 SoC-based systems.
diff --git a/sound/soc/qcom/Makefile b/sound/soc/qcom/Makefile
index f0e94d48ba98..41b2c7a23a4d 100644
--- a/sound/soc/qcom/Makefile
+++ b/sound/soc/qcom/Makefile
@@ -13,13 +13,15 @@ obj-$(CONFIG_SND_SOC_LPASS_APQ8016) += snd-soc-lpass-apq8016.o
 # Machine
 snd-soc-storm-objs := storm.o
 snd-soc-apq8016-sbc-objs := apq8016_sbc.o
-snd-soc-apq8096-objs := apq8096.o common.o
-snd-soc-sdm845-objs := sdm845.o common.o
+snd-soc-apq8096-objs := apq8096.o
+snd-soc-sdm845-objs := sdm845.o
+snd-soc-qcom-common-objs := common.o
 
 obj-$(CONFIG_SND_SOC_STORM) += snd-soc-storm.o
 obj-$(CONFIG_SND_SOC_APQ8016_SBC) += snd-soc-apq8016-sbc.o
 obj-$(CONFIG_SND_SOC_MSM8996) += snd-soc-apq8096.o
 obj-$(CONFIG_SND_SOC_SDM845) += snd-soc-sdm845.o
+obj-$(CONFIG_SND_SOC_QCOM_COMMON) += snd-soc-qcom-common.o
 
 #DSP lib
 obj-$(CONFIG_SND_SOC_QDSP6) += qdsp6/
-- 
2.16.2

