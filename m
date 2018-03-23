Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCWQLq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 12:11:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:39483 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbeCWQLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 12:11:44 -0400
X-Google-Smtp-Source: AG47ELtJs2Hl5lDxxsofHihEirb13Vd+pSu0EpEBcc+WiZWT3EL9EHDW0TyFa6GJyJ9JvwdYZG3L5Q==
From: Anup Patel <anup@brainfault.org>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2] rpmsg: Add driver_override device attribute for rpmsg_device
Date: Fri, 23 Mar 2018 21:41:17 +0530
Message-Id: <1521821477-31378-1-git-send-email-anup@brainfault.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds "driver_override" device attribute for rpmsg_device which
will allow users to explicitly specify the rpmsg_driver to be used via
sysfs entry.

The "driver_override" device attribute implemented here is very similar
to "driver_override" implemented for platform, pci, and amba bus types.

One important use-case of "driver_override" device attribute is to force
use of rpmsg_chrdev driver for certain rpmsg_device instances.

Signed-off-by: Anup Patel <anup@brainfault.org>

Changes since v1:
 - Removed un-related changes from patch
 - Renamed "path" to "member" in rpmsg_string_attr() macro
 - Used strcspn() instead of strchr() in rpmsg_string_attr() macro

---
 Documentation/ABI/testing/sysfs-bus-rpmsg | 20 ++++++++++++++++
 drivers/rpmsg/rpmsg_core.c                | 39 +++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-rpmsg b/Documentation/ABI/testing/sysfs-bus-rpmsg
index 189e419..1c8599e 100644
--- a/Documentation/ABI/testing/sysfs-bus-rpmsg
+++ b/Documentation/ABI/testing/sysfs-bus-rpmsg
@@ -73,3 +73,23 @@ Description:
 		This sysfs entry tells us whether the channel is a local
 		server channel that is announced (values are either
 		true or false).
+
+What:		/sys/bus/rpmsg/devices/.../driver_override
+Date:		March 2018
+KernelVersion:	4.17
+Contact:	Ohad Ben-Cohen <ohad@wizery.com>
+Description:
+		Every rpmsg device is a communication channel with a remote
+		processor. Channels are identified by a textual name (see
+		/sys/bus/rpmsg/devices/.../name above) and have a local
+		("source") rpmsg address, and remote ("destination") rpmsg
+		address.
+
+		The listening entity (or client) which communicates with a
+		remote processor is referred as rpmsg driver. The rpmsg device
+		and rpmsg driver are matched based on rpmsg device name and
+		rpmsg driver ID table.
+
+		This sysfs entry allows the rpmsg driver for a rpmsg device
+		to be specified which will override standard OF, ID table
+		and name matching.
diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 5a08176..3e71976 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -333,11 +333,49 @@ field##_show(struct device *dev,					\
 }									\
 static DEVICE_ATTR_RO(field);
 
+#define rpmsg_string_attr(field, member)				\
+static ssize_t								\
+field##_store(struct device *dev, struct device_attribute *attr,	\
+	      const char *buf, size_t sz)				\
+{									\
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
+	char *new, *old;						\
+									\
+	new = kstrndup(buf, sz, GFP_KERNEL);				\
+	if (!new)							\
+		return -ENOMEM;						\
+	new[strcspn(new, "\n")] = '\0';					\
+									\
+	device_lock(dev);						\
+	old = rpdev->member;						\
+	if (strlen(new)) {						\
+		rpdev->member = new;					\
+	} else {							\
+		kfree(new);						\
+		rpdev->member = NULL;					\
+	}								\
+	device_unlock(dev);						\
+									\
+	kfree(old);							\
+									\
+	return sz;							\
+}									\
+static ssize_t								\
+field##_show(struct device *dev,					\
+	     struct device_attribute *attr, char *buf)			\
+{									\
+	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
+									\
+	return sprintf(buf, "%s\n", rpdev->member);			\
+}									\
+static DEVICE_ATTR_RW(field)
+
 /* for more info, see Documentation/ABI/testing/sysfs-bus-rpmsg */
 rpmsg_show_attr(name, id.name, "%s\n");
 rpmsg_show_attr(src, src, "0x%x\n");
 rpmsg_show_attr(dst, dst, "0x%x\n");
 rpmsg_show_attr(announce, announce ? "true" : "false", "%s\n");
+rpmsg_string_attr(driver_override, driver_override);
 
 static ssize_t modalias_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
@@ -359,6 +397,7 @@ static struct attribute *rpmsg_dev_attrs[] = {
 	&dev_attr_dst.attr,
 	&dev_attr_src.attr,
 	&dev_attr_announce.attr,
+	&dev_attr_driver_override.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(rpmsg_dev);
-- 
2.7.4
