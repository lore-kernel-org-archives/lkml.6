Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971725AbeCSUzJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:55:09 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:49015 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968768AbeCSUyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:54:14 -0400
X-ME-Helo: linux.numericable.fr
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Mar 2018 21:54:13 +0100
X-ME-IP: 77.198.79.136
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: masaki.ota@jp.alps.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/4] HID: alps: Check errors returned by 't4_read_write_register()'
Date: Mon, 19 Mar 2018 21:53:28 +0100
Message-Id: <c66533ec775540b7f1da48611a7e45bda28cead5.1521492069.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521492069.git.christophe.jaillet@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If only the first 't4_read_write_register()' call fails, the error code
will be overwritten and lost.
Directly report the error instead.

While at it, log some errors if 't4_read_write_register()' fails, as done
in the rest of the driver.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/hid/hid-alps.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index fe8a0624d5e4..137b963779c6 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -460,17 +460,35 @@ static int __maybe_unused alps_post_reset(struct hid_device *hdev)
 	case T4:
 		ret = t4_read_write_register(hdev, T4_PRM_FEED_CONFIG_1,
 			NULL, T4_I2C_ABS, false);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "failed T4_PRM_FEED_CONFIG_1 (%d)\n",
+				ret);
+			goto exit;
+		}
+
 		ret = t4_read_write_register(hdev, T4_PRM_FEED_CONFIG_4,
 			NULL, T4_FEEDCFG4_ADVANCED_ABS_ENABLE, false);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "failed T4_PRM_FEED_CONFIG_4 (%d)\n",
+				ret);
+			goto exit;
+		}
 		break;
 	case U1:
 		ret = u1_read_write_register(hdev,
 			ADDRESS_U1_DEV_CTRL_1, NULL,
 			U1_TP_ABS_MODE | U1_SP_ABS_MODE, false);
+		if (ret < 0) {
+			dev_err(&hdev->dev, "failed to change TP mode (%d)\n",
+				ret);
+			goto exit;
+		}
 		break;
 	default:
 		break;
 	}
+
+exit:
 	return ret;
 }
 
-- 
2.14.1
