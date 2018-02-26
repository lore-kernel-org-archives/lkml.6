Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753616AbeBZNX6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:23:58 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38004 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753078AbeBZNRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:17:30 -0500
X-Google-Smtp-Source: AH8x225rHsPeXeKovMfzAO/c17adweh7373tW4O5YCFBvLo8UA5ognPTpLn6SLniKxK6U9ZhjWKqvA==
From: "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <jg@lightnvm.io>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To: mb@lightnvm.io
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH 03/19] lightnvm: add minor version to generic geometry
Date: Mon, 26 Feb 2018 14:17:02 +0100
Message-Id: <1519651038-16845-4-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
References: <1519651038-16845-1-git-send-email-javier@cnexlabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the version between major and minor on the generic geometry and
represent it through sysfs in the 2.0 path. The 1.2 path only shows the major
version to preserve the existing user space interface.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/core.c      |  4 ++--
 drivers/nvme/host/lightnvm.c | 25 ++++++++++++++++++++-----
 include/linux/lightnvm.h     |  3 ++-
 3 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 43e3d6bb5be6..96f4e62d383b 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -897,8 +897,8 @@ static int nvm_init(struct nvm_dev *dev)
 		goto err;
 	}
 
-	pr_debug("nvm: ver:%u nvm_vendor:%x\n",
-				dev_geo->ver_id,
+	pr_debug("nvm: ver:%u.%u nvm_vendor:%x\n",
+				dev_geo->major_ver_id, dev_geo->minor_ver_id,
 				dev_geo->c.vmnt);
 
 	ret = nvm_core_init(dev);
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 10392a664b50..8befb60eeacb 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -295,7 +295,9 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 *id,
 		return -EINVAL;
 	}
 
-	dev_geo->ver_id = id->ver_id;
+	/* 1.2 spec. only reports a single version id - unfold */
+	dev_geo->major_ver_id = id->ver_id;
+	dev_geo->minor_ver_id = 2;
 
 	dev_geo->nr_chnls = src->num_ch;
 	dev_geo->nr_luns = src->num_lun;
@@ -380,7 +382,14 @@ static void nvme_nvm_set_addr_20(struct nvm_addr_format *dst,
 static int nvme_nvm_setup_20(struct nvme_nvm_id20 *id,
 			     struct nvm_geo *dev_geo)
 {
-	dev_geo->ver_id = id->mjr;
+	dev_geo->major_ver_id = id->mjr;
+	dev_geo->minor_ver_id = id->mnr;
+
+	if (!(dev_geo->major_ver_id == 2 && dev_geo->minor_ver_id == 0)) {
+		pr_err("nvm: OCSSD version not supported (v%d.%d)\n",
+				dev_geo->major_ver_id, dev_geo->minor_ver_id);
+		return -EINVAL;
+	}
 
 	dev_geo->nr_chnls = le16_to_cpu(id->num_grp);
 	dev_geo->nr_luns = le16_to_cpu(id->num_pu);
@@ -920,7 +929,13 @@ static ssize_t nvm_dev_attr_show(struct device *dev,
 	attr = &dattr->attr;
 
 	if (strcmp(attr->name, "version") == 0) {
-		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->ver_id);
+		if (dev_geo->major_ver_id == 1)
+			return scnprintf(page, PAGE_SIZE, "%u\n",
+						dev_geo->major_ver_id);
+		else
+			return scnprintf(page, PAGE_SIZE, "%u.%u\n",
+						dev_geo->major_ver_id,
+						dev_geo->minor_ver_id);
 	} else if (strcmp(attr->name, "capabilities") == 0) {
 		return scnprintf(page, PAGE_SIZE, "%u\n", dev_geo->c.cap);
 	} else if (strcmp(attr->name, "read_typ") == 0) {
@@ -1174,7 +1189,7 @@ int nvme_nvm_register_sysfs(struct nvme_ns *ns)
 	if (!ndev)
 		return -EINVAL;
 
-	switch (dev_geo->ver_id) {
+	switch (dev_geo->major_ver_id) {
 	case 1:
 		return sysfs_create_group(&disk_to_dev(ns->disk)->kobj,
 					&nvm_dev_attr_group_12);
@@ -1191,7 +1206,7 @@ void nvme_nvm_unregister_sysfs(struct nvme_ns *ns)
 	struct nvm_dev *ndev = ns->ndev;
 	struct nvm_geo *dev_geo = &ndev->geo;
 
-	switch (dev_geo->ver_id) {
+	switch (dev_geo->major_ver_id) {
 	case 1:
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
 					&nvm_dev_attr_group_12);
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 42704c4ca9af..ccaf8a30202d 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -309,7 +309,8 @@ struct nvm_common_geo {
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
