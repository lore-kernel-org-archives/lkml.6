Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvqsXRyUfPAROlV8g0xCidu8aboZZk9P6blYgxr4tSoHH18tihWIz0ewGGIfBKoifa4hP+r
ARC-Seal: i=1; a=rsa-sha256; t=1520451736; cv=none;
        d=google.com; s=arc-20160816;
        b=0K80gLGo/6BZb/Mk9VtEAzIg683AID4/twa0ub6b+AXqJK+gnxzVrUP5HREtNOV5/w
         zWscZfK6r7fD7WrwbmmttdMPv9jqcge1cCsVfs3Zo1A7MfNthP9KDo3kzS+0auWD8ldA
         7i1weHWsUC1+dpNkAFbCzNa/gos47vnZVUXjPGGbzQQIAT/K2uHn79loJDLFNZQ3fSqV
         qZfwN7yDvxsVeU2LxsG7P5oST3/6+2haHTAUEhuecsXA5qQ9cF2igw1RRMo5I6o4MeMR
         sBBwb6YcGT+r6USXZBOHxA1sHb6WiOnLUcCyzUAFHjcYFFPbZfIvWiq92XKQBEDTuHw8
         9kWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=8eKeu8oZc9S7/MdNAwo3syObm4Dh85s677g3X8ys7/8=;
        b=wtWJ1AiVGwPvSbkKyvR0CXQgp+/Lk6jWqawD0gOS7uyvj1+LUehr2g/IfSLPAkYLcc
         WbT1I2EQdYzAzOBawKq914LqJjaRc3eUoRr52PgxzBRRNFlHTwGS/0veqVjPGVelM34v
         BsrCPnLJaD9MYV+kDosaxHD5O7shsJhTS5VyKHtepESYwDaQOE7p7lMFU/Uzlj5PioTh
         Y7J299HrmzfmnoJ4x7PDGf2GC92c56TePqGlqX4pVVl60z1SqYyIGPWlh+b2QXoEZy+E
         I8QFXQObSWYtDF+pHVn3ep5dPJUVMDEYQUS/FYQl0TrYS7HRCuSm5ZV+VHY12KPaktyP
         W7hg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Woody Suwalski <terraluna977@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	William Grant <william.grant@canonical.com>
Subject: [PATCH 4.15 038/122] x86/cpu_entry_area: Sync cpu_entry_area to initial_page_table
Date: Wed,  7 Mar 2018 11:37:30 -0800
Message-Id: <20180307191734.595316838@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309200217298970?=
X-GMAIL-MSGID: =?utf-8?q?1594309200217298970?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 945fd17ab6bab8a4d05da6c3170519fbcfe62ddb upstream.

The separation of the cpu_entry_area from the fixmap missed the fact that
on 32bit non-PAE kernels the cpu_entry_area mapping might not be covered in
initial_page_table by the previous synchronizations.

This results in suspend/resume failures because 32bit utilizes initial page
table for resume. The absence of the cpu_entry_area mapping results in a
triple fault, aka. insta reboot.

With PAE enabled this works by chance because the PGD entry which covers
the fixmap and other parts incindentally provides the cpu_entry_area
mapping as well.

Synchronize the initial page table after setting up the cpu entry
area. Instead of adding yet another copy of the same code, move it to a
function and invoke it from the various places.

It needs to be investigated if the existing calls in setup_arch() and
setup_per_cpu_areas() can be replaced by the later invocation from
setup_cpu_entry_areas(), but that's beyond the scope of this fix.

Fixes: 92a0f81d8957 ("x86/cpu_entry_area: Move it out of the fixmap")
Reported-by: Woody Suwalski <terraluna977@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Woody Suwalski <terraluna977@gmail.com>
Cc: William Grant <william.grant@canonical.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1802282137290.1392@nanos.tec.linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/pgtable_32.h |    1 +
 arch/x86/include/asm/pgtable_64.h |    1 +
 arch/x86/kernel/setup.c           |   17 +++++------------
 arch/x86/kernel/setup_percpu.c    |   17 ++++-------------
 arch/x86/mm/cpu_entry_area.c      |    6 ++++++
 arch/x86/mm/init_32.c             |   15 +++++++++++++++
 6 files changed, 32 insertions(+), 25 deletions(-)

