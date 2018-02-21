Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226/2//LPj5+D18CsSjedQ9E0FVT8yuHbQ9Gd300ptq87csZ2hZrSo4EqczXo5FQDj5FwIhc
ARC-Seal: i=1; a=rsa-sha256; t=1519218346; cv=none;
        d=google.com; s=arc-20160816;
        b=yxdXYfjz4PO1UEUbRB12xJHIA9Wa4llJ9/rcL+LZT0M8LqL40aQLXz3cwzgSFE2Qpw
         Zl6n6pGXSJ4QtHTQS6WVe6g14SWYcqflOvozcPcBe0j74QK5eNOov4xef2P1Z1Wmgxkb
         OMSpwx/IuBtKUzKdWPYspcefSiBn4YQTkjrWCY+SzizTHlqFi3jr3wro19G9rl/CE65g
         W9GgtqIbxLL0HBNd8oj9NNbobiiO7RPr4DccN46I45Xw7CBeUvb6DjpX0CAvSnEJ+m2D
         g/z/LqRvLNCaUQo0jJ1mA4611wH9TRr+byYUYLr6rirwis4yl4O4v5AkW/4XdLkMfzgg
         VU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=thziLbpOyK1v29UlK7xX+q7ArK6xcZw8aDtMeXmYKPk=;
        b=UHCUv06tTe4AmyfjD6iVPt1w9imFpa2tFGJvjLWns+HRc7UvUOCMFW8ww1yA4yFW4k
         VsfhJ3zrm60TiQxxhqTYzvWnKcJI5yadr9LY3l/sLvXtJnXZXdUV75oDLlqALEClV+dI
         EgXjLEt7N4PTqi3DQwgnSaZyFhsVcVmW8hm8boBy6/2RuPxZvUVhybdsenySQnv7Or8w
         yNhZjDkegOEeLLRu1Dhi1FZitOi4oTc4vdhVw8RkfmHBy3y29cXvuMg9F2Rbwvosjj4x
         CFw/SO5FVNs7t2zM9oh4ncSl7D3y8phs89m5FYzC8FOr+FQ9YHU0gCJbHv8JDwcgRKA9
         ZO8g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@suse.de>,
	Brian Gerst <brgerst@gmail.com>,
	Dave <dave.hansen@intel.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Robert (Persistent Memory)" <elliott@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 152/167] x86/mm, mm/hwpoison: Dont unconditionally unmap kernel 1:1 pages
Date: Wed, 21 Feb 2018 13:49:23 +0100
Message-Id: <20180221124533.132182139@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015897258712699?=
X-GMAIL-MSGID: =?utf-8?q?1593015897258712699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit fd0e786d9d09024f67bd71ec094b110237dc3840 upstream.

In the following commit:

  ce0fa3e56ad2 ("x86/mm, mm/hwpoison: Clear PRESENT bit for kernel 1:1 mappings of poison pages")

... we added code to memory_failure() to unmap the page from the
kernel 1:1 virtual address space to avoid speculative access to the
page logging additional errors.

But memory_failure() may not always succeed in taking the page offline,
especially if the page belongs to the kernel.  This can happen if
there are too many corrected errors on a page and either mcelog(8)
or drivers/ras/cec.c asks to take a page offline.

Since we remove the 1:1 mapping early in memory_failure(), we can
end up with the page unmapped, but still in use. On the next access
the kernel crashes :-(

There are also various debug paths that call memory_failure() to simulate
occurrence of an error. Since there is no actual error in memory, we
don't need to map out the page for those cases.

Revert most of the previous attempt and keep the solution local to
arch/x86/kernel/cpu/mcheck/mce.c. Unmap the page only when:

	1) there is a real error
	2) memory_failure() succeeds.

All of this only applies to 64-bit systems. 32-bit kernel doesn't map
all of memory into kernel space. It isn't worth adding the code to unmap
the piece that is mapped because nobody would run a 32-bit kernel on a
machine that has recoverable machine checks.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave <dave.hansen@intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert (Persistent Memory) <elliott@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Cc: stable@vger.kernel.org #v4.14
Fixes: ce0fa3e56ad2 ("x86/mm, mm/hwpoison: Clear PRESENT bit for kernel 1:1 mappings of poison pages")
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/page_64.h            |    4 ----
 arch/x86/kernel/cpu/mcheck/mce-internal.h |   15 +++++++++++++++
 arch/x86/kernel/cpu/mcheck/mce.c          |   17 +++++++++++------
 include/linux/mm_inline.h                 |    6 ------
 mm/memory-failure.c                       |    2 --
 5 files changed, 26 insertions(+), 18 deletions(-)

