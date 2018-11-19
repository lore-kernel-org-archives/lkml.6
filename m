Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D022C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F4220851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibFmcHJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F4220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731842AbeKTJLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:11:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:44896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731808AbeKTJLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:41 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACCDD2146D;
        Mon, 19 Nov 2018 22:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667548;
        bh=HLpi73lMMNR3GIs+xoNLaTO8Hek5mPQJG2bz+2UXbmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ibFmcHJBRM+LVXNegWr6gnBNKLd32iwN1smKkPRnFpeBVNUsBWXF9gsl4we2nSXvi
         MRBqOMXwjG/bOp24C/+zLVZrvocCXxqfPdFlCgUDa6itu7kozmWioCqN6/8Tctwurn
         V146B2YxIT5+otG3YGou+Q8TzjN9we/6rO1jT/14=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 08/13] x86/fault: Don't set thread.cr2, etc before OOPSing
Date:   Mon, 19 Nov 2018 14:45:32 -0800
Message-Id: <d418022aa0fad9cb40467aa7acaf4e95be50ee96.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fault handling code sets the cr2, trap_nr, and error_code fields
in thread_struct before OOPSing.  No one reads those fields during
an OOPS, so remove the code to set them.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index fac931d89c23..a6554110ef62 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -621,10 +621,6 @@ pgtable_bad(struct pt_regs *regs, unsigned long error_code,
 	       tsk->comm, address);
 	dump_pagetable(address);
 
-	tsk->thread.cr2		= address;
-	tsk->thread.trap_nr	= X86_TRAP_PF;
-	tsk->thread.error_code	= error_code;
-
 	if (__die("Bad pagetable", regs, error_code))
 		sig = 0;
 
@@ -753,10 +749,6 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (task_stack_end_corrupted(tsk))
 		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
 
-	tsk->thread.cr2		= address;
-	tsk->thread.trap_nr	= X86_TRAP_PF;
-	tsk->thread.error_code	= error_code;
-
 	sig = SIGKILL;
 	if (__die("Oops", regs, error_code))
 		sig = 0;
-- 
2.17.2

