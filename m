Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CFCC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 849AA20892
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849AA20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbeLETuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:50:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbeLETuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:50:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 79380307DAA2;
        Wed,  5 Dec 2018 19:50:00 +0000 (UTC)
Received: from llong.com (dhcp-17-55.bos.redhat.com [10.18.17.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83EF41DB;
        Wed,  5 Dec 2018 19:49:59 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] x86/speculation: switch_to_cond_stibp on is the likely case
Date:   Wed,  5 Dec 2018 14:49:28 -0500
Message-Id: <1544039368-9009-2-git-send-email-longman@redhat.com>
In-Reply-To: <1544039368-9009-1-git-send-email-longman@redhat.com>
References: <1544039368-9009-1-git-send-email-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 05 Dec 2018 19:50:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since conditional STIBP is the default, it should be treated as
the likely case. Changes the use of static_branch_unlikely() to
static_branch_likely() for switch_to_cond_stibp.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 arch/x86/kernel/process.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a68b32c..bd11119 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -153,7 +153,7 @@ void __init check_bugs(void)
 			hostval |= ssbd_tif_to_spec_ctrl(ti->flags);
 
 		/* Conditional STIBP enabled? */
-		if (static_branch_unlikely(&switch_to_cond_stibp))
+		if (static_branch_likely(&switch_to_cond_stibp))
 			hostval |= stibp_tif_to_spec_ctrl(ti->flags);
 
 		if (hostval != guestval) {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 7d31192..39a21ae 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -434,7 +434,7 @@ static __always_inline void __speculation_ctrl_update(unsigned long tifp,
 	 * otherwise avoid the MSR write.
 	 */
 	if (IS_ENABLED(CONFIG_SMP) &&
-	    static_branch_unlikely(&switch_to_cond_stibp)) {
+	    static_branch_likely(&switch_to_cond_stibp)) {
 		updmsr |= !!(tif_diff & _TIF_SPEC_IB);
 		msr |= stibp_tif_to_spec_ctrl(tifn);
 	}
-- 
1.8.3.1

