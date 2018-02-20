Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751758AbeBTKgi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:36:38 -0500
Received: from terminus.zytor.com ([198.137.202.136]:52361 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbeBTKgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:36:37 -0500
Date: Tue, 20 Feb 2018 02:24:08 -0800
From: tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-795e2963a1afef44ed9ec7e6d16c8052fcd8d886@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, jgross@suse.com, ebiederm@xmission.com,
        rafael.j.wysocki@intel.com, hpa@zytor.com, bp@alien8.de,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, keescook@chromium.org,
        mingo@kernel.org, peterz@infradead.org, andy.shevchenko@gmail.com
Reply-To: andy.shevchenko@gmail.com, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, keescook@chromium.org,
        kirill.shutemov@linux.intel.com, hpa@zytor.com,
        torvalds@linux-foundation.org, bp@alien8.de, ebiederm@xmission.com,
        jgross@suse.com, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com
In-Reply-To: <20180219100906.14265-2-jgross@suse.com>
References: <20180219100906.14265-2-jgross@suse.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] acpi: Introduce acpi_arch_get_root_pointer() for
 getting rsdp address
Git-Commit-ID: 795e2963a1afef44ed9ec7e6d16c8052fcd8d886
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

Commit-ID:  795e2963a1afef44ed9ec7e6d16c8052fcd8d886
Gitweb:     https://git.kernel.org/tip/795e2963a1afef44ed9ec7e6d16c8052fcd8d886
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Mon, 19 Feb 2018 11:09:04 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 09:00:55 +0100

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
index 3bb46cb..7ca41bf 100644
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
index 968173e..15bfb15 100644
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
