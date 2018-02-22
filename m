Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752517AbeBVGWJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 01:22:09 -0500
Received: from mga05.intel.com ([192.55.52.43]:13644 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752439AbeBVGWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 01:22:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,377,1515484800";
   d="scan'208";a="206038885"
From: Haiyue Wang <haiyue.wang@linux.intel.com>
To: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: [PATCH ipmi/kcs_bmc v4] ipmi: kcs_bmc: make the code be more clean
Date: Thu, 22 Feb 2018 14:23:06 +0800
Message-Id: <1519280586-3380-1-git-send-email-haiyue.wang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify the file read and write operation API's parameter declaration to
meet the name convention.

Rename the helper function by following the to_<xxx>() name style.

Update the poll API with the new type '__poll_t', this is new commit from
linux-4.16-rc1.

Correct the header file's comment style for 'SPDX-License-Identifier'.

Correct the header file's macro defination end comment which is old file
name.

Remove the space between the comment words and colon by referring other
modules.

Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
v3 -> v4:
 - Correct the header file's macro defination end comment which is old
   file name, I forgot to change it after changing the file name.
 - Remove the space between the comment words and colon by referring
   other modules.

v2 -> v3:
 - Make the commit message be more understandable.

v1 -> v2:
 - Add 'SPDX-License-Identifier' style for header files modification.
---
 drivers/char/ipmi/kcs_bmc.c        | 32 +++++++++++++++++---------------
 drivers/char/ipmi/kcs_bmc.h        | 36 +++++++++++++++++++-----------------
 drivers/char/ipmi/kcs_bmc_aspeed.c |  4 +++-
 include/uapi/linux/ipmi_bmc.h      |  8 +++++---
 4 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 6476bfb..fbfc05e 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2015-2018, Intel Corporation.
+/*
+ * Copyright (c) 2015-2018, Intel Corporation.
+ */
 
 #define pr_fmt(fmt) "kcs-bmc: " fmt
 
@@ -242,14 +244,14 @@ int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
 }
 EXPORT_SYMBOL(kcs_bmc_handle_event);
 
-static inline struct kcs_bmc *file_to_kcs_bmc(struct file *filp)
+static inline struct kcs_bmc *to_kcs_bmc(struct file *filp)
 {
 	return container_of(filp->private_data, struct kcs_bmc, miscdev);
 }
 
 static int kcs_bmc_open(struct inode *inode, struct file *filp)
 {
-	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
+	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
 	int ret = 0;
 
 	spin_lock_irq(&kcs_bmc->lock);
@@ -262,25 +264,25 @@ static int kcs_bmc_open(struct inode *inode, struct file *filp)
 	return ret;
 }
 
-static unsigned int kcs_bmc_poll(struct file *filp, poll_table *wait)
+static __poll_t kcs_bmc_poll(struct file *filp, poll_table *wait)
 {
-	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
-	unsigned int mask = 0;
+	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
+	__poll_t mask = 0;
 
 	poll_wait(filp, &kcs_bmc->queue, wait);
 
 	spin_lock_irq(&kcs_bmc->lock);
 	if (kcs_bmc->data_in_avail)
-		mask |= POLLIN;
+		mask |= EPOLLIN;
 	spin_unlock_irq(&kcs_bmc->lock);
 
 	return mask;
 }
 
