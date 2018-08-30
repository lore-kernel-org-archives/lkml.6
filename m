Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEE6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25EB20835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c/TM2kd0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F25EB20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeHaCAq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:00:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34617 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbeHaCAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:00:45 -0400
Received: by mail-pg1-f195.google.com with SMTP id d19-v6so4490451pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 14:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QcFL356MAhLkKLgvLnv14Bj/GWDN0Ja5s+Ff/8fRGs0=;
        b=c/TM2kd09Qd2nmUC/nZ+uotwMWVKab1wh7r2/tBJSLUPxyY4fRvkXE5ZOCLR2/HuGI
         pbEMjhOySYnYwFY91c+uGCZ4+Q+jPcHttZ+aK/9ynmkL92L0qYaJGvpUhAJi0rOdQ4Si
         dWVwaqcfDH9Y9Jae9LTQUlKsE8DOrqzXEbpGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QcFL356MAhLkKLgvLnv14Bj/GWDN0Ja5s+Ff/8fRGs0=;
        b=iQ/89sT0H1hNJ/ikMN9E7FMLVdHXkUeOV+HmxjbPz52p35YMnzZzOk/qB63bn7g46U
         a1jrk64GBG/8ZtsvYiemdJJ2slHLkanHIw3TgMt3xNQedbIevJsZCDtL56nGx4dLYZk5
         SFTtKvCQrfZ6qeZ5LlUDgy4am3PV30pY44V4pvjeZLJVkYOf1YZrzD/lD06dEhBI3j5T
         vETvkaDbm5NOqSD0pDcpHnL/hEtShEukmHwJQVFU6TVbrvjpJrT+5A20O8f4u0406Y42
         64fGADvq1b2Mvk+u5d7I7GLufUZj7awxVZcp66Mn8/6oz0hdbyI9hT3+fyo3+omHTFEs
         9g4A==
X-Gm-Message-State: APzg51CjFHx11wy4HngrjLi0iONcWeEEaPbkwN/aXlmasEpJA9yCSKOr
        J3kKwWk37qdqwThily58PwpWpw==
X-Google-Smtp-Source: ANB0VdYr2ABZM9jTf/bsUPFpY/IvZnkUmrVnpJO8BC0JtuOf6RzZaHwPZjGfLw2FsZZN0AybaeU35g==
X-Received: by 2002:a63:5c10:: with SMTP id q16-v6mr11342336pgb.452.1535666189427;
        Thu, 30 Aug 2018 14:56:29 -0700 (PDT)
Received: from kolhar.mtv.corp.google.com ([2620:15c:202:201:356a:9de2:526a:5bc])
        by smtp.gmail.com with ESMTPSA id h132-v6sm13516828pfc.100.2018.08.30.14.56.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 14:56:29 -0700 (PDT)
From:   Harry Cutts <hcutts@chromium.org>
To:     linux-input <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jiri Kosina <jiri.kosina@suse.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Harry Cutts <hcutts@chromium.org>,
        Jiri Kosina <jikos@kernel.org>
Subject: [PATCH v2 2/5] Create a utility class for counting scroll events
Date:   Thu, 30 Aug 2018 14:56:19 -0700
Message-Id: <20180830215622.47550-3-hcutts@chromium.org>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <20180830215622.47550-1-hcutts@chromium.org>
References: <20180830215622.47550-1-hcutts@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid code duplication, this class counts high-resolution scroll
movements and emits the legacy low-resolution events when appropriate.
Drivers should be able to create one instance for each scroll wheel that
they need to handle.

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

Changes in v2: None

 drivers/hid/hid-input.c | 45 +++++++++++++++++++++++++++++++++++++++++
 include/linux/hid.h     | 28 +++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 4e94ea3e280a..6e84e7b9afcb 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1826,3 +1826,48 @@ void hidinput_disconnect(struct hid_device *hid)
 }
 EXPORT_SYMBOL_GPL(hidinput_disconnect);
 
+/**
+ * hid_scroll_counter_handle_scroll() - Send high- and low-resolution scroll
+ *                                      events given a high-resolution wheel
+ *                                      movement.
+ * @counter: a hid_scroll_counter struct describing the wheel.
+ * @hi_res_value: the movement of the wheel, in the mouse's high-resolution
+ *                units.
+ *
+ * Given a high-resolution movement, this function converts the movement into
+ * microns and emits high-resolution scroll events for the input device. It also
+ * uses the multiplier from &struct hid_scroll_counter to emit low-resolution
+ * scroll events when appropriate for backwards-compatibility with userspace
+ * input libraries.
+ */
+void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
+				      int hi_res_value)
+{
+	int low_res_scroll_amount;
+	/* Some wheels will rest 7/8ths of a notch from the previous notch
+	 * after slow movement, so we want the threshold for low-res events to
+	 * be in the middle of the notches (e.g. after 4/8ths) as opposed to on
+	 * the notches themselves (8/8ths).
+	 */
+	int threshold = counter->resolution_multiplier / 2;
+
+	input_report_rel(counter->dev, REL_WHEEL_HI_RES,
+			 hi_res_value * counter->microns_per_hi_res_unit);
+
+	counter->remainder += hi_res_value;
+	if (abs(counter->remainder) >= threshold) {
+		/* Add (or subtract) 1 because we want to trigger when the wheel
+		 * is half-way to the next notch (i.e. scroll 1 notch after a
+		 * 1/2 notch movement, 2 notches after a 1 1/2 notch movement,
+		 * etc.).
+		 */
+		low_res_scroll_amount =
+			counter->remainder / counter->resolution_multiplier
+			+ (hi_res_value > 0 ? 1 : -1);
+		input_report_rel(counter->dev, REL_WHEEL,
+				 low_res_scroll_amount);
+		counter->remainder -=
+			low_res_scroll_amount * counter->resolution_multiplier;
+	}
+}
+EXPORT_SYMBOL_GPL(hid_scroll_counter_handle_scroll);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 834e6461a690..037e37b0b0e6 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1138,6 +1138,34 @@ static inline u32 hid_report_len(struct hid_report *report)
 int hid_report_raw_event(struct hid_device *hid, int type, u8 *data, u32 size,
 		int interrupt);
 
+
+/**
+ * struct hid_scroll_counter - Utility class for processing high-resolution
+ *                             scroll events.
+ * @dev: the input device for which events should be reported.
+ * @microns_per_hi_res_unit: the amount moved by the user's finger for each
+ *                           high-resolution unit reported by the mouse, in
+ *                           microns.
+ * @resolution_multiplier: the wheel's resolution in high-resolution mode as a
+ *                         multiple of its lower resolution. For example, if
+ *                         moving the wheel by one "notch" would result in a
+ *                         value of 1 in low-resolution mode but 8 in
+ *                         high-resolution, the multiplier is 8.
+ * @remainder: counts the number of high-resolution units moved since the last
+ *             low-resolution event (REL_WHEEL or REL_HWHEEL) was sent. Should
+ *             only be used by class methods.
+ */
+struct hid_scroll_counter {
+	struct input_dev *dev;
+	int microns_per_hi_res_unit;
+	int resolution_multiplier;
+
+	int remainder;
+};
+
+void hid_scroll_counter_handle_scroll(struct hid_scroll_counter *counter,
+				      int hi_res_value);
+
 /* HID quirks API */
 unsigned long hid_lookup_quirk(const struct hid_device *hdev);
 int hid_quirks_init(char **quirks_param, __u16 bus, int count);
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