--- a/arch/x86/include/asm/pgtable_32.h
+++ b/arch/x86/include/asm/pgtable_32.h
@@ -32,6 +32,7 @@ extern pmd_t initial_pg_pmd[];
 static inline void pgtable_cache_init(void) { }
 static inline void check_pgt_cache(void) { }
 void paging_init(void);
+void sync_initial_page_table(void);
 
 /*
  * Define this if things work differently on an i386 and an i486:
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -28,6 +28,7 @@ extern pgd_t init_top_pgt[];
 #define swapper_pg_dir init_top_pgt
 
 extern void paging_init(void);
+static inline void sync_initial_page_table(void) { }
 
 #define pte_ERROR(e)					\
 	pr_err("%s:%d: bad pte %p(%016lx)\n",		\
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1205,20 +1205,13 @@ void __init setup_arch(char **cmdline_p)
 
 	kasan_init();
 
-#ifdef CONFIG_X86_32
-	/* sync back kernel address range */
-	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			KERNEL_PGD_PTRS);
-
 	/*
-	 * sync back low identity map too.  It is used for example
-	 * in the 32-bit EFI stub.
+	 * Sync back kernel address range.
+	 *
+	 * FIXME: Can the later sync in setup_cpu_entry_areas() replace
+	 * this call?
 	 */
-	clone_pgd_range(initial_page_table,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
-#endif
+	sync_initial_page_table();
 
 	tboot_probe();
 
--- a/arch/x86/kernel/setup_percpu.c
+++ b/arch/x86/kernel/setup_percpu.c
@@ -287,24 +287,15 @@ void __init setup_per_cpu_areas(void)
 	/* Setup cpu initialized, callin, callout masks */
 	setup_cpu_local_masks();
 
-#ifdef CONFIG_X86_32
 	/*
 	 * Sync back kernel address range again.  We already did this in
 	 * setup_arch(), but percpu data also needs to be available in
 	 * the smpboot asm.  We can't reliably pick up percpu mappings
 	 * using vmalloc_fault(), because exception dispatch needs
 	 * percpu data.
+	 *
+	 * FIXME: Can the later sync in setup_cpu_entry_areas() replace
+	 * this call?
 	 */
-	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			KERNEL_PGD_PTRS);
-
-	/*
-	 * sync back low identity map too.  It is used for example
-	 * in the 32-bit EFI stub.
-	 */
-	clone_pgd_range(initial_page_table,
-			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
-			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
-#endif
+	sync_initial_page_table();
 }
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -163,4 +163,10 @@ void __init setup_cpu_entry_areas(void)
 
 	for_each_possible_cpu(cpu)
 		setup_cpu_entry_area(cpu);
+
+	/*
+	 * This is the last essential update to swapper_pgdir which needs
+	 * to be synchronized to initial_page_table on 32bit.
+	 */
+	sync_initial_page_table();
 }
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -453,6 +453,21 @@ static inline void permanent_kmaps_init(
 }
 #endif /* CONFIG_HIGHMEM */
 
+void __init sync_initial_page_table(void)
+{
+	clone_pgd_range(initial_page_table + KERNEL_PGD_BOUNDARY,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			KERNEL_PGD_PTRS);
+
+	/*
+	 * sync back low identity map too.  It is used for example
+	 * in the 32-bit EFI stub.
+	 */
+	clone_pgd_range(initial_page_table,
+			swapper_pg_dir     + KERNEL_PGD_BOUNDARY,
+			min(KERNEL_PGD_PTRS, KERNEL_PGD_BOUNDARY));
+}
+
 void __init native_pagetable_init(void)
 {
 	unsigned long pfn, va;
