Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754824AbeBGRQh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 12:16:37 -0500
Received: from zimbra.linuxprofi.at ([93.83.54.199]:45634 "EHLO
        zimbra.linuxprofi.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754743AbeBGRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 12:16:32 -0500
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph@boehmwalder.at>
Subject: [PATCH 2/3] hid: logitech-dj: fix checkpatch issues
Date: Wed,  7 Feb 2018 18:07:59 +0100
Message-Id: <20180207170800.15015-3-christoph@boehmwalder.at>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180207170800.15015-1-christoph@boehmwalder.at>
References: <20180207170800.15015-1-christoph@boehmwalder.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some code style issues, mostly related to making sure quoted strings
aren't split over multiple lines.

Other fixes:
* Drop != NULL from some null pointer checks
* Use sizeof(*ptr) instead of sizeof(ptr_type)
* Combine some if statements to reduce indentation

Signed-off-by: Christoph Böhmwalder <christoph@boehmwalder.at>
---
 drivers/hid/hid-logitech-dj.c | 71 ++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 530d10b5a404..59c54cb4bc64 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -347,13 +347,14 @@ static void logi_dj_recv_destroy_djhid_device(struct dj_receiver_dev *djrcv_dev,
 	djrcv_dev->paired_dj_devices[dj_report->device_index] = NULL;
 	spin_unlock_irqrestore(&djrcv_dev->lock, flags);
 
-	if (dj_dev != NULL) {
+	if (dj_dev) {
 		hid_destroy_device(dj_dev->hdev);
 		kfree(dj_dev);
-	} else {
-		dev_err(&djrcv_dev->hdev->dev, "%s: can't destroy a NULL device\n",
-			__func__);
+		return;
 	}
+
+	dev_err(&djrcv_dev->hdev->dev, "%s: can't destroy a NULL device\n",
+		__func__);
 }
 
 static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
@@ -411,7 +412,7 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 	snprintf(tmpstr, sizeof(tmpstr), ":%d", dj_report->device_index);
 	strlcat(dj_hiddev->phys, tmpstr, sizeof(dj_hiddev->phys));
 
-	dj_dev = kzalloc(sizeof(struct dj_device), GFP_KERNEL);
+	dj_dev = kzalloc(sizeof(*dj_dev), GFP_KERNEL);
 
 	if (!dj_dev) {
 		dev_err(&djrcv_hdev->dev, "%s: failed allocating dj_device\n",
@@ -419,8 +420,9 @@ static void logi_dj_recv_add_djhid_device(struct dj_receiver_dev *djrcv_dev,
 		goto dj_device_allocate_fail;
 	}
 
-	dj_dev->reports_supported = get_unaligned_le32(
-		dj_report->report_params + DEVICE_PAIRED_RF_REPORT_TYPE);
+	dj_dev->reports_supported =
+		get_unaligned_le32(dj_report->report_params
+				   + DEVICE_PAIRED_RF_REPORT_TYPE);
 	dj_dev->hdev = dj_hiddev;
 	dj_dev->dj_receiver_dev = djrcv_dev;
 	dj_dev->device_index = dj_report->device_index;
@@ -461,17 +463,17 @@ static void delayedwork_callback(struct work_struct *work)
 			  sizeof(struct dj_report));
 
 	if (count != sizeof(struct dj_report)) {
-		dev_err(&djrcv_dev->hdev->dev, "%s: workitem triggered without "
-			"notifications available\n", __func__);
+		dev_err(&djrcv_dev->hdev->dev,
+			"%s: workitem triggered without notifications available"
+			"\n", __func__);
 		spin_unlock_irqrestore(&djrcv_dev->lock, flags);
 		return;
 	}
 
-	if (!kfifo_is_empty(&djrcv_dev->notif_fifo)) {
-		if (schedule_work(&djrcv_dev->work) == 0) {
-			dbg_hid("%s: did not schedule the work item, was "
-				"already queued\n", __func__);
-		}
+	if (!kfifo_is_empty(&djrcv_dev->notif_fifo) &&
+	    schedule_work(&djrcv_dev->work) == 0) {
+		dbg_hid("%s: did not schedule the work item, was already queued"
+			"\n", __func__);
 	}
 
 	spin_unlock_irqrestore(&djrcv_dev->lock, flags);
@@ -504,8 +506,8 @@ static void delayedwork_callback(struct work_struct *work)
 				break;
 			}
 			dev_err(&djrcv_dev->hdev->dev,
-				"%s:logi_dj_recv_query_paired_devices"
-				" error:%d\n", __func__, retval);
+				"%s: logi_dj_recv_query_paired_devices error: "
+				"%d\n", __func__, retval);
 		}
 		dbg_hid("%s: unexpected report type\n", __func__);
 	}
@@ -519,8 +521,8 @@ static void logi_dj_recv_queue_notification(struct dj_receiver_dev *djrcv_dev,
 	kfifo_in(&djrcv_dev->notif_fifo, dj_report, sizeof(struct dj_report));
 
 	if (schedule_work(&djrcv_dev->work) == 0) {
-		dbg_hid("%s: did not schedule the work item, was already "
-			"queued\n", __func__);
+		dbg_hid("%s: did not schedule the work item, was already queued"
+			"\n", __func__);
 	}
 }
 
