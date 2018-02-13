Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933562AbeBMPcU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 10:32:20 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47841 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751235AbeBMPcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 10:32:18 -0500
Date: Tue, 13 Feb 2018 07:31:50 -0800
From: tip-bot for Andy Lutomirski <tipbot@zytor.com>
Message-ID: <tip-116fef6408599dd6ff6996235c50aa692e9b5631@git.kernel.org>
Cc: hpa@zytor.com, torvalds@linux-foundation.org, peterz@infradead.org,
        luto@kernel.org, ard.biesheuvel@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de
Reply-To: linux-kernel@vger.kernel.org, bp@alien8.de, mingo@kernel.org,
        torvalds@linux-foundation.org, peterz@infradead.org, hpa@zytor.com,
        tglx@linutronix.de, ard.biesheuvel@linaro.org, luto@kernel.org
In-Reply-To: <ba158a93f3250e6fca752cff2cfb1fcdd9f2b50c.1517414050.git.luto@kernel.org>
References: <ba158a93f3250e6fca752cff2cfb1fcdd9f2b50c.1517414050.git.luto@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/mm/dump_pagetables: Add the EFI pagetable to the
 debugfs 'page_tables' directory
Git-Commit-ID: 116fef6408599dd6ff6996235c50aa692e9b5631
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

Commit-ID:  116fef6408599dd6ff6996235c50aa692e9b5631
Gitweb:     https://git.kernel.org/tip/116fef6408599dd6ff6996235c50aa692e9b5631
Author:     Andy Lutomirski <luto@kernel.org>
AuthorDate: Wed, 31 Jan 2018 07:56:22 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 16:00:45 +0100

x86/mm/dump_pagetables: Add the EFI pagetable to the debugfs 'page_tables' directory

EFI is complicated enough that being able to view its pagetables is
quite helpful.  Rather than requiring users to fish it out of dmesg
on an appropriately configured kernel, let users view it in debugfs
as well.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-efi@vger.kernel.org
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/ba158a93f3250e6fca752cff2cfb1fcdd9f2b50c.1517414050.git.luto@kernel.org
[ Fixed trivial whitespace damage and fixed missing export. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/debug_pagetables.c | 32 ++++++++++++++++++++++++++++++++
 arch/x86/platform/efi/efi_64.c |  4 +++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/debug_pagetables.c b/arch/x86/mm/debug_pagetables.c
index 421f266..51a6f92 100644
--- a/arch/x86/mm/debug_pagetables.c
+++ b/arch/x86/mm/debug_pagetables.c
@@ -72,6 +72,31 @@ static const struct file_operations ptdump_curusr_fops = {
 };
 #endif
 
+#if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
+extern pgd_t *efi_pgd;
+static struct dentry *pe_efi;
+
+static int ptdump_show_efi(struct seq_file *m, void *v)
+{
+	if (efi_pgd)
+		ptdump_walk_pgd_level_debugfs(m, efi_pgd, false);
+	return 0;
+}
+
+static int ptdump_open_efi(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, ptdump_show_efi, NULL);
+}
+
+static const struct file_operations ptdump_efi_fops = {
+	.owner		= THIS_MODULE,
+	.open		= ptdump_open_efi,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+#endif
+
 static struct dentry *dir, *pe_knl, *pe_curknl;
 
 static int __init pt_dump_debug_init(void)
@@ -96,6 +121,13 @@ static int __init pt_dump_debug_init(void)
 	if (!pe_curusr)
 		goto err;
 #endif
+
+#if defined(CONFIG_EFI) && defined(CONFIG_X86_64)
+	pe_efi = debugfs_create_file("efi", 0400, dir, NULL, &ptdump_efi_fops);
+	if (!pe_efi)
+		goto err;
+#endif
+
 	return 0;
 err:
 	debugfs_remove_recursive(dir);
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index c310a82..780460a 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -27,6 +27,7 @@
 #include <linux/ioport.h>
 #include <linux/mc146818rtc.h>
 #include <linux/efi.h>
+#include <linux/export.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/reboot.h>
@@ -190,7 +191,8 @@ void __init efi_call_phys_epilog(pgd_t *save_pgd)
 	early_code_mapping_set_exec(0);
 }
 
-static pgd_t *efi_pgd;
+pgd_t *efi_pgd;
+EXPORT_SYMBOL_GPL(efi_pgd);
 
 /*
  * We need our own copy of the higher levels of the page tables
