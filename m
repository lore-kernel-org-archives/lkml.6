Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbeDTIyS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 04:54:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59356 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754066AbeDTIyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 04:54:05 -0400
From: Quentin Schulz <quentin.schulz@bootlin.com>
To: dedekind1@gmail.com, richard@nod.at, dwmw2@infradead.org,
        computersforpeace@gmail.com, boris.brezillon@bootlin.com,
        marek.vasut@gmail.com
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com,
        Quentin Schulz <quentin.schulz@bootlin.com>
Subject: [PATCH 2/2] ubi: introduce ubi.nocheck parameter to skip CRC check when attaching ubi vol
Date: Fri, 20 Apr 2018 10:52:41 +0200
Message-Id: <6551534f88b3aa77cc377c4270c4ddf7fe92cdf4.1524214122.git-series.quentin.schulz@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com>
References: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com>
In-Reply-To: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com>
References: <95e04a201ac4ef82e68ce8e0c4f548b193e51b55.1524214122.git-series.quentin.schulz@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's already ECC on NAND pages so there may be no need for one to
check the CRC of a UBI volume.

Let's introduce a ubi.nocheck parameter that let one skip the CRC check
when attaching a UBI volume.

This also drastically speeds kernel boot by removing a potentially
useless check, e.g. I gained 3.2s on boot time of a SPEAr600-based board
for a ~20MB UBI volume used as rootfs.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/mtd/ubi/kapi.c | 70 +++++++++++++++++++++++++++++++++++++++++++-
 drivers/mtd/ubi/ubi.h  |  6 ++++-
 drivers/mtd/ubi/vtbl.c | 24 ++++++++++++++-
 3 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/kapi.c b/drivers/mtd/ubi/kapi.c
index d4b2e87..d604cd5 100644
--- a/drivers/mtd/ubi/kapi.c
+++ b/drivers/mtd/ubi/kapi.c
@@ -28,6 +28,9 @@
 #include <asm/div64.h>
 #include "ubi.h"
 
+struct ubivol_param ubinocheck_param[UBIVOL_MAX_DEVICES];
+int ubinocheck_devs;
+
 /**
  * ubi_do_get_device_info - get information about UBI device.
  * @ubi: UBI device description object
@@ -865,3 +868,70 @@ int ubi_unregister_volume_notifier(struct notifier_block *nb)
 	return blocking_notifier_chain_unregister(&ubi_notifiers, nb);
 }
 EXPORT_SYMBOL_GPL(ubi_unregister_volume_notifier);
+
+static int __init ubinocheckvol_set_param(const char *val,
+					  const struct kernel_param *kp)
+{
+	int i, ret;
+	size_t len;
+	struct ubivol_param *param;
+	char buf[UBIVOL_PARAM_LEN];
+	char *pbuf = &buf[0];
+	char *tokens[UBIVOL_PARAM_COUNT];
+
+	if (!val)
+		return -EINVAL;
+
+	len = strnlen(val, UBIVOL_PARAM_LEN);
+	if (len == 0) {
+		pr_warn("UBI: nocheck: empty 'nocheck=' parameter - ignored\n");
+		return 0;
+	}
+
+	if (len == UBIVOL_PARAM_LEN) {
+		pr_err("UBI: nocheck: parameter \"%s\" is too long, max. is %d\n",
+		       val, UBIVOL_PARAM_LEN);
+		return -EINVAL;
+	}
+
+	strcpy(buf, val);
+
+	/* Get rid of the final newline */
+	if (buf[len - 1] == '\n')
+		buf[len - 1] = '\0';
+
+	for (i = 0; i < UBIVOL_PARAM_COUNT; i++)
+		tokens[i] = strsep(&pbuf, ",");
+
+	param = &ubinocheck_param[ubinocheck_devs];
+	if (tokens[1]) {
+		/* Two parameters: can be 'ubi, vol_id' or 'ubi, vol_name' */
+		ret = kstrtoint(tokens[0], 10, &param->ubi_num);
+		if (ret < 0)
+			return -EINVAL;
+
+		/* Second param can be a number or a name */
+		ret = kstrtoint(tokens[1], 10, &param->vol_id);
+		if (ret < 0) {
+			param->vol_id = -1;
+			strcpy(param->name, tokens[1]);
+		}
+	}
+
+	ubinocheck_devs++;
+
+	return 0;
+}
+
+static const struct kernel_param_ops ubinocheckvol_param_ops = {
+	.set	= ubinocheckvol_set_param,
+};
+module_param_cb(nocheck, &ubinocheckvol_param_ops, NULL, 0);
+MODULE_PARM_DESC(nocheck,
+		 "Disable CRC check for UBI volumes. Parameter format: nocheck=dev,[num|name]>.\n"
+		 "Multiple \"nocheck\" parameters may be specified.\n"
+		 "Examples\n"
+		 "Using the UBI device, and the volume name:\n"
+		 "ubi.nocheck=0,rootfs\n"
+		 "Using both UBI device number and UBI volume number:\n"
+		 "ubi.nocheck=0,0\n");
diff --git a/drivers/mtd/ubi/ubi.h b/drivers/mtd/ubi/ubi.h
index 4cc6ec9..2bd89b4 100644
--- a/drivers/mtd/ubi/ubi.h
+++ b/drivers/mtd/ubi/ubi.h
@@ -825,6 +825,12 @@ struct ubivol_param {
 	char name[UBIVOL_PARAM_LEN + 1];
 };
 
+/* Numbers of elements set in the @ubinocheck_param array */
+extern int ubinocheck_devs;
+
+/* MTD devices specification parameters */
+extern struct ubivol_param ubinocheck_param[UBIVOL_MAX_DEVICES];
+
 #include "debug.h"
 
 extern struct kmem_cache *ubi_wl_entry_slab;
diff --git a/drivers/mtd/ubi/vtbl.c b/drivers/mtd/ubi/vtbl.c
index 263743e..06b6cfd 100644
--- a/drivers/mtd/ubi/vtbl.c
+++ b/drivers/mtd/ubi/vtbl.c
@@ -534,9 +534,10 @@ static int init_volumes(struct ubi_device *ubi,
 			const struct ubi_attach_info *ai,
 			const struct ubi_vtbl_record *vtbl)
 {
-	int i, reserved_pebs = 0;
+	int i, j, reserved_pebs = 0;
 	struct ubi_ainf_volume *av;
 	struct ubi_volume *vol;
+	struct ubivol_param *param;
 
 	for (i = 0; i < ubi->vtbl_slots; i++) {
 		cond_resched();
@@ -620,6 +621,27 @@ static int init_volumes(struct ubi_device *ubi,
 			(long long)(vol->used_ebs - 1) * vol->usable_leb_size;
 		vol->used_bytes += av->last_data_size;
 		vol->last_eb_bytes = av->last_data_size;
+
+		for (j = 0; j < ubinocheck_devs; j++) {
+			param = &ubinocheck_param[j];
+
+			if (vol->ubi->ubi_num != param->ubi_num)
+				continue;
+			if (vol->vol_id == param->vol_id) {
+				ubi_msg(vol->ubi,
+					"skipping CRC check for volume %d",
+					vol->vol_id);
+				vol->checked = true;
+				break;
+			}
+			if (!strcmp(vol->name, param->name)) {
+				ubi_msg(vol->ubi,
+					"skipping CRC check for volume %s",
+					param->name);
+				vol->checked = true;
+				break;
+			}
+		}
 	}
 
 	/* And add the layout volume */
-- 
git-series 0.9.1
