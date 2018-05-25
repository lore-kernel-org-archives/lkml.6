Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935994AbeEYMvO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 08:51:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59450 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933260AbeEYMvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 08:51:12 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>
Cc: Oscar Morante <spacepluk@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: rmi: use HID_QUIRK_NO_INPUT_SYNC
Date: Fri, 25 May 2018 14:51:06 +0200
Message-Id: <20180525125106.18008-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we receive a RMI4 report, we should not unconditionally send an
input_sync event. Instead, we should let the rmi4 transport layer do it
for us.

This fixes a situation where we might receive X in a report and the rest
in a subsequent one. And this messes up user space.

Link: https://bugs.freedesktop.org/show_bug.cgi?id=100436

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Hi,

Oscar, do you mind if we add your "Tested-by: Oscar Morante <your@email>"?

Andrew, can you check for any sides effects please?

Cheers,
Benjamin

 drivers/hid/hid-rmi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 9c9362149641..9e33165250a3 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -413,6 +413,24 @@ static int rmi_event(struct hid_device *hdev, struct hid_field *field,
 	return 0;
 }
 
+static void rmi_report(struct hid_device *hid, struct hid_report *report)
+{
+	struct hid_field *field = report->field[0];
+
+	if (!(hid->claimed & HID_CLAIMED_INPUT))
+		return;
+
+	switch (report->id) {
+	case RMI_READ_DATA_REPORT_ID:
+		/* fall-through */
+	case RMI_ATTN_REPORT_ID:
+		return;
+	}
+
+	if (field && field->hidinput && field->hidinput->input)
+		input_sync(field->hidinput->input);
+}
+
 #ifdef CONFIG_PM
 static int rmi_suspend(struct hid_device *hdev, pm_message_t message)
 {
@@ -637,6 +655,7 @@ static int rmi_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	hid_set_drvdata(hdev, data);
 
 	hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
+	hdev->quirks |= HID_QUIRK_NO_INPUT_SYNC;
 
 	ret = hid_parse(hdev);
 	if (ret) {
@@ -744,6 +763,7 @@ static struct hid_driver rmi_driver = {
 	.remove			= rmi_remove,
 	.event			= rmi_event,
 	.raw_event		= rmi_raw_event,
+	.report			= rmi_report,
 	.input_mapping		= rmi_input_mapping,
 	.input_configured	= rmi_input_configured,
 #ifdef CONFIG_PM
-- 
2.14.3
