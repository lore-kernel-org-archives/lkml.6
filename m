Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753266AbeA3Wis (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 17:38:48 -0500
Received: from terminus.zytor.com ([65.50.211.136]:52983 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753169AbeA3Wip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 17:38:45 -0500
Date: Tue, 30 Jan 2018 14:37:38 -0800
From: tip-bot for Dan Williams <tipbot@zytor.com>
Message-ID: <tip-56c30ba7b348b90484969054d561f711ba196507@git.kernel.org>
Cc: tglx@linutronix.de, viro@zeniv.linux.org.uk, dan.j.williams@intel.com,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        elena.reshetova@intel.com
Reply-To: linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        mingo@kernel.org, hpa@zytor.com, dan.j.williams@intel.com,
        viro@zeniv.linux.org.uk, tglx@linutronix.de
In-Reply-To: <151727418500.33451.17392199002892248656.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <151727418500.33451.17392199002892248656.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] vfs, fdtable: Prevent bounds-check bypass via
 speculative execution
Git-Commit-ID: 56c30ba7b348b90484969054d561f711ba196507
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

Commit-ID:  56c30ba7b348b90484969054d561f711ba196507
Gitweb:     https://git.kernel.org/tip/56c30ba7b348b90484969054d561f711ba196507
Author:     Dan Williams <dan.j.williams@intel.com>
AuthorDate: Mon, 29 Jan 2018 17:03:05 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 30 Jan 2018 21:54:32 +0100

vfs, fdtable: Prevent bounds-check bypass via speculative execution

'fd' is a user controlled value that is used as a data dependency to
read from the 'fdt->fd' array.  In order to avoid potential leaks of
kernel memory values, block speculative execution of the instruction
stream that could issue reads based on an invalid 'file *' returned from
__fcheck_files.

Co-developed-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-arch@vger.kernel.org
Cc: kernel-hardening@lists.openwall.com
Cc: gregkh@linuxfoundation.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: torvalds@linux-foundation.org
Cc: alan@linux.intel.com
Link: https://lkml.kernel.org/r/151727418500.33451.17392199002892248656.stgit@dwillia2-desk3.amr.corp.intel.com

---
 include/linux/fdtable.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/fdtable.h b/include/linux/fdtable.h
index 1c65817..41615f3 100644
--- a/include/linux/fdtable.h
+++ b/include/linux/fdtable.h
@@ -10,6 +10,7 @@
 #include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
+#include <linux/nospec.h>
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/fs.h>
@@ -82,8 +83,10 @@ static inline struct file *__fcheck_files(struct files_struct *files, unsigned i
 {
 	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
 
-	if (fd < fdt->max_fds)
+	if (fd < fdt->max_fds) {
+		fd = array_index_nospec(fd, fdt->max_fds);
 		return rcu_dereference_raw(fdt->fd[fd]);
+	}
 	return NULL;
 }
 
