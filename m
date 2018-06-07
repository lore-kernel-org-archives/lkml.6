Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SW9TGoFDGVvtCAAAmS7hNA
	; Thu, 07 Jun 2018 14:39:16 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 11D7B607E7; Thu,  7 Jun 2018 14:39:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5AC25601C3;
	Thu,  7 Jun 2018 14:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5AC25601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934283AbeFGOjN (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:39:13 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40484 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934244AbeFGOin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:38:43 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbY-0005hK-Rt; Thu, 07 Jun 2018 15:09:33 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb9-00036o-Ck; Thu, 07 Jun 2018 15:09:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Jessica Yu" <jeyu@kernel.org>, "Robert Richter" <rric@kernel.org>,
        "Kees Cook" <keescook@chromium.org>, oprofile-list@lists.sf.net,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Martin Sebor" <msebor@gcc.gnu.org>, stable@decadent.org.uk,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.49749620@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 275/410] x86/oprofile: Fix bogus GCC-8 warning in
 nmi_setup()
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

From: Arnd Bergmann <arnd@arndb.de>

commit 85c615eb52222bc5fab6c7190d146bc59fac289e upstream.

GCC-8 shows a warning for the x86 oprofile code that copies per-CPU
data from CPU 0 to all other CPUs, which when building a non-SMP
kernel turns into a memcpy() with identical source and destination
pointers:

 arch/x86/oprofile/nmi_int.c: In function 'mux_clone':
 arch/x86/oprofile/nmi_int.c:285:2: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
   memcpy(per_cpu(cpu_msrs, cpu).multiplex,
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          per_cpu(cpu_msrs, 0).multiplex,
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
          sizeof(struct op_msr) * model->num_virt_counters);
          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 arch/x86/oprofile/nmi_int.c: In function 'nmi_setup':
 arch/x86/oprofile/nmi_int.c:466:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]
 arch/x86/oprofile/nmi_int.c:470:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

I have analyzed a number of such warnings now: some are valid and the
GCC warning is welcome. Others turned out to be false-positives, and
GCC was changed to not warn about those any more. This is a corner case
that is a false-positive but the GCC developers feel it's better to keep
warning about it.

In this case, it seems best to work around it by telling GCC
a little more clearly that this code path is never hit with
an IS_ENABLED() configuration check.

Cc:stable as we also want old kernels to build cleanly with GCC-8.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Martin Sebor <msebor@gcc.gnu.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Richter <rric@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: oprofile-list@lists.sf.net
Link: http://lkml.kernel.org/r/20180220205826.2008875-1-arnd@arndb.de
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84095
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/x86/oprofile/nmi_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -471,7 +471,7 @@ static int nmi_setup(void)
 		goto fail;
 
 	for_each_possible_cpu(cpu) {
-		if (!cpu)
+		if (!IS_ENABLED(CONFIG_SMP) || !cpu)
 			continue;
 
 		memcpy(per_cpu(cpu_msrs, cpu).counters,
