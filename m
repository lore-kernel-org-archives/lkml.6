Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45DCC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E972133F
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E972133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeLETuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:50:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeLETt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:49:59 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 639E6307CDD4;
        Wed,  5 Dec 2018 19:49:59 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 396BC194AF;
        Wed,  5 Dec 2018 19:49:56 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/2] x86/speculation: Change STIPB to STIBP
Date:   Wed,  5 Dec 2018 14:49:27 -0500
Message-Id: <1544039368-9009-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 05 Dec 2018 19:49:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STIBP stands for Single Thread Indirect Branch Predictors. The acronym,
however, can be easily mis-spelled as STIPB. It is perhaps due to the
presence of another related term - IBPB (Indirect Branch Predictor
Barrier).

Fix the mis-spelling in the code.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/cpu/bugs.c | 6 +++---
 arch/x86/kernel/process.h  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 500278f..a68b32c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -54,7 +54,7 @@
 u64 __ro_after_init x86_amd_ls_cfg_base;
 u64 __ro_after_init x86_amd_ls_cfg_ssbd_mask;
 
-/* Control conditional STIPB in switch_to() */
+/* Control conditional STIBP in switch_to() */
 DEFINE_STATIC_KEY_FALSE(switch_to_cond_stibp);
 /* Control conditional IBPB in switch_mm() */
 DEFINE_STATIC_KEY_FALSE(switch_mm_cond_ibpb);
@@ -379,12 +379,12 @@ static void __init spec_v2_user_print_cond(const char *reason, bool secure)
 			"always-on" : "conditional");
 	}
 
-	/* If enhanced IBRS is enabled no STIPB required */
+	/* If enhanced IBRS is enabled no STIBP required */
 	if (spectre_v2_enabled == SPECTRE_V2_IBRS_ENHANCED)
 		return;
 
 	/*
-	 * If SMT is not possible or STIBP is not available clear the STIPB
+	 * If SMT is not possible or STIBP is not available clear the STIBP
 	 * mode.
 	 */
 	if (!smt_possible || !boot_cpu_has(X86_FEATURE_STIBP))
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 898e97c..320ab97 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -19,7 +19,7 @@ static inline void switch_to_extra(struct task_struct *prev,
 	if (IS_ENABLED(CONFIG_SMP)) {
 		/*
 		 * Avoid __switch_to_xtra() invocation when conditional
-		 * STIPB is disabled and the only different bit is
+		 * STIBP is disabled and the only different bit is
 		 * TIF_SPEC_IB. For CONFIG_SMP=n TIF_SPEC_IB is not
 		 * in the TIF_WORK_CTXSW masks.
 		 */
-- 
1.8.3.1

