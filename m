Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971755AbeCSUzu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:55:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:62509 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968538AbeCSSIz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 14:08:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="39330599"
From: "Chang S. Bae" <chang.seok.bae@intel.com>
To: x86@kernel.org
Cc: luto@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        markus.t.metzger@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: [PATCH 12/15] x86/fsgsbase/64: When copying a thread, use FSGSBASE if enabled
Date: Mon, 19 Mar 2018 10:49:24 -0700
Message-Id: <1521481767-22113-13-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
References: <1521481767-22113-1-git-send-email-chang.seok.bae@intel.com>
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
---
 arch/x86/kernel/process_64.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 7249a54..5aae132 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -491,10 +491,16 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap_ptr = NULL;
 
-	savesegment(gs, p->thread.gsindex);
-	p->thread.gsbase = p->thread.gsindex ? 0 : me->thread.gsbase;
 	savesegment(fs, p->thread.fsindex);
-	p->thread.fsbase = p->thread.fsindex ? 0 : me->thread.fsbase;
+	savesegment(gs, p->thread.gsindex);
+	if (static_cpu_has(X86_FEATURE_FSGSBASE)) {
+		p->thread.fsbase = rdfsbase();
+		p->thread.gsbase = rd_shadow_gsbase();
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
