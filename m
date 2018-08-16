Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3791FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF3821477
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOM9MV87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF3821477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbeHPFkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:40:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34344 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387802AbeHPFkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:40:21 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so1337634plo.1;
        Wed, 15 Aug 2018 19:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EKUZVPR7XnLZOsjr5K2KoU6Was7+ha87cagi1tAlF+w=;
        b=LOM9MV87hNrcw+foIY/qnW56+bTm5PRSiQxRbRM5Y4EG76KMCUGShWuQZUE9OPataA
         ayJad1dQ7PxUFhAmyqgk+yLpP0KPqqktpIQbHSMvyz2Ved/EJvdhYXyhjrM56kSRo0lh
         PH3g/Mlm6bkqKVpq/J9Etll6l4K9jZ2L5BaTKmjFqpGhUdI2CF+zLU/1EESdJPg2Cp5u
         uAYZBucoKf+uS7oMWx4QBM01XYSlb5scD7Y7x9GwzpIpFTBHpq8PLa/JQBvu350ebTpH
         THQ5CqWM+/JCaCQFhc32+2uinAyi9wrQOHgMZvVuHjD1Yxnj66BX5HpLY1SMx3CvKbIb
         KsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EKUZVPR7XnLZOsjr5K2KoU6Was7+ha87cagi1tAlF+w=;
        b=NuMtou86JmW5ZJa/1A3Uaz5UcDysDwxn9WmxRG/K8BXVComNBsOZXbQRB8pGpoz0P6
         CruFMx3EXYpIL/fXsC98kxrGKTZq3t6AjBKspSyEZJJhbSUxrm2rwCRFxDIctCi1u6f/
         ozuMrBbb/GwWvCQkvgBbGHNrYqa9Aw8dSUks5BRIa9t5WAgxDBJ289WQ+DOEhD1Wor/l
         ePgx1rUhvKcurvHB58QPTAmt81om3C1JaeqZI/PU5R0yMSQH6SAsOMm/XRfYWalqLblR
         OEFFbcbj7UYguYDv3bz/BwUKGzbbvbbRWXO34yK1vdYJq3+sTxlHfw3VkjCF9yOPf5CB
         OVyA==
X-Gm-Message-State: AOUpUlHH4Ma2U3GxM/zWzEX75asWF8Zx1lGH1cuo/XvTgEH0NzsRGyCh
        BEY+JOFyoUkQbk3jhH3FEwE=
X-Google-Smtp-Source: AA+uWPxsymLlyfoMaHA6nOrf1JLvaPWEdkYh4mHP3Ons9LYNbrspMa+DLHR5aHR+hjqEuU1Bnno16Q==
X-Received: by 2002:a17:902:b60b:: with SMTP id b11-v6mr26803370pls.301.1534387509944;
        Wed, 15 Aug 2018 19:45:09 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id t15-v6sm37823323pfa.158.2018.08.15.19.45.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 19:45:09 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Juha Kuikka <juha.kuikka@gmail.com>
Subject: [PATCH v2 2/2] hid: microsoft: Add rumble support for Xbox One S controller
Date:   Wed, 15 Aug 2018 19:44:10 -0700
Message-Id: <20180816024410.29218-3-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180816024410.29218-1-andrew.smirnov@gmail.com>
References: <20180816024410.29218-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HID quirk driver for Xbox One S controller over bluetooth.

This driver only adds support for rumble. Standard controller
functionality is exposed by default HID driver.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
Signed-off-by: Juha Kuikka <juha.kuikka@gmail.com>
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 drivers/hid/hid-ids.h       |   1 +
 drivers/hid/hid-microsoft.c | 117 ++++++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c7981ddd8776..c8b4bc7fe053 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -798,6 +798,7 @@
 #define USB_DEVICE_ID_MS_TOUCH_COVER_2   0x07a7
 #define USB_DEVICE_ID_MS_TYPE_COVER_2    0x07a9
 #define USB_DEVICE_ID_MS_POWER_COVER     0x07da
+#define USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER	0x02fd
 
 #define USB_VENDOR_ID_MOJO		0x8282
 #define USB_DEVICE_ID_RETRO_ADAPTER	0x3201
diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
index f8868d96c0c7..3bbef16d876a 100644
--- a/drivers/hid/hid-microsoft.c
+++ b/drivers/hid/hid-microsoft.c
@@ -28,11 +28,36 @@
 #define MS_RDESC		0x08
 #define MS_NOGET		0x10
 #define MS_DUPLICATE_USAGES	0x20
+#define MS_QUIRK_FF		0x40
 
 struct ms_data {
 	unsigned long quirks;
+	struct hid_device *hdev;
+	struct work_struct ff_worker;
+	__u8 strong;
+	__u8 weak;
+	void *output_report_dmabuf;
 };
 
