Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA8F2087A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 08:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cfYfgeZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA8F2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeIYOKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 10:10:03 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35554 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbeIYOKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 10:10:02 -0400
Received: by mail-pf1-f194.google.com with SMTP id p12-v6so10679709pfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 01:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+KON09110A72XVzaovlJFvPoSYpVq29B6AgkhSw+3bo=;
        b=cfYfgeZlLyBsPgO8ZzyNen8N1VnWy0XPLpfqhtm7hHYJM41kS6BMb6hA6SU2kdzaeH
         zt1SOqOIaurxwQDRht5kIU0d4LAn80hkUbiW23snu6wSIPlm9QlfcY8h6s/DrWMpffnq
         4VdIztRuyOmNFZAhXPLZ9zb/SVfbetMkfvvMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+KON09110A72XVzaovlJFvPoSYpVq29B6AgkhSw+3bo=;
        b=QnmovTf3S3lfXV3hJq2K4hHcQSsIF7AwpuaAvol3dcTtevfjG2hPYzKM1aLQX6zeFF
         pBaYARs+Qd3oKivmKkSQN+gruhJTUCk6dY5MrK5tqH6jkm3w3akbSaivx02KvxThENF9
         /ZwD5Uq64xb9h51CgRs4tcbt7DWXWcfN3+0PjlcEZbSAeapPN6NaGHscU8gOSksLD2aN
         Vch1/d0Zuy1ce2tNBKEb5h0UtIpTh06aEtOVqfH0R0E/kUnJp3vBVC75ZvYuZJ95hHua
         45TTCdh8c99/DsdbrzFjm1gCPwCMiX/sr4yzCrO3h+kNVdhuUdYlrZ4T5eF6693i7aJE
         i4dw==
X-Gm-Message-State: ABuFfoh5C3EngCt4RpsxokEiDmFnqZyCHOpdISlUzD0OSHMbyd8kgm2S
        F3XojSTy4OrM0wew20onsR2OpQ==
X-Google-Smtp-Source: ACcGV63seL4HnydVSA7IcGSghDmvV9ypk3nisxfNY1b++geCeb5Euq708aR8ot3POzzE5U0MN5XJAQ==
X-Received: by 2002:a17:902:bf46:: with SMTP id u6-v6mr2419099pls.105.1537862622010;
        Tue, 25 Sep 2018 01:03:42 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x4-v6sm1879646pfm.119.2018.09.25.01.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 01:03:41 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [RFC PATCH] soc: qcom: rmtfs_mem: Control remoteproc from rmtfs_mem
Date:   Tue, 25 Sep 2018 01:06:07 -0700
Message-Id: <20180925080607.30565-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rmtfs_mem provides access to physical storage and is crucial for the
operation of the Qualcomm modem subsystem.

The rmtfs_mem implementation must be available before the modem
subsystem is booted and a solution where the modem remoteproc will
verify that the rmtfs_mem is available has been discussed in the past.
But this would not handle the case where the rmtfs_mem provider is
restarted, which would cause fatal loss of access to the storage device
for the modem.

The suggestion is therefor to link the rmtfs_mem to its associated
remote processor instance and control it based on the availability of
the rmtfs_mem implementation.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

The currently implemented workaround in the Linaro QCOMLT releases is to
blacklist the qcom_q6v5_pil kernel module and load this explicitly after rmtfs
has been started.

With this patch the modem module can be loaded automatically by the
platform_bus and will only be booted as the rmtfs becomes available. Performing
actions such as upgrading (and restarting) the rmtfs service will cause the
modem to automatically restart and hence continue to function after the
upgrade.

 .../reserved-memory/qcom,rmtfs-mem.txt        |  7 ++++++
 drivers/remoteproc/qcom_q6v5_pil.c            |  1 +
 drivers/soc/qcom/Kconfig                      |  1 +
 drivers/soc/qcom/rmtfs_mem.c                  | 23 ++++++++++++++++++-
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
index 8562ba1dce69..95b209e7f5d1 100644
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.txt
@@ -32,6 +32,13 @@ access block device data using the Remote Filesystem protocol.
 	Value type: <u32>
 	Definition: vmid of the remote processor, to set up memory protection.
 
