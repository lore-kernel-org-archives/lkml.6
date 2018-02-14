Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031721AbeBNPnY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 10:43:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:19076 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031597AbeBNPnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 10:43:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="204097007"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] x86/platform/quark: Re-use DEFINE_SHOW_ATTRIBUTE() macro
Date: Wed, 14 Feb 2018 17:43:17 +0200
Message-Id: <20180214154317.52290-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180214154317.52290-1-andriy.shevchenko@linux.intel.com>
References: <20180214154317.52290-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...instead of open coding file operations followed by custom ->open()
callbacks per each attribute.

While here, replace permissions by explicit octal value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/platform/intel-quark/imr.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index 17d6d2296e4d..49828c2707ac 100644
--- a/arch/x86/platform/intel-quark/imr.c
+++ b/arch/x86/platform/intel-quark/imr.c
@@ -224,25 +224,7 @@ static int imr_dbgfs_state_show(struct seq_file *s, void *unused)
 	mutex_unlock(&idev->lock);
 	return ret;
 }
-
-/**
- * imr_state_open - debugfs open callback.
- *
- * @inode:	pointer to struct inode.
- * @file:	pointer to struct file.
- * @return:	result of single open.
- */
-static int imr_state_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, imr_dbgfs_state_show, inode->i_private);
-}
-
-static const struct file_operations imr_state_ops = {
-	.open		= imr_state_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(imr_dbgfs_state);
 
 /**
  * imr_debugfs_register - register debugfs hooks.
@@ -252,8 +234,8 @@ static const struct file_operations imr_state_ops = {
  */
 static int imr_debugfs_register(struct imr_device *idev)
 {
-	idev->file = debugfs_create_file("imr_state", S_IFREG | S_IRUGO, NULL,
-					 idev, &imr_state_ops);
+	idev->file = debugfs_create_file("imr_state", 0444, NULL, idev,
+					 &imr_dbgfs_state_fops);
 	return PTR_ERR_OR_ZERO(idev->file);
 }
 
-- 
2.15.1
