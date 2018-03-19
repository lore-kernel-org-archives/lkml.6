Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971732AbeCSUzc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:55:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:62510 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968554AbeCSSI4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330608"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 14/15] x86/fsgsbase/64: Support legacy behavior when FS/GS updated by ptracer
Date: Mon, 19 Mar 2018 10:49:26 -0700
Message-Id: <1521481767-22113-15-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When FSGSBASE enabled, ptracer's FS/GS selector update
fetches FS/GS base from GDT/LDT. This emulation of FS/GS
segment loading provides backward compatibility for the
legacy ptracers.

When ptracer sets FS/GS selector, its base is going to be
(accordingly) reloaded as the tracee resumes. This is without
FSGSBASE. With FSGSBASE, FS/GS base is preserved regardless
of its selector. Thus, emulating FS/GS load in ptrace is
requested to keep compatible with what has been with FS/GS
setting.

Additionally, whenever a new base value is written, the
FSGSBASE-enabled kernel allows the tracee effectively carry
on. This also means that when both selector and base are
changed, the base is not fetched from GDT/LDT, but
preserved as given.

In a summary, ptracer's update on FS/GS selector and base
yields such results on tracee's base:
- When FS/GS selector only changed (to nonzero), fetch base
from GDT/LDT (legacy behavior)
- When FS/GS base (regardless of selector) changed, tracee
will have the base

Suggested-by: Markus T. Metzger <markus.t.metzger@intel.com>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/asm/fsgsbase.h |  4 +++
 arch/x86/kernel/process_64.c    |  4 +--
 arch/x86/kernel/ptrace.c        | 68 +++++++++++++++++++++++++++++++++++------
 3 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index 76d3457..430ae40 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -17,6 +17,10 @@ unsigned long read_task_gsbase(struct task_struct *task);
 int write_task_fsbase(struct task_struct *task, unsigned long fsbase);
 int write_task_gsbase(struct task_struct *task, unsigned long gsbase);
 
+/* Read (FS/GS) base from GDT/LDT */
+unsigned long task_seg_base(struct task_struct *task,
+			    unsigned short selector);
+
 /*
  * Must be protected by X86_FEATURE_FSGSBASE check.
  */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 5aae132..ef32f75 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -328,8 +328,8 @@ static __always_inline void load_fsgs(struct thread_struct *prev,
 	}
 }
 
-static unsigned long task_seg_base(struct task_struct *task,
-				   unsigned short selector)
+unsigned long task_seg_base(struct task_struct *task,
+			    unsigned short selector)
 {
 	unsigned short idx = selector >> 3;
 	unsigned long base;
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index ee37e28..be3e022 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -307,14 +307,26 @@ static int set_segment_reg(struct task_struct *task,
 
 	switch (offset) {
 	case USER_REGS_OFFSET(fs):
-		task->thread.fsindex = value;
 		if (task == current)
-			loadsegment(fs, task->thread.fsindex);
+			loadsegment(fs, value);
+		/*
+		 * %fs setting goes to reload its base, when tracee
+		 * resumes without FSGSBASE (legacy). Here with FSGSBASE
+		 * FS base is (manually) fetched from GDT/LDT when needed.
+		 */
+		else if (static_cpu_has(X86_FEATURE_FSGSBASE) &&
+			 (value != 0) && (task->thread.fsindex != value))
+			task->thread.fsbase = task_seg_base(task, value);
+		task->thread.fsindex = value;
 		break;
 	case USER_REGS_OFFSET(gs):
-		task->thread.gsindex = value;
 		if (task == current)
-			load_gs_index(task->thread.gsindex);
+			load_gs_index(value);
+		/* Same as %fs handling above */
+		else if (static_cpu_has(X86_FEATURE_FSGSBASE) &&
+			 (value != 0) && (task->thread.gsindex != value))
+			task->thread.gsbase = task_seg_base(task, value);
+		task->thread.gsindex = value;
 		break;
 	case USER_REGS_OFFSET(ds):
 		task->thread.ds = value;
@@ -433,14 +445,31 @@ static int putregs(struct task_struct *child,
 			((offset + count) >= USER_REGS_OFFSET(fs));
 	bool gs_fully_covered = (offset <= USER_REGS_OFFSET(gs_base)) &&
 			((offset + count) >= USER_REGS_OFFSET(gs));
+	bool fs_updated = false, gs_updated = false;
 
 	offset += count - sizeof(*v);
 
 	while (count >= sizeof(*v) && !ret) {
 		v--;
 		switch (offset) {
+		case USER_REGS_OFFSET(fs):
+			if (fs_fully_covered &&
+			    static_cpu_has(X86_FEATURE_FSGSBASE)) {
+				if (invalid_selector(*v))
+					return -EIO;
+				/*
+				 * Set the flag to fetch fsbase from GDT/LDT
+				 * with FSGSBASE
+				 */
+				fs_updated = (*v != 0) &&
+					(child->thread.fsindex != *v);
+				child->thread.fsindex = *v;
+				break;
+			}
 		case USER_REGS_OFFSET(fs_base):
 			if (fs_fully_covered) {
+				struct thread_struct *thread = &child->thread;
+
 				if (unlikely(*v >= TASK_SIZE_MAX))
 					return -EIO;
 				/*
@@ -448,17 +477,38 @@ static int putregs(struct task_struct *child,
 				 * write_task_fsbase() tends to overwrite
 				 * task's %fs. Simply setting base only here.
 				 */
-				if (child->thread.fsbase != *v)
-					child->thread.fsbase = *v;
+				if (thread->fsbase != *v)
+					thread->fsbase = *v;
+				else if (fs_updated)
+					thread->fsbase =
+						task_seg_base(child,
+							      thread->fsindex);
+				break;
+			}
+		case USER_REGS_OFFSET(gs):
+			if (gs_fully_covered &&
+			    static_cpu_has(X86_FEATURE_FSGSBASE)) {
+				if (invalid_selector(*v))
+					return -EIO;
+				/* Same here as the %fs handling above */
+				gs_updated = (*v != 0) &&
+					(child->thread.gsindex != *v);
+				child->thread.gsindex = *v;
 				break;
 			}
 		case USER_REGS_OFFSET(gs_base):
 			if (gs_fully_covered) {
+				struct thread_struct *thread = &child->thread;
+
 				if (unlikely(*v >= TASK_SIZE_MAX))
 					return -EIO;
-				/* Same here as the %fs handling above */
-				if (child->thread.gsbase != *v)
-					child->thread.gsbase = *v;
+				/* Same here as the %fs_base handling above */
+				if (thread->gsbase != *v)
+					thread->gsbase = *v;
+				else if (gs_updated)
+					thread->gsbase =
+						task_seg_base(child,
+							      thread->gsindex);
 				break;
 			}
 		default:
-- 
2.7.4
