Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932099AbeBGJMK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 04:12:10 -0500
Received: from albert.telenet-ops.be ([195.130.137.90]:49106 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753469AbeBGJMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 04:12:07 -0500
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>
Cc: Arnd Bergmann <arnd@arndb.de>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] platform/mellanox: mlxreg-hotplug: Fix uninitialized variable
Date: Wed,  7 Feb 2018 10:12:04 +0100
Message-Id: <1517994724-5931-1-git-send-email-geert@linux-m68k.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc-4.1.2:

    drivers/platform/mellanox/mlxreg-hotplug.c: In function ‘mlxreg_hotplug_health_work_helper’:
    drivers/platform/mellanox/mlxreg-hotplug.c:347: warning: ‘ret’ is used uninitialized in this function

Indeed, if mlxreg_core_item.count is zero, ret is used uninitialized.

While this is unlikely to happen (it is set to ARRAY_SIZE(...) in x86
board files), this is done in another source file, so fix this by
preinitializing ret to zero.

Fixes: c6acad68eb2dbffd ("platform/mellanox: mlxreg-hotplug: Modify to use a regmap interface")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index 0dfa1ca0d05b0217..313cf8ad77bf68ce 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -300,7 +300,7 @@ mlxreg_hotplug_health_work_helper(struct mlxreg_hotplug_priv_data *priv,
 {
 	struct mlxreg_core_data *data = item->data;
 	u32 regval;
-	int i, ret;
+	int i, ret = 0;
 
 	for (i = 0; i < item->count; i++, data++) {
 		/* Mask event. */
-- 
2.7.4
