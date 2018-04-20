Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbeDTIyG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:54:06 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59347 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753971AbeDTIyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:54:05 -0400
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: dedekind1@gmail.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 1/2] ubi: move constants for ubi vol parsing from kernel param to ubi.h
Date: Fri, 20 Apr 2018 10:52:40 +0200
Message-Id: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constants used to parse ubi.block parameters from the kernel command
line are not specific to UBI block devices but rather to UBI volumes
(on which block devices are "based").

So let's rename UBIBLOCK_* constants used in parameter parsing to
UBIVOL_*.

Let's move the constants to ubi.h so that they can be used to parse
other parameters impacting UBI volumes.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/mtd/ubi/block.c | 33 +++++++++------------------------
 drivers/mtd/ubi/ubi.h   | 15 +++++++++++++++
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index d0b63bb..836272c 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -54,21 +54,6 @@
 #include "ubi-media.h"
 #include "ubi.h"
 
-/* Maximum number of supported devices */
-#define UBIBLOCK_MAX_DEVICES 32
-
-/* Maximum length of the 'block=' parameter */
-#define UBIBLOCK_PARAM_LEN 63
-
-/* Maximum number of comma-separated items in the 'block=' parameter */
-#define UBIBLOCK_PARAM_COUNT 2
-
-struct ubiblock_param {
-	int ubi_num;
-	int vol_id;
-	char name[UBIBLOCK_PARAM_LEN+1];
-};
-
 struct ubiblock_pdu {
 	struct work_struct work;
 	struct ubi_sgl usgl;
@@ -78,7 +63,7 @@ struct ubiblock_pdu {
 static int ubiblock_devs __initdata;
 
 /* MTD devices specification parameters */
-static struct ubiblock_param ubiblock_param[UBIBLOCK_MAX_DEVICES] __initdata;
+static struct ubivol_param ubiblock_param[UBIVOL_MAX_DEVICES] __initdata;
 
 struct ubiblock {
 	struct ubi_volume_desc *desc;
@@ -109,23 +94,23 @@ static int __init ubiblock_set_param(const char *val,
 {
 	int i, ret;
 	size_t len;
-	struct ubiblock_param *param;
-	char buf[UBIBLOCK_PARAM_LEN];
+	struct ubivol_param *param;
+	char buf[UBIVOL_PARAM_LEN];
 	char *pbuf = &buf[0];
-	char *tokens[UBIBLOCK_PARAM_COUNT];
+	char *tokens[UBIVOL_PARAM_COUNT];
 
 	if (!val)
 		return -EINVAL;
 
-	len = strnlen(val, UBIBLOCK_PARAM_LEN);
+	len = strnlen(val, UBIVOL_PARAM_LEN);
 	if (len == 0) {
 		pr_warn("UBI: block: empty 'block=' parameter - ignored\n");
 		return 0;
 	}
 
-	if (len == UBIBLOCK_PARAM_LEN) {
+	if (len == UBIVOL_PARAM_LEN) {
 		pr_err("UBI: block: parameter \"%s\" is too long, max. is %d\n",
-		       val, UBIBLOCK_PARAM_LEN);
+		       val, UBIVOL_PARAM_LEN);
 		return -EINVAL;
 	}
 
@@ -135,7 +120,7 @@ static int __init ubiblock_set_param(const char *val,
 	if (buf[len - 1] == '\n')
 		buf[len - 1] = '\0';
 
-	for (i = 0; i < UBIBLOCK_PARAM_COUNT; i++)
+	for (i = 0; i < UBIVOL_PARAM_COUNT; i++)
 		tokens[i] = strsep(&pbuf, ",");
 
 	param = &ubiblock_param[ubiblock_devs];
@@ -599,7 +584,7 @@ open_volume_desc(const char *name, int ubi_num, int vol_id)
 static void __init ubiblock_create_from_param(void)
 {
 	int i, ret = 0;
-	struct ubiblock_param *p;
+	struct ubivol_param *p;
 	struct ubi_volume_desc *desc;
 	struct ubi_volume_info vi;
 
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 5fe6265..4cc6ec9 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -810,6 +810,21 @@ struct ubi_work {
 	int anchor;
 };
 
+/* Maximum number of supported devices */
+#define UBIVOL_MAX_DEVICES 32
+
+/* Maximum length of the vol parameter */
+#define UBIVOL_PARAM_LEN 63
+
+/* Maximum number of comma-separated items in a vol parameter */
+#define UBIVOL_PARAM_COUNT 2
+
+struct ubivol_param {
+	int ubi_num;
+	int vol_id;
+	char name[UBIVOL_PARAM_LEN + 1];
+};
+
 #include "debug.h"
 
 extern struct kmem_cache *ubi_wl_entry_slab;

base-commit: 559d97996f1b75731195d813158eee7cc8a1f316
-- 
git-series 0.9.1
