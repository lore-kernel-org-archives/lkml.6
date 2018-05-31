Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754948AbeEaL1B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:27:01 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8225 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754571AbeEaLWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:22:41 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: <andy.shevchenko@gmail.com>, Yisheng Xie <xieyisheng1@huawei.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Quytelda Kahja <quytelda@tamalin.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH v2 03/21] Staging: gdm724x: use match_string() helper
Date: Thu, 31 May 2018 19:11:08 +0800
Message-ID: <1527765086-19873-4-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used instead of open coded variant.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Quytelda Kahja <quytelda@tamalin.org>
Cc: devel@driverdev.osuosl.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
v2:
 - const DRIVER_STRING instead  - per Andy

 drivers/staging/gdm724x/gdm_tty.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 3cdebb8..397ecaa 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -43,7 +43,7 @@
 static struct gdm *gdm_table[TTY_MAX_COUNT][GDM_TTY_MINOR];
 static DEFINE_MUTEX(gdm_table_lock);
 
-static char *DRIVER_STRING[TTY_MAX_COUNT] = {"GCTATC", "GCTDM"};
+static const char *DRIVER_STRING[TTY_MAX_COUNT] = {"GCTATC", "GCTDM"};
 static char *DEVICE_STRING[TTY_MAX_COUNT] = {"GCT-ATC", "GCT-DM"};
 
 static void gdm_port_destruct(struct tty_port *port)
@@ -65,22 +65,14 @@ static int gdm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct gdm *gdm = NULL;
 	int ret;
-	int i;
-	int j;
-
-	j = GDM_TTY_MINOR;
-	for (i = 0; i < TTY_MAX_COUNT; i++) {
-		if (!strcmp(tty->driver->driver_name, DRIVER_STRING[i])) {
-			j = tty->index;
-			break;
-		}
-	}
 
-	if (j == GDM_TTY_MINOR)
+	ret = match_string(DRIVER_STRING, TTY_MAX_COUNT,
+			   tty->driver->driver_name);
+	if (ret < 0 || tty->index == GDM_TTY_MINOR)
 		return -ENODEV;
 
 	mutex_lock(&gdm_table_lock);
-	gdm = gdm_table[i][j];
+	gdm = gdm_table[ret][tty->index];
 	if (!gdm) {
 		mutex_unlock(&gdm_table_lock);
 		return -ENODEV;
-- 
1.7.12.4
