Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753029AbeCXX1M (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 19:27:12 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:9942 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752315AbeCXX1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 19:27:10 -0400
From: Alban Bedel <albeu@free.fr>
To: linux-kernel@vger.kernel.org
Cc: Alban Bedel <albeu@free.fr>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v3 3/3] mtd: Add support for reading MTD devices via the nvmem API
Date: Sun, 25 Mar 2018 00:24:59 +0100
Message-Id: <1521933899-362-4-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521933899-362-1-git-send-email-albeu@free.fr>
References: <1521933899-362-1-git-send-email-albeu@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow drivers that use the nvmem API to read data stored on MTD devices.
For this the mtd devices are registered as read-only NVMEM providers.
On OF systems only devices that have the 'nvmem-provider' property
are registered, on non-OF system all MTD devices are registered.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
Changelog:
v2: * Moved to the MTD core instead of using notifiers
    * Fixed the Kconfig description
v3: * Rebased on current kernel
    * Moved the code to mtdcore.c and removed the conditional
      compilation as suggested by Boris Brezillon
    * Fixed my name in From and Signed-off-by
    * Only allow root to read from the nvmem sysfs interface
---
 drivers/mtd/Kconfig     |  1 +
 drivers/mtd/mtdcore.c   | 59 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  2 ++
 3 files changed, 62 insertions(+)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 2a8ac68..911d869 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -1,5 +1,6 @@
 menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
+	imply NVMEM
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
 	  used for solid state file systems on embedded devices. This option
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 28553c8..d2a127c 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -478,6 +478,48 @@ int mtd_pairing_groups(struct mtd_info *mtd)
 }
 EXPORT_SYMBOL_GPL(mtd_pairing_groups);
 
+static int mtd_nvmem_reg_read(void *priv, unsigned int offset,
+			      void *val, size_t bytes)
+{
+	struct mtd_info *mtd = priv;
+	size_t retlen;
+	int err;
+
+	err = mtd_read(mtd, offset, bytes, &retlen, val);
+	if (err && err != -EUCLEAN)
+		return err;
+
+	return retlen == bytes ? 0 : -EIO;
+}
+
+static int mtd_nvmem_add(struct mtd_info *mtd)
+{
+	struct nvmem_config config = {};
+
+	config.dev = &mtd->dev;
+	config.owner = THIS_MODULE;
+	config.reg_read = mtd_nvmem_reg_read;
+	config.size = mtd->size;
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.priv = mtd;
+
+	mtd->nvmem = nvmem_register(&config);
+	if (IS_ERR(mtd->nvmem)) {
+		/* Just ignore if there is no NVMEM support in the kernel */
+		if (PTR_ERR(mtd->nvmem) == -ENOSYS) {
+			mtd->nvmem = NULL;
+		} else {
+			dev_err(&mtd->dev, "Failed to register NVMEM device\n");
+			return PTR_ERR(mtd->nvmem);
+		}
+	}
+
+	return 0;
+}
+
 static struct dentry *dfs_dir_mtd;
 
 /**
@@ -560,6 +602,11 @@ int add_mtd_device(struct mtd_info *mtd)
 	if (error)
 		goto fail_added;
 
+	/* Add the nvmem provider */
+	error = mtd_nvmem_add(mtd);
+	if (error)
+		goto fail_nvmem_add;
+
 	if (!IS_ERR_OR_NULL(dfs_dir_mtd)) {
 		mtd->dbg.dfs_dir = debugfs_create_dir(dev_name(&mtd->dev), dfs_dir_mtd);
 		if (IS_ERR_OR_NULL(mtd->dbg.dfs_dir)) {
@@ -585,6 +632,8 @@ int add_mtd_device(struct mtd_info *mtd)
 	__module_get(THIS_MODULE);
 	return 0;
 
+fail_nvmem_add:
+	device_unregister(&mtd->dev);
 fail_added:
 	of_node_put(mtd_get_of_node(mtd));
 	idr_remove(&mtd_idr, i);
@@ -627,6 +676,16 @@ int del_mtd_device(struct mtd_info *mtd)
 		       mtd->index, mtd->name, mtd->usecount);
 		ret = -EBUSY;
 	} else {
+		/* Try to remove the NVMEM provider */
+		if (mtd->nvmem) {
+			ret = nvmem_unregister(mtd->nvmem);
+			if (ret) {
+				dev_err(&mtd->dev,
+					"Failed to unregister NVMEM device\n");
+				goto out_error;
+			}
+		}
+
 		device_unregister(&mtd->dev);
 
 		idr_remove(&mtd_idr, mtd->index);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 205eded..660b8e7 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -25,6 +25,7 @@
 #include <linux/notifier.h>
 #include <linux/device.h>
 #include <linux/of.h>
+#include <linux/nvmem-provider.h>
 
 #include <mtd/mtd-abi.h>
 
@@ -352,6 +353,7 @@ struct mtd_info {
 	struct device dev;
 	int usecount;
 	struct mtd_debug_info dbg;
+	struct nvmem_device *nvmem;
 };
 
 int mtd_ooblayout_ecc(struct mtd_info *mtd, int section,
-- 
2.7.4
