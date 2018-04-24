Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932855AbeDXIE6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 04:04:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756323AbeDXIEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 04:04:44 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Hutterer <peter.hutterer@who-t.net>, Mario.Limonciello@dell.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 1/6] HID: store the full list of reports in the hidinput
Date: Tue, 24 Apr 2018 10:04:32 +0200
Message-Id: <20180424080437.21367-2-benjamin.tissoires@redhat.com>
In-Reply-To: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
References: <20180424080437.21367-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We were only storing the report in case of QUIRK_MULTI_INPUT.
It is interesting for the upcoming  HID_QUIRK_INPUT_PER_APP to also
store the full list of reports that are attached to it.

We need the full list because a device (Advanced Silicon has some)
might want to use a different report ID for the Input reports and
the Output reports. Storing the full list allows the drivers to
have all the data.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-input.c | 6 ++++++
 include/linux/hid.h     | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index a8a33e56b43e..62e42664955e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -1536,9 +1536,12 @@ static struct hid_input *hidinput_allocate(struct hid_device *hid)
 	input_dev->id.product = hid->product;
 	input_dev->id.version = hid->version;
 	input_dev->dev.parent = &hid->dev;
+
 	hidinput->input = input_dev;
 	list_add_tail(&hidinput->list, &hid->inputs);
 
+	INIT_LIST_HEAD(&hidinput->reports);
+
 	return hidinput;
 }
 
@@ -1688,6 +1691,9 @@ int hidinput_connect(struct hid_device *hid, unsigned int force)
 
 			if (hid->quirks & HID_QUIRK_MULTI_INPUT)
 				hidinput->report = report;
+
+			list_add_tail(&report->hidinput_list,
+				      &hidinput->reports);
 		}
 	}
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 0a8d5c320b6c..e1ec7f91f926 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -464,6 +464,7 @@ struct hid_field {
 
 struct hid_report {
 	struct list_head list;
+	struct list_head hidinput_list;
 	unsigned id;					/* id of this report */
 	unsigned type;					/* report type */
 	struct hid_field *field[HID_MAX_FIELDS];	/* fields of the report */
@@ -510,6 +511,7 @@ struct hid_input {
 	struct hid_report *report;
 	struct input_dev *input;
 	bool registered;
+	struct list_head reports;	/* the list of reports */
 };
 
 enum hid_type {
-- 
2.14.3
