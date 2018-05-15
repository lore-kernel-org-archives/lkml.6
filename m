Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752651AbeEOIxk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 04:53:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45654 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752568AbeEOIwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 04:52:41 -0400
X-UUID: 99f8ddac2d454d1a9ea995f190fa9985-20180515
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <marcel@holtmann.org>,
        <johan.hedberg@gmail.com>
CC: <devicetree@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v2 4/7] Bluetooth: Add new quirk for non-persistent setup settings
Date: Tue, 15 May 2018 16:52:19 +0800
Message-ID: <1d6097f538b3182b2876ad48225ecd6e2d1b128c.1526374087.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526374087.git.sean.wang@mediatek.com>
References: <cover.1526374087.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add a new quirk HCI_QUIRK_NON_PERSISTENT_SETUP allowing that a quirk that
runs setup() after every open() and not just after the first open().

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/net/bluetooth/hci.h | 9 +++++++++
 net/bluetooth/hci_core.c    | 3 ++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1668211..b37d973 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -183,6 +183,15 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_NON_PERSISTENT_DIAG,
+
+	/* When this quirk is set, setup() would be run after every
+	 * open() and not just after the first open().
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 *
+	 */
+	HCI_QUIRK_NON_PERSISTENT_SETUP,
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 40d260f..7de712e2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1377,7 +1377,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	atomic_set(&hdev->cmd_cnt, 1);
 	set_bit(HCI_INIT, &hdev->flags);
 
-	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
+	if (hci_dev_test_flag(hdev, HCI_SETUP) ||
+	    test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks)) {
 		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
 
 		if (hdev->setup)
-- 
2.7.4
