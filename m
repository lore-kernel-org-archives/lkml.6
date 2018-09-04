Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43CAC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862CC20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862CC20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeIDR4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 13:56:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54264 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727057AbeIDR4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 13:56:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEC9A804B9F2;
        Tue,  4 Sep 2018 13:31:36 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-116-25.ams2.redhat.com [10.36.116.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88B24A9EF9;
        Tue,  4 Sep 2018 13:31:35 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/4] HID: multitouch: fix Elan panels with 2 input modes declaration
Date:   Tue,  4 Sep 2018 15:31:12 +0200
Message-Id: <20180904133115.5111-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
References: <20180904133115.5111-1-benjamin.tissoires@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 04 Sep 2018 13:31:36 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 04 Sep 2018 13:31:36 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'benjamin.tissoires@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When implementing commit 7f81c8db5489 ("HID: multitouch: simplify
the settings of the various features"), I wrongly removed a test
that made sure we never try to set the second InputMode feature
to something else than 0.

This broke badly some recent Elan panels that now forget to send the
click button in some area of the touchpad.

Fixes 7f81c8db5489

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200899

Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 40fbb7c52723..88da991ef256 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1375,7 +1375,8 @@ static bool mt_need_to_apply_feature(struct hid_device *hdev,
 				     struct hid_usage *usage,
 				     enum latency_mode latency,
 				     bool surface_switch,
-				     bool button_switch)
+				     bool button_switch,
+				     bool *inputmode_found)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 	struct mt_class *cls = &td->mtclass;
@@ -1387,6 +1388,14 @@ static bool mt_need_to_apply_feature(struct hid_device *hdev,
 
 	switch (usage->hid) {
 	case HID_DG_INPUTMODE:
+		/*
+		 * Some elan panels wrongly declare 2 input mode features,
+		 * and silently ignore when we set the value in the second
+		 * field. Skip the second feature and hope for the best.
+		 */
+		if (*inputmode_found)
+			return false;
+
 		if (cls->quirks & MT_QUIRK_FORCE_GET_FEATURE) {
 			report_len = hid_report_len(report);
 			buf = hid_alloc_report_buf(report, GFP_KERNEL);
@@ -1402,6 +1411,7 @@ static bool mt_need_to_apply_feature(struct hid_device *hdev,
 		}
 
 		field->value[index] = td->inputmode_value;
+		*inputmode_found = true;
 		return true;
 
 	case HID_DG_CONTACTMAX:
@@ -1439,6 +1449,7 @@ static void mt_set_modes(struct hid_device *hdev, enum latency_mode latency,
 	struct hid_usage *usage;
 	int i, j;
 	bool update_report;
+	bool inputmode_found = false;
 
 	rep_enum = &hdev->report_enum[HID_FEATURE_REPORT];
 	list_for_each_entry(rep, &rep_enum->report_list, list) {
@@ -1457,7 +1468,8 @@ static void mt_set_modes(struct hid_device *hdev, enum latency_mode latency,
 							     usage,
 							     latency,
 							     surface_switch,
-							     button_switch))
+							     button_switch,
+							     &inputmode_found))
 					update_report = true;
 			}
 		}
-- 
2.14.3

