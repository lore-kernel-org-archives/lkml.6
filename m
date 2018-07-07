Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1488FC3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB3422460
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 02:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilDIqt92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB3422460
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933156AbeGGCmU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 22:42:20 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41268 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbeGGClm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 22:41:42 -0400
Received: by mail-pf0-f193.google.com with SMTP id c21-v6so5157766pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 19:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SI41sQ5454geOvFjxefsoRHhxqgvH1ZPJTEqjz2mQ0k=;
        b=ilDIqt92LyHjJtZ1M51Msv6yqHdiMGIHR+rEVkPaOvIbBnW5LdyioSoxBtDRZE9LAM
         OaXqlFrQAHWyK41he+6Zzy4sRzWO6HSAxyjxNAIRbeQBJPNSy9qo1qDqt/0JYzKTPadk
         6kZZyHANYj0rmMQHkFGeZe6+rQRjy683WGDRF0rPgJZBA82a4Joa77sw/NYJNQGEgjWp
         44illHbbeuoleOEH23d8+UlU5rHBoYHBSW1+IaNBQ1LstbsfwSghDH9/kCrRxmVEqGtw
         IBHD2O/6Smgv91QJyHupIarCCHUCOun+1/ly7e9WoCEeRd7nk0sOji2l8KiCOY1d1miE
         OdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SI41sQ5454geOvFjxefsoRHhxqgvH1ZPJTEqjz2mQ0k=;
        b=iox6NwITjWNhkH+SDDvACCjTKq9uUwjhXMBdsoFmPiFoGpH27kNf7ARGpjteTrzbhN
         V7JU+cDen5KmTBMkpATgdsAb97KAsGF5XAs2PLaHNl7eSvVQGegz31gbgyaSv+zUhjcv
         +Chz7wMvxMO4MN/+DxxA4c3xSxDOXWaT+bPl2WZCx5T2h00+DdTq1NsiOlJtNet2mTPa
         sSYmtlpQspeupvTR5dtm0M56MfHHeE9VAhXV1Jot7ISRIF+7zxrTkBqckwjtb4XJDS4c
         XfJhNdc37Bf3U6+qn/x3uKibKT3pX1b974RS4he8vZp65wC1WosY4c1pzqEEln7hvzJp
         X+Ww==
X-Gm-Message-State: APt69E1jRcbDdffkkb1RRu7Uzz5JLP2HLeLrD9WZj8wzFYvv4R6dC89F
        w1V2g4CctwxDH+A2prinRTs=
X-Google-Smtp-Source: AAOMgpdK04XRyz6PkRpuztbubxyEPZckHUMpTMsKDqJ5GX6isPuI5vft2+ihZ51KT5Vt6ZhW7obNPg==
X-Received: by 2002:a62:dc1d:: with SMTP id t29-v6mr12884530pfg.244.1530931301674;
        Fri, 06 Jul 2018 19:41:41 -0700 (PDT)
Received: from localhost.localdomain (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id i17-v6sm18897276pfj.95.2018.07.06.19.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 19:41:40 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 6/6] mfd: rave-sp: Emulate CMD_GET_STATUS on device that don't support it
Date:   Fri,  6 Jul 2018 19:41:08 -0700
Message-Id: <20180707024108.32373-7-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180707024108.32373-1-andrew.smirnov@gmail.com>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CMD_GET_STATUS is not supported by some devices implementing
RDU2-compatible ICD as well as "legacy" devices. To account for that
fact, add code that obtains the same information (app/bootloader FW
version) using several different commands.

