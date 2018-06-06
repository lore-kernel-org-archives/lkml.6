Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEAC5607B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeFFCYU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Tue, 5 Jun 2018 22:24:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8699 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752424AbeFFCYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 22:24:19 -0400
Subject: [PATCH v3 03/21] Staging: gdm724x: use match_string() helper
To: <linux-kernel@vger.kernel.org>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
 <1527765086-19873-4-git-send-email-xieyisheng1@huawei.com>
CC: <andy.shevchenko@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quytelda Kahja <quytelda@tamalin.org>,
        <devel@driverdev.osuosl.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <643c3ad1-55c0-4ad6-7305-4938b1280be6@huawei.com>
Date: Wed, 6 Jun 2018 10:21:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1527765086-19873-4-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
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
v3:
 - no need to check input tty's index - per Greg
v2:
 - const DRIVER_STRING instead  - per Andy

 drivers/staging/gdm724x/gdm_tty.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 3cdebb8..29ac6b5 100644
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
+	if (ret < 0)
 		return -ENODEV;

 	mutex_lock(&gdm_table_lock);
-	gdm = gdm_table[i][j];
+	gdm = gdm_table[ret][tty->index];
 	if (!gdm) {
 		mutex_unlock(&gdm_table_lock);
 		return -ENODEV;
-- 
1.7.12.4
