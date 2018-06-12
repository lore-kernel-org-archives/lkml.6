Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DB8C5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4E5208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4E5208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933797AbeFLK2n (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:28:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:34353 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754141AbeFLKW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:22:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 03:22:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,214,1526367600"; 
   d="scan'208";a="66321905"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2018 03:22:27 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v6 05/29] fpga: region: add compat_id support
Date:   Tue, 12 Jun 2018 18:10:19 +0800
Message-Id: <1528798243-2029-6-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a compat_id pointer member and sysfs interface
for each fpga region, similar as compat_id for fpga manager, it allows
applications to read the per region compat_id for compatibility
checking before other actions on this fpga-region (e.g PR).

Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v5: use pointer for compat_id as it's optional to implement.
v6: add Acked-by from Alan.
---
 Documentation/ABI/testing/sysfs-class-fpga-region |  9 +++++++++
 drivers/fpga/fpga-region.c                        | 22 ++++++++++++++++++++++
 include/linux/fpga/fpga-region.h                  |  2 ++
 3 files changed, 33 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-region

diff --git a/Documentation/ABI/testing/sysfs-class-fpga-region b/Documentation/ABI/testing/sysfs-class-fpga-region
new file mode 100644
index 0000000..ffdc853
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-fpga-region
@@ -0,0 +1,9 @@
+What:		/sys/class/fpga_region/<region>/compat_id
+Date:		June 2018
+KernelVersion:	4.18
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	FPGA region id for compatibility check, e.g compatibility
+		of the FPGA reconfiguration hardware and image. This value
+		is defined or calculated by the layer that is creating the
+		FPGA region. This interface returns the compat_id value or
+		just error code -ENOENT in case compat_id is not used.
diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
index 6d214d7..0d65220 100644
--- a/drivers/fpga/fpga-region.c
+++ b/drivers/fpga/fpga-region.c
@@ -158,6 +158,27 @@ int fpga_region_program_fpga(struct fpga_region *region)
 }
 EXPORT_SYMBOL_GPL(fpga_region_program_fpga);
 
+static ssize_t compat_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct fpga_region *region = to_fpga_region(dev);
+
+	if (!region->compat_id)
+		return -ENOENT;
+
+	return sprintf(buf, "%016llx%016llx\n",
+		       (unsigned long long)region->compat_id->id_h,
+		       (unsigned long long)region->compat_id->id_l);
+}
+
+static DEVICE_ATTR_RO(compat_id);
+
+static struct attribute *fpga_region_attrs[] = {
+	&dev_attr_compat_id.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(fpga_region);
+
 /**
  * fpga_region_create - alloc and init a struct fpga_region
  * @dev: device parent
@@ -258,6 +279,7 @@ static int __init fpga_region_init(void)
 	if (IS_ERR(fpga_region_class))
 		return PTR_ERR(fpga_region_class);
 
+	fpga_region_class->dev_groups = fpga_region_groups;
 	fpga_region_class->dev_release = fpga_region_dev_release;
 
 	return 0;
diff --git a/include/linux/fpga/fpga-region.h b/include/linux/fpga/fpga-region.h
index d7071cd..0521b7f 100644
--- a/include/linux/fpga/fpga-region.h
+++ b/include/linux/fpga/fpga-region.h
@@ -14,6 +14,7 @@
  * @bridge_list: list of FPGA bridges specified in region
  * @mgr: FPGA manager
  * @info: FPGA image info
+ * @compat_id: FPGA region id for compatibility check.
  * @priv: private data
  * @get_bridges: optional function to get bridges to a list
  */
@@ -23,6 +24,7 @@ struct fpga_region {
 	struct list_head bridge_list;
 	struct fpga_manager *mgr;
 	struct fpga_image_info *info;
+	struct fpga_compat_id *compat_id;
 	void *priv;
 	int (*get_bridges)(struct fpga_region *region);
 };
-- 
1.8.3.1

