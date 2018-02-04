Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeBDVLO (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 16:11:14 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:38016 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbeBDVKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 16:10:13 -0500
X-Google-Smtp-Source: AH8x2273PIA4Cw/NISCwu2SxDz+AxW5/y9VUYpO5vbL2ZmR7BQpmhexRCQUNCFMcMDSNnPfogFpSTA==
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH v2 4/5] drivers: bluetooth: ath3k: Fix warning: quoted string split across lines
Date: Mon,  5 Feb 2018 00:09:46 +0300
Message-Id: <20180204210947.31002-5-mussitantesmortem@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180204210947.31002-1-mussitantesmortem@gmail.com>
References: <20180204205934.12117-4-mussitantesmortem@gmail.com>
 <20180204210947.31002-1-mussitantesmortem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoided the warning:
WARNING: quoted string split across lines
 #355: FILE: drivers/bluetooth/ath3k.c:355:
 +			BT_ERR("Error in firmware loading err = %d,"
 +				"len = %d, size = %d", err, len, size);

This patch fix this issue.

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/bluetooth/ath3k.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 4df5b953a40d..8fe5ec4bb342 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -203,6 +203,12 @@ static const struct usb_device_id ath3k_blist_tbl[] = {
 	{ }	/* Terminating entry */
 };
 
+static inline void ath3k_log_failed_loading(int err, int len, int size)
+{
+	BT_ERR("Error in firmware loading err = %d, len = %d, size = %d",
+			err, len, size);
+}
+
 #define USB_REQ_DFU_DNLOAD	1
 #define BULK_SIZE		4096
 #define FW_HDR_SIZE		20
@@ -251,8 +257,7 @@ static int ath3k_load_firmware(struct usb_device *udev,
 					&len, 3000);
 
 		if (err || (len != size)) {
-			BT_ERR("Error in firmware loading err = %d,"
-				"len = %d, size = %d", err, len, size);
+			ath3k_log_failed_loading(err, len, size);
 			goto error;
 		}
 
@@ -351,8 +356,7 @@ static int ath3k_load_fwfile(struct usb_device *udev,
 		err = usb_bulk_msg(udev, pipe, send_buf, size,
 					&len, 3000);
 		if (err || (len != size)) {
-			BT_ERR("Error in firmware loading err = %d,"
-				"len = %d, size = %d", err, len, size);
+			ath3k_log_failed_loading(err, len, size);
 			kfree(send_buf);
 			return err;
 		}
-- 
2.16.1
