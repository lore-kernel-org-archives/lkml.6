Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuJ5kPOlGGaQWbkg4ji2gn0EANdvPBJCI/9cRCj1ZVAr8GyMN8xoe4cGIAKa7xhpbVCB79k
ARC-Seal: i=1; a=rsa-sha256; t=1520641369; cv=none;
        d=google.com; s=arc-20160816;
        b=H7aboa/UvT0UJBJBse5w92t90vAV4Vu+VXNXCs46i+dshbWO2V9uTdlhC1smUv6IpI
         yAdMBe4ecSdcimeqjLia6mE5Dr8A23sIsFGX0qlsqVRx5CmSUC5+lODyXaS85cABCtvM
         5GCq5kvrHQnCVXI3Fn1JFECP/5k1fpvQXoXD2p/wssPP9Sd5Pga0ivaIe6dBwpdcVx9w
         0kfpLCFeEBjwQgSOeyJOqN9NTVFRzmp+5QFelhM80XTJ4dR2720Xu1ylrhkM3k4STLLC
         pIJ5jtEZAbwUTueSqQ+KovU07QjSCEdRo4wQw6E6b7Q3dWUDdOT8YrFr4dx8yvXco+Ek
         crXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jQ5OZY3kFJcYST3hvlm7jbxbLfL1X9/Fv6rpfGgUvTw=;
        b=SNJtCR7+V9QiIkvPgr/sBIXdlELJr5J2X5GDsy9i1Xwt4gjFCN4s+blHIsNYBZL0Z2
         Jr/zopgZ+j4raqG97o08+i2a9+3H9HR68KzARo3wf/hIM6EQ0v8vb4o9xK+Mp3Y8rFC8
         F18w6htOoGZD9ProQ5I+DeMkXOWUaqxzWNxi0Gw8GrZFhH8vpOGVL4Wb+iUyOh8waew6
         LyAY4j4bpS8ve3iU98p9Mml1matxxqcZoNA0/+Mk47DMSGhLFmoCav5FceAKnqDvdsVF
         THsp3pbgh4jHA273PTAmeFy1pduS5G0Vlziphri52lRCDf1CXumbxurORec7V5oKsvUM
         ziiA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Nadav Amit <nadav.amit@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Rik van Riel <riel@redhat.com>,
	linux-mm@kvack.org,
	Ingo Molnar <mingo@kernel.org>,
	Tim Chen <tim.c.chen@linux.intel.com>
Subject: [PATCH 4.9 28/65] x86/mm: Give each mm TLB flush generation a unique ID
Date: Fri,  9 Mar 2018 16:18:28 -0800
Message-Id: <20180310001827.163065947@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180310001824.927996722@linuxfoundation.org>
References: <20180310001824.927996722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594508044857341900?=
X-GMAIL-MSGID: =?utf-8?q?1594508044857341900?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Lutomirski <luto@kernel.org>

commit f39681ed0f48498b80455095376f11535feea332 upstream.

This adds two new variables to mmu_context_t: ctx_id and tlb_gen.
ctx_id uniquely identifies the mm_struct and will never be reused.
For a given mm_struct (and hence ctx_id), tlb_gen is a monotonic
count of the number of times that a TLB flush has been requested.
The pair (ctx_id, tlb_gen) can be used as an identifier for TLB
flush actions and will be used in subsequent patches to reliably
determine whether all needed TLB flushes have occurred on a given
CPU.

This patch is split out for ease of review.  By itself, it has no
real effect other than creating and updating the new variables.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Nadav Amit <nadav.amit@gmail.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/413a91c24dab3ed0caa5f4e4d017d87b0857f920.1498751203.git.luto@kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/mmu.h         |   15 +++++++++++++--
 arch/x86/include/asm/mmu_context.h |    5 +++++
 arch/x86/mm/tlb.c                  |    2 ++
 3 files changed, 20 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -3,12 +3,18 @@
 
 #include <linux/spinlock.h>
 #include <linux/mutex.h>
+#include <linux/atomic.h>
 
 /*
- * The x86 doesn't have a mmu context, but
- * we put the segment information here.
+ * x86 has arch-specific MMU state beyond what lives in mm_struct.
  */
 typedef struct {
+	/*
+	 * ctx_id uniquely identifies this mm_struct.  A ctx_id will never
+	 * be reused, and zero is not a valid ctx_id.
+	 */
+	u64 ctx_id;
+
 #ifdef CONFIG_MODIFY_LDT_SYSCALL
 	struct ldt_struct *ldt;
 #endif
@@ -33,6 +39,11 @@ typedef struct {
 #endif
 } mm_context_t;
 
+#define INIT_MM_CONTEXT(mm)						\
+	.context = {							\
+		.ctx_id = 1,						\
+	}
+
 void leave_mm(int cpu);
 
 #endif /* _ASM_X86_MMU_H */
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -12,6 +12,9 @@
 #include <asm/tlbflush.h>
 #include <asm/paravirt.h>
 #include <asm/mpx.h>
+
+extern atomic64_t last_mm_ctx_id;
+
 #ifndef CONFIG_PARAVIRT
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
@@ -106,6 +109,8 @@ static inline void enter_lazy_tlb(struct
 static inline int init_new_context(struct task_struct *tsk,
 				   struct mm_struct *mm)
 {
+	mm->context.ctx_id = atomic64_inc_return(&last_mm_ctx_id);
+
 	#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 	if (cpu_feature_enabled(X86_FEATURE_OSPKE)) {
 		/* pkey 0 is the default and always allocated */
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -29,6 +29,8 @@
  *	Implement flush IPI by CALL_FUNCTION_VECTOR, Alex Shi
  */
 
+atomic64_t last_mm_ctx_id = ATOMIC64_INIT(1);
+
 struct flush_tlb_info {
 	struct mm_struct *flush_mm;
 	unsigned long flush_start;
