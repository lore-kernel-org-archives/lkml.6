Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933065AbeBPJ6V (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:58:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40715 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932979AbeBPJ6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:58:20 -0500
Date: Fri, 16 Feb 2018 01:47:59 -0800
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-a66b86f0026b07b0ea7340e3690ac9fd5ac1499a@git.kernel.org>
Cc: tglx@linutronix.de, peterz@infradead.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, torvalds@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        andriy.shevchenko@linux.intel.com, mingo@kernel.org
In-Reply-To: <20180214154317.52290-2-andriy.shevchenko@linux.intel.com>
References: <20180214154317.52290-2-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/platform/quark: Re-use
 DEFINE_SHOW_ATTRIBUTE() macro
Git-Commit-ID: a66b86f0026b07b0ea7340e3690ac9fd5ac1499a
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a66b86f0026b07b0ea7340e3690ac9fd5ac1499a
Gitweb:     https://git.kernel.org/tip/a66b86f0026b07b0ea7340e3690ac9fd5ac1499a
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 17:43:17 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:10:14 +0100

x86/platform/quark: Re-use DEFINE_SHOW_ATTRIBUTE() macro

...instead of open coding file operations followed by custom ->open()
callbacks per each attribute.

While here, replace permissions by explicit octal value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180214154317.52290-2-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/intel-quark/imr.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/x86/platform/intel-quark/imr.c b/arch/x86/platform/intel-quark/imr.c
index 17d6d22..49828c2 100644
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
 
