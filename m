Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971696AbeCSUyR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:54:17 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:33490 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971632AbeCSUyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:54:12 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Mar 2018 21:54:11 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: masaki.ota@jp.alps.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/4] HID: alps: Report an error if we receive invalid data in 't4_read_write_register()'
Date: Mon, 19 Mar 2018 21:53:26 +0100
Message-Id: <c59e5f62dd36950a027eb629a7780e714cb8766f.1521492069.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the data received is not what is expected, we should return an error.

Otherwise, we return 0 or a positive value which will be interpreted as
success, but '*read_val' has not been updated.

Fixes: 73196ebe134d ("HID: alps: add support for Alps T4 Touchpad device")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Untested
---
 drivers/hid/hid-alps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index b1eeb4839bfc..925396fdf0d9 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -219,6 +219,8 @@ static int t4_read_write_register(struct hid_device *hdev, u32 address,
 			goto exit_readbuf;
 		}
 
+		ret = -EINVAL;
+
 		if (*(u32 *)&readbuf[6] != address) {
 			dev_err(&hdev->dev, "read register address error (%x,%x)\n",
 			*(u32 *)&readbuf[6], address);
-- 
2.14.1