@@ -543,8 +545,7 @@ static void logi_dj_recv_forward_null_report(struct dj_receiver_dev *djrcv_dev,
 					     HID_INPUT_REPORT,
 					     reportbuffer,
 					     hid_reportid_size_map[i], 1)) {
-				dbg_hid("hid_input_report error sending null "
-					"report\n");
+				dbg_hid("hid_input_report error sending null report\n");
 			}
 		}
 	}
@@ -559,8 +560,8 @@ static void logi_dj_recv_forward_report(struct dj_receiver_dev *djrcv_dev,
 	dj_device = djrcv_dev->paired_dj_devices[dj_report->device_index];
 
 	if ((dj_report->report_type > ARRAY_SIZE(hid_reportid_size_map) - 1) ||
-	    (hid_reportid_size_map[dj_report->report_type] == 0)) {
-		dbg_hid("invalid report type:%x\n", dj_report->report_type);
+	    hid_reportid_size_map[dj_report->report_type] == 0) {
+		dbg_hid("invalid report type: %x\n", dj_report->report_type);
 		return;
 	}
 
@@ -613,7 +614,7 @@ static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
 	if (djrcv_dev->querying_devices)
 		return 0;
 
-	dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
+	dj_report = kzalloc(sizeof(*dj_report), GFP_KERNEL);
 	if (!dj_report)
 		return -ENOMEM;
 	dj_report->report_id = REPORT_ID_DJ_SHORT;
@@ -625,14 +626,14 @@ static int logi_dj_recv_query_paired_devices(struct dj_receiver_dev *djrcv_dev)
 }
 
 static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
-					  unsigned timeout)
+					  unsigned int timeout)
 {
 	struct hid_device *hdev = djrcv_dev->hdev;
 	struct dj_report *dj_report;
 	u8 *buf;
 	int retval;
 
-	dj_report = kzalloc(sizeof(struct dj_report), GFP_KERNEL);
+	dj_report = kzalloc(sizeof(*dj_report), GFP_KERNEL);
 	if (!dj_report)
 		return -ENOMEM;
 	dj_report->report_id = REPORT_ID_DJ_SHORT;
@@ -704,8 +705,8 @@ static int logi_dj_ll_raw_request(struct hid_device *hid,
 	u8 *out_buf;
 	int ret;
 
-	if ((buf[0] == REPORT_ID_HIDPP_SHORT) ||
-	    (buf[0] == REPORT_ID_HIDPP_LONG)) {
+	if (buf[0] == REPORT_ID_HIDPP_SHORT ||
+	    buf[0] == REPORT_ID_HIDPP_LONG) {
 		if (count < 2)
 			return -EINVAL;
 
@@ -857,8 +858,8 @@ static int logi_dj_dj_event(struct hid_device *hdev,
 	 * and return 1 so hid-core does not anything else with it.
 	 */
 
-	if ((dj_report->device_index < DJ_DEVICE_INDEX_MIN) ||
-	    (dj_report->device_index > DJ_DEVICE_INDEX_MAX)) {
+	if (dj_report->device_index < DJ_DEVICE_INDEX_MIN ||
+	    dj_report->device_index > DJ_DEVICE_INDEX_MAX) {
 		/*
 		 * Device index is wrong, bail out.
 		 * This driver can safely ignore the receiver notifications,
@@ -931,8 +932,8 @@ static int logi_dj_hidpp_event(struct hid_device *hdev,
 	 * via the receiver.
 	 */
 
-	if ((device_index < DJ_DEVICE_INDEX_MIN) ||
-	    (device_index > DJ_DEVICE_INDEX_MAX)) {
+	if (device_index < DJ_DEVICE_INDEX_MIN ||
+	    device_index > DJ_DEVICE_INDEX_MAX) {
 		/*
 		 * Device index is wrong, bail out.
 		 * This driver can safely ignore the receiver notifications,
@@ -1013,7 +1014,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 
 	/* Treat interface 2 */
 
-	djrcv_dev = kzalloc(sizeof(struct dj_receiver_dev), GFP_KERNEL);
+	djrcv_dev = kzalloc(sizeof(*djrcv_dev), GFP_KERNEL);
 	if (!djrcv_dev) {
 		dev_err(&hdev->dev,
 			"%s:failed allocating dj_receiver_dev\n", __func__);
@@ -1083,8 +1084,8 @@ static int logi_dj_probe(struct hid_device *hdev,
 
 	retval = logi_dj_recv_query_paired_devices(djrcv_dev);
 	if (retval < 0) {
-		dev_err(&hdev->dev, "%s:logi_dj_recv_query_paired_devices "
-			"error:%d\n", __func__, retval);
+		dev_err(&hdev->dev, "%s:logi_dj_recv_query_paired_devices error:"
+			"%d\n", __func__, retval);
 		goto logi_dj_recv_query_paired_devices_failed;
 	}
 
@@ -1144,7 +1145,7 @@ static void logi_dj_remove(struct hid_device *hdev)
 	 */
 	for (i = 0; i < (DJ_MAX_PAIRED_DEVICES + DJ_DEVICE_INDEX_MIN); i++) {
 		dj_dev = djrcv_dev->paired_dj_devices[i];
-		if (dj_dev != NULL) {
+		if (dj_dev) {
 			hid_destroy_device(dj_dev->hdev);
 			kfree(dj_dev);
 			djrcv_dev->paired_dj_devices[i] = NULL;
-- 
2.13.6
