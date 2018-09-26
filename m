Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A146C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D42D4214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 10:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e43z3rL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42D4214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeIZQiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 12:38:20 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50670 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeIZQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 12:38:18 -0400
Received: by mail-wm1-f51.google.com with SMTP id s12-v6so1694585wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 03:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mFjadR6BsgPuHP9WgDqWOULIM9tP8Tkl7i3Z5EXFShQ=;
        b=e43z3rL+N5vhsGt0DCWQU4wbwdPS3YiL15rftgl0WqdWQ6JhQ5M2yXnkEQjVWJAo6k
         Bqbl6LZFST3bp6Fpyqilvo3qgkEq750tnHG+YlRhOWhQ9j38U3bgkiAPA6vdfNYjGuSy
         m5eDVL2999XW8PtmVJ4N4VTOsQ2HoHRwOqUaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mFjadR6BsgPuHP9WgDqWOULIM9tP8Tkl7i3Z5EXFShQ=;
        b=OiOiLSzEl23MkEsNxmmZkje3FByaEOkLNsuRvAaRD8q8upz5z4zVyUdqj88C+HemcS
         yVkYoU5ZSpcKo5K8vG5TXtHyB++J6S7Q9oaGhhMiNIUDwfGs10x9zGDEspgVbw4GBr0R
         5VNyPpIt95AmhCReExgO0XgiyWualfJfyb9rr5TMGeDX57farWKV72Tc9McvgyARXTrX
         nwCwfeyYwRi4r7BL+4wU38L00LWDfK1pJosvnt2e4UbRt/OuXHku7EWkZ19NQyO9S0xh
         qnUoupxVZYYv4CHbWn1zWBoc2IRGjhOOKaVxuziik5HsGaxXHNRJDZMM2ihzH9dycvNx
         h7kw==
X-Gm-Message-State: ABuFfoi0Qo81vpMt2O0H7O0pDOPId2yc/vNrypd0EyJhE1esO3jIcAvE
        iHSbVbY8dQJuej2iRjJPSbSmiTQOOw4=
X-Google-Smtp-Source: ACcGV63ArG+Mf2q89oxQlfmjOt6EIq2yymYcHWwtTCwjGUJnJLfVflXnx41wm7hJOuCXzIbSJdCJlw==
X-Received: by 2002:a1c:89cd:: with SMTP id l196-v6mr3757018wmd.7.1537957560789;
        Wed, 26 Sep 2018 03:26:00 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id b12sm4442648wrx.11.2018.09.26.03.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Sep 2018 03:26:00 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, vkoul@kernel.org,
        bgoswami@codeaurora.org, rohitkr@codeaurora.org,
        lgirdwood@gmail.com, tiwai@suse.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 4/5] ASoC: qdsp6: q6asm: add support to MP3 format
Date:   Wed, 26 Sep 2018 11:23:48 +0100
Message-Id: <20180926102349.23481-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
References: <20180926102349.23481-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6asm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
index 2b2c7233bb5f..e98aee1baadd 100644
--- a/sound/soc/qcom/qdsp6/q6asm.c
+++ b/sound/soc/qcom/qdsp6/q6asm.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <uapi/sound/asound.h>
+#include <uapi/sound/compress_params.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/mm.h>
@@ -37,6 +38,7 @@
 #define ASM_PARAM_ID_ENCDEC_ENC_CFG_BLK_V2	0x00010DA3
 #define ASM_SESSION_CMD_RUN_V2			0x00010DAA
 #define ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2	0x00010DA5
+#define ASM_MEDIA_FMT_MP3			0x00010BE9
 #define ASM_DATA_CMD_WRITE_V2			0x00010DAB
 #define ASM_DATA_CMD_READ_V2			0x00010DAC
 #define ASM_SESSION_CMD_SUSPEND			0x00010DEC
@@ -869,6 +871,9 @@ int q6asm_open_write(struct audio_client *ac, uint32_t format,
 	open->postprocopo_id = ASM_NULL_POPP_TOPOLOGY;
 
 	switch (format) {
+	case SND_AUDIOCODEC_MP3:
+		open->dec_fmt_id = ASM_MEDIA_FMT_MP3;
+		break;
 	case FORMAT_LINEAR_PCM:
 		open->dec_fmt_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
 		break;
-- 
2.19.0

