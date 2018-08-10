Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CA2C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8861422426
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 23:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8861422426
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHKBj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 21:39:26 -0400
Received: from a2nlsmtp01-03.prod.iad2.secureserver.net ([198.71.225.37]:41764
        "EHLO a2nlsmtp01-03.prod.iad2.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727256AbeHKBjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 21:39:10 -0400
Received: from linuxonhyperv2.linuxonhyperv.com ([107.180.71.197])
        by : HOSTING RELAY : with SMTP
        id oGU0fTf0dVktnoGU0fMnYP; Fri, 10 Aug 2018 16:06:13 -0700
x-originating-ip: 107.180.71.197
Received: from kys by linuxonhyperv2.linuxonhyperv.com with local (Exim 4.91)
        (envelope-from <kys@linuxonhyperv2.linuxonhyperv.com>)
        id 1foGU0-0000Yw-Lk; Fri, 10 Aug 2018 16:06:12 -0700
From:   kys@linuxonhyperv.com
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
        jasowang@redhat.com, sthemmin@microsoft.com,
        Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "K . Y . Srinivasan" <kys@microsoft.com>
Subject: [PATCH 2/5] vmbus: add driver_override support
Date:   Fri, 10 Aug 2018 23:06:08 +0000
Message-Id: <20180810230611.2114-2-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180810230611.2114-1-kys@linuxonhyperv.com>
References: <20180810230520.2055-1-kys@linuxonhyperv.com>
 <20180810230611.2114-1-kys@linuxonhyperv.com>
Reply-To: kys@microsoft.com
X-CMAE-Envelope: MS4wfJoa6aczn8Ldip6hrc4e/xQA/Y7+7vNgEoJFvQg4SAZ5Xkh5xltOlLftHKO9658+oAHLVOvqfzfy6WaEzvmhnhGqFJUZkQ2sboACwjPknENkvA7RllVO
 O9gh+fOcJ5IrSyVQr2e4YXCP+EG/iND9tY+vOAfh56CLAEQ+JJf/s4SUuM/B9o8XWOAAfZ2wFJF8/ig8BGRvfLLqNv+5D13wslc2i2seoTU7hgCmYeO1dkl5
 KoM7NxGgzLYG3ZvOBpH5bNxS4Bg/wvuE6PThYlaFjo0Epc+Zw224aI//uLEN4SKN1Afp51s9dq25O2zbZsUzoLrqOfBR4cpDDdQJ0K0h5z8ysMn7fjYZ4ZTW
 33p6triS3cvKVLj3jumjm/QjLe8irpDW/dF1S3oMAFD+ygYG5FII2LSPxr6sT9IjGQSaHtc5xUNUFdYQDZYjaWkIdTkv34tU3tQPfpL2GraYqLvKmIRd3yAY
 c2ujXJ9xaLM4WPafegmgVoEbmKpidOJCMpkunaUVbB7bNosZQIa3unOMl8x13tICR2kaoiyQS5Q0XICu04N24ApXIsjhH6zaon6hYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <stephen@networkplumber.org>

Add support for overriding the default driver for a VMBus device
in the same way that it can be done for PCI devices. This patch
adds the /sys/bus/vmbus/devices/.../driver_override file
and the logic for matching.

This is used by driverctl tool to do driver override.
https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.com%2Fdriverctl%2Fdriverctl&amp;data=02%7C01%7Ckys%40microsoft.com%7C42e803feb2c544ef6ea908d5fd538878%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636693457619960040&amp;sdata=kEyYHRIjNZCk%2B37moCSqbrZL426YccNQrsWpENcrZdw%3D&amp;reserved=0

Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 Documentation/ABI/testing/sysfs-bus-vmbus |  21 ++++
 drivers/hv/vmbus_drv.c                    | 115 ++++++++++++++++++----
 include/linux/hyperv.h                    |   1 +
 3 files changed, 118 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-vmbus

diff --git a/Documentation/ABI/testing/sysfs-bus-vmbus b/Documentation/ABI/testing/sysfs-bus-vmbus
new file mode 100644
index 000000000000..91e6c065973c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-vmbus
@@ -0,0 +1,21 @@
+What:		/sys/bus/vmbus/devices/.../driver_override
+Date:		August 2019
+Contact:	Stephen Hemminger <sthemmin@microsoft.com>
+Description:
+		This file allows the driver for a device to be specified which
+		will override standard static and dynamic ID matching.  When
+		specified, only a driver with a name matching the value written
+		to driver_override will have an opportunity to bind to the
+		device.  The override is specified by writing a string to the
+		driver_override file (echo uio_hv_generic > driver_override) and
+		may be cleared with an empty string (echo > driver_override).
+		This returns the device to standard matching rules binding.
+		Writing to driver_override does not automatically unbind the
+		device from its current driver or make any attempt to
+		automatically load the specified driver.  If no driver with a
+		matching name is currently loaded in the kernel, the device
+		will not bind to any driver.  This also allows devices to
+		opt-out of driver binding using a driver_override name such as
+		"none".  Only a single driver may be specified in the override,
+		there is no support for parsing delimiters.
+
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b1b548a21f91..e6d8fdac6d8b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -498,6 +498,54 @@ static ssize_t device_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(device);
 
+static ssize_t driver_override_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+	char *driver_override, *old, *cp;
+
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
+		return -EINVAL;
+
+	driver_override = kstrndup(buf, count, GFP_KERNEL);
+	if (!driver_override)
+		return -ENOMEM;
+
+	cp = strchr(driver_override, '\n');
+	if (cp)
+		*cp = '\0';
+
+	device_lock(dev);
+	old = hv_dev->driver_override;
+	if (strlen(driver_override)) {
+		hv_dev->driver_override = driver_override;
+	} else {
+		kfree(driver_override);
+		hv_dev->driver_override = NULL;
+	}
+	device_unlock(dev);
+
+	kfree(old);
+
+	return count;
+}
+
+static ssize_t driver_override_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct hv_device *hv_dev = device_to_hv_device(dev);
+	ssize_t len;
+
+	device_lock(dev);
+	len = snprintf(buf, PAGE_SIZE, "%s\n", hv_dev->driver_override);
+	device_unlock(dev);
+
+	return len;
+}
+static DEVICE_ATTR_RW(driver_override);
+
 /* Set up per device attributes in /sys/bus/vmbus/devices/<bus device> */
 static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_id.attr,
