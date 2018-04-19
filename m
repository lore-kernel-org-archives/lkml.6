Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753446AbeDSPq6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 11:46:58 -0400
Received: from dougal.metanate.com ([90.155.101.14]:42020 "EHLO metanate.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752634AbeDSPqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 11:46:55 -0400
From: John Keeping <john@metanate.com>
To: linux-bluetooth@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        John Keeping <john@metanate.com>
Subject: [PATCH] Bluetooth: use wait_event API instead of open-coding it
Date: Thu, 19 Apr 2018 16:29:37 +0100
Message-Id: <20180419152937.13515-1-john@metanate.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've seen timeout errors from HCI commands where it looks like
schedule_timeout() has returned immediately; additional logging for the
error case gives:

	req_status=1 req_result=0 remaining=10000 jiffies

so the device is still in state HCI_REQ_PEND and the value returned by
schedule_timeout() is the same as the original timeout (HCI_INIT_TIMEOUT
on a system with HZ=1000).

Use wait_event_interruptible_timeout() instead of open-coding similar
behaviour which is subject to the spurious failure described above.

Signed-off-by: John Keeping <john@metanate.com>
---
I saw problems with the -rt patchset on 4.9 and I'm not convinced that
it's Bluetooth at fault for the problem described above, but I think
this is a nice cleanup even if it's not a bug fix.

 net/bluetooth/hci_request.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 66c0781773df..e44d34734834 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -122,7 +122,6 @@ void hci_req_sync_cancel(struct hci_dev *hdev, int err)
 struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 				  const void *param, u8 event, u32 timeout)
 {
-	DECLARE_WAITQUEUE(wait, current);
 	struct hci_request req;
 	struct sk_buff *skb;
 	int err = 0;
@@ -135,21 +134,14 @@ struct sk_buff *__hci_cmd_sync_ev(struct hci_dev *hdev, u16 opcode, u32 plen,
 
 	hdev->req_status = HCI_REQ_PEND;
 
-	add_wait_queue(&hdev->req_wait_q, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-
 	err = hci_req_run_skb(&req, hci_req_sync_complete);
-	if (err < 0) {
-		remove_wait_queue(&hdev->req_wait_q, &wait);
-		set_current_state(TASK_RUNNING);
+	if (err < 0)
 		return ERR_PTR(err);
-	}
 
-	schedule_timeout(timeout);
+	err = wait_event_interruptible_timeout(hdev->req_wait_q,
+			hdev->req_status != HCI_REQ_PEND, timeout);
 
-	remove_wait_queue(&hdev->req_wait_q, &wait);
-
-	if (signal_pending(current))
+	if (err == -ERESTARTSYS)
 		return ERR_PTR(-EINTR);
 
 	switch (hdev->req_status) {
@@ -197,7 +189,6 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 		   unsigned long opt, u32 timeout, u8 *hci_status)
 {
 	struct hci_request req;
-	DECLARE_WAITQUEUE(wait, current);
 	int err = 0;
 
 	BT_DBG("%s start", hdev->name);
@@ -213,16 +204,10 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 		return err;
 	}
 
-	add_wait_queue(&hdev->req_wait_q, &wait);
-	set_current_state(TASK_INTERRUPTIBLE);
-
 	err = hci_req_run_skb(&req, hci_req_sync_complete);
 	if (err < 0) {
 		hdev->req_status = 0;
 
-		remove_wait_queue(&hdev->req_wait_q, &wait);
-		set_current_state(TASK_RUNNING);
-
 		/* ENODATA means the HCI request command queue is empty.
 		 * This can happen when a request with conditionals doesn't
 		 * trigger any commands to be sent. This is normal behavior
@@ -240,11 +225,10 @@ int __hci_req_sync(struct hci_dev *hdev, int (*func)(struct hci_request *req,
 		return err;
 	}
 
-	schedule_timeout(timeout);
-
-	remove_wait_queue(&hdev->req_wait_q, &wait);
+	err = wait_event_interruptible_timeout(hdev->req_wait_q,
+			hdev->req_status != HCI_REQ_PEND, timeout);
 
-	if (signal_pending(current))
+	if (err == -ERESTARTSYS)
 		return -EINTR;
 
 	switch (hdev->req_status) {
-- 
2.17.0
