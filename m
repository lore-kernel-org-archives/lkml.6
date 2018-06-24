Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1E8C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CA525319
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 21:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45CA525319
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeFXVMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 17:12:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:48385 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751575AbeFXVMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 17:12:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2018 14:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,267,1526367600"; 
   d="scan'208";a="51888194"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.43])
  by orsmga008.jf.intel.com with ESMTP; 24 Jun 2018 14:12:47 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 2/2] mei: expose fw version to sysfs
Date:   Mon, 25 Jun 2018 00:11:41 +0300
Message-Id: <20180624211141.7681-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180624211141.7681-1-tomas.winkler@intel.com>
References: <20180624211141.7681-1-tomas.winkler@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The ME FW version is constantly used by detection and update tools.
To improve the reliability and simplify these tools provide
a sysfs interface to access version of the platform ME firmware
in the following format:
<platform>:<major>.<minor>.<milestone>.<build>.
There can be up to three such blocks for different FW components.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 Documentation/ABI/testing/sysfs-class-mei | 11 ++++
 drivers/misc/mei/bus-fixup.c              | 86 ++++++++++++++++++++++++++++---
 drivers/misc/mei/main.c                   | 30 ++++++++++-
 drivers/misc/mei/mei_dev.h                | 25 ++++++++-
 4 files changed, 144 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-mei b/Documentation/ABI/testing/sysfs-class-mei
index 81ff6abf9673..17d7444a2397 100644
--- a/Documentation/ABI/testing/sysfs-class-mei
+++ b/Documentation/ABI/testing/sysfs-class-mei
@@ -54,3 +54,14 @@ Description:	Configure tx queue limit
 
 		Set maximal number of pending writes
 		per opened session.
+
+What:		/sys/class/mei/meiN/fw_ver
+Date:		May 2018
+KernelVersion:	4.18
+Contact:	Tomas Winkler <tomas.winkler@intel.com>
+Description:	Display the ME firmware version.
+
+		The version of the platform ME firmware is in format:
+		<platform>:<major>.<minor>.<milestone>.<build_no>.
+		There can be up to three such blocks for different
+		FW components.
diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index b17c46a43812..e45fe826d87d 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -1,7 +1,7 @@
 /*
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2013, Intel Corporation.
+ * Copyright (c) 2003-2018, Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -96,8 +96,22 @@ struct mkhi_fwcaps {
 	u8 data[0];
 } __packed;
 
+struct mkhi_fw_ver_block {
+	u16 minor;
+	u8 major;
+	u8 platform;
+	u16 buildno;
+	u16 hotfix;
+} __packed;
+
+struct mkhi_fw_ver {
+	struct mkhi_fw_ver_block ver[MEI_MAX_FW_VER_BLOCKS];
+} __packed;
+
 #define MKHI_FWCAPS_GROUP_ID 0x3
 #define MKHI_FWCAPS_SET_OS_VER_APP_RULE_CMD 6
+#define MKHI_GEN_GROUP_ID 0xFF
+#define MKHI_GEN_GET_FW_VERSION_CMD 0x2
 struct mkhi_msg_hdr {
 	u8  group_id;
 	u8  command;
@@ -139,21 +153,81 @@ static int mei_osver(struct mei_cl_device *cldev)
 	return __mei_cl_send(cldev->cl, buf, size, mode);
 }
 
+#define MKHI_FWVER_BUF_LEN (sizeof(struct mkhi_msg_hdr) + \
+			    sizeof(struct mkhi_fw_ver))
+#define MKHI_FWVER_LEN(__num) (sizeof(struct mkhi_msg_hdr) + \
+			       sizeof(struct mkhi_fw_ver_block) * (__num))
+#define MKHI_RCV_TIMEOUT 500 /* receive timeout in msec */
+static int mei_fwver(struct mei_cl_device *cldev)
+{
+	char buf[MKHI_FWVER_BUF_LEN];
+	struct mkhi_msg *req;
+	struct mkhi_fw_ver *fwver;
+	int bytes_recv, ret, i;
+
+	memset(buf, 0, sizeof(buf));
+
+	req = (struct mkhi_msg *)buf;
+	req->hdr.group_id = MKHI_GEN_GROUP_ID;
+	req->hdr.command = MKHI_GEN_GET_FW_VERSION_CMD;
+
+	ret = __mei_cl_send(cldev->cl, buf, sizeof(struct mkhi_msg_hdr),
+			    MEI_CL_IO_TX_BLOCKING);
+	if (ret < 0) {
+		dev_err(&cldev->dev, "Could not send ReqFWVersion cmd\n");
+		return ret;
+	}
+
+	ret = 0;
+	bytes_recv = __mei_cl_recv(cldev->cl, buf, sizeof(buf), 0,
+				   MKHI_RCV_TIMEOUT);
+	if (bytes_recv < MKHI_FWVER_LEN(1)) {
+		/*
+		 * Should be at least one version block,
+		 * error out if nothing found
+		 */
+		dev_err(&cldev->dev, "Could not read FW version\n");
+		return -EIO;
+	}
+
+	fwver = (struct mkhi_fw_ver *)req->data;
+	memset(cldev->bus->fw_ver, 0, sizeof(cldev->bus->fw_ver));
+	for (i = 0; i < MEI_MAX_FW_VER_BLOCKS; i++) {
+		if (bytes_recv < MKHI_FWVER_LEN(i + 1))
+			break;
+		dev_dbg(&cldev->dev, "FW version%d %d:%d.%d.%d.%d\n",
+			i, fwver->ver[i].platform,
+			fwver->ver[i].major, fwver->ver[i].minor,
+			fwver->ver[i].hotfix, fwver->ver[i].buildno);
+
+		cldev->bus->fw_ver[i].platform = fwver->ver[i].platform;
+		cldev->bus->fw_ver[i].major = fwver->ver[i].major;
+		cldev->bus->fw_ver[i].minor = fwver->ver[i].minor;
+		cldev->bus->fw_ver[i].hotfix = fwver->ver[i].hotfix;
+		cldev->bus->fw_ver[i].buildno = fwver->ver[i].buildno;
+	}
+
+	return ret;
+}
+
 static void mei_mkhi_fix(struct mei_cl_device *cldev)
 {
 	int ret;
 
-	if (!cldev->bus->hbm_f_os_supported)
-		return;
-
 	ret = mei_cldev_enable(cldev);
 	if (ret)
 		return;
 
-	ret = mei_osver(cldev);
+	ret = mei_fwver(cldev);
 	if (ret < 0)
-		dev_err(&cldev->dev, "OS version command failed %d\n", ret);
+		dev_err(&cldev->dev, "FW version command failed %d\n", ret);
 
+	if (cldev->bus->hbm_f_os_supported) {
+		ret = mei_osver(cldev);
+		if (ret < 0)
+			dev_err(&cldev->dev, "OS version command failed %d\n",
+				ret);
+	}
 	mei_cldev_disable(cldev);
 }
 