Cc: linux-kernel@vger.kernel.org
Cc: cphealy@gmail.com
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/mfd/rave-sp.c | 96 ++++++++++++++++++++++++++++---------------
 1 file changed, 63 insertions(+), 33 deletions(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index eee62ba6874d..2a8369657e38 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -117,14 +117,44 @@ struct rave_sp_checksum {
 	void (*subroutine)(const u8 *, size_t, u8 *);
 };
 
+struct rave_sp_version {
+	u8     hardware;
+	__le16 major;
+	u8     minor;
+	u8     letter[2];
+} __packed;
+
+struct rave_sp_status {
+	struct rave_sp_version bootloader_version;
+	struct rave_sp_version firmware_version;
+	u16 rdu_eeprom_flag;
+	u16 dds_eeprom_flag;
+	u8  pic_flag;
+	u8  orientation;
+	u32 etc;
+	s16 temp[2];
+	u8  backlight_current[3];
+	u8  dip_switch;
+	u8  host_interrupt;
+	u16 voltage_28;
+	u8  i2c_device_status;
+	u8  power_status;
+	u8  general_status;
+	u8  deprecated1;
+	u8  power_led_status;
+	u8  deprecated2;
+	u8  periph_power_shutoff;
+} __packed;
+
 /**
  * struct rave_sp_variant_cmds - Variant specific command routines
  *
  * @translate:	Generic to variant specific command mapping routine
- *
+ * @get_status: Variant specific implementation of CMD_GET_STATUS
  */
 struct rave_sp_variant_cmds {
 	int (*translate)(enum rave_sp_command);
+	int (*get_status)(struct rave_sp *sp, struct rave_sp_status *);
 };
 
 /**
@@ -170,35 +200,6 @@ struct rave_sp {
 	const char *part_number_bootloader;
 };
 
-struct rave_sp_version {
-	u8     hardware;
-	__le16 major;
-	u8     minor;
-	u8     letter[2];
-} __packed;
-
-struct rave_sp_status {
-	struct rave_sp_version bootloader_version;
-	struct rave_sp_version firmware_version;
-	u16 rdu_eeprom_flag;
-	u16 dds_eeprom_flag;
-	u8  pic_flag;
-	u8  orientation;
-	u32 etc;
-	s16 temp[2];
-	u8  backlight_current[3];
-	u8  dip_switch;
-	u8  host_interrupt;
-	u16 voltage_28;
-	u8  i2c_device_status;
-	u8  power_status;
-	u8  general_status;
-	u8  deprecated1;
-	u8  power_led_status;
-	u8  deprecated2;
-	u8  periph_power_shutoff;
-} __packed;
-
 static bool rave_sp_id_is_event(u8 code)
 {
 	return (code & 0xF0) == RAVE_SP_EVNT_BASE;
@@ -660,18 +661,44 @@ static const char *devm_rave_sp_version(struct device *dev,
 			      version->letter[1]);
 }
 
-static int rave_sp_get_status(struct rave_sp *sp)
+static int rave_sp_rdu1_get_status(struct rave_sp *sp,
+				   struct rave_sp_status *status)
 {
-	struct device *dev = &sp->serdev->dev;
 	u8 cmd[] = {
 		[0] = RAVE_SP_CMD_STATUS,
 		[1] = 0
 	};
+
+	return rave_sp_exec(sp, cmd, sizeof(cmd), status, sizeof(*status));
+}
+
+static int rave_sp_emulated_get_status(struct rave_sp *sp,
+				       struct rave_sp_status *status)
+{
+	u8 cmd[] = {
+		[0] = RAVE_SP_CMD_GET_FIRMWARE_VERSION,
+		[1] = 0,
+	};
+	int ret;
+
+	ret = rave_sp_exec(sp, cmd, sizeof(cmd), &status->firmware_version,
+			   sizeof(status->firmware_version));
+	if (ret)
+		return ret;
+
+	cmd[0] = RAVE_SP_CMD_GET_BOOTLOADER_VERSION;
+	return rave_sp_exec(sp, cmd, sizeof(cmd), &status->bootloader_version,
+			    sizeof(status->bootloader_version));
+}
+
+static int rave_sp_get_status(struct rave_sp *sp)
+{
+	struct device *dev = &sp->serdev->dev;
 	struct rave_sp_status status;
 	const char *version;
 	int ret;
 
-	ret = rave_sp_exec(sp, cmd, sizeof(cmd), &status, sizeof(status));
+	ret = sp->variant->cmd.get_status(sp, &status);
 	if (ret)
 		return ret;
 
@@ -704,6 +731,7 @@ static const struct rave_sp_variant rave_sp_legacy = {
 	.checksum = &rave_sp_checksum_ccitt,
 	.cmd = {
 		.translate = rave_sp_default_cmd_translate,
+		.get_status = rave_sp_emulated_get_status,
 	},
 };
 
@@ -711,6 +739,7 @@ static const struct rave_sp_variant rave_sp_rdu1 = {
 	.checksum = &rave_sp_checksum_8b2c,
 	.cmd = {
 		.translate = rave_sp_rdu1_cmd_translate,
+		.get_status = rave_sp_rdu1_get_status,
 	},
 };
 
@@ -718,6 +747,7 @@ static const struct rave_sp_variant rave_sp_rdu2 = {
 	.checksum = &rave_sp_checksum_ccitt,
 	.cmd = {
 		.translate = rave_sp_rdu2_cmd_translate,
+		.get_status = rave_sp_emulated_get_status,
 	},
 };
 
-- 
2.17.1

