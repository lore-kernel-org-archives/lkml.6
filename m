Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F1BCC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A5C20665
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546864932;
	bh=SSaqSRbhIu0GJo1FlYZ3TwNMahQ05dCv8d223HPREAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FHINBWpfPQ+cMXOvjF/fGis1KhDWL5gBGzx5vQVQsqiTPLFdAnvkBxpEbkU8zDzjP
	 fpGJvKBv3t4c5bMFp7WnV28p8ILS2BnF34IlX3qgenjobRw8NGKAO1HGWghOx0Dvq0
	 fGbYV33nSBec4RTgdrr94Sd/4TvPFo0/zkzPx1Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfAGMmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfAGMmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:42:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA17220665;
        Mon,  7 Jan 2019 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546864927;
        bh=SSaqSRbhIu0GJo1FlYZ3TwNMahQ05dCv8d223HPREAM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bEnuZU6UXbDwPMZISXX/20fT33an7LxCaZd/bGKrnGpdcyLvO0xQ3nxS9pIFy6hN9
         Fj+arFGfthETzt4eUZ4dDiZEQV7HStGoFglxFEap5Iu0pm63g3im9rCsyrhqIuS9Wf
         0fThnWM5CmM98nx3h8TmYqO1m2HET63yt/tcWCy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.20 103/145] powerpc/tm: Unset MSR[TS] if not recheckpointing
Date:   Mon,  7 Jan 2019 13:32:20 +0100
Message-Id: <20190107104450.742716209@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104437.308206189@linuxfoundation.org>
References: <20190107104437.308206189@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

commit 6f5b9f018f4c7686fd944d920209d1382d320e4e upstream.

There is a TM Bad Thing bug that can be caused when you return from a
signal context in a suspended transaction but with ucontext MSR[TS] unset.

This forces regs->msr[TS] to be set at syscall entrance (since the CPU
state is transactional). It also calls treclaim() to flush the transaction
state, which is done based on the live (mfmsr) MSR state.

Since user context MSR[TS] is not set, then restore_tm_sigcontexts() is not
called, thus, not executing recheckpoint, keeping the CPU state as not
transactional. When calling rfid, SRR1 will have MSR[TS] set, but the CPU
state is non transactional, causing the TM Bad Thing with the following
stack:

	[   33.862316] Bad kernel stack pointer 3fffd9dce3e0 at c00000000000c47c
	cpu 0x8: Vector: 700 (Program Check) at [c00000003ff7fd40]
	    pc: c00000000000c47c: fast_exception_return+0xac/0xb4
	    lr: 00003fff865f442c
	    sp: 3fffd9dce3e0
	   msr: 8000000102a03031
	  current = 0xc00000041f68b700
	  paca    = 0xc00000000fb84800   softe: 0        irq_happened: 0x01
	    pid   = 1721, comm = tm-signal-sigre
	Linux version 4.9.0-3-powerpc64le (debian-kernel@lists.debian.org) (gcc version 6.3.0 20170516 (Debian 6.3.0-18) ) #1 SMP Debian 4.9.30-2+deb9u2 (2017-06-26)
	WARNING: exception is not recoverable, can't continue

The same problem happens on 32-bits signal handler, and the fix is very
similar, if tm_recheckpoint() is not executed, then regs->msr[TS] should be
zeroed.

This patch also fixes a sparse warning related to lack of indentation when
CONFIG_PPC_TRANSACTIONAL_MEM is set.

Fixes: 2b0a576d15e0e ("powerpc: Add new transactional memory state to the signal context")
CC: Stable <stable@vger.kernel.org>	# 3.10+
Signed-off-by: Breno Leitao <leitao@debian.org>
Tested-by: Michal Suchánek <msuchanek@suse.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/signal_32.c |   18 +++++++++++++-----
 arch/powerpc/kernel/signal_64.c |   20 ++++++++++++++++----
 2 files changed, 29 insertions(+), 9 deletions(-)

--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -1158,11 +1158,11 @@ SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct rt_sigframe __user *rt_sf;
 	struct pt_regs *regs = current_pt_regs();
+	int tm_restore = 0;
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	struct ucontext __user *uc_transact;
 	unsigned long msr_hi;
 	unsigned long tmp;
-	int tm_restore = 0;
 #endif
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -1210,11 +1210,19 @@ SYSCALL_DEFINE0(rt_sigreturn)
 				goto bad;
 		}
 	}
-	if (!tm_restore)
-		/* Fall through, for non-TM restore */
+	if (!tm_restore) {
+		/*
+		 * Unset regs->msr because ucontext MSR TS is not
+		 * set, and recheckpoint was not called. This avoid
+		 * hitting a TM Bad thing at RFID
+		 */
+		regs->msr &= ~MSR_TS_MASK;
+	}
+	/* Fall through, for non-TM restore */
 #endif
-	if (do_setcontext(&rt_sf->uc, regs, 1))
-		goto bad;
+	if (!tm_restore)
+		if (do_setcontext(&rt_sf->uc, regs, 1))
+			goto bad;
 
 	/*
 	 * It's not clear whether or why it is desirable to save the
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -756,11 +756,23 @@ SYSCALL_DEFINE0(rt_sigreturn)
 					   &uc_transact->uc_mcontext))
 			goto badframe;
 	}
-	else
-	/* Fall through, for non-TM restore */
 #endif
-	if (restore_sigcontext(current, NULL, 1, &uc->uc_mcontext))
-		goto badframe;
+	/* Fall through, for non-TM restore */
+	if (!MSR_TM_ACTIVE(msr)) {
+		/*
+		 * Unset MSR[TS] on the thread regs since MSR from user
+		 * context does not have MSR active, and recheckpoint was
+		 * not called since restore_tm_sigcontexts() was not called
+		 * also.
+		 *
+		 * If not unsetting it, the code can RFID to userspace with
+		 * MSR[TS] set, but without CPU in the proper state,
+		 * causing a TM bad thing.
+		 */
+		current->thread.regs->msr &= ~MSR_TS_MASK;
+		if (restore_sigcontext(current, NULL, 1, &uc->uc_mcontext))
+			goto badframe;
+	}
 
 	if (restore_altstack(&uc->uc_stack))
 		goto badframe;


