Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAD2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE292124D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE292124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeHBJnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:43:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15523 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbeHBJnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:43:55 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41h2Vs3ZLmz9ttRq;
        Thu,  2 Aug 2018 09:53:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Xc4bp5f_MOhs; Thu,  2 Aug 2018 09:53:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41h2Vs338Bz9ttRp;
        Thu,  2 Aug 2018 09:53:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C81B8B842;
        Thu,  2 Aug 2018 09:53:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id M3sh0_gUDjZS; Thu,  2 Aug 2018 09:53:58 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 53A3C8B755;
        Thu,  2 Aug 2018 09:53:58 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EEC6E6C0CC; Thu,  2 Aug 2018 07:53:57 +0000 (UTC)
Message-Id: <af8fe0a5bebd1745ceec07813fa55f1569930f2b.1533151550.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 1/3] powerpc/time: isolate scaled cputime accounting in
 dedicated functions.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  2 Aug 2018 07:53:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scaled cputime is only meaningfull when the processor has
SPURR and/or PURR, which means only on PPC64.

In preparation of the following patch that will remove
CONFIG_ARCH_HAS_SCALED_CPUTIME on PPC32, this patch moves
all scaled cputing accounting logic into dedicated functions.

This patch doesn't change any functionality. It's only code
reorganisation.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v5:
  - v4 patch split in two patches. First part isolates scaled cputime accounting
    in dedicated functions, second part activates it only on PPC64.
  - read_spurr() kept as a separate function.
 v4:
  - Using the correct symbol CONFIG_ARCH_HAS_SCALED_CPUTIME instead of ARCH_HAS_SCALED_CPUTIME
  - Grouped CONFIG_ARCH_HAS_SCALED_CPUTIME related code in dedicated functions to reduce the number of #ifdefs
  - Integrated read_spurr() directly into the related function.
 v3: Rebased following modifications in xmon.c
 v2: added ifdefs in xmon to fix compilation error

 arch/powerpc/kernel/time.c | 69 +++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 70f145e02487..6196bd7393a3 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -281,26 +281,16 @@ static inline u64 calculate_stolen_time(u64 stop_tb)
  * Account time for a transition between system, hard irq
  * or soft irq state.
  */
-static unsigned long vtime_delta(struct task_struct *tsk,
-				 unsigned long *stime_scaled,
-				 unsigned long *steal_time)
+static unsigned long vtime_delta_scaled(struct cpu_accounting_data *acct,
+					unsigned long now, unsigned long stime)
 {
-	unsigned long now, nowscaled, deltascaled;
-	unsigned long stime;
+	unsigned long stime_scaled;
+	unsigned long nowscaled, deltascaled;
 	unsigned long utime, utime_scaled;
-	struct cpu_accounting_data *acct = get_accounting(tsk);
 
-	WARN_ON_ONCE(!irqs_disabled());
-
-	now = mftb();
 	nowscaled = read_spurr(now);
-	stime = now - acct->starttime;
-	acct->starttime = now;
 	deltascaled = nowscaled - acct->startspurr;
 	acct->startspurr = nowscaled;
-
-	*steal_time = calculate_stolen_time(now);
-
 	utime = acct->utime - acct->utime_sspurr;
 	acct->utime_sspurr = acct->utime;
 
@@ -314,18 +304,38 @@ static unsigned long vtime_delta(struct task_struct *tsk,
 	 * the user ticks get saved up in paca->user_time_scaled to be
 	 * used by account_process_tick.
 	 */
-	*stime_scaled = stime;
+	stime_scaled = stime;
 	utime_scaled = utime;
 	if (deltascaled != stime + utime) {
 		if (utime) {
-			*stime_scaled = deltascaled * stime / (stime + utime);
-			utime_scaled = deltascaled - *stime_scaled;
+			stime_scaled = deltascaled * stime / (stime + utime);
+			utime_scaled = deltascaled - stime_scaled;
 		} else {
-			*stime_scaled = deltascaled;
+			stime_scaled = deltascaled;
 		}
 	}
 	acct->utime_scaled += utime_scaled;
 
+	return stime_scaled;
+}
+
+static unsigned long vtime_delta(struct task_struct *tsk,
+				 unsigned long *stime_scaled,
+				 unsigned long *steal_time)
+{
+	unsigned long now, stime;
+	struct cpu_accounting_data *acct = get_accounting(tsk);
+
+	WARN_ON_ONCE(!irqs_disabled());
+
+	now = mftb();
+	stime = now - acct->starttime;
+	acct->starttime = now;
+
+	*stime_scaled = vtime_delta_scaled(acct, now, stime);
+
+	*steal_time = calculate_stolen_time(now);
+
 	return stime;
 }
 
@@ -364,6 +374,19 @@ void vtime_account_idle(struct task_struct *tsk)
 	acct->idle_time += stime + steal_time;
 }
 
+static void vtime_flush_scaled(struct task_struct *tsk,
+			       struct cpu_accounting_data *acct)
+{
+	if (acct->utime_scaled)
+		tsk->utimescaled += cputime_to_nsecs(acct->utime_scaled);
+	if (acct->stime_scaled)
+		tsk->stimescaled += cputime_to_nsecs(acct->stime_scaled);
+
+	acct->utime_scaled = 0;
+	acct->utime_sspurr = 0;
+	acct->stime_scaled = 0;
+}
+
 /*
  * Account the whole cputime accumulated in the paca
  * Must be called with interrupts disabled.
@@ -378,9 +401,6 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->utime)
 		account_user_time(tsk, cputime_to_nsecs(acct->utime));
 
-	if (acct->utime_scaled)
-		tsk->utimescaled += cputime_to_nsecs(acct->utime_scaled);
-
 	if (acct->gtime)
 		account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
 
@@ -393,8 +413,6 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->stime)
 		account_system_index_time(tsk, cputime_to_nsecs(acct->stime),
 					  CPUTIME_SYSTEM);
-	if (acct->stime_scaled)
-		tsk->stimescaled += cputime_to_nsecs(acct->stime_scaled);
 
 	if (acct->hardirq_time)
 		account_system_index_time(tsk, cputime_to_nsecs(acct->hardirq_time),
@@ -403,14 +421,13 @@ void vtime_flush(struct task_struct *tsk)
 		account_system_index_time(tsk, cputime_to_nsecs(acct->softirq_time),
 					  CPUTIME_SOFTIRQ);
 
+	vtime_flush_scaled(tsk, acct);
+
 	acct->utime = 0;
-	acct->utime_scaled = 0;
-	acct->utime_sspurr = 0;
 	acct->gtime = 0;
 	acct->steal_time = 0;
 	acct->idle_time = 0;
 	acct->stime = 0;
-	acct->stime_scaled = 0;
 	acct->hardirq_time = 0;
 	acct->softirq_time = 0;
 }
-- 
2.13.3

