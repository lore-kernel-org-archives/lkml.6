Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756010AbeEaR7L (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 13:59:11 -0400
Received: from mga01.intel.com ([192.55.52.88]:18552 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755933AbeEaR65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:58:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="60725507"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 04/15] x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to
Date: Thu, 31 May 2018 10:58:34 -0700
Message-Id: <1527789525-8857-5-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open code, load_fsgs() will cleanup __switch_to
and symmetric with FS/GS segment save. When FSGSBASE
enabled, X86_FEATURE_FSGSBASE check will be incorporated.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/process_64.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e498671..cebf240 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -279,6 +279,15 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
+static __always_inline void load_fsgs(struct thread_struct *prev,
+				      struct thread_struct *next)
+{
+	load_seg_legacy(prev->fsindex, prev->fsbase,
+			next->fsindex, next->fsbase, FS);
+	load_seg_legacy(prev->gsindex, prev->gsbase,
+			next->gsindex, next->gsbase, GS);
+}
+
 static unsigned long task_seg_base(struct task_struct *task,
 				   unsigned short selector)
 {
@@ -588,10 +597,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (unlikely(next->ds | prev->ds))
 		loadsegment(ds, next->ds);
 
-	load_seg_legacy(prev->fsindex, prev->fsbase,
-			next->fsindex, next->fsbase, FS);
-	load_seg_legacy(prev->gsindex, prev->gsbase,
-			next->gsindex, next->gsbase, GS);
+	load_fsgs(prev, next);
 
 	switch_fpu_finish(next_fpu, cpu);
 
-- 
2.7.4
