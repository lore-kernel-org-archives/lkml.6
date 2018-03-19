Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971709AbeCSUyV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:54:21 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:28191 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971679AbeCSUyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:54:13 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Mar 2018 21:54:12 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: masaki.ota@jp.alps.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 2/4] HID: alps: Save a memory allocation in 't4_read_write_register()' when writing data
Date: Mon, 19 Mar 2018 21:53:27 +0100
Message-Id: <8b54f1506a54fdb1e7ea94c53a3104366e3aaccd.1521492069.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if 'read_flag' is false, there is no need to allocate and free memory.
We can simply avoid the memory allocation and pass NULL to kfree.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/hid-alps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 925396fdf0d9..fe8a0624d5e4 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -171,7 +171,7 @@ static int t4_read_write_register(struct hid_device *hdev, u32 address,
 	int ret;
 	u16 check_sum;
 	u8 *input;
-	u8 *readbuf;
+	u8 *readbuf = NULL;
 
 	input = kzalloc(T4_FEATURE_REPORT_LEN, GFP_KERNEL);
 	if (!input)
@@ -204,8 +204,8 @@ static int t4_read_write_register(struct hid_device *hdev, u32 address,
 		goto exit;
 	}
 
-	readbuf = kzalloc(T4_FEATURE_REPORT_LEN, GFP_KERNEL);
 	if (read_flag) {
+		readbuf = kzalloc(T4_FEATURE_REPORT_LEN, GFP_KERNEL);
 		if (!readbuf) {
 			ret = -ENOMEM;
 			goto exit;
-- 
2.14.1
