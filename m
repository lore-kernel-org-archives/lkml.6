Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8B2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44EB2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctMxXUU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44EB2148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbeKTJLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:11:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730419AbeKTJLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:35 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD853208E3;
        Mon, 19 Nov 2018 22:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667542;
        bh=MzcxZmK5e+MGjf4ZpuNMiLcJmHonRaL5XZvydYAL3Pc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ctMxXUU9NKQubjVzK5AiKKbQLHApCuc2Ch96ZmHcWB0uHdis80mkfASaLmtgG81M9
         q0crBHsIif+7fT+/8muqxlMR7zz/As1cPzxMNImwXCUyDa8jkDs+pR8+i/LE4J40m5
         FULK5v2q1F0FBj2chuOB+XIfAlta42lPs1qkNdVs=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 02/13] x86/fault: Check user_mode(regs) when validating a stack extension
Date:   Mon, 19 Nov 2018 14:45:26 -0800
Message-Id: <e2e8e92d67d64700ba88aec73a4fc2b7986c0f87.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fault handling code tries to validate that a page fault from
user mode that would extend the stack is within a certain range of
the user SP.  regs->sp is only equal to the user SP if
user_mode(regs).  In the extremely unlikely event that that
sw_error_code had the USER bit set but the faulting instruction was
in the kernel (i.e. the faulting instruction was WRUSS), then the
*kernel* stack pointer would have been checked, which would be an
info leak.

Note to -stable maintainers: don't backport this unless you backport
CET.  The bug it fixes is unobservable in current kernels.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 91d4d2722f2e..eae7ee3ce89b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1377,7 +1377,7 @@ void do_user_addr_fault(struct pt_regs *regs,
 		bad_area(regs, sw_error_code, address);
 		return;
 	}
-	if (sw_error_code & X86_PF_USER) {
+	if (user_mode(regs)) {
 		/*
 		 * Accessing the stack below %sp is always a bug.
 		 * The large cushion allows instructions like enter
-- 
2.17.2

