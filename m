Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752951AbeEUMJQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:09:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38665 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752822AbeEUMJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:02 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quytelda Kahja <quytelda@tamalin.org>, <devel@driverdev.osuosl.org>
Subject: [PATCH 03/33] Staging: gdm724x: use match_string() helper
Date: Mon, 21 May 2018 19:57:40 +0800
Message-ID: <1526903890-35761-4-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Quytelda Kahja <quytelda@tamalin.org>
Cc: devel@driverdev.osuosl.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 3cdebb8..ba53a06 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
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
+	ret = match_string((const char **)DRIVER_STRING,
+			   TTY_MAX_COUNT, tty->driver->driver_name);
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
