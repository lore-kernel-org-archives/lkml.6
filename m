Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD3ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24D5D2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24D5D2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbeIREhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:37:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49862 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731108AbeIREhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:37:39 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 43F6EC49;
        Mon, 17 Sep 2018 23:08:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH 4.18 003/158] HID: multitouch: fix Elan panels with 2 input modes declaration
Date:   Tue, 18 Sep 2018 00:40:33 +0200
Message-Id: <20180917211710.648266752@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211710.383360696@linuxfoundation.org>
References: <20180917211710.383360696@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

commit ec6adef5fbc3f140c70e7499fdad818acb3a46c6 upstream.

When implementing commit 7f81c8db5489 ("HID: multitouch: simplify
the settings of the various features"), I wrongly removed a test
that made sure we never try to set the second InputMode feature
to something else than 0.

This broke badly some recent Elan panels that now forget to send the
click button in some area of the touchpad.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=200899
Fixes: 7f81c8db5489 ("HID: multitouch: simplify the settings of the various features")
Cc: stable@vger.kernel.org # v4.18+
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hid/hid-multitouch.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1167,7 +1167,8 @@ static bool mt_need_to_apply_feature(str
 				     struct hid_usage *usage,
 				     enum latency_mode latency,
 				     bool surface_switch,
-				     bool button_switch)
+				     bool button_switch,
+				     bool *inputmode_found)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 	struct mt_class *cls = &td->mtclass;
@@ -1179,6 +1180,14 @@ static bool mt_need_to_apply_feature(str
 
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
@@ -1194,6 +1203,7 @@ static bool mt_need_to_apply_feature(str
 		}
 
 		field->value[index] = td->inputmode_value;
+		*inputmode_found = true;
 		return true;
 
 	case HID_DG_CONTACTMAX:
@@ -1231,6 +1241,7 @@ static void mt_set_modes(struct hid_devi
 	struct hid_usage *usage;
 	int i, j;
 	bool update_report;
+	bool inputmode_found = false;
 
 	rep_enum = &hdev->report_enum[HID_FEATURE_REPORT];
 	list_for_each_entry(rep, &rep_enum->report_list, list) {
@@ -1249,7 +1260,8 @@ static void mt_set_modes(struct hid_devi
 							     usage,
 							     latency,
 							     surface_switch,
-							     button_switch))
+							     button_switch,
+							     &inputmode_found))
 					update_report = true;
 			}
 		}


