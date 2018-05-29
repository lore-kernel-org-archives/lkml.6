Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936872AbeE2QTf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:19:35 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:41685 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935771AbeE2QTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:19:20 -0400
Message-Id: <96d2828025d815e91e3946f6ef45a09d9a206ca3.1527610536.git.christophe.leroy@c-s.fr>
In-Reply-To: <2e937890abac10677aae3c1e345dd934a6794c37.1527610536.git.christophe.leroy@c-s.fr>
References: <2e937890abac10677aae3c1e345dd934a6794c37.1527610536.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 3/3] powerpc/time: no steal_time if !CONFIG_PPC_SPLPAR
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 29 May 2018 16:19:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PPC_SPLPAR is not selected, steal_time will always
be NUL, so accounting it is pointless

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 New in v3
 
 arch/powerpc/kernel/time.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7d6040233003..85d1b1ff45f3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -346,7 +346,8 @@ void vtime_account_system(struct task_struct *tsk)
 	stime = vtime_delta(tsk, &stime_scaled, &steal_time);
 
 	stime -= min(stime, steal_time);
-	acct->steal_time += steal_time;
+	if (IS_ENABLED(CONFIG_PPC_SPLPAR))
+		acct->steal_time += steal_time;
 
 	if ((tsk->flags & PF_VCPU) && !irq_count()) {
 		acct->gtime += stime;
@@ -401,7 +402,7 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->gtime)
 		account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
 
-	if (acct->steal_time)
+	if (IS_ENABLED(CONFIG_PPC_SPLPAR) && acct->steal_time)
 		account_steal_time(cputime_to_nsecs(acct->steal_time));
 
 	if (acct->idle_time)
@@ -425,7 +426,8 @@ void vtime_flush(struct task_struct *tsk)
 	acct->stime_scaled = 0;
 #endif
 	acct->gtime = 0;
-	acct->steal_time = 0;
+	if (IS_ENABLED(CONFIG_PPC_SPLPAR))
+		acct->steal_time = 0;
 	acct->idle_time = 0;
 	acct->stime = 0;
 	acct->hardirq_time = 0;
-- 
2.13.3
