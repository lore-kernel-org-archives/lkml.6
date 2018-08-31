Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B750FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6250820839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 08:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6250820839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbeHaMK3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 08:10:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:41450 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbeHaMK3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 08:10:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8BBFADD8;
        Fri, 31 Aug 2018 08:04:14 +0000 (UTC)
Date:   Fri, 31 Aug 2018 10:04:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/dumpstack: fix address space casting in
 show_opcodes()
Message-ID: <20180831080441.GB3354@nazgul.tnic>
References: <20180830194736.210039-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180830194736.210039-1-jannh@google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:47:36PM +0200, Jann Horn wrote:
> I sloppily passed a kernel-typed pointer to __range_not_ok(), and sparse
> doesn't like that.
> Make `prologue` a __user pointer (to protect against accidental
> dereferences) and force-cast it to a kernel pointer when calling
> probe_kernel_read(), which will then immediately force-cast it back to a
> user pointer.

Yeah, that's some crazy casting.

Can we define a local __user pointer only for the check instead? It is
less casting and looks simpler and actually even easier to understand
what we're doing...

---
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index 605c60b1624f..9c5a15491108 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -97,14 +97,17 @@ void show_opcodes(struct pt_regs *regs, const char *loglvl)
 #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
 	u8 opcodes[OPCODE_BUFSIZE];
 	u8 *prologue = (u8 *)(regs->ip - PROLOGUE_SIZE);
-	bool bad_ip;
+	bool bad_ip = false;
 
 	/*
 	 * Make sure userspace isn't trying to trick us into dumping kernel
 	 * memory by pointing the userspace instruction pointer at it.
 	 */
-	bad_ip = user_mode(regs) &&
-		__range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
+	if (user_mode(regs)) {
+		u8 __user *up = (u8 __user *)prologue;
+
+		bad_ip = __range_not_ok(up, OPCODE_BUFSIZE, TASK_SIZE_MAX);
+	}
 
 	if (bad_ip || probe_kernel_read(opcodes, prologue, OPCODE_BUFSIZE)) {
 		printk("%sCode: Bad RIP value.\n", loglvl);

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
