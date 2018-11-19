Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB5BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:46:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734BF2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFEkqj0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 734BF2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbeKTJMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:12:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:44784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731784AbeKTJLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:11:39 -0500
Received: from localhost (c-71-205-112-160.hsd1.co.comcast.net [71.205.112.160])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19CF213A2;
        Mon, 19 Nov 2018 22:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542667546;
        bh=OWzmIJbKZlrQWIvmwPfVwyRPqOV209QY46DfMLZNUOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=ZFEkqj0Ec4ya3mcu+hesbJJNIkqLipbtVDM2CS8g4pqVNtHtXMsTivXxNqy4284Zu
         JMvfuROvw7j1ZlEKyKgrzPhGczeEDNe05mtKyNMjlijTxbYVQ/tLgSkpRvzZ8mvHuG
         xd55789bIyF933Ftg1y0ad1A+yUWphpyevx3TYdQ=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 06/13] x86/fault: Improve the condition for signalling vs OOPSing
Date:   Mon, 19 Nov 2018 14:45:30 -0800
Message-Id: <10e509c43893170e262e82027ea399130ae81159.1542667307.git.luto@kernel.org>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
In-Reply-To: <cover.1542667307.git.luto@kernel.org>
References: <cover.1542667307.git.luto@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__bad_area_nosemaphore() currently checks the X86_PF_USER bit in the
error code to decide whether to send a signal or to treat the fault
as a kernel error.  This can cause somewhat erratic behavior.  The
straightforward cases where the CPL agrees with the hardware USER
bit are all correct, but the other cases are confusing.

 - A user instruction accessing a kernel address with supervisor
   privilege (e.g. a descriptor table access failed).  The USER bit
   will be clear, and we OOPS.  This is correct, because it indicates
   a kernel bug, not a user error.

 - A user instruction accessing a user address with supervisor
   privilege (e.g. a descriptor table was incorrectly pointing at
   user memory).  __bad_area_nosemaphore() will be passed a modified
   error code with the user bit set, and we will send a signal.
   Sending the signal will work (because the regs and the entry
   frame genuinely come from user mode), but we really ought to
   OOPS, as this event indicates a severe kernel bug.

 - A kernel instruction with user privilege (i.e. WRUSS).  This
   should OOPS or get fixed up.  The current code would instead try
   send a signal and malfunction.

Change the logic: a signal should be sent if the faulting context is
user mode *and* the access has user privilege.  Otherwise it's
either a kernel mode fault or a failed implicit access, either of
which should end up in no_context().

Note to -stable maintainers: don't backport this unless you backport
CET.  The bug it fixes is unobservable in current kernels unless
something is extremely wrong.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/mm/fault.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 95d94d48a10d..bd89b6f83aa2 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -794,7 +794,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 	struct task_struct *tsk = current;
 
 	/* User mode accesses just cause a SIGSEGV */
-	if (error_code & X86_PF_USER) {
+	if (user_mode(regs) && (error_code & X86_PF_USER)) {
 		/*
 		 * It's possible to have interrupts off here:
 		 */
-- 
2.17.2