-static ssize_t kcs_bmc_read(struct file *filp, char *buf,
-			    size_t count, loff_t *offset)
+static ssize_t kcs_bmc_read(struct file *filp, char __user *buf,
+			    size_t count, loff_t *ppos)
 {
-	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
+	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
 	bool data_avail;
 	size_t data_len;
 	ssize_t ret;
@@ -339,10 +341,10 @@ static ssize_t kcs_bmc_read(struct file *filp, char *buf,
 	return ret;
 }
 
-static ssize_t kcs_bmc_write(struct file *filp, const char *buf,
-			     size_t count, loff_t *offset)
+static ssize_t kcs_bmc_write(struct file *filp, const char __user *buf,
+			     size_t count, loff_t *ppos)
 {
-	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
+	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
 	ssize_t ret;
 
 	/* a minimum response size '3' : netfn + cmd + ccode */
@@ -378,7 +380,7 @@ static ssize_t kcs_bmc_write(struct file *filp, const char *buf,
 static long kcs_bmc_ioctl(struct file *filp, unsigned int cmd,
 			  unsigned long arg)
 {
-	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
+	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
 	long ret = 0;
 
 	spin_lock_irq(&kcs_bmc->lock);
@@ -410,7 +412,7 @@ static long kcs_bmc_ioctl(struct file *filp, unsigned int cmd,
 
 static int kcs_bmc_release(struct inode *inode, struct file *filp)
 {
-	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
+	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
 
 	spin_lock_irq(&kcs_bmc->lock);
 	kcs_bmc->running = 0;
diff --git a/drivers/char/ipmi/kcs_bmc.h b/drivers/char/ipmi/kcs_bmc.h
index c19501d..eb9ea4c 100644
--- a/drivers/char/ipmi/kcs_bmc.h
+++ b/drivers/char/ipmi/kcs_bmc.h
@@ -1,31 +1,33 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2015-2018, Intel Corporation.
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2015-2018, Intel Corporation.
+ */
 
 #ifndef __KCS_BMC_H__
 #define __KCS_BMC_H__
 
 #include <linux/miscdevice.h>
 
-/* Different phases of the KCS BMC module :
- *  KCS_PHASE_IDLE :
+/* Different phases of the KCS BMC module.
+ *  KCS_PHASE_IDLE:
  *            BMC should not be expecting nor sending any data.
- *  KCS_PHASE_WRITE_START :
+ *  KCS_PHASE_WRITE_START:
  *            BMC is receiving a WRITE_START command from system software.
- *  KCS_PHASE_WRITE_DATA :
+ *  KCS_PHASE_WRITE_DATA:
  *            BMC is receiving a data byte from system software.
- *  KCS_PHASE_WRITE_END_CMD :
+ *  KCS_PHASE_WRITE_END_CMD:
  *            BMC is waiting a last data byte from system software.
- *  KCS_PHASE_WRITE_DONE :
+ *  KCS_PHASE_WRITE_DONE:
  *            BMC has received the whole request from system software.
- *  KCS_PHASE_WAIT_READ :
+ *  KCS_PHASE_WAIT_READ:
  *            BMC is waiting the response from the upper IPMI service.
- *  KCS_PHASE_READ :
+ *  KCS_PHASE_READ:
  *            BMC is transferring the response to system software.
- *  KCS_PHASE_ABORT_ERROR1 :
+ *  KCS_PHASE_ABORT_ERROR1:
  *            BMC is waiting error status request from system software.
- *  KCS_PHASE_ABORT_ERROR2 :
+ *  KCS_PHASE_ABORT_ERROR2:
  *            BMC is waiting for idle status afer error from system software.
- *  KCS_PHASE_ERROR :
+ *  KCS_PHASE_ERROR:
  *            BMC has detected a protocol violation at the interface level.
  */
 enum kcs_phases {
@@ -54,9 +56,9 @@ enum kcs_errors {
 };
 
 /* IPMI 2.0 - 9.5, KCS Interface Registers
- * @idr : Input Data Register
- * @odr : Output Data Register
- * @str : Status Register
+ * @idr: Input Data Register
+ * @odr: Output Data Register
+ * @str: Status Register
  */
 struct kcs_ioreg {
 	u32 idr;
@@ -103,4 +105,4 @@ static inline void *kcs_bmc_priv(struct kcs_bmc *kcs_bmc)
 int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc);
 struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv,
 					u32 channel);
-#endif
+#endif /* __KCS_BMC_H__ */
diff --git a/drivers/char/ipmi/kcs_bmc_aspeed.c b/drivers/char/ipmi/kcs_bmc_aspeed.c
index 0c4d1a3..dba6075 100644
--- a/drivers/char/ipmi/kcs_bmc_aspeed.c
+++ b/drivers/char/ipmi/kcs_bmc_aspeed.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2015-2018, Intel Corporation.
+/*
+ * Copyright (c) 2015-2018, Intel Corporation.
+ */
 
 #define pr_fmt(fmt) "aspeed-kcs-bmc: " fmt
 
diff --git a/include/uapi/linux/ipmi_bmc.h b/include/uapi/linux/ipmi_bmc.h
index 2f9f97e..1670f09 100644
--- a/include/uapi/linux/ipmi_bmc.h
+++ b/include/uapi/linux/ipmi_bmc.h
@@ -1,5 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2015-2018, Intel Corporation.
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2015-2018, Intel Corporation.
+ */
 
 #ifndef _UAPI_LINUX_IPMI_BMC_H
 #define _UAPI_LINUX_IPMI_BMC_H
@@ -11,4 +13,4 @@
 #define IPMI_BMC_IOCTL_CLEAR_SMS_ATN  _IO(__IPMI_BMC_IOCTL_MAGIC, 0x01)
 #define IPMI_BMC_IOCTL_FORCE_ABORT    _IO(__IPMI_BMC_IOCTL_MAGIC, 0x02)
 
-#endif /* _UAPI_LINUX_KCS_BMC_H */
+#endif /* _UAPI_LINUX_IPMI_BMC_H */
-- 
2.7.4
