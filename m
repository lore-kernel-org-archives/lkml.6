Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751682AbeCOMUE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:20:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:11680 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750731AbeCOMUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:20:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,310,1517904000";
   d="scan'208";a="24749073"
From: Haiyue Wang <haiyue.wang@linux.intel.com>
To: minyard@acm.org, openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc: Haiyue Wang <haiyue.wang@linux.intel.com>
Subject: [PATCH ipmi/kcs_bmc v1] ipmi: kcs_bmc: optimize the data buffers allocation
Date: Thu, 15 Mar 2018 20:20:52 +0800
Message-Id: <1521116452-4993-1-git-send-email-haiyue.wang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate a continuous memory block for the three KCS data buffers with
related index assignment.

Signed-off-by: Haiyue Wang <haiyue.wang@linux.intel.com>
---
 drivers/char/ipmi/kcs_bmc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index fbfc05e..dc19c0d 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -435,6 +435,7 @@ static const struct file_operations kcs_bmc_fops = {
 struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv, u32 channel)
 {
 	struct kcs_bmc *kcs_bmc;
+	void *buf;
 
 	kcs_bmc = devm_kzalloc(dev, sizeof(*kcs_bmc) + sizeof_priv, GFP_KERNEL);
 	if (!kcs_bmc)
@@ -448,11 +449,12 @@ struct kcs_bmc *kcs_bmc_alloc(struct device *dev, int sizeof_priv, u32 channel)
 	mutex_init(&kcs_bmc->mutex);
 	init_waitqueue_head(&kcs_bmc->queue);
 
-	kcs_bmc->data_in = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
-	kcs_bmc->data_out = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
-	kcs_bmc->kbuffer = devm_kmalloc(dev, KCS_MSG_BUFSIZ, GFP_KERNEL);
-	if (!kcs_bmc->data_in || !kcs_bmc->data_out || !kcs_bmc->kbuffer)
+	buf = devm_kmalloc_array(dev, 3, KCS_MSG_BUFSIZ, GFP_KERNEL);
+	if (!buf)
 		return NULL;
+	kcs_bmc->data_in  = buf;
+	kcs_bmc->data_out = buf + KCS_MSG_BUFSIZ;
+	kcs_bmc->kbuffer  = buf + KCS_MSG_BUFSIZ * 2;
 
 	kcs_bmc->miscdev.minor = MISC_DYNAMIC_MINOR;
 	kcs_bmc->miscdev.name = dev_name(dev);
-- 
2.7.4
