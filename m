Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id n5CEJKlYGVsgAwAAmS7hNA
	; Thu, 07 Jun 2018 16:10:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0C537607E7; Thu,  7 Jun 2018 16:10:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A46FE60590;
	Thu,  7 Jun 2018 16:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A46FE60590
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935238AbeFGQJJ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 12:09:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39207 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932989AbeFGOJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:02 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb1-0005Zx-Qx; Thu, 07 Jun 2018 15:08:59 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvay-0002ik-6O; Thu, 07 Jun 2018 15:08:56 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Steven Rostedt" <rostedt@goodmis.org>,
        "Masami Hiramatsu" <masami.hiramatsu.pt@hitachi.com>,
        "Wang Nan" <wangnan0@huawei.com>, "Ingo Molnar" <mingo@kernel.org>,
        "" <dave.hansen@linux.intel.com>, "" <oleg@redhat.com>,
        "" <lizefan@huawei.com>, "" <luto@amacapital.net>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.843909735@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 033/410] x86/traps: Enable DEBUG_STACK after
 cpu_init() for TRAP_DB/BP
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Nan <wangnan0@huawei.com>

commit b4d8327024637cb2a1f7910dcb5d0ad7a096f473 upstream.

Before this patch early_trap_init() installs DEBUG_STACK for
X86_TRAP_BP and X86_TRAP_DB. However, DEBUG_STACK doesn't work
correctly until cpu_init() <-- trap_init().

This patch passes 0 to set_intr_gate_ist() and
set_system_intr_gate_ist() instead of DEBUG_STACK to let it use
same stack as kernel, and installs DEBUG_STACK for them in
trap_init().

As core runs at ring 0 between early_trap_init() and
trap_init(), there is no chance to get a bad stack before
trap_init().

As NMI is also enabled in trap_init(), we don't need to care
about is_debug_stack() and related things used in
arch/x86/kernel/nmi.c.

Signed-off-by: Wang Nan <wangnan0@huawei.com>
Reviewed-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Acked-by: Steven Rostedt <rostedt@goodmis.org>
Cc: <dave.hansen@linux.intel.com>
Cc: <lizefan@huawei.com>
Cc: <luto@amacapital.net>
Cc: <oleg@redhat.com>
Link: http://lkml.kernel.org/r/1424929779-13174-1-git-send-email-wangnan0@huawei.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/traps.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -773,9 +773,17 @@ dotraplinkage void do_iret_error(struct
 /* Set of traps needed for early debugging. */
 void __init early_trap_init(void)
 {
-	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
+	/*
+	 * Don't set ist to DEBUG_STACK as it doesn't work until TSS is
+	 * ready in cpu_init() <-- trap_init(). Before trap_init(), CPU
+	 * runs at ring 0 so it is impossible to hit an invalid stack.
+	 * Using the original stack works well enough at this early
+	 * stage. DEBUG_STACK will be equipped after cpu_init() in
+	 * trap_init().
+	 */
+	set_intr_gate_ist(X86_TRAP_DB, &debug, 0);
 	/* int3 can be called from all */
-	set_system_intr_gate_ist(X86_TRAP_BP, &int3, DEBUG_STACK);
+	set_system_intr_gate_ist(X86_TRAP_BP, &int3, 0);
 #ifdef CONFIG_X86_32
 	set_intr_gate(X86_TRAP_PF, page_fault);
 #endif
@@ -853,6 +861,15 @@ void __init trap_init(void)
 	 */
 	cpu_init();
 
+	/*
+	 * X86_TRAP_DB and X86_TRAP_BP have been set
+	 * in early_trap_init(). However, DEBUG_STACK works only after
+	 * cpu_init() loads TSS. See comments in early_trap_init().
+	 */
+	set_intr_gate_ist(X86_TRAP_DB, &debug, DEBUG_STACK);
+	/* int3 can be called from all */
+	set_system_intr_gate_ist(X86_TRAP_BP, &int3, DEBUG_STACK);
+
 	x86_init.irqs.trap_init();
 
 #ifdef CONFIG_X86_64
