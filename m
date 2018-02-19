Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbeBSNQo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 08:16:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:19259 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752666AbeBSNQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 08:16:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,535,1511856000";
   d="scan'208";a="202198410"
From: Haiyue Wang <haiyue.wang@linux.intel.com>
To: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: [PATCH ipmi/kcs_bmc v1] ipmi: kcs_bmc: make the code be more clean
Date: Mon, 19 Feb 2018 21:17:34 +0800
Message-Id: <1519046254-17251-1-git-send-email-haiyue.wang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

I've changed some code style to meet with the whole Linux style. Please help
to review.

BR,
Haiyue

---

1. Add the missed key word '__user' for read / write.
2. Remove the prefix 'file' of 'file_to_kcs_bmc', no need this
duplicated word as its parameter has 'struct file *filp'.
3. Change the 'unsigned int' to '__poll_t' to meet the new 'poll'
definition.

Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
 drivers/char/ipmi/kcs_bmc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index 6476bfb..2fe55b0 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -242,14 +242,14 @@ int kcs_bmc_handle_event(struct kcs_bmc *kcs_bmc)
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
@@ -262,10 +262,10 @@ static int kcs_bmc_open(struct inode *inode, struct file *filp)
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
 
@@ -277,10 +277,10 @@ static unsigned int kcs_bmc_poll(struct file *filp, poll_table *wait)
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
@@ -339,10 +339,10 @@ static ssize_t kcs_bmc_read(struct file *filp, char *buf,
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
@@ -378,7 +378,7 @@ static ssize_t kcs_bmc_write(struct file *filp, const char *buf,
 static long kcs_bmc_ioctl(struct file *filp, unsigned int cmd,
 			  unsigned long arg)
 {
-	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
+	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
 	long ret = 0;
 
 	spin_lock_irq(&kcs_bmc->lock);
@@ -410,7 +410,7 @@ static long kcs_bmc_ioctl(struct file *filp, unsigned int cmd,
 
 static int kcs_bmc_release(struct inode *inode, struct file *filp)
 {
-	struct kcs_bmc *kcs_bmc = file_to_kcs_bmc(filp);
+	struct kcs_bmc *kcs_bmc = to_kcs_bmc(filp);
 
 	spin_lock_irq(&kcs_bmc->lock);
 	kcs_bmc->running = 0;
-- 
2.7.4
