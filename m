Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C19C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD56020C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:54:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD56020C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbeHBJoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:44:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28596 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeHBJn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:43:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 41h2Vx1qbYz9ttSM;
        Thu,  2 Aug 2018 09:54:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Ub2B-z4om8Tt; Thu,  2 Aug 2018 09:54:01 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 41h2Vx1DFPz9ttRp;
        Thu,  2 Aug 2018 09:54:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 52E578B842;
        Thu,  2 Aug 2018 09:54:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qOPTiUdfY4hc; Thu,  2 Aug 2018 09:54:02 +0200 (CEST)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 23A598B755;
        Thu,  2 Aug 2018 09:54:02 +0200 (CEST)
Received: by po14934vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E9B816C0CC; Thu,  2 Aug 2018 07:54:01 +0000 (UTC)
Message-Id: <019a806ec215dc5afb078cee0972c968a3993a73.1533151550.git.christophe.leroy@c-s.fr>
In-Reply-To: <af8fe0a5bebd1745ceec07813fa55f1569930f2b.1533151550.git.christophe.leroy@c-s.fr>
References: <af8fe0a5bebd1745ceec07813fa55f1569930f2b.1533151550.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 3/3] powerpc/time: no steal_time when CONFIG_PPC_SPLPAR is
 not selected
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  2 Aug 2018 07:54:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_PPC_SPLPAR is not selected, steal_time will always
be NUL, so accounting it is pointless

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v5: moved the change to the original localtion
 v4: removed the check in vtime_account_system(), the compiler removes the code regardless.
 v3: new

 arch/powerpc/kernel/time.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 3b03731221c1..b0f5cc491f8b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -412,8 +412,10 @@ void vtime_flush(struct task_struct *tsk)
 	if (acct->gtime)
 		account_guest_time(tsk, cputime_to_nsecs(acct->gtime));
 
-	if (acct->steal_time)
+	if (IS_ENABLED(CONFIG_PPC_SPLPAR) && acct->steal_time) {
 		account_steal_time(cputime_to_nsecs(acct->steal_time));
+		acct->steal_time = 0;
+	}
 
 	if (acct->idle_time)
 		account_idle_time(cputime_to_nsecs(acct->idle_time));
@@ -433,7 +435,6 @@ void vtime_flush(struct task_struct *tsk)
 
 	acct->utime = 0;
 	acct->gtime = 0;
-	acct->steal_time = 0;
 	acct->idle_time = 0;
 	acct->stime = 0;
 	acct->hardirq_time = 0;
-- 
2.13.3

