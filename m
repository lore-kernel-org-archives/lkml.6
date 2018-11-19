Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B17C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D69920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vx0T1BEj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D69920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732005AbeKTJMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:12:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbeKTJLh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:37 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C3320C01;
        Mon, 19 Nov 2018 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667544;
        bh=hspd7+YSGF4H5UoVQjihTz8YwVIWRwdU+/U2giuzSNs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=vx0T1BEjJ5Oeg0N1oL7EWvX/Jm/T9wrXKsYyo62WEmNyVMBhhQ9NkCNjtO/jG5QJE
         J7mIZQGlnsyYZRJ80pvGIAywrVW4vTYascBfjoFAPpl/EDCOd/9MxImSe8ETfdXy8y
         OTiPcnKw25gbX8Mhde3s48Uq5qR/m+qN8znrMPCY=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 04/13] x86/fault: Fold smap_violation() into do_user_addr_fault()
Date:   Mon, 19 Nov 2018 14:45:28 -0800
Message-Id: <806c366f6ca861152398ce2c01744d59d9aceb6d.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smap_violation() has a single caller, and the contents are a bit
nonsensical.  I'm going to fix it, but first let's fold it into its
caller for ease of comprehension.

In this particular case, the user_mode(regs) check is incorrect --
it will cause false positives in the case of a user-initiated
kernel-privileged access.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 0597342d4a55..c50cd67521b6 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1148,20 +1148,6 @@ static int fault_in_kernel_space(unsigned long address)
 	return address >= TASK_SIZE_MAX;
 }
 
-static inline bool smap_violation(int error_code, struct pt_regs *regs)
-{
-	if (!cpu_feature_enabled(X86_FEATURE_SMAP))
-		return false;
-
-	if (error_code & X86_PF_USER)
-		return false;
-
-	if (!user_mode(regs) && (regs->flags & X86_EFLAGS_AC))
-		return false;
-
-	return true;
-}
-
 /*
  * Called for all faults where 'address' is part of the kernel address
  * space.  Might get called for faults that originate from *code* that
@@ -1249,10 +1235,13 @@ void do_user_addr_fault(struct pt_regs *regs,
 		pgtable_bad(regs, hw_error_code, address);
 
 	/*
-	 * Check for invalid kernel (supervisor) access to user
-	 * pages in the user address space.
+	 * If SMAP is on, check for invalid kernel (supervisor)
+	 * access to user pages in the user address space.
 	 */
-	if (unlikely(smap_violation(hw_error_code, regs))) {
+	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
+		     !(hw_error_code & X86_PF_USER) &&
+		     (user_mode(regs) || !(regs->flags & X86_EFLAGS_AC))))
+	{
 		bad_area_nosemaphore(regs, hw_error_code, address);
 		return;
 	}
-- 
2.17.2

