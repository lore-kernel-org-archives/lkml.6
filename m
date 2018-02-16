Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933042AbeBPJ5w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:57:52 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58225 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932979AbeBPJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:57:50 -0500
Date: Fri, 16 Feb 2018 01:47:30 -0800
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-3130451e270960065e8de684c60b898e970c940c@git.kernel.org>
Cc: peterz@infradead.org, torvalds@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        peterz@infradead.org, torvalds@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180214154317.52290-1-andriy.shevchenko@linux.intel.com>
References: <20180214154317.52290-1-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/platform] x86/platform/atom: Re-use
 DEFINE_SHOW_ATTRIBUTE() macro
Git-Commit-ID: 3130451e270960065e8de684c60b898e970c940c
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

Commit-ID:  3130451e270960065e8de684c60b898e970c940c
Gitweb:     https://git.kernel.org/tip/3130451e270960065e8de684c60b898e970c940c
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Wed, 14 Feb 2018 17:43:16 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 16 Feb 2018 10:10:14 +0100

x86/platform/atom: Re-use DEFINE_SHOW_ATTRIBUTE() macro

...instead of open coding file operations followed by custom ->open()
callbacks per each attribute.

While here, replace permissions by explicit octal value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180214154317.52290-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/platform/atom/punit_atom_debug.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/arch/x86/platform/atom/punit_atom_debug.c b/arch/x86/platform/atom/punit_atom_debug.c
index d49d3be..034813d 100644
--- a/arch/x86/platform/atom/punit_atom_debug.c
+++ b/arch/x86/platform/atom/punit_atom_debug.c
@@ -109,18 +109,7 @@ static int punit_dev_state_show(struct seq_file *seq_file, void *unused)
 
 	return 0;
 }
-
-static int punit_dev_state_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, punit_dev_state_show, inode->i_private);
-}
-
-static const struct file_operations punit_dev_state_ops = {
-	.open		= punit_dev_state_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(punit_dev_state);
 
 static struct dentry *punit_dbg_file;
 
@@ -132,9 +121,9 @@ static int punit_dbgfs_register(struct punit_device *punit_device)
 	if (!punit_dbg_file)
 		return -ENXIO;
 
-	dev_state = debugfs_create_file("dev_power_state", S_IFREG | S_IRUGO,
+	dev_state = debugfs_create_file("dev_power_state", 0444,
 					punit_dbg_file, punit_device,
-					&punit_dev_state_ops);
+					&punit_dev_state_fops);
 	if (!dev_state) {
 		pr_err("punit_dev_state register failed\n");
 		debugfs_remove(punit_dbg_file);
