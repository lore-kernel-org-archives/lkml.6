Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbeBTKfj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 05:35:39 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeBTKfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 05:35:37 -0500
Date: Tue, 20 Feb 2018 02:25:08 -0800
From: tip-bot for Juergen Gross <tipbot@zytor.com>
Message-ID: <tip-e9cb8fc2e5ca5996417f900ed5149bd9150f6abd@git.kernel.org>
Cc: rafael.j.wysocki@intel.com, tglx@linutronix.de, hpa@zytor.com,
        jgross@suse.com, bp@alien8.de, peterz@infradead.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org, mingo@kernel.org,
        ebiederm@xmission.com, torvalds@linux-foundation.org,
        kirill.shutemov@linux.intel.com, andy.shevchenko@gmail.com
Reply-To: hpa@zytor.com, jgross@suse.com, bp@alien8.de, peterz@infradead.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        andy.shevchenko@gmail.com, torvalds@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mingo@kernel.org,
        ebiederm@xmission.com
In-Reply-To: <20180219100906.14265-4-jgross@suse.com>
References: <20180219100906.14265-4-jgross@suse.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/boot] x86/xen: Add pvh specific rsdp address retrieval
 function
Git-Commit-ID: e9cb8fc2e5ca5996417f900ed5149bd9150f6abd
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

Commit-ID:  e9cb8fc2e5ca5996417f900ed5149bd9150f6abd
Gitweb:     https://git.kernel.org/tip/e9cb8fc2e5ca5996417f900ed5149bd9150f6abd
Author:     Juergen Gross <jgross@suse.com>
AuthorDate: Mon, 19 Feb 2018 11:09:06 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Feb 2018 09:00:56 +0100

x86/xen: Add pvh specific rsdp address retrieval function

Add pvh_get_root_pointer() for Xen PVH guests to communicate the
address of the RSDP table given to the kernel via Xen start info.

This makes the kernel boot again in PVH mode after on recent Xen the
RSDP was moved to higher addresses. So up to that change it was pure
luck that the legacy method to locate the RSDP was working when
running as PVH mode.

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
Link: http://lkml.kernel.org/r/20180219100906.14265-4-jgross@suse.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/xen/enlighten_pvh.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 436c4f0..aa1c6a68 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -6,6 +6,7 @@
 #include <asm/io_apic.h>
 #include <asm/hypervisor.h>
 #include <asm/e820/api.h>
+#include <asm/x86_init.h>
 
 #include <asm/xen/interface.h>
 #include <asm/xen/hypercall.h>
@@ -16,15 +17,20 @@
 /*
  * PVH variables.
  *
- * xen_pvh and pvh_bootparams need to live in data segment since they
- * are used after startup_{32|64}, which clear .bss, are invoked.
+ * xen_pvh pvh_bootparams and pvh_start_info need to live in data segment
+ * since they are used after startup_{32|64}, which clear .bss, are invoked.
  */
 bool xen_pvh __attribute__((section(".data"))) = 0;
 struct boot_params pvh_bootparams __attribute__((section(".data")));
+struct hvm_start_info pvh_start_info __attribute__((section(".data")));
 
-struct hvm_start_info pvh_start_info;
 unsigned int pvh_start_info_sz = sizeof(pvh_start_info);
 
+static u64 pvh_get_root_pointer(void)
+{
+	return pvh_start_info.rsdp_paddr;
+}
+
 static void __init init_pvh_bootparams(void)
 {
 	struct xen_memory_map memmap;
@@ -71,6 +77,8 @@ static void __init init_pvh_bootparams(void)
 	 */
 	pvh_bootparams.hdr.version = 0x212;
 	pvh_bootparams.hdr.type_of_loader = (9 << 4) | 0; /* Xen loader */
+
+	x86_init.acpi.get_root_pointer = pvh_get_root_pointer;
 }
 
 /*
