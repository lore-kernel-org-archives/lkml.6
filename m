Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48062C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105522082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 12:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0rKrgcz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 105522082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730485AbeK0XAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 18:00:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43767 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeK0XAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 18:00:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so8243590pfk.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 04:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tktT1SUa7RmLbPg6StnIGtD+g4ZsELo16pz2ELFtQF0=;
        b=I0rKrgcz5kwOgeB/yfikT0b/AFxAkfReZQRBE8Wp0ruHHc9O2eViWn6++ZTyLUjWT/
         9027ErJCrJY72Xm0T+6hyxbOm55ehAoe1rR3YfyPUk1PoovFXrS5ja49aO/RYShHT95i
         A9gi1CpYZvByn01UU0FCbiRi0gIsmNUNugqfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tktT1SUa7RmLbPg6StnIGtD+g4ZsELo16pz2ELFtQF0=;
        b=KEt0MOXRjGA3GS6Mjw2CdkObOeF8+8XdiObdzm8J9EYwa7rT+puSGZ6rR6BrrPjINC
         aBLEh7BGQ8I5kocWtVchE2yrUkXKfcFw3TbLV368LAiIbnPHiAPVvXhQZpt8I2hvQAmF
         voactZqvdcj+5O3jbuKYI4V8eXCrHZtVpyPfgUhzzl7d0w3UFQc1ZqI5RXUGtx+BDVd9
         2/vLGWFUf/Oy9Ba0fh0zFZbjRmSZTGt2bIuIRoJVdFOysA+o6vsSqtOqIOWEZuvLPfjI
         mLauQXV7Ulf6HI2L/FdNV7cmj2POCGOdUhGLewF4zoVoDb7JO8CWDm/pySKihi0ZOoPz
         jyGA==
X-Gm-Message-State: AGRZ1gKBVflCtkzyA+HsFuFmGVZGwzfw9VGYzmG/SrrTkDzshIv7XrLk
        gle+cQR3ZcAIIVKXXgs20U9rlGYfSX8=
X-Google-Smtp-Source: AJdET5fpl4p0vuGCUfnQ28sB3TLMI0pjujMx58duyHw22SzSIjIwS5MyNnXA90BXjGxdhvPsTsz9Hw==
X-Received: by 2002:a62:cd44:: with SMTP id o65mr32312341pfg.222.1543320143978;
        Tue, 27 Nov 2018 04:02:23 -0800 (PST)
Received: from cychiang-z840.tpe.corp.google.com ([2401:fa00:1:b:e688:dfd2:a1a7:2956])
        by smtp.gmail.com with ESMTPSA id m85sm8312778pfj.171.2018.11.27.04.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 04:02:22 -0800 (PST)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        Rohit kumar <rohitkr@codeaurora.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 1/3] mfd: cros_ec: Add commands to control codec
Date:   Tue, 27 Nov 2018 20:00:39 +0800
Message-Id: <20181127120041.90759-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EC host commands to control codec on EC.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 include/linux/mfd/cros_ec_commands.h | 94 ++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/include/linux/mfd/cros_ec_commands.h b/include/linux/mfd/cros_ec_commands.h
index 07fe4ea0361d3..a3ac792f4915b 100644
--- a/include/linux/mfd/cros_ec_commands.h
+++ b/include/linux/mfd/cros_ec_commands.h
@@ -4077,6 +4077,100 @@ struct __ec_align1 ec_response_i2c_passthru_protect {
 	uint8_t status;		/* Status flags (0: unlocked, 1: locked) */
 };
 
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
2.20.0.rc0.387.gc7a69e6b6c-goog

