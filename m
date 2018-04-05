Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeDEXJ6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:09:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37904 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbeDEXJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:09:56 -0400
X-Google-Smtp-Source: AIpwx49nN92/sfVimD6/UcEVrqMXJBKgswrbOPSTw/PU2TlEY1NPEXID8g0S1gK4H61Imzu6DmCAJg==
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Subject: [PATCH] hidraw: Fix crash on HIDIOCGFEATURE with a destroyed device
Date: Fri,  6 Apr 2018 01:09:36 +0200
Message-Id: <20180405230936.4572-1-rodrigorivascosta@gmail.com>
X-Mailer: git-send-email 2.16.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Doing `ioctl(HIDIOCGFEATURE)` in a tight loop on a hidraw device
and then disconnecting the device, or unloading the driver, can
cause a NULL pointer dereference.

When a hidraw device is destroyed it sets 0 to `dev->exist`.
Most functions check 'dev->exist' before doing its work, but
`hidraw_get_report()` was missing that check.

Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
---
 drivers/hid/hidraw.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hidraw.c b/drivers/hid/hidraw.c
index 5fbe0f81ab2e..01b5a9f01814 100644
--- a/drivers/hid/hidraw.c
+++ b/drivers/hid/hidraw.c
@@ -192,6 +192,11 @@ static ssize_t hidraw_get_report(struct file *file, char __user *buffer, size_t
 	int ret = 0, len;
 	unsigned char report_number;
 
+	if (!hidraw_table[minor] || !hidraw_table[minor]->exist) {
+		ret = -ENODEV;
+		goto out;
+	}
+
 	dev = hidraw_table[minor]->hid;
 
 	if (!dev->ll_driver->raw_request) {
-- 
2.16.3
