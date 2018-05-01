Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755507AbeEAJOG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 05:14:06 -0400
Received: from foss.arm.com ([217.140.101.70]:44266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754932AbeEAJL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 05:11:59 -0400
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, robert.walker@arm.com, mark.rutland@arm.com,
        will.deacon@arm.com, robin.murphy@arm.com, sudeep.holla@arm.com,
        frowand.list@gmail.com, robh@kernel.org, john.horley@arm.com,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v2 20/27] coresight: tmc: Add configuration support for trace buffer size
Date: Tue,  1 May 2018 10:10:50 +0100
Message-Id: <1525165857-11096-21-git-send-email-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
References: <1525165857-11096-1-git-send-email-suzuki.poulose@arm.com>
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
 drivers/hwtracing/coresight/coresight-tmc.c        | 33 ++++++++++++++++++++++
 2 files changed, 41 insertions(+)

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
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index c7bc681..4d41b4b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -288,8 +288,41 @@ static ssize_t trigger_cntr_store(struct device *dev,
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
