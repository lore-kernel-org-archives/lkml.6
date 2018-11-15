Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C48C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63056223CB
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 18:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UeW0A/Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63056223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbeKPEY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 23:24:28 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53433 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388454AbeKPEY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 23:24:27 -0500
Received: by mail-wm1-f49.google.com with SMTP id f10-v6so19686883wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 10:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LYRqNC3RC3C8D1z2RDljriVISNyoMdcAQwEZ0hOyVmY=;
        b=UeW0A/Hu7pYM3VodQ6SXBsirVZqx7FUK4P8KuwDC4JKYS3sSCXNHwgju59z99rJZCv
         6sqgrVsLwoBv7m+pLy/vBjdzLs9NF0SyaPGvck9kttMzVuvj7GptY113n585mtKiIiaw
         d8orl/3jP/+feMIrB9lS/JHuzH5uRe6S91Ye0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LYRqNC3RC3C8D1z2RDljriVISNyoMdcAQwEZ0hOyVmY=;
        b=ug/rblpIfz1Ewy0rYq/YJfLvBMAslyqhOwpG1vzwvV0DRJTr99c7QoMvijNm74u2cJ
         Ub4YEZO8cdG3LyVL/stsWYbUMYGyMSKVxPv1KKhIAH4tl2iFjVfgMy/hCgdXaGHzYAsG
         +2ICOENUGlH8Nj5XLpln8HpS+MqqRbuZ9hwacZM9nCBLLQRIJzoQof6auDAw+aZah3ul
         sgjVZRzn4cI8d/aTc0KqkOZQebwiZzkQYQ3ikk+RGBJeR+LLXYh+SZtKdOHTAbknjEPC
         YZuJGbaVzb6HmmUNWMIebEDOrcFOOskHyckavisOG94ep/MfdUNEVOBqvW55Y6k1T6w2
         E97Q==
X-Gm-Message-State: AGRZ1gK/0lAJkTeKOXmSbBQpM2tajaWMGasROD1vSXKfTnhFKNFGALSA
        /bYwdVYVYh+HJiHxdDFDMtxJxw==
X-Google-Smtp-Source: AJdET5dNZQSTLe+MI3Y1VD9bxx9xSY54XmCqitSZd1CYMQtra61b0f+WHB2x9RU7BnwWgqvCWWcnSw==
X-Received: by 2002:a1c:d1cd:: with SMTP id i196mr5969547wmg.107.1542305734050;
        Thu, 15 Nov 2018 10:15:34 -0800 (PST)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id r76-v6sm20934737wmb.21.2018.11.15.10.15.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Nov 2018 10:15:33 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        rohitkr@codeaurora.org, lgirdwood@gmail.com, tiwai@suse.com,
        devicetree@vger.kernel.org, srini@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 4/5] ASoC: qdsp6: q6asm: add support to MP3 format
Date:   Thu, 15 Nov 2018 18:13:23 +0000
Message-Id: <20181115181324.26784-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
References: <20181115181324.26784-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support to mp3 format in ASM module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index e1cfa846a1dc..4f85cb19a309 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -12,6 +12,7 @@
 #include <linux/kref.h>
 #include <linux/of.h>
 #include <uapi/sound/asound.h>
+#include <uapi/sound/compress_params.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -36,6 +37,7 @@
 #define ASM_PARAM_ID_ENCDEC_ENC_CFG_BLK_V2	0x00010DA3
 #define ASM_SESSION_CMD_RUN_V2			0x00010DAA
 #define ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2	0x00010DA5
+#define ASM_MEDIA_FMT_MP3			0x00010BE9
 #define ASM_DATA_CMD_WRITE_V2			0x00010DAB
 #define ASM_DATA_CMD_READ_V2			0x00010DAC
 #define ASM_SESSION_CMD_SUSPEND			0x00010DEC
@@ -868,6 +870,9 @@ int q6asm_open_write(struct audio_client *ac, uint32_t format,
 	open->postprocopo_id = ASM_NULL_POPP_TOPOLOGY;
 
 	switch (format) {
+	case SND_AUDIOCODEC_MP3:
+		open->dec_fmt_id = ASM_MEDIA_FMT_MP3;
+		break;
 	case FORMAT_LINEAR_PCM:
 		open->dec_fmt_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
 		break;
-- 
2.19.1

