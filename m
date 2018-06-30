Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CD8C6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B507280E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 01:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B507280E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965687AbeF3BGn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 21:06:43 -0400
Received: from mga01.intel.com ([192.55.52.88]:57850 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932781AbeF3BGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 21:06:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 18:06:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,288,1526367600"; 
   d="scan'208";a="212317351"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2018 18:06:25 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com,
        Tim Whisonant <tim.whisonant@intel.com>,
        Enno Luebbers <enno.luebbers@intel.com>,
        Shiva Rao <shiva.rao@intel.com>,
        Christopher Rauer <christopher.rauer@intel.com>,
        Xiao Guangrong <guangrong.xiao@linux.intel.com>
Subject: [PATCH v7 15/29] fpga: dfl: fme: add header sub feature support
Date:   Sat, 30 Jun 2018 08:53:22 +0800
Message-Id: <1530320016-24712-16-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
References: <1530320016-24712-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kang Luwei <luwei.kang@intel.com>

The Header Register set is always present for FPGA Management Engine (FME),
this patch implements init and uinit function for header sub feature and
introduces several read-only sysfs interfaces for the capability and
status.

Sysfs interfaces:
* /sys/class/fpga_region/<regionX>/<dfl-fme.x>/ports_num
  Read-only. Number of ports implemented

* /sys/class/fpga_region/<regionX>/<dfl-fme.x>/bitstream_id
  Read-only. Bitstream (static FPGA region) identifier number. It contains
  the detailed version and other information of this static FPGA region.

* /sys/class/fpga_region/<regionX>/<dfl-fme.x>/bitstream_metadata
  Read-only. Bitstream (static FPGA region) meta data. It contains the
  synthesis date, seed and other information of this static FPGA region.

Signed-off-by: Tim Whisonant <tim.whisonant@intel.com>
Signed-off-by: Enno Luebbers <enno.luebbers@intel.com>
Signed-off-by: Shiva Rao <shiva.rao@intel.com>
Signed-off-by: Christopher Rauer <christopher.rauer@intel.com>
Signed-off-by: Kang Luwei <luwei.kang@intel.com>
Signed-off-by: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v2: add sysfs documentation
v3: rename driver to fpga-dfl-fme.
    improve sysfs doc and commit description.
    replace bitfield.
v4: rebase and switch to use id for sub feature matching.
    add more description for bitstream_id/metadata.
v5: rebase due to DFL framework API naming changes.
    replace "blue bitstream" terminology.
    fix one typo in sysfs doc and add acked-by from Alan.
v6: reabse
v7: update kernelversion in sysfs doc.
---
 Documentation/ABI/testing/sysfs-platform-dfl-fme | 23 ++++++++
 drivers/fpga/dfl-fme-main.c                      | 68 ++++++++++++++++++++++++
 2 files changed, 91 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-dfl-fme

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
new file mode 100644
index 0000000..8fa4feb
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -0,0 +1,23 @@
+What:		/sys/bus/platform/devices/dfl-fme.0/ports_num
+Date:		June 2018
+KernelVersion:  4.19
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. One DFL FPGA device may have more than 1
+		port/Accelerator Function Unit (AFU). It returns the
+		number of ports on the FPGA device when read it.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/bitstream_id
+Date:		June 2018
+KernelVersion:  4.19
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns Bitstream (static FPGA region)
+		identifier number, which includes the detailed version
+		and other information of this static FPGA region.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/bitstream_metadata
+Date:		June 2018
+KernelVersion:  4.19
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns Bitstream (static FPGA region) meta
+		data, which includes the synthesis date, seed and other
+		information of this static FPGA region.
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index bdcfe95..c23c56f 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -19,10 +19,77 @@
 
 #include "dfl.h"
 
+static ssize_t ports_num_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_CAP);
+
+	return scnprintf(buf, PAGE_SIZE, "%u\n",
+			 (unsigned int)FIELD_GET(FME_CAP_NUM_PORTS, v));
+}
+static DEVICE_ATTR_RO(ports_num);
+
+/*
+ * Bitstream (static FPGA region) identifier number. It contains the
+ * detailed version and other information of this static FPGA region.
+ */
+static ssize_t bitstream_id_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_BITSTREAM_ID);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
+}
+static DEVICE_ATTR_RO(bitstream_id);
+
+/*
+ * Bitstream (static FPGA region) meta data. It contains the synthesis
+ * date, seed and other information of this static FPGA region.
+ */
+static ssize_t bitstream_metadata_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_BITSTREAM_MD);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", (unsigned long long)v);
+}
+static DEVICE_ATTR_RO(bitstream_metadata);
+
+static const struct attribute *fme_hdr_attrs[] = {
+	&dev_attr_ports_num.attr,
+	&dev_attr_bitstream_id.attr,
+	&dev_attr_bitstream_metadata.attr,
+	NULL,
+};
+
 static int fme_hdr_init(struct platform_device *pdev,
 			struct dfl_feature *feature)
 {
+	void __iomem *base = feature->ioaddr;
+	int ret;
+
 	dev_dbg(&pdev->dev, "FME HDR Init.\n");
+	dev_dbg(&pdev->dev, "FME cap %llx.\n",
+		(unsigned long long)readq(base + FME_HDR_CAP));
+
+	ret = sysfs_create_files(&pdev->dev.kobj, fme_hdr_attrs);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -31,6 +98,7 @@ static void fme_hdr_uinit(struct platform_device *pdev,
 			  struct dfl_feature *feature)
 {
 	dev_dbg(&pdev->dev, "FME HDR UInit.\n");
+	sysfs_remove_files(&pdev->dev.kobj, fme_hdr_attrs);
 }
 
 static const struct dfl_feature_ops fme_hdr_ops = {
-- 
1.8.3.1

