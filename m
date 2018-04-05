Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeDEN0M (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:26:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54194 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751359AbeDENZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:25:59 -0400
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: kt.liao@emc.com.tw, Oliver Haessler <oliver@redhat.com>,
        Benjamin Berg <bberg@redhat.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 8/8] input: psmouse-smbus: allow to control psmouse_deactivate
Date: Thu,  5 Apr 2018 15:25:37 +0200
Message-Id: <20180405132537.3218-9-benjamin.tissoires@redhat.com>
In-Reply-To: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
References: <20180405132537.3218-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be Synaptics specific, as some Elan touchpads are not
correctly switching to SMBus if we call deactivate before switching to
SMBus on cold boot and on resume.

Tested with the T480s

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c      |  2 +-
 drivers/input/mouse/psmouse-smbus.c | 13 ++++++++++---
 drivers/input/mouse/psmouse.h       |  1 +
 drivers/input/mouse/synaptics.c     |  2 +-
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 29f55e8e07e9..6009fb7d0d31 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1771,7 +1771,7 @@ static int elantech_create_smbus(struct psmouse *psmouse,
 	};
 
 	return psmouse_smbus_init(psmouse, &smbus_board, &pdata,
-				  sizeof(pdata), leave_breadcrumbs);
+				  sizeof(pdata), false, leave_breadcrumbs);
 }
 
 /**
diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index c7ac24d119c1..facfe902b073 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -23,6 +23,7 @@ struct psmouse_smbus_dev {
 	struct i2c_client *client;
 	struct list_head node;
 	bool dead;
+	bool need_deactivate;
 };
 
 static LIST_HEAD(psmouse_smbus_list);
@@ -118,7 +119,10 @@ static psmouse_ret_t psmouse_smbus_process_byte(struct psmouse *psmouse)
 
 static int psmouse_smbus_reconnect(struct psmouse *psmouse)
 {
-	psmouse_deactivate(psmouse);
+	struct psmouse_smbus_dev *smbdev = psmouse->private;
+
+	if (smbdev->need_deactivate)
+		psmouse_deactivate(psmouse);
 
 	return 0;
 }
@@ -225,6 +229,7 @@ void psmouse_smbus_cleanup(struct psmouse *psmouse)
 int psmouse_smbus_init(struct psmouse *psmouse,
 		       const struct i2c_board_info *board,
 		       const void *pdata, size_t pdata_size,
+		       bool need_deactivate,
 		       bool leave_breadcrumbs)
 {
 	struct psmouse_smbus_dev *smbdev;
@@ -236,6 +241,7 @@ int psmouse_smbus_init(struct psmouse *psmouse,
 
 	smbdev->psmouse = psmouse;
 	smbdev->board = *board;
+	smbdev->need_deactivate = need_deactivate;
 
 	smbdev->board.platform_data = kmemdup(pdata, pdata_size, GFP_KERNEL);
 	if (!smbdev->board.platform_data) {
@@ -243,6 +249,9 @@ int psmouse_smbus_init(struct psmouse *psmouse,
 		return -ENOMEM;
 	}
 
+	if (need_deactivate)
+		psmouse_deactivate(psmouse);
+
 	psmouse->private = smbdev;
 	psmouse->protocol_handler = psmouse_smbus_process_byte;
 	psmouse->reconnect = psmouse_smbus_reconnect;
@@ -250,8 +259,6 @@ int psmouse_smbus_init(struct psmouse *psmouse,
 	psmouse->disconnect = psmouse_smbus_disconnect;
 	psmouse->resync_time = 0;
 
-	psmouse_deactivate(psmouse);
-
 	mutex_lock(&psmouse_smbus_mutex);
 	list_add_tail(&smbdev->node, &psmouse_smbus_list);
 	mutex_unlock(&psmouse_smbus_mutex);
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index dd4ec1f602d7..64c3a5d3fb3e 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -225,6 +225,7 @@ struct i2c_board_info;
 int psmouse_smbus_init(struct psmouse *psmouse,
 		       const struct i2c_board_info *board,
 		       const void *pdata, size_t pdata_size,
+		       bool need_deactivate,
 		       bool leave_breadcrumbs);
 void psmouse_smbus_cleanup(struct psmouse *psmouse);
 
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 14a1188561aa..6b1ed53a8b03 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1751,7 +1751,7 @@ static int synaptics_create_intertouch(struct psmouse *psmouse,
 	};
 
 	return psmouse_smbus_init(psmouse, &intertouch_board,
-				  &pdata, sizeof(pdata),
+				  &pdata, sizeof(pdata), true,
 				  leave_breadcrumbs);
 }
 
-- 
2.14.3
