Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971823AbeCSU4m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:56:42 -0400
Received: from mga14.intel.com ([192.55.52.115]:62510 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968202AbeCSSIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330573"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 05/15] x86/ptrace: A new macro to get an offset of user_regs_struct
Date: Mon, 19 Mar 2018 10:49:17 -0700
Message-Id: <1521481767-22113-6-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Proliferation of offsetof() for user_regs_struct is trimmed
down with the USER_REGS_OFFSET macro.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/kernel/ptrace.c | 78 +++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 38 deletions(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index b2f0beb..d8a1e1b 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -149,6 +149,8 @@ static inline bool invalid_selector(u16 value)
 	return unlikely(value != 0 && (value & SEGMENT_RPL_MASK) != USER_RPL);
 }
 
+#define USER_REGS_OFFSET(r) offsetof(struct user_regs_struct, r)
+
 #ifdef CONFIG_X86_32
 
 #define FLAG_MASK		FLAG_MASK_32
@@ -194,7 +196,7 @@ static u16 get_segment_reg(struct task_struct *task, unsigned long offset)
 	 * Returning the value truncates it to 16 bits.
 	 */
 	unsigned int retval;
-	if (offset != offsetof(struct user_regs_struct, gs))
+	if (offset != USER_REGS_OFFSET(gs))
 		retval = *pt_regs_access(task_pt_regs(task), offset);
 	else {
 		if (task == current)
@@ -224,8 +226,8 @@ static int set_segment_reg(struct task_struct *task,
 	 * safely use invalid selectors) from a kernel trap frame.
 	 */
 	switch (offset) {
-	case offsetof(struct user_regs_struct, cs):
-	case offsetof(struct user_regs_struct, ss):
+	case USER_REGS_OFFSET(cs):
+	case USER_REGS_OFFSET(ss):
 		if (unlikely(value == 0))
 			return -EIO;
 
@@ -233,7 +235,7 @@ static int set_segment_reg(struct task_struct *task,
 		*pt_regs_access(task_pt_regs(task), offset) = value;
 		break;
 
-	case offsetof(struct user_regs_struct, gs):
+	case USER_REGS_OFFSET(gs):
 		if (task == current)
 			set_user_gs(task_pt_regs(task), value);
 		else
@@ -261,34 +263,34 @@ static u16 get_segment_reg(struct task_struct *task, unsigned long offset)
 	unsigned int seg;
 
 	switch (offset) {
-	case offsetof(struct user_regs_struct, fs):
+	case USER_REGS_OFFSET(fs):
 		if (task == current) {
 			/* Older gas can't assemble movq %?s,%r?? */
 			asm("movl %%fs,%0" : "=r" (seg));
 			return seg;
 		}
 		return task->thread.fsindex;
-	case offsetof(struct user_regs_struct, gs):
+	case USER_REGS_OFFSET(gs):
 		if (task == current) {
 			asm("movl %%gs,%0" : "=r" (seg));
 			return seg;
 		}
 		return task->thread.gsindex;
-	case offsetof(struct user_regs_struct, ds):
+	case USER_REGS_OFFSET(ds):
 		if (task == current) {
 			asm("movl %%ds,%0" : "=r" (seg));
 			return seg;
 		}
 		return task->thread.ds;
-	case offsetof(struct user_regs_struct, es):
+	case USER_REGS_OFFSET(es):
 		if (task == current) {
 			asm("movl %%es,%0" : "=r" (seg));
 			return seg;
 		}
 		return task->thread.es;
 
-	case offsetof(struct user_regs_struct, cs):
-	case offsetof(struct user_regs_struct, ss):
+	case USER_REGS_OFFSET(cs):
+	case USER_REGS_OFFSET(ss):
 		break;
 	}
 	return *pt_regs_access(task_pt_regs(task), offset);
@@ -304,22 +306,22 @@ static int set_segment_reg(struct task_struct *task,
 		return -EIO;
 
 	switch (offset) {
-	case offsetof(struct user_regs_struct,fs):
+	case USER_REGS_OFFSET(fs):
 		task->thread.fsindex = value;
 		if (task == current)
 			loadsegment(fs, task->thread.fsindex);
 		break;
-	case offsetof(struct user_regs_struct,gs):
+	case USER_REGS_OFFSET(gs):
 		task->thread.gsindex = value;
 		if (task == current)
 			load_gs_index(task->thread.gsindex);
 		break;
-	case offsetof(struct user_regs_struct,ds):
+	case USER_REGS_OFFSET(ds):
 		task->thread.ds = value;
 		if (task == current)
 			loadsegment(ds, task->thread.ds);
 		break;
-	case offsetof(struct user_regs_struct,es):
+	case USER_REGS_OFFSET(es):
 		task->thread.es = value;
 		if (task == current)
 			loadsegment(es, task->thread.es);
@@ -328,12 +330,12 @@ static int set_segment_reg(struct task_struct *task,
 		/*
 		 * Can't actually change these in 64-bit mode.
 		 */
-	case offsetof(struct user_regs_struct,cs):
+	case USER_REGS_OFFSET(cs):
 		if (unlikely(value == 0))
 			return -EIO;
 		task_pt_regs(task)->cs = value;
 		break;
-	case offsetof(struct user_regs_struct,ss):
+	case USER_REGS_OFFSET(ss):
 		if (unlikely(value == 0))
 			return -EIO;
 		task_pt_regs(task)->ss = value;
@@ -381,19 +383,19 @@ static int putreg(struct task_struct *child,
 		  unsigned long offset, unsigned long value)
 {
 	switch (offset) {
-	case offsetof(struct user_regs_struct, cs):
-	case offsetof(struct user_regs_struct, ds):
-	case offsetof(struct user_regs_struct, es):
-	case offsetof(struct user_regs_struct, fs):
-	case offsetof(struct user_regs_struct, gs):
-	case offsetof(struct user_regs_struct, ss):
+	case USER_REGS_OFFSET(cs):
+	case USER_REGS_OFFSET(ds):
+	case USER_REGS_OFFSET(es):
+	case USER_REGS_OFFSET(fs):
+	case USER_REGS_OFFSET(gs):
+	case USER_REGS_OFFSET(ss):
 		return set_segment_reg(child, offset, value);
 
-	case offsetof(struct user_regs_struct, flags):
+	case USER_REGS_OFFSET(flags):
 		return set_flags(child, value);
 
 #ifdef CONFIG_X86_64
-	case offsetof(struct user_regs_struct,fs_base):
+	case USER_REGS_OFFSET(fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		/*
@@ -403,7 +405,7 @@ static int putreg(struct task_struct *child,
 		if (child->thread.fsbase != value)
 			return write_task_fsbase(child, value);
 		return 0;
-	case offsetof(struct user_regs_struct,gs_base):
+	case USER_REGS_OFFSET(gs_base):
 		/*
 		 * Exactly the same here as the %fs handling above.
 		 */
@@ -422,21 +424,21 @@ static int putreg(struct task_struct *child,
 static unsigned long getreg(struct task_struct *task, unsigned long offset)
 {
 	switch (offset) {
-	case offsetof(struct user_regs_struct, cs):
-	case offsetof(struct user_regs_struct, ds):
-	case offsetof(struct user_regs_struct, es):
-	case offsetof(struct user_regs_struct, fs):
-	case offsetof(struct user_regs_struct, gs):
-	case offsetof(struct user_regs_struct, ss):
+	case USER_REGS_OFFSET(cs):
+	case USER_REGS_OFFSET(ds):
+	case USER_REGS_OFFSET(es):
+	case USER_REGS_OFFSET(fs):
+	case USER_REGS_OFFSET(gs):
+	case USER_REGS_OFFSET(ss):
 		return get_segment_reg(task, offset);
 
-	case offsetof(struct user_regs_struct, flags):
+	case USER_REGS_OFFSET(flags):
 		return get_flags(task);
 
 #ifdef CONFIG_X86_64
-	case offsetof(struct user_regs_struct, fs_base):
+	case USER_REGS_OFFSET(fs_base):
 		return read_task_fsbase(task);
-	case offsetof(struct user_regs_struct, gs_base):
+	case USER_REGS_OFFSET(gs_base):
 		return read_task_gsbase(task);
 #endif
 	}
@@ -885,7 +887,7 @@ long arch_ptrace(struct task_struct *child, long request,
 #define SEG32(rs)							\
 	case offsetof(struct user32, regs.rs):				\
 		return set_segment_reg(child,				\
-				       offsetof(struct user_regs_struct, rs), \
+				       USER_REGS_OFFSET(rs), \
 				       value);				\
 		break
 
@@ -959,7 +961,7 @@ static int putreg32(struct task_struct *child, unsigned regno, u32 value)
 #define SEG32(rs)							\
 	case offsetof(struct user32, regs.rs):				\
 		*val = get_segment_reg(child,				\
-				       offsetof(struct user_regs_struct, rs)); \
+				       USER_REGS_OFFSET(rs)); \
 		break
 
 static int getreg32(struct task_struct *child, unsigned regno, u32 *val)
@@ -1153,7 +1155,7 @@ static long x32_arch_ptrace(struct task_struct *child,
 
 		ret = -EIO;
 		if ((addr & (sizeof(data) - 1)) || addr >= sizeof(struct user) ||
-		    addr < offsetof(struct user_regs_struct, cs))
+		    addr < USER_REGS_OFFSET(cs))
 			break;
 
 		tmp = 0;  /* Default return condition */
@@ -1174,7 +1176,7 @@ static long x32_arch_ptrace(struct task_struct *child,
 	case PTRACE_POKEUSR:
 		ret = -EIO;
 		if ((addr & (sizeof(data) - 1)) || addr >= sizeof(struct user) ||
-		    addr < offsetof(struct user_regs_struct, cs))
+		    addr < USER_REGS_OFFSET(cs))
 			break;
 
 		if (addr < sizeof(struct user_regs_struct))
-- 
2.7.4
