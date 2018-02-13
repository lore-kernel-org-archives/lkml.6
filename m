Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933223AbeBMBhb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 20:37:31 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36425 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933157AbeBMBh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 20:37:29 -0500
X-Google-Smtp-Source: AH8x225Nd4+nP4jOPaDb2rrEQCOEwDPOj+0S9SMXQIzxLO1uehv/3bLeJxpBogzjlzRF22mB83pdGA==
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>,
        Govind Singh <govinds@qti.qualcomm.com>,
        Shon Parate <sparate@qti.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] soc: qcom: rmtfs-mem: Add support for assigning memory to remote
Date: Mon, 12 Feb 2018 17:37:23 -0800
Message-Id: <20180213013724.3177-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platform the remote processor's memory map is not statically
configured in TrustZone, so each memory region that is to be accessed by
the remote needs a call into TrustZone to set up the remote's
permissions.

Implement this for the rmtfs memory driver, to give the modem on 8996
access to the shared file system buffers.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/soc/qcom/Kconfig     |  1 +
 drivers/soc/qcom/rmtfs_mem.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index e050eb83341d..a993d19fa562 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -47,6 +47,7 @@ config QCOM_QMI_HELPERS
 config QCOM_RMTFS_MEM
 	tristate "Qualcomm Remote Filesystem memory driver"
 	depends on ARCH_QCOM
+	select QCOM_SCM
 	help
 	  The Qualcomm remote filesystem memory driver is used for allocating
 	  and exposing regions of shared memory with remote processors for the
diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 0a43b2e8906f..c8999e38b005 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -37,6 +37,8 @@ struct qcom_rmtfs_mem {
 	phys_addr_t size;
 
 	unsigned int client_id;
+
+	unsigned int perms;
 };
 
 static ssize_t qcom_rmtfs_mem_show(struct device *dev,
@@ -151,9 +153,11 @@ static void qcom_rmtfs_mem_release_device(struct device *dev)
 static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
+	struct qcom_scm_vmperm perms[2];
 	struct reserved_mem *rmem;
 	struct qcom_rmtfs_mem *rmtfs_mem;
 	u32 client_id;
+	u32 vmid;
 	int ret;
 
 	rmem = of_reserved_mem_lookup(node);
@@ -204,10 +208,31 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 
 	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
 
+	ret = of_property_read_u32(node, "qcom,vmid", &vmid);
+	if (ret < 0 && ret != -EINVAL) {
+		dev_err(&pdev->dev, "failed to parse qcom,vmid\n");
+		goto remove_cdev;
+	} else if (!ret) {
+		perms[0].vmid = QCOM_SCM_VMID_HLOS;
+		perms[0].perm = QCOM_SCM_PERM_RW;
+		perms[1].vmid = vmid;
+		perms[1].perm = QCOM_SCM_PERM_RW;
+
+		rmtfs_mem->perms = BIT(QCOM_SCM_VMID_HLOS);
+		ret = qcom_scm_assign_mem(rmtfs_mem->addr, rmtfs_mem->size,
+					  &rmtfs_mem->perms, perms, 2);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "assign memory failed\n");
+			goto remove_cdev;
+		}
+	}
+
 	dev_set_drvdata(&pdev->dev, rmtfs_mem);
 
 	return 0;
 
+remove_cdev:
+	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
 put_device:
 	put_device(&rmtfs_mem->dev);
 
@@ -217,6 +242,15 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 static int qcom_rmtfs_mem_remove(struct platform_device *pdev)
 {
 	struct qcom_rmtfs_mem *rmtfs_mem = dev_get_drvdata(&pdev->dev);
+	struct qcom_scm_vmperm perm;
+
+	if (rmtfs_mem->perms) {
+		perm.vmid = QCOM_SCM_VMID_HLOS;
+		perm.perm = QCOM_SCM_PERM_RW;
+
+		qcom_scm_assign_mem(rmtfs_mem->addr, rmtfs_mem->size,
+				    &rmtfs_mem->perms, &perm, 1);
+	}
 
 	cdev_device_del(&rmtfs_mem->cdev, &rmtfs_mem->dev);
 	put_device(&rmtfs_mem->dev);
-- 
2.15.0