+- rproc:
+	Usage: optional
+	Value type: <phandle>
+	Definition: reference to a remoteproc node, that should be powered up
+		    while the remote file system memory instance is ready to
+		    handle requests from the remote subsystem.
+
 = EXAMPLE
 The following example shows the remote filesystem memory setup for APQ8016,
 with the rmtfs region for the Hexagon DSP (id #1) located at 0x86700000.
diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index d7a4b9eca5d2..1445a38e8b34 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -1142,6 +1142,7 @@ static int q6v5_probe(struct platform_device *pdev)
 	qproc = (struct q6v5 *)rproc->priv;
 	qproc->dev = &pdev->dev;
 	qproc->rproc = rproc;
+	rproc->auto_boot = false;
 	platform_set_drvdata(pdev, qproc);
 
 	ret = q6v5_init_mem(qproc, pdev);
diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 01fb6aba61d2..1109272479b9 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -88,6 +88,7 @@ config QCOM_QMI_HELPERS
 config QCOM_RMTFS_MEM
 	tristate "Qualcomm Remote Filesystem memory driver"
 	depends on ARCH_QCOM
+	depends on REMOTEPROC
 	select QCOM_SCM
 	help
 	  The Qualcomm remote filesystem memory driver is used for allocating
diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 8a3678c2e83c..8b08be310397 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -18,6 +18,7 @@
 #include <linux/platform_device.h>
 #include <linux/of.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/remoteproc.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -39,6 +40,8 @@ struct qcom_rmtfs_mem {
 	unsigned int client_id;
 
 	unsigned int perms;
+
+	struct rproc *rproc;
 };
 
 static ssize_t qcom_rmtfs_mem_show(struct device *dev,
@@ -80,11 +83,18 @@ static int qcom_rmtfs_mem_open(struct inode *inode, struct file *filp)
 	struct qcom_rmtfs_mem *rmtfs_mem = container_of(inode->i_cdev,
 							struct qcom_rmtfs_mem,
 							cdev);
+	int ret = 0;
 
 	get_device(&rmtfs_mem->dev);
 	filp->private_data = rmtfs_mem;
 
-	return 0;
+	if (rmtfs_mem->rproc) {
+		ret = rproc_boot(rmtfs_mem->rproc);
+		if (ret)
+			put_device(&rmtfs_mem->dev);
+	}
+
+	return ret;
 }
 static ssize_t qcom_rmtfs_mem_read(struct file *filp,
 			      char __user *buf, size_t count, loff_t *f_pos)
@@ -127,6 +137,9 @@ static int qcom_rmtfs_mem_release(struct inode *inode, struct file *filp)
 {
 	struct qcom_rmtfs_mem *rmtfs_mem = filp->private_data;
 
+	if (rmtfs_mem->rproc)
+		rproc_shutdown(rmtfs_mem->rproc);
+
 	put_device(&rmtfs_mem->dev);
 
 	return 0;
@@ -156,6 +169,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 	struct qcom_scm_vmperm perms[2];
 	struct reserved_mem *rmem;
 	struct qcom_rmtfs_mem *rmtfs_mem;
+	phandle rproc_phandle;
 	u32 client_id;
 	u32 vmid;
 	int ret;
@@ -181,6 +195,13 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 	rmtfs_mem->client_id = client_id;
 	rmtfs_mem->size = rmem->size;
 
+	ret = of_property_read_u32(node, "rproc", &rproc_phandle);
+	if (!ret) {
+		rmtfs_mem->rproc = rproc_get_by_phandle(rproc_phandle);
+		if (!rmtfs_mem->rproc)
+			return -EPROBE_DEFER;
+	}
+
 	device_initialize(&rmtfs_mem->dev);
 	rmtfs_mem->dev.parent = &pdev->dev;
 	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
-- 
2.18.0