--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -52,10 +52,6 @@ static inline void clear_page(void *page
 
 void copy_page(void *to, void *from);
 
-#ifdef CONFIG_X86_MCE
-#define arch_unmap_kpfn arch_unmap_kpfn
-#endif
-
 #endif	/* !__ASSEMBLY__ */
 
 #ifdef CONFIG_X86_VSYSCALL_EMULATION
--- a/arch/x86/kernel/cpu/mcheck/mce-internal.h
+++ b/arch/x86/kernel/cpu/mcheck/mce-internal.h
@@ -115,4 +115,19 @@ static inline void mce_unregister_inject
 
 extern struct mca_config mca_cfg;
 
+#ifndef CONFIG_X86_64
+/*
+ * On 32-bit systems it would be difficult to safely unmap a poison page
+ * from the kernel 1:1 map because there are no non-canonical addresses that
+ * we can use to refer to the address without risking a speculative access.
+ * However, this isn't much of an issue because:
+ * 1) Few unmappable pages are in the 1:1 map. Most are in HIGHMEM which
+ *    are only mapped into the kernel as needed
+ * 2) Few people would run a 32-bit kernel on a machine that supports
+ *    recoverable errors because they have too much memory to boot 32-bit.
+ */
+static inline void mce_unmap_kpfn(unsigned long pfn) {}
+#define mce_unmap_kpfn mce_unmap_kpfn
+#endif
+
 #endif /* __X86_MCE_INTERNAL_H__ */
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -106,6 +106,10 @@ static struct irq_work mce_irq_work;
 
 static void (*quirk_no_way_out)(int bank, struct mce *m, struct pt_regs *regs);
 
+#ifndef mce_unmap_kpfn
+static void mce_unmap_kpfn(unsigned long pfn);
+#endif
+
 /*
  * CPU/chipset specific EDAC code can register a notifier call here to print
  * MCE errors in a human-readable form.
@@ -582,7 +586,8 @@ static int srao_decode_notifier(struct n
 
 	if (mce_usable_address(mce) && (mce->severity == MCE_AO_SEVERITY)) {
 		pfn = mce->addr >> PAGE_SHIFT;
-		memory_failure(pfn, MCE_VECTOR, 0);
+		if (memory_failure(pfn, MCE_VECTOR, 0))
+			mce_unmap_kpfn(pfn);
 	}
 
 	return NOTIFY_OK;
@@ -1049,12 +1054,13 @@ static int do_memory_failure(struct mce
 	ret = memory_failure(m->addr >> PAGE_SHIFT, MCE_VECTOR, flags);
 	if (ret)
 		pr_err("Memory error not recovered");
+	else
+		mce_unmap_kpfn(m->addr >> PAGE_SHIFT);
 	return ret;
 }
 
-#if defined(arch_unmap_kpfn) && defined(CONFIG_MEMORY_FAILURE)
-
-void arch_unmap_kpfn(unsigned long pfn)
+#ifndef mce_unmap_kpfn
+static void mce_unmap_kpfn(unsigned long pfn)
 {
 	unsigned long decoy_addr;
 
@@ -1065,7 +1071,7 @@ void arch_unmap_kpfn(unsigned long pfn)
 	 * We would like to just call:
 	 *	set_memory_np((unsigned long)pfn_to_kaddr(pfn), 1);
 	 * but doing that would radically increase the odds of a
-	 * speculative access to the posion page because we'd have
+	 * speculative access to the poison page because we'd have
 	 * the virtual address of the kernel 1:1 mapping sitting
 	 * around in registers.
 	 * Instead we get tricky.  We create a non-canonical address
@@ -1090,7 +1096,6 @@ void arch_unmap_kpfn(unsigned long pfn)
 
 	if (set_memory_np(decoy_addr, 1))
 		pr_warn("Could not invalidate pfn=0x%lx from 1:1 map\n", pfn);
-
 }
 #endif
 
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -127,10 +127,4 @@ static __always_inline enum lru_list pag
 
 #define lru_to_page(head) (list_entry((head)->prev, struct page, lru))
 
-#ifdef arch_unmap_kpfn
-extern void arch_unmap_kpfn(unsigned long pfn);
-#else
-static __always_inline void arch_unmap_kpfn(unsigned long pfn) { }
-#endif
-
 #endif
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1146,8 +1146,6 @@ int memory_failure(unsigned long pfn, in
 		return 0;
 	}
 
-	arch_unmap_kpfn(pfn);
-
 	orig_head = hpage = compound_head(p);
 	num_poisoned_pages_inc();
 
