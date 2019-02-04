Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DF1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0519F2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 14:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="U3jVRJwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfBDOYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 09:24:18 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:59458 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729482AbfBDOYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 09:24:16 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x14ENOPh092268;
        Mon, 4 Feb 2019 08:23:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549290204;
        bh=aQQh5mbN3Lm2NCwZgplMn107Oi639JI6b5ee5DbdFuI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=U3jVRJwyg5DOyhgPfHbzhqR0x24ka/c+XccYQDDH1ZMwTz14KDpuM8GOV1eXl/HIB
         f8AshPjRg4SgG9mM9lsTb3UpsxTgtHw7k7CFW05GVsLUM2YxMHrfUM4ia1nETrW7GS
         D3T9qUgehN8HAEwaccejfHnxJaFEvHzi9h5vAjn0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x14ENOKA069032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 4 Feb 2019 08:23:24 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 4
 Feb 2019 08:23:23 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 4 Feb 2019 08:23:23 -0600
Received: from localhost.localdomain (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x14EMoKf012232;
        Mon, 4 Feb 2019 08:23:20 -0600
From:   Roger Quadros <rogerq@ti.com>
To:     <tony@atomide.com>, <ohad@wizery.com>, <bjorn.andersson@linaro.org>
CC:     <s-anna@ti.com>, <david@lechnology.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <rogerq@ti.com>
Subject: [PATCH v2 07/14] remoteproc: Add a rproc_set_firmware() API
Date:   Mon, 4 Feb 2019 16:22:40 +0200
Message-ID: <1549290167-876-8-git-send-email-rogerq@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549290167-876-1-git-send-email-rogerq@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

A new API, rproc_set_firmware() is added to allow the remoteproc platform
drivers and remoteproc client drivers to be able to configure a custom
firmware name that is different from the default name used during
remoteproc registration. This function is being introduced to provide
a kernel-level equivalent of the current sysfs interface to remoteproc
client drivers. This allows some remoteproc drivers to choose different
firmwares at runtime when the remote processor is not running based on
the functional feature it is providing using that remote processor.
The TI PRU Ethernet driver will be an example of such usage as it
requires to use different firmwares for different supported protocols.

Also, update the firmware_store() function used by the sysfs interface
to reuse this function to avoid code duplication.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/remoteproc/remoteproc_core.c  | 61 +++++++++++++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_sysfs.c | 33 ++-----------------
 include/linux/remoteproc.h            |  1 +
 3 files changed, 64 insertions(+), 31 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 06ef4fa..2d9646f 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -2149,6 +2149,67 @@ void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type)
 }
 EXPORT_SYMBOL(rproc_report_crash);
 
+/**
+ * rproc_set_firmware() - assign a new firmware
+ * @rproc: rproc handle to which the new firmware is being assigned
+ * @fw_name: new firmware name to be assigned
+ *
+ * This function allows remoteproc drivers or clients to configure a custom
+ * firmware name that is different from the default name used during remoteproc
+ * registration. The function does not trigger a remote processor boot,
+ * only sets the firmware name used for a subsequent boot. This function
+ * should also be called only when the remote processor is offline.
+ *
+ * This allows either the userspace to configure a different name through
+ * sysfs or a kernel-level remoteproc or a remoteproc client driver to set
+ * a specific firmware when it is controlling the boot and shutdown of the
+ * remote processor.
+ *
+ * Returns 0 on success or a negative value upon failure
+ */
+int rproc_set_firmware(struct rproc *rproc, const char *fw_name)
+{
+	struct device *dev = rproc->dev.parent;
+	int ret, len;
+	char *p;
+
+	if (!rproc || !fw_name)
+		return -EINVAL;
+
+	ret = mutex_lock_interruptible(&rproc->lock);
+	if (ret) {
+		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, ret);
+		return -EINVAL;
+	}
+
+	if (rproc->state != RPROC_OFFLINE) {
+		dev_err(dev, "can't change firmware while running\n");
+		ret = -EBUSY;
+		goto out;
+	}
+
+	len = strcspn(fw_name, "\n");
+	if (!len) {
+		dev_err(dev, "empty firmware name string\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	p = kstrndup(fw_name, len, GFP_KERNEL);
+	if (!p) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	kfree(rproc->firmware);
+	rproc->firmware = p;
+
+out:
+	mutex_unlock(&rproc->lock);
+	return ret;
+}
+EXPORT_SYMBOL(rproc_set_firmware);
+
 static int __init remoteproc_init(void)
 {
 	rproc_init_sysfs();
diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 3a4c3d7..6cf04a7 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -32,38 +32,9 @@ static ssize_t firmware_store(struct device *dev,
 			      const char *buf, size_t count)
 {
 	struct rproc *rproc = to_rproc(dev);
-	char *p;
-	int err, len = count;
+	int err;
 
-	err = mutex_lock_interruptible(&rproc->lock);
-	if (err) {
-		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, err);
-		return -EINVAL;
-	}
-
-	if (rproc->state != RPROC_OFFLINE) {
-		dev_err(dev, "can't change firmware while running\n");
-		err = -EBUSY;
-		goto out;
-	}
-
-	len = strcspn(buf, "\n");
-	if (!len) {
-		dev_err(dev, "can't provide a NULL firmware\n");
-		err = -EINVAL;
-		goto out;
-	}
-
-	p = kstrndup(buf, len, GFP_KERNEL);
-	if (!p) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	kfree(rproc->firmware);
-	rproc->firmware = p;
-out:
-	mutex_unlock(&rproc->lock);
+	err = rproc_set_firmware(rproc, buf);
 
 	return err ? err : count;
 }
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e908b58..b5aa5fb 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -590,6 +590,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, int len,
 
 int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
+int rproc_set_firmware(struct rproc *rproc, const char *fw_name);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 int rproc_coredump_add_segment(struct rproc *rproc, dma_addr_t da, size_t size);
 int rproc_coredump_add_custom_segment(struct rproc *rproc,
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

