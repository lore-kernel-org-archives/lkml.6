Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0761EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED63214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 04:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z+BCezBR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BED63214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbeLFEFs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 23:05:48 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43437 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbeLFEFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 23:05:48 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so11096241pfk.10
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 20:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3GLH5cRUIzvQJsMHdOA7EGzkO1h7tTXaTf44gFcUy8=;
        b=Z+BCezBRlFDr9K4ZzgDYbM1CpxiNf4JuYrYryLhChB4eWAxthfI34YFGIw9IzeLXQD
         hVljXhCEKHoyh+4YVCokn8YwSv1nPyCNYqqeeSbTD7XSe4+lTe4NFgJjFUY9DPoD7kT8
         szDmSeYMLgmFKSkv3hv9uBA3aV/mrOoIGsYic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/3GLH5cRUIzvQJsMHdOA7EGzkO1h7tTXaTf44gFcUy8=;
        b=F390hz3xAWHIuoyox3RX5oo38C2uf88S0h/oQ5jmKiH5N7U4R4VT6vBq6xMuyp8YY0
         x57L8GHydDzQQzmDOWhP47sZ2ftyWZLwYntNEwP0Ij+FTfjlG+Nr3zA7JUmNZ5iGtmOn
         mvkbkfPpHdnjJm9mTqyAwn+JCBuPfvqYMjNsz3zW8EIyihqRzk7DoXVWyayBkqd00XxB
         qWOwFAhJwegWqaqskGL0zWLS3T3HIQ8Gq52b/Y9iR/lnqd68KuN/58Q4VFOhrZFJ34yR
         ONWAWHWLaHycI2XjhBsHxnfRLKVbrPQ/31KxKA6rRkKECE0MCEzmL82ow74e9x51z2RL
         eMdQ==
X-Gm-Message-State: AA+aEWZ8LhJFB+9Q6Y+tMCpaJnwDpKsbOwHdHOeDzu0uWzapGwWb3Y3n
        SIIYLY3SGhy9yyXUKh+xWNcznv/xXzU=
X-Google-Smtp-Source: AFSGD/WIOEGfBMetXzKlHl9y2W/30Jarc8AAn/K6xPXwUZuYHF3Gy+ohYLFVrLw5rMQYRtJAzVkDpA==
X-Received: by 2002:a63:20e:: with SMTP id 14mr22726368pgc.161.1544069146607;
        Wed, 05 Dec 2018 20:05:46 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id u29sm31332217pgn.23.2018.12.05.20.05.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 20:05:45 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, dgreid@chromium.org,
        tzungbi@chromium.org, Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v2] mfd: cros_ec: Add commands to control codec
Date:   Thu,  6 Dec 2018 12:05:40 +0800
Message-Id: <20181206040540.84632-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EC host commands to control codec on EC.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 V2 fixed the wrong ancestor issue so the patch can be applied cleanly on mfd tree.
 Codec driver that uses these commands will be sent separately.
 Thanks!

 include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 9a9631f0559e2..fc91082d4c357 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -2790,6 +2790,100 @@ struct ec_response_battery_vendor_param {
 	uint32_t value;
 } __packed;
 
+/*****************************************************************************/
+/* Commands for I2S recording on audio codec. */
+
+#define EC_CMD_CODEC_I2S 0x00BC
+
+enum ec_codec_i2s_subcmd {
+	EC_CODEC_SET_SAMPLE_DEPTH = 0x0,
+	EC_CODEC_SET_GAIN = 0x1,
+	EC_CODEC_GET_GAIN = 0x2,
+	EC_CODEC_I2S_ENABLE = 0x3,
+	EC_CODEC_I2S_SET_CONFIG = 0x4,
+	EC_CODEC_I2S_SET_TDM_CONFIG = 0x5,
+	EC_CODEC_I2S_SET_BCLK = 0x6,
+};
+
+enum ec_sample_depth_value {
+	EC_CODEC_SAMPLE_DEPTH_16 = 0,
+	EC_CODEC_SAMPLE_DEPTH_24 = 1,
+};
+
+enum ec_i2s_config {
+	EC_DAI_FMT_I2S = 0,
+	EC_DAI_FMT_RIGHT_J = 1,
+	EC_DAI_FMT_LEFT_J = 2,
+	EC_DAI_FMT_PCM_A = 3,
+	EC_DAI_FMT_PCM_B = 4,
+	EC_DAI_FMT_PCM_TDM = 5,
+};
+
+struct ec_param_codec_i2s {
+	/*
+	 * enum ec_codec_i2s_subcmd
+	 */
+	uint8_t cmd;
+	union {
+		/*
+		 * EC_CODEC_SET_SAMPLE_DEPTH
+		 * Value should be one of ec_sample_depth_value.
+		 */
+		uint8_t depth;
+
+		/*
+		 * EC_CODEC_SET_GAIN
+		 * Value should be 0~43 for both channels.
+		 */
+		struct ec_param_codec_i2s_set_gain {
+			uint8_t left;
+			uint8_t right;
+		} __packed gain;
+
+		/*
+		 * EC_CODEC_I2S_ENABLE
+		 * 1 to enable, 0 to disable.
+		 */
+		uint8_t i2s_enable;
+
+		/*
+		 * EC_CODEC_I2S_SET_COFNIG
+		 * Value should be one of ec_i2s_config.
+		 */
+		uint8_t i2s_config;
+
+		/*
+		 * EC_CODEC_I2S_SET_TDM_CONFIG
+		 * Value should be one of ec_i2s_config.
+		 */
+		struct ec_param_codec_i2s_tdm {
+			/*
+			 * 0 to 496
+			 */
+			int16_t ch0_delay;
+			/*
+			 * -1 to 496
+			 */
+			int16_t ch1_delay;
+			uint8_t adjacent_to_ch0;
+			uint8_t adjacent_to_ch1;
+		} __packed tdm_param;
+
+		/*
+		 * EC_CODEC_I2S_SET_BCLK
+		 */
+		uint32_t bclk;
+	};
+} __packed;
+
+/*
+ * For subcommand EC_CODEC_GET_GAIN.
+ */
+struct ec_response_codec_gain {
+	uint8_t left;
+	uint8_t right;
+} __packed;
+
 /*****************************************************************************/
 /* System commands */
 
-- 
2.20.0.rc1.387.gf8505762e3-goog

