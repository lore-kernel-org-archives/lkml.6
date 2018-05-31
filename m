Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932862AbeEaSAO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:00:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:18555 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755981AbeEaR7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 13:59:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="60725537"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: Andy Lutomirski <luto@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 11/15] x86/fsgsbase/64: When copying a thread, use FSGSBASE if enabled
Date: Thu, 31 May 2018 10:58:41 -0700
Message-Id: <1527789525-8857-12-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When FSGSBASE enabled, copy real FS/GS base values instead
of approximation.

Factor out to save_fsgs() does not yield the exact same
behavior, because save_base_legacy() does not copy FS/GS base
when index is zero.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/process_64.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 55af719..8f9f2f9 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -505,10 +505,16 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap_ptr = NULL;
 
-	savesegment(gs, p->thread.gsindex);
-	p->thread.gsbase = p->thread.gsindex ? 0 : me->thread.gsbase;
 	savesegment(fs, p->thread.fsindex);
-	p->thread.fsbase = p->thread.fsindex ? 0 : me->thread.fsbase;
+	savesegment(gs, p->thread.gsindex);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		p->thread.fsbase = rdfsbase();
+		p->thread.gsbase = rd_inactive_gsbase();
+	} else {
+		/* save_base_legacy() does not set base when index is zero. */
+		p->thread.fsbase = p->thread.fsindex ? 0 : me->thread.fsbase;
+		p->thread.gsbase = p->thread.gsindex ? 0 : me->thread.gsbase;
+	}
 	savesegment(es, p->thread.es);
 	savesegment(ds, p->thread.ds);
 	memset(p->thread.ptrace_bps, 0, sizeof(p->thread.ptrace_bps));
-- 
2.7.4
