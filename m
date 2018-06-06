Return-Path: <linux-kernel-owner@vger.kernel.org>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 45DC5601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752189AbeFFOVR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:21:17 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59567 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752026AbeFFOVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:21:12 -0400
Message-Id: <a74751d73e669ab3117e4479b7a138dc832e8f8b.1528292284.git.christophe.leroy@c-s.fr>
In-Reply-To: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
References: <d9ac8da98f53debb4758b98d0227979aca9196f7.1528292284.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 2/2] powerpc/time: no steal_time when CONFIG_PPC_SPLPAR is
 not selected
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  6 Jun 2018 14:21:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PPC_SPLPAR is not selected, steal_time will always
be NUL, so accounting it is pointless

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: removed the check in vtime_account_system(), the compiler removes the code regardless.
 v3: new

 arch/powerpc/kernel/time.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7a9f4e2f22c8..eda78b1ed7d3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -412,9 +412,6 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->gtime)
 		account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
 
-	if (acct->steal_time)
-		account_steal_time(cputime_to_nsecs(acct->steal_time));
-
 	if (acct->idle_time)
 		account_idle_time(cputime_to_nsecs(acct->idle_time));
 
@@ -431,13 +428,17 @@ void vtime_flush(struct task_struct *tsk)
 
 	acct->utime = 0;
 	acct->gtime = 0;
-	acct->steal_time = 0;
 	acct->idle_time = 0;
 	acct->stime = 0;
 	acct->hardirq_time = 0;
 	acct->softirq_time = 0;
 
 	vtime_flush_scaled(tsk, acct);
+
+	if (IS_ENABLED(CONFIG_PPC_SPLPAR) && acct->steal_time) {
+		account_steal_time(cputime_to_nsecs(acct->steal_time));
+		acct->steal_time = 0;
+	}
 }
 
 #else /* ! CONFIG_VIRT_CPU_ACCOUNTING_NATIVE */
-- 
2.13.3