+#define XB1S_FF_REPORT		3
+#define ENABLE_WEAK		BIT(0)
+#define ENABLE_STRONG		BIT(1)
+
+enum {
+	MAGNITUDE_STRONG = 2,
+	MAGNITUDE_WEAK,
+	MAGNITUDE_NUM
+};
+
+struct xb1s_ff_report {
+	__u8	report_id;
+	__u8	enable;
+	__u8	magnitude[MAGNITUDE_NUM];
+	__u8	duration_10ms;
+	__u8	start_delay_10ms;
+	__u8	loop_count;
+} __packed;
+
 static __u8 *ms_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -227,6 +252,84 @@ static int ms_event(struct hid_device *hdev, struct hid_field *field,
 	return 0;
 }
 
+static void ms_ff_worker(struct work_struct *work)
+{
+	struct ms_data *ms = container_of(work, struct ms_data, ff_worker);
+	struct hid_device *hdev = ms->hdev;
+	struct xb1s_ff_report *r = ms->output_report_dmabuf;
+	int ret;
+
+	memset(r, 0, sizeof(*r));
+
+	r->report_id = XB1S_FF_REPORT;
+	r->enable = ENABLE_WEAK | ENABLE_STRONG;
+	/*
+	 * Specifying maximum duration and maximum loop count should
+	 * cover maximum duration of a single effect, which is 65536
+	 * ms
+	 */
+	r->duration_10ms = U8_MAX;
+	r->loop_count = U8_MAX;
+	r->magnitude[MAGNITUDE_STRONG] = ms->strong; /* left actuator */
+	r->magnitude[MAGNITUDE_WEAK] = ms->weak;     /* right actuator */
+
+	ret = hid_hw_output_report(hdev, (__u8 *)r, sizeof(*r));
+	if (ret)
+		hid_warn(hdev, "failed to send FF report\n");
+}
+
+static int ms_play_effect(struct input_dev *dev, void *data,
+			  struct ff_effect *effect)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct ms_data *ms = hid_get_drvdata(hid);
+
+	if (effect->type != FF_RUMBLE)
+		return 0;
+
+	/*
+	 * Magnitude is 0..100 so scale the 16-bit input here
+	 */
+	ms->strong = ((u32) effect->u.rumble.strong_magnitude * 100) / U16_MAX;
+	ms->weak = ((u32) effect->u.rumble.weak_magnitude * 100) / U16_MAX;
+
+	schedule_work(&ms->ff_worker);
+	return 0;
+}
+
+static int ms_init_ff(struct hid_device *hdev)
+{
+	struct hid_input *hidinput = list_entry(hdev->inputs.next,
+						struct hid_input, list);
+	struct input_dev *input_dev = hidinput->input;
+	struct ms_data *ms = hid_get_drvdata(hdev);
+
+	if (!(ms->quirks & MS_QUIRK_FF))
+		return 0;
+
+	ms->hdev = hdev;
+	INIT_WORK(&ms->ff_worker, ms_ff_worker);
+
+	ms->output_report_dmabuf = devm_kzalloc(&hdev->dev,
+						sizeof(struct xb1s_ff_report),
+						GFP_KERNEL);
+	if (ms->output_report_dmabuf == NULL)
+		return -ENOMEM;
+
+	input_set_capability(input_dev, EV_FF, FF_RUMBLE);
+	return input_ff_create_memless(input_dev, NULL, ms_play_effect);
+}
+
+static void ms_remove_ff(struct hid_device *hdev)
+{
+	struct ms_data *ms = hid_get_drvdata(hdev);
+
+	if (!(ms->quirks & MS_QUIRK_FF))
+		return;
+
+	cancel_work_sync(&ms->ff_worker);
+}
+
 static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	unsigned long quirks = id->driver_data;
@@ -257,11 +360,21 @@ static int ms_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		goto err_free;
 	}
 
+	ret = ms_init_ff(hdev);
+	if (ret)
+		hid_err(hdev, "could not initialize ff, continuing anyway");
+
 	return 0;
 err_free:
 	return ret;
 }
 
+static void ms_remove(struct hid_device *hdev)
+{
+	hid_hw_stop(hdev);
+	ms_remove_ff(hdev);
+}
+
 static const struct hid_device_id ms_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_SIDEWINDER_GV),
 		.driver_data = MS_HIDINPUT },
@@ -296,6 +409,9 @@ static const struct hid_device_id ms_devices[] = {
 
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
 		.driver_data = MS_PRESENTER },
+
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_XBOX_ONE_S_CONTROLLER),
+		.driver_data = MS_QUIRK_FF },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ms_devices);
@@ -308,6 +424,7 @@ static struct hid_driver ms_driver = {
 	.input_mapped = ms_input_mapped,
 	.event = ms_event,
 	.probe = ms_probe,
+	.remove = ms_remove,
 };
 module_hid_driver(ms_driver);
 
-- 
2.17.1

