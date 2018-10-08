Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AA8C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C6E2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 09:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0C6E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbeJHRIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 13:08:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50653 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbeJHRIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 13:08:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w989v8IZ560154
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 02:57:08 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w989v8lQ560151;
        Mon, 8 Oct 2018 02:57:08 -0700
Date:   Mon, 8 Oct 2018 02:57:08 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   "tip-bot for Chang S. Bae" <tipbot@zytor.com>
Message-ID: <tip-f4550b52e495e1b634d1f2c1004bcea5dc3321ea@git.kernel.org>
Cc:     chang.seok.bae@intel.com, riel@surriel.com, bp@alien8.de,
        luto@amacapital.net, hpa@zytor.com, linux-kernel@vger.kernel.org,
        brgerst@gmail.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, luto@kernel.org,
        dave.hansen@linux.intel.com, ravi.v.shankar@intel.com,
        ak@linux.intel.com, mingo@kernel.org, markus.t.metzger@intel.com,
        dvlasenk@redhat.com, peterz@infradead.org
Reply-To: peterz@infradead.org, dvlasenk@redhat.com,
          markus.t.metzger@intel.com, mingo@kernel.org, ak@linux.intel.com,
          luto@kernel.org, dave.hansen@linux.intel.com,
          ravi.v.shankar@intel.com, torvalds@linux-foundation.org,
          tglx@linutronix.de, brgerst@gmail.com,
          linux-kernel@vger.kernel.org, luto@amacapital.net, hpa@zytor.com,
          bp@alien8.de, riel@surriel.com, chang.seok.bae@intel.com
In-Reply-To: <1537312139-5580-6-git-send-email-chang.seok.bae@intel.com>
References: <1537312139-5580-6-git-send-email-chang.seok.bae@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/asm] x86/fsgsbase/64: Factor out FS/GS segment loading
 from __switch_to()
Git-Commit-ID: f4550b52e495e1b634d1f2c1004bcea5dc3321ea
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  f4550b52e495e1b634d1f2c1004bcea5dc3321ea
Gitweb:     https://git.kernel.org/tip/f4550b52e495e1b634d1f2c1004bcea5dc3321ea
Author:     Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate: Tue, 18 Sep 2018 16:08:56 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 8 Oct 2018 10:41:09 +0200

x86/fsgsbase/64: Factor out FS/GS segment loading from __switch_to()

Instead of open coding the calls to load_seg_legacy(), introduce
x86_fsgsbase_load() to load FS/GS segments.

This makes it more explicit that this is part of FSGSBASE functionality,
and the new helper can be updated when FSGSBASE instructions are enabled.

[ mingo: Wrote new changelog. ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Markus T Metzger <markus.t.metzger@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Shankar <ravi.v.shankar@intel.com>
Cc: Rik van Riel <riel@surriel.com>
Link: http://lkml.kernel.org/r/1537312139-5580-6-git-send-email-chang.seok.bae@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/kernel/process_64.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e5fb0c3dee4d..d6674a425714 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -287,6 +287,15 @@ static __always_inline void load_seg_legacy(unsigned short prev_index,
 	}
 }
 
+static __always_inline void x86_fsgsbase_load(struct thread_struct *prev,
+					      struct thread_struct *next)
+{
+	load_seg_legacy(prev->fsindex, prev->fsbase,
+			next->fsindex, next->fsbase, FS);
+	load_seg_legacy(prev->gsindex, prev->gsbase,
+			next->gsindex, next->gsbase, GS);
+}
+
 static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
 					    unsigned short selector)
 {
@@ -597,10 +606,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	if (unlikely(next->ds | prev->ds))
 		loadsegment(ds, next->ds);
 
-	load_seg_legacy(prev->fsindex, prev->fsbase,
-			next->fsindex, next->fsbase, FS);
-	load_seg_legacy(prev->gsindex, prev->gsbase,
-			next->gsindex, next->gsbase, GS);
+	x86_fsgsbase_load(prev, next);
 
 	switch_fpu_finish(next_fpu, cpu);
 
