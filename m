Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4322AC43610
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08903214E0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnGlZUjV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08903214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbeKTJLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:11:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:44756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731725AbeKTJLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:38 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D542147A;
        Mon, 19 Nov 2018 22:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667545;
        bh=mNZjfv8td9He4V53KWiC9y9xI2RDeHgEeANThIq7IX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=nnGlZUjVwfPfeIpCJwmNhdGXvP6SOJvpHZ0BjokBhjfqO1HQGRQjnw0r2WEj7M5wm
         WG22XQFZ4V/O6cFh+aoaXYOWMkQWCZd0uiaJ5YVwhpu7q4DSQztr/JkN+moqK0BkFP
         mbIGY2cpU3mX3Y9Am3CVqVbcHDiZYIHKyyHhfAIk=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 05/13] x86/fault: Fix SMAP #PF handling buglet for implicit supervisor accesses
Date:   Mon, 19 Nov 2018 14:45:29 -0800
Message-Id: <d1d1b2e66ef31f884dba172084486ea9423ddcdb.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if a user program somehow triggers an implicit supervisor
access to a user address (e.g. if the kernel somehow sets LDTR to a
user address), it will be incorrectly detected as a SMAP violation
if AC is clear and SMAP is enabled.  This is incorrect -- the error
has nothing to do with SMAP.  Fix the condition so that only
accesses with the hardware USER bit set are diagnosed as SMAP
violations.

With the logic fixed, an implicit supervisor access to a user address
will hit the code lower in the function that is intended to handle it
even if SMAP is enabled.  That logic is still a bit buggy, and later
patches will clean it up.

I *think* this code is still correct for WRUSS, and I've added a
comment to that effect.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index c50cd67521b6..95d94d48a10d 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1235,12 +1235,15 @@ void do_user_addr_fault(struct pt_regs *regs,
 		pgtable_bad(regs, hw_error_code, address);
 
 	/*
-	 * If SMAP is on, check for invalid kernel (supervisor)
-	 * access to user pages in the user address space.
+	 * If SMAP is on, check for invalid kernel (supervisor) access to user
+	 * pages in the user address space.  The odd case here is WRUSS,
+	 * which, according to the preliminary documentation, does not respect
+	 * SMAP and will have the USER bit set so, in all cases, SMAP
+	 * enforcement appears to be consistent with the USER bit.
 	 */
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
 		     !(hw_error_code & X86_PF_USER) &&
-		     (user_mode(regs) || !(regs->flags & X86_EFLAGS_AC))))
+		     !(regs->flags & X86_EFLAGS_AC)))
 	{
 		bad_area_nosemaphore(regs, hw_error_code, address);
 		return;
-- 
2.17.2