diff --git a/drivers/misc/mei/main.c b/drivers/misc/mei/main.c
index 7465f17e1559..f690918f7817 100644
--- a/drivers/misc/mei/main.c
+++ b/drivers/misc/mei/main.c
@@ -1,7 +1,7 @@
 /*
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
+ * Copyright (c) 2003-2018, Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -812,11 +812,39 @@ static ssize_t tx_queue_limit_store(struct device *device,
 }
 static DEVICE_ATTR_RW(tx_queue_limit);
 
+/**
+ * fw_ver_show - display ME FW version
+ *
+ * @device: device pointer
+ * @attr: attribute pointer
+ * @buf:  char out buffer
+ *
+ * Return: number of the bytes printed into buf or error
+ */
+static ssize_t fw_ver_show(struct device *device,
+			   struct device_attribute *attr, char *buf)
+{
+	struct mei_device *dev = dev_get_drvdata(device);
+	struct mei_fw_version *ver;
+	ssize_t cnt = 0;
+	int i;
+
+	ver = dev->fw_ver;
+
+	for (i = 0; i < MEI_MAX_FW_VER_BLOCKS; i++)
+		cnt += scnprintf(buf + cnt, PAGE_SIZE - cnt, "%u:%u.%u.%u.%u\n",
+				 ver[i].platform, ver[i].major, ver[i].minor,
+				 ver[i].hotfix, ver[i].buildno);
+	return cnt;
+}
+static DEVICE_ATTR_RO(fw_ver);
+
 static struct attribute *mei_attrs[] = {
 	&dev_attr_fw_status.attr,
 	&dev_attr_hbm_ver.attr,
 	&dev_attr_hbm_ver_drv.attr,
 	&dev_attr_tx_queue_limit.attr,
+	&dev_attr_fw_ver.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(mei);
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index 4058ab5ad2d8..d522585b71b7 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -1,7 +1,7 @@
 /*
  *
  * Intel Management Engine Interface (Intel MEI) Linux driver
- * Copyright (c) 2003-2012, Intel Corporation.
+ * Copyright (c) 2003-2018, Intel Corporation.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -354,6 +354,25 @@ enum mei_pg_state {
 
 const char *mei_pg_state_str(enum mei_pg_state state);
 
+/**
+ * struct mei_fw_version - MEI FW version struct
+ *
+ * @platform: platform identifier
+ * @major: major version field
+ * @minor: minor version field
+ * @buildno: build number version field
+ * @hotfix: hotfix number version field
+ */
+struct mei_fw_version {
+	u8 platform;
+	u8 major;
+	u16 minor;
+	u16 buildno;
+	u16 hotfix;
+};
+
+#define MEI_MAX_FW_VER_BLOCKS 3
+
 /**
  * struct mei_device -  MEI private device struct
  *
@@ -402,6 +421,8 @@ const char *mei_pg_state_str(enum mei_pg_state state);
  * @hbm_f_ie_supported  : hbm feature immediate reply to enum request
  * @hbm_f_os_supported  : hbm feature support OS ver message
  *
+ * @fw_ver : FW versions
+ *
  * @me_clients_rwsem: rw lock over me_clients list
  * @me_clients  : list of FW clients
  * @me_clients_map : FW clients bit map
@@ -478,6 +499,8 @@ struct mei_device {
 	unsigned int hbm_f_ie_supported:1;
 	unsigned int hbm_f_os_supported:1;
 
+	struct mei_fw_version fw_ver[MEI_MAX_FW_VER_BLOCKS];
+
 	struct rw_semaphore me_clients_rwsem;
 	struct list_head me_clients;
 	DECLARE_BITMAP(me_clients_map, MEI_CLIENTS_MAX);
-- 
2.14.4

