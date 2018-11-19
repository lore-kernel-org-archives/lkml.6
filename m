Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28226C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:20:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A0A20851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2A0A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbeKTHqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 02:46:02 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:51144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730209AbeKTHqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 02:46:02 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9898596A0D366;
        Tue, 20 Nov 2018 05:20:29 +0800 (CST)
Received: from S00293818-DELL1.china.huawei.com (10.47.88.214) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Tue, 20 Nov 2018 05:20:22 +0800
From:   Salil Mehta <salil.mehta@huawei.com>
To:     <davem@davemloft.net>
CC:     <salil.mehta@huawei.com>, <yisen.zhuang@huawei.com>,
        <lipeng321@huawei.com>, <mehta.salil@opnsrc.net>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, liuzhongzhu <liuzhongzhu@huawei.com>
Subject: [PATCH net-next 1/8] net: hns3: Add debugfs framework registration
Date:   Mon, 19 Nov 2018 21:18:38 +0000
Message-ID: <20181119211845.23168-2-salil.mehta@huawei.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20181119211845.23168-1-salil.mehta@huawei.com>
References: <20181119211845.23168-1-salil.mehta@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.47.88.214]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: liuzhongzhu <liuzhongzhu@huawei.com>

Add the debugfs framework to the driver and create a debugfs
command interface for each device.

example command:
"echo queue info > cmd" Query the packet forwarding queue information.

Signed-off-by: liuzhongzhu <liuzhongzhu@huawei.com>
Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/Makefile  |   2 +-
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   1 +
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 136 ++++++++++++++++++
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  17 ++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.h   |   4 +
 5 files changed, 157 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c

diff --git a/drivers/net/ethernet/hisilicon/hns3/Makefile b/drivers/net/ethernet/hisilicon/hns3/Makefile
index 002534f12b66..d01bf536eb86 100644
--- a/drivers/net/ethernet/hisilicon/hns3/Makefile
+++ b/drivers/net/ethernet/hisilicon/hns3/Makefile
@@ -9,6 +9,6 @@ obj-$(CONFIG_HNS3) += hns3vf/
 obj-$(CONFIG_HNS3) += hnae3.o
 
 obj-$(CONFIG_HNS3_ENET) += hns3.o
-hns3-objs = hns3_enet.o hns3_ethtool.o
+hns3-objs = hns3_enet.o hns3_ethtool.o hns3_debugfs.o
 
 hns3-$(CONFIG_HNS3_DCB) += hns3_dcbnl.o
diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index 4a39feaba8b2..f32f075991f5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -566,6 +566,7 @@ struct hnae3_handle {
 	u32 numa_node_mask;	/* for multi-chip support */
 
 	u8 netdev_flags;
+	struct dentry *hnae3_dbgfs;
 };
 
 #define hnae3_set_field(origin, mask, shift, val) \
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
new file mode 100644
index 000000000000..9bc6ceb6fbc1
--- /dev/null
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Copyright (c) 2018-2019 Hisilicon Limited.
+
+#include <linux/debugfs.h>
+#include <linux/device.h>
+
+#include "hnae3.h"
+#include "hns3_enet.h"
+
+#define HNS3_DBG_READ_LEN 256
+
+static struct dentry *hns3_dbgfs_root;
+
+static void hns3_dbg_help(struct hnae3_handle *h)
+{
+	dev_info(&h->pdev->dev, "available commands\n");
+	dev_info(&h->pdev->dev, "queue info [number]\n");
+	dev_info(&h->pdev->dev, "dump fd tcam\n");
+}
+
+static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
+				 size_t count, loff_t *ppos)
+{
+	int uncopy_bytes;
+	char *buf;
+	int len;
+
+	if (*ppos != 0)
+		return 0;
+
+	if (count < HNS3_DBG_READ_LEN)
+		return -ENOSPC;
+
+	buf = kzalloc(HNS3_DBG_READ_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	len = snprintf(buf, HNS3_DBG_READ_LEN, "%s\n",
+		       "Please echo help to cmd to get help information");
+	uncopy_bytes = copy_to_user(buffer, buf, len);
+
+	kfree(buf);
+
+	if (uncopy_bytes)
+		return -EFAULT;
+
+	return (*ppos = len);
+}
+
+static ssize_t hns3_dbg_cmd_write(struct file *filp, const char __user *buffer,
+				  size_t count, loff_t *ppos)
+{
+	struct hnae3_handle *handle = filp->private_data;
+	char *cmd_buf, *cmd_buf_tmp;
+	int uncopied_bytes;
+	int ret = 0;
+
+	if (*ppos != 0)
+		return 0;
+
+	cmd_buf = kzalloc(count + 1, GFP_KERNEL);
+	if (!cmd_buf)
+		return count;
+
+	uncopied_bytes = copy_from_user(cmd_buf, buffer, count);
+	if (uncopied_bytes) {
+		kfree(cmd_buf);
+		return -EFAULT;
+	}
+
+	cmd_buf[count] = '\0';
+
+	cmd_buf_tmp = strchr(cmd_buf, '\n');
+	if (cmd_buf_tmp) {
+		*cmd_buf_tmp = '\0';
+		count = cmd_buf_tmp - cmd_buf + 1;
+	}
+
+	if (strncmp(cmd_buf, "help", 4) == 0)
+		hns3_dbg_help(handle);
+
+	if (ret)
+		hns3_dbg_help(handle);
+
+	kfree(cmd_buf);
+	cmd_buf = NULL;
+
+	return count;
+}
+
+static const struct file_operations hns3_dbg_cmd_fops = {
+	.owner = THIS_MODULE,
+	.open  = simple_open,
+	.read  = hns3_dbg_cmd_read,
+	.write = hns3_dbg_cmd_write,
+};
+
+void hns3_dbg_init(struct hnae3_handle *handle)
+{
+	const char *name = pci_name(handle->pdev);
+	struct dentry *pfile;
+
+	handle->hnae3_dbgfs = debugfs_create_dir(name, hns3_dbgfs_root);
+	if (!handle->hnae3_dbgfs)
+		return;
+
+	pfile = debugfs_create_file("cmd", 0600, handle->hnae3_dbgfs, handle,
+				    &hns3_dbg_cmd_fops);
+	if (!pfile) {
+		debugfs_remove_recursive(handle->hnae3_dbgfs);
+		handle->hnae3_dbgfs = NULL;
+		dev_warn(&handle->pdev->dev, "create file for %s fail\n",
+			 name);
+	}
+}
+
+void hns3_dbg_uninit(struct hnae3_handle *handle)
+{
+	debugfs_remove_recursive(handle->hnae3_dbgfs);
+	handle->hnae3_dbgfs = NULL;
+}
+
+void hns3_dbg_register_debugfs(const char *debugfs_dir_name)
+{
+	hns3_dbgfs_root = debugfs_create_dir(debugfs_dir_name, NULL);
+	if (!hns3_dbgfs_root) {
+		pr_warn("Register debugfs for %s fail\n", debugfs_dir_name);
+		return;
+	}
+}
+
+void hns3_dbg_unregister_debugfs(void)
+{
+	debugfs_remove_recursive(hns3_dbgfs_root);
+	hns3_dbgfs_root = NULL;
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 7f81db3df041..d1b2de2ecc89 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3620,6 +3620,8 @@ static int hns3_client_init(struct hnae3_handle *handle)
 
 	hns3_dcbnl_setup(handle);
 
+	hns3_dbg_init(handle);
+
 	/* MTU range: (ETH_MIN_MTU(kernel default) - 9702) */
 	netdev->max_mtu = HNS3_MAX_MTU;
 
@@ -3676,6 +3678,8 @@ static void hns3_client_uninit(struct hnae3_handle *handle, bool reset)
 
 	hns3_put_ring_config(priv);
 
+	hns3_dbg_uninit(handle);
+
 	priv->ring_data = NULL;
 
 out_netdev_free:
@@ -4245,15 +4249,23 @@ static int __init hns3_init_module(void)
 
 	INIT_LIST_HEAD(&client.node);
 
+	hns3_dbg_register_debugfs(hns3_driver_name);
+
 	ret = hnae3_register_client(&client);
 	if (ret)
-		return ret;
+		goto err_reg_client;
 
 	ret = pci_register_driver(&hns3_driver);
 	if (ret)
-		hnae3_unregister_client(&client);
+		goto err_reg_driver;
 
 	return ret;
+
+err_reg_driver:
+	hnae3_unregister_client(&client);
+err_reg_client:
+	hns3_dbg_unregister_debugfs();
+	return ret;
 }
 module_init(hns3_init_module);
 
@@ -4265,6 +4277,7 @@ static void __exit hns3_exit_module(void)
 {
 	pci_unregister_driver(&hns3_driver);
 	hnae3_unregister_client(&client);
+	hns3_dbg_unregister_debugfs();
 }
 module_exit(hns3_exit_module);
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
index bbf227ba30f8..4e4b48ba78e3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.h
@@ -683,4 +683,8 @@ void hns3_dcbnl_setup(struct hnae3_handle *handle);
 static inline void hns3_dcbnl_setup(struct hnae3_handle *handle) {}
 #endif
 
+void hns3_dbg_init(struct hnae3_handle *handle);
+void hns3_dbg_uninit(struct hnae3_handle *handle);
+void hns3_dbg_register_debugfs(const char *debugfs_dir_name);
+void hns3_dbg_unregister_debugfs(void);
 #endif
-- 
2.17.1


