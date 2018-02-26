Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeBZIqu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:46:50 -0500
Received: from terminus.zytor.com ([198.137.202.136]:53129 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751956AbeBZIqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:46:47 -0500
Date: Mon, 26 Feb 2018 00:46:06 -0800
From: tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-dfc9327ab7c99bc13e12106448615efba833886b@git.kernel.org>
Cc: keescook@chromium.org, tglx@linutronix.de, hpa@zytor.com,
        peterz@infradead.org, bp@alien8.de, torvalds@linux-foundation.org,
        rafael.j.wysocki@intel.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        andy.shevchenko@gmail.com
Reply-To: tglx@linutronix.de, keescook@chromium.org, hpa@zytor.com,
        bp@alien8.de, peterz@infradead.org, torvalds@linux-foundation.org,
        rafael.j.wysocki@intel.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        andy.shevchenko@gmail.com
In-Reply-To: <20180219100906.14265-2-jgross@suse.com>
References: <20180219100906.14265-2-jgross@suse.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] acpi: Introduce acpi_arch_get_root_pointer() for
 getting rsdp address
Git-Commit-ID: dfc9327ab7c99bc13e12106448615efba833886b
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

Commit-ID:  dfc9327ab7c99bc13e12106448615efba833886b
Gitweb:     https://git.kernel.org/tip/dfc9327ab7c99bc13e12106448615efba833886b
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Mon, 19 Feb 2018 11:09:04 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 26 Feb 2018 08:43:20 +0100

acpi: Introduce acpi_arch_get_root_pointer() for getting rsdp address

Add an architecture specific function to get the address of the RSDP
table. Per default it will just return 0 indicating falling back to
the current mechanism.

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: boris.ostrovsky@oracle.com
Cc: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
Link: http://lkml.kernel.org/r/20180219100906.14265-2-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/acpi/osl.c   | 5 ++++-
 include/linux/acpi.h | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 3bb46cb24a99..7ca41bf023c9 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -189,12 +189,15 @@ early_param("acpi_rsdp", setup_acpi_rsdp);
 
 acpi_physical_address __init acpi_os_get_root_pointer(void)
 {
-	acpi_physical_address pa = 0;
+	acpi_physical_address pa;
 
 #ifdef CONFIG_KEXEC
 	if (acpi_rsdp)
 		return acpi_rsdp;
 #endif
+	pa = acpi_arch_get_root_pointer();
+	if (pa)
+		return pa;
 
 	if (efi_enabled(EFI_CONFIG_TABLES)) {
 		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 968173ec2726..15bfb15c2fa5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -623,6 +623,13 @@ bool acpi_gtdt_c3stop(int type);
 int acpi_arch_timer_mem_init(struct arch_timer_mem *timer_mem, int *timer_count);
 #endif
 
+#ifndef ACPI_HAVE_ARCH_GET_ROOT_POINTER
+static inline u64 acpi_arch_get_root_pointer(void)
+{
+	return 0;
+}
+#endif
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
