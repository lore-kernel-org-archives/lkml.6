Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753081AbeBSPyk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:54:40 -0500
Received: from mga14.intel.com ([192.55.52.115]:13263 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751701AbeBSPyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:54:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,535,1511856000";
   d="scan'208";a="19533934"
From: Haiyue Wang <haiyue.wang@linux.intel.com>
To: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: [PATCH ipmi/kcs_bmc v2] ipmi: kcs_bmc: make the code be more clean
Date: Mon, 19 Feb 2018 23:55:31 +0800
Message-Id: <1519055731-18923-1-git-send-email-haiyue.wang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
v1 -> v2:

Add 'SPDX-License-Identifier' style for header files modification.
---

1. Add the missed key word '__user' for read / write.
2. Remove the prefix 'file' of 'file_to_kcs_bmc', no need this
duplicated word as its parameter has 'struct file *filp'.
3. Change the 'unsigned int' to '__poll_t' to meet the new 'poll'
definition.
4. Correct the 'SPDX-License-Identifier' style for header files.

Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
 drivers/char/ipmi/kcs_bmc.c        | 32 +++++++++++++++++---------------
 drivers/char/ipmi/kcs_bmc.h        |  6 ++++--
 drivers/char/ipmi/kcs_bmc_aspeed.c |  4 +++-
 include/uapi/linux/ipmi_bmc.h      |  6 ++++--
 4 files changed, 28 insertions(+), 20 deletions(-)

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
index c19501d..69d9a70 100644
--- a/drivers/char/ipmi/kcs_bmc.h
+++ b/drivers/char/ipmi/kcs_bmc.h
@@ -1,5 +1,7 @@
-// SPDX-License-Identifier: GPL-2.0
-// Copyright (c) 2015-2018, Intel Corporation.
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2015-2018, Intel Corporation.
+ */
 
 #ifndef __KCS_BMC_H__
 #define __KCS_BMC_H__
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
index 2f9f97e..d3efacd 100644
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
-- 
2.7.4
