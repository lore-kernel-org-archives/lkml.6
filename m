Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752622AbeBCP5e (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Feb 2018 10:57:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53503 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751963AbeBCP5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Feb 2018 10:57:25 -0500
From: Aaron Ma <aaron.ma@canonical.com>
To: aaron.ma@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HID: Fix hid_report_len usage
Date: Sat,  3 Feb 2018 23:57:15 +0800
Message-Id: <20180203155715.2970-1-aaron.ma@canonical.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180108024141.10590-2-aaron.ma@canonical.com>
References: <20180108024141.10590-2-aaron.ma@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the change of return type u32 of hid_report_len,
fix all the types of variables those get the return value of
hid_report_len to u32, and all other code already uses u32.

Cc: stable@vger.kernel.org
Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
---
 drivers/hid/hid-input.c      | 3 ++-
 drivers/hid/hid-multitouch.c | 5 +++--
 drivers/hid/hid-rmi.c        | 4 ++--
 drivers/hid/wacom_sys.c      | 4 ++--
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 04d01b57d94c..d86398755b0d 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1368,7 +1368,8 @@ static void hidinput_led_worker(struct work_struct *work)
 					      led_work);
 	struct hid_field *field;
 	struct hid_report *report;
-	int len, ret;
+	int ret;
+	u32 len;
 	__u8 *buf;
 
 	field = hidinput_get_led_field(hid);
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 3b4739bde05d..2e1736ba2444 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -370,7 +370,8 @@ static const struct attribute_group mt_attribute_group = {
 static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
-	int ret, size = hid_report_len(report);
+	int ret;
+	u32 size = hid_report_len(report);
 	u8 *buf;
 
 	/*
@@ -1183,7 +1184,7 @@ static void mt_set_input_mode(struct hid_device *hdev)
 	struct hid_report_enum *re;
 	struct mt_class *cls = &td->mtclass;
 	char *buf;
-	int report_len;
+	u32 report_len;
 
 	if (td->inputmode < 0)
 		return;
diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index c6c05df3e8d2..9c9362149641 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -89,8 +89,8 @@ struct rmi_data {
 	u8 *writeReport;
 	u8 *readReport;
 
-	int input_report_size;
-	int output_report_size;
+	u32 input_report_size;
+	u32 output_report_size;
 
 	unsigned long flags;
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 409543160af7..b54ef1ffcbec 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -219,7 +219,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	u8 *data;
 	int ret;
-	int n;
+	u32 n;
 
 	switch (equivalent_usage) {
 	case HID_DG_CONTACTMAX:
@@ -519,7 +519,7 @@ static int wacom_set_device_mode(struct hid_device *hdev,
 	u8 *rep_data;
 	struct hid_report *r;
 	struct hid_report_enum *re;
-	int length;
+	u32 length;
 	int error = -ENOMEM, limit = 0;
 
 	if (wacom_wac->mode_report < 0)
-- 
2.14.3
