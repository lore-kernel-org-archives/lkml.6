Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3118FC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA65720652
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA65720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932623AbeFTXPd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:15:33 -0400
Received: from mga12.intel.com ([192.55.52.136]:65395 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754308AbeFTXP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:15:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2018 16:15:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,249,1526367600"; 
   d="scan'208";a="66325217"
Received: from chang-linux-2.sc.intel.com ([10.3.52.139])
  by orsmga001.jf.intel.com with ESMTP; 20 Jun 2018 16:15:26 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Markus T Metzger <markus.t.metzger@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/7] x86/fsgsbase/64: Factor out load FS/GS segments from __switch_to
Date:   Wed, 20 Jun 2018 16:15:03 -0700
Message-Id: <1529536506-26237-5-git-send-email-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of open coding the calls to load_seg_legacy(), add a
load_fsgs() helper to handle fs and gs.  When FSGSBASE is enabled,
load_fsgs() will be updated.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
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

