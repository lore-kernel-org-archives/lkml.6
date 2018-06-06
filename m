Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 95998601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753568AbeFFQXi (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 12:23:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:61008 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753432AbeFFQXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 12:23:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,483,1520924400";
   d="scan'208";a="62323469"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/8] x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to
Date: Wed,  6 Jun 2018 09:23:15 -0700
Message-Id: <1528302199-29619-5-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com>
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
Reviewed-by: Andy Lutomirski <luto@kernel.org>
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
