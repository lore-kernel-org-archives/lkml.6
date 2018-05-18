Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeERQkD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:40:03 -0400
Received: from foss.arm.com ([217.140.101.70]:56176 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751744AbeERQj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:39:57 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        robh@kernel.org, sudeep.holla@arm.com, frowand.list@gmail.com,
        coresight@lists.linaro.org, mark.rutland@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH 11/11] coresight: tmc: Add configuration support for trace buffer size
Date: Fri, 18 May 2018 17:39:27 +0100
Message-Id: <1526661567-4578-12-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
References: <1526661567-4578-1-git-send-email-suzuki.poulose@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can dynamically switch between contiguous memory and
SG table depending on the trace buffer size, provide the support
for selecting an appropriate buffer size.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |  8 ++++++
 .../devicetree/bindings/arm/coresight.txt          |  3 +-
 drivers/hwtracing/coresight/coresight-tmc.c        | 33 ++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index 4fe677e..ea78714 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -83,3 +83,11 @@ KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(R) Indicates the capabilities of the Coresight TMC.
 		The value is read directly from the DEVID register, 0xFC8,
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/buffer_size
+Date:		August 2018
+KernelVersion:	4.18
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(RW) Size of the trace buffer for TMC-ETR when used in SYSFS
+		mode. Writable only for TMC-ETR configurations. The value
+		should be aligned to the kernel pagesize.
diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 603d3c6..9aa30a1 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -84,7 +84,8 @@ its hardware characteristcs.
 * Optional property for TMC:
 
 	* arm,buffer-size: size of contiguous buffer space for TMC ETR
-	 (embedded trace router)
+	  (embedded trace router). This property is obsolete. The buffer size
+	  can be configured dynamically via buffer_size property in sysfs.
 
 	* arm,scatter-gather: boolean. Indicates that the TMC-ETR can safely
 	  use the SG mode on this system.
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 7d8331d..57b6621 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -285,8 +285,41 @@ static ssize_t trigger_cntr_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(trigger_cntr);
 
+static ssize_t buffer_size_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sprintf(buf, "%#x\n", drvdata->size);
+}
+
+static ssize_t buffer_size_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	int ret;
+	unsigned long val;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	/* Only permitted for TMC-ETRs */
+	if (drvdata->config_type != TMC_CONFIG_TYPE_ETR)
+		return -EPERM;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+	/* The buffer size should be page aligned */
+	if (val & (PAGE_SIZE - 1))
+		return -EINVAL;
+	drvdata->size = val;
+	return size;
+}
+
+static DEVICE_ATTR_RW(buffer_size);
+
 static struct attribute *coresight_tmc_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
+	&dev_attr_buffer_size.attr,
 	NULL,
 };
 
-- 
2.7.4
