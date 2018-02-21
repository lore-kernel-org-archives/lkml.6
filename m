Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933359AbeBUKjV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:39:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58245 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932751AbeBUKjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:39:19 -0500
Date: Wed, 21 Feb 2018 02:38:51 -0800
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-85c615eb52222bc5fab6c7190d146bc59fac289e@git.kernel.org>
Cc: peterz@infradead.org, msebor@gcc.gnu.org,
        torvalds@linux-foundation.org, arnd@arndb.de, mingo@kernel.org,
        tglx@linutronix.de, jeyu@kernel.org, hpa@zytor.com, rric@kernel.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, keescook@chromium.org, rric@kernel.org,
        hpa@zytor.com, jeyu@kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, arnd@arndb.de, mingo@kernel.org,
        msebor@gcc.gnu.org, peterz@infradead.org
In-Reply-To: <20180220205826.2008875-1-arnd@arndb.de>
References: <20180220205826.2008875-1-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] x86/oprofile: Fix bogus GCC-8 warning in
 nmi_setup()
Git-Commit-ID: 85c615eb52222bc5fab6c7190d146bc59fac289e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  85c615eb52222bc5fab6c7190d146bc59fac289e
Gitweb:     https://git.kernel.org/tip/85c615eb52222bc5fab6c7190d146bc59fac289e
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Tue, 20 Feb 2018 21:58:21 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Wed, 21 Feb 2018 09:54:17 +0100

x86/oprofile: Fix bogus GCC-8 warning in nmi_setup()

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
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/20180220205826.2008875-1-arnd@arndb.de
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=84095
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/oprofile/nmi_int.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/oprofile/nmi_int.c b/arch/x86/oprofile/nmi_int.c
index 174c597..a7a7677 100644
--- a/arch/x86/oprofile/nmi_int.c
+++ b/arch/x86/oprofile/nmi_int.c
@@ -460,7 +460,7 @@ static int nmi_setup(void)
 		goto fail;
 
 	for_each_possible_cpu(cpu) {
-		if (!cpu)
+		if (!IS_ENABLED(CONFIG_SMP) || !cpu)
 			continue;
 
 		memcpy(per_cpu(cpu_msrs, cpu).counters,
