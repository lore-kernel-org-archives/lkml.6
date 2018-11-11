Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32233C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEECC20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEECC20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbeKLG3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 01:29:08 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49518 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729975AbeKLFsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:48:07 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsT-0000oO-Dv; Sun, 11 Nov 2018 19:58:37 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsS-0001aE-Tv; Sun, 11 Nov 2018 19:58:36 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Borislav  Petkov" <bpetkov@suse.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Siarhei Liakh" <siarhei.liakh@concurrent-rt.com>,
        "Siarhei Liakh" <Siarhei.Liakh@concurrent-rt.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.245765097@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 158/366] x86: Call fixup_exception() before
 notify_die() in math_error()
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Siarhei Liakh <Siarhei.Liakh@concurrent-rt.com>

commit 3ae6295ccb7cf6d344908209701badbbbb503e40 upstream.

fpu__drop() has an explicit fwait which under some conditions can trigger a
fixable FPU exception while in kernel. Thus, we should attempt to fixup the
exception first, and only call notify_die() if the fixup failed just like
in do_general_protection(). The original call sequence incorrectly triggers
KDB entry on debug kernels under particular FPU-intensive workloads.

Andy noted, that this makes the whole conditional irq enable thing even
more inconsistent, but fixing that it outside the scope of this.

Signed-off-by: Siarhei Liakh <siarhei.liakh@concurrent-rt.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Borislav  Petkov" <bpetkov@suse.de>
Link: https://lkml.kernel.org/r/DM5PR11MB201156F1CAB2592B07C79A03B17D0@DM5PR11MB2011.namprd11.prod.outlook.com
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/kernel/traps.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -556,17 +556,19 @@ static void math_error(struct pt_regs *r
 	char *str = (trapnr == X86_TRAP_MF) ? "fpu exception" :
 						"simd exception";
 
-	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, SIGFPE) == NOTIFY_STOP)
-		return;
 	conditional_sti(regs);
 
 	if (!user_mode_vm(regs))
 	{
-		if (!fixup_exception(regs)) {
-			task->thread.error_code = error_code;
-			task->thread.trap_nr = trapnr;
+		if (fixup_exception(regs))
+			return;
+
+		task->thread.error_code = error_code;
+		task->thread.trap_nr = trapnr;
+
+		if (notify_die(DIE_TRAP, str, regs, error_code,
+					trapnr, SIGFPE) != NOTIFY_STOP)
 			die(str, regs, error_code);
-		}
 		return;
 	}
 

