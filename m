Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933751AbeB1RMg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:12:36 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55819 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752869AbeB1Ptv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 10:49:51 -0500
X-Google-Smtp-Source: AH8x227so8mIlHv3/MfzGue3MgqE+0AzGRitdr3qgr54BgsgV+RoVMMMHLm/J8w2PtrDyh6eUaQSgQ==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 03/15] lightnvm: add minor version to generic geometry
Date: Wed, 28 Feb 2018 16:49:23 +0100
Message-Id: <1519832975-25432-4-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
References: <1519832975-25432-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the version between major and minor on the generic geometry and
represent it through sysfs in the 2.0 path. The 1.2 path only shows the
major version to preserve the existing user space interface.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      |  4 ++--
 drivers/nvme/host/lightnvm.c | 25 ++++++++++++++++++++-----
 include/linux/lightnvm.h     |  3 ++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 9a417d9cdf0c..c4f72fbad2bf 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -890,8 +890,8 @@ static int nvm_init(struct nvm_dev *dev)
 		goto err;
 	}
 
-	pr_debug("nvm: ver:%u nvm_vendor:%x\n",
-				geo->ver_id,
+	pr_debug("nvm: ver:%u.%u nvm_vendor:%x\n",
+				geo->major_ver_id, geo->minor_ver_id,
 				geo->vmnt);
 
 	ret = nvm_core_init(dev);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 5b2024ebac76..a600e70b6e6b 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -295,7 +295,9 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 		return -EINVAL;
 	}
 
-	geo->ver_id = id->ver_id;
+	/* 1.2 spec. only reports a single version id - unfold */
+	geo->major_ver_id = id->ver_id;
+	geo->minor_ver_id = 2;
 
 	geo->nr_chnls = src->num_ch;
 	geo->nr_luns = src->num_lun;
@@ -380,7 +382,14 @@ static void nvme_nvm_set_addr_20(struct nvm_addr_format *dst,
 static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 			     struct nvm_geo *geo)
 {
-	geo->ver_id = id->mjr;
+	geo->major_ver_id = id->mjr;
+	geo->minor_ver_id = id->mnr;
+
+	if (!(geo->major_ver_id == 2 && geo->minor_ver_id == 0)) {
+		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
+				geo->major_ver_id, geo->minor_ver_id);
+		return -EINVAL;
+	}
 
 	geo->nr_chnls = le16_to_cpu(id->num_grp);
 	geo->nr_luns = le16_to_cpu(id->num_pu);
@@ -917,7 +926,13 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
 	attr = &dattr->attr;
 
 	if (strcmp(attr->name, "version") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", geo->ver_id);
+		if (geo->major_ver_id == 1)
+			return scnprintf(page, PAGE_SIZE, "%u\n",
+						geo->major_ver_id);
+		else
+			return scnprintf(page, PAGE_SIZE, "%u.%u\n",
+						geo->major_ver_id,
+						geo->minor_ver_id);
 	} else if (strcmp(attr->name, "capabilities") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", geo->cap);
 	} else if (strcmp(attr->name, "read_typ") == 0) {
@@ -1171,7 +1186,7 @@ int nvme_nvm_register_sysfs(struct nvme_ns *ns)
 	if (!ndev)
 		return -EINVAL;
 
-	switch (geo->ver_id) {
+	switch (geo->major_ver_id) {
 	case 1:
 		return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
 					&nvm_dev_attr_group_12);
@@ -1188,7 +1203,7 @@ void nvme_nvm_unregister_sysfs(struct nvme_ns *ns)
 	struct nvm_dev *ndev = ns->ndev;
 	struct nvm_geo *geo = &ndev->geo;
 
-	switch (geo->ver_id) {
+	switch (geo->major_ver_id) {
 	case 1:
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvm_dev_attr_group_12);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index b9f0d2070de9..4b2ecbf45fd9 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -263,7 +263,8 @@ enum {
 /* Instance geometry */
 struct nvm_geo {
 	/* device reported version */
-	u8	ver_id;
+	u8	major_ver_id;
+	u8	minor_ver_id;
 
 	/* instance specific geometry */
 	int nr_chnls;
-- 
2.7.4