@@ -528,6 +576,7 @@ static struct attribute *vmbus_dev_attrs[] = {
 	&dev_attr_channel_vp_mapping.attr,
 	&dev_attr_vendor.attr,
 	&dev_attr_device.attr,
+	&dev_attr_driver_override.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(vmbus_dev);
@@ -563,17 +612,26 @@ static inline bool is_null_guid(const uuid_le *guid)
 	return true;
 }
 
-/*
- * Return a matching hv_vmbus_device_id pointer.
- * If there is no match, return NULL.
- */
-static const struct hv_vmbus_device_id *hv_vmbus_get_id(struct hv_driver *drv,
-					const uuid_le *guid)
+static const struct hv_vmbus_device_id *
+hv_vmbus_dev_match(const struct hv_vmbus_device_id *id, const uuid_le *guid)
+
+{
+	if (id == NULL)
+		return NULL; /* empty device table */
+
+	for (; !is_null_guid(&id->guid); id++)
+		if (!uuid_le_cmp(id->guid, *guid))
+			return id;
+
+	return NULL;
+}
+
+static const struct hv_vmbus_device_id *
+hv_vmbus_dynid_match(struct hv_driver *drv, const uuid_le *guid)
 {
 	const struct hv_vmbus_device_id *id = NULL;
 	struct vmbus_dynid *dynid;
 
-	/* Look at the dynamic ids first, before the static ones */
 	spin_lock(&drv->dynids.lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
 		if (!uuid_le_cmp(dynid->id.guid, *guid)) {
@@ -583,18 +641,37 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(struct hv_driver *drv,
 	}
 	spin_unlock(&drv->dynids.lock);
 
-	if (id)
-		return id;
+	return id;
+}
 
-	id = drv->id_table;
-	if (id == NULL)
-		return NULL; /* empty device table */
+static const struct hv_vmbus_device_id vmbus_device_null = {
+	.guid = NULL_UUID_LE,
+};
 
-	for (; !is_null_guid(&id->guid); id++)
-		if (!uuid_le_cmp(id->guid, *guid))
-			return id;
+/*
+ * Return a matching hv_vmbus_device_id pointer.
+ * If there is no match, return NULL.
+ */
+static const struct hv_vmbus_device_id *hv_vmbus_get_id(struct hv_driver *drv,
+							struct hv_device *dev)
+{
+	const uuid_le *guid = &dev->dev_type;
+	const struct hv_vmbus_device_id *id;
 
-	return NULL;
+	/* When driver_override is set, only bind to the matching driver */
+	if (dev->driver_override && strcmp(dev->driver_override, drv->name))
+		return NULL;
+
+	/* Look at the dynamic ids first, before the static ones */
+	id = hv_vmbus_dynid_match(drv, guid);
+	if (!id)
+		id = hv_vmbus_dev_match(drv->id_table, guid);
+
+	/* driver_override will always match, send a dummy id */
+	if (!id && dev->driver_override)
+		id = &vmbus_device_null;
+
+	return id;
 }
 
 /* vmbus_add_dynid - add a new device ID to this driver and re-probe devices */
@@ -643,7 +720,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 	if (retval)
 		return retval;
 
-	if (hv_vmbus_get_id(drv, &guid))
+	if (hv_vmbus_dynid_match(drv, &guid))
 		return -EEXIST;
 
 	retval = vmbus_add_dynid(drv, &guid);
@@ -708,7 +785,7 @@ static int vmbus_match(struct device *device, struct device_driver *driver)
 	if (is_hvsock_channel(hv_dev->channel))
 		return drv->hvsock;
 
-	if (hv_vmbus_get_id(drv, &hv_dev->dev_type))
+	if (hv_vmbus_get_id(drv, hv_dev))
 		return 1;
 
 	return 0;
@@ -725,7 +802,7 @@ static int vmbus_probe(struct device *child_device)
 	struct hv_device *dev = device_to_hv_device(child_device);
 	const struct hv_vmbus_device_id *dev_id;
 
-	dev_id = hv_vmbus_get_id(drv, &dev->dev_type);
+	dev_id = hv_vmbus_get_id(drv, dev);
 	if (drv->probe) {
 		ret = drv->probe(dev, dev_id);
 		if (ret != 0)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index efda23cf32c7..2c3798bcb01c 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1125,6 +1125,7 @@ struct hv_device {
 	u16 device_id;
 
 	struct device device;
+	char *driver_override; /* Driver name to force a match */
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
-- 
2.18.0

