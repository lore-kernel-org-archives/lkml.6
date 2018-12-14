Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED755206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbeLNPXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:23:35 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:31981 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLNPXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:23:35 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43GZ7m40WZz9v18b;
        Fri, 14 Dec 2018 16:23:32 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id CHM39Rs7AmHg; Fri, 14 Dec 2018 16:23:32 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43GZ7m3P5mz9v18Z;
        Fri, 14 Dec 2018 16:23:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F35018B8EB;
        Fri, 14 Dec 2018 16:23:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id YdRd5yRaKs_d; Fri, 14 Dec 2018 16:23:33 +0100 (CET)
Received: from po14163vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC7428B8EA;
        Fri, 14 Dec 2018 16:23:33 +0100 (CET)
Received: by po14163vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B22D871710; Fri, 14 Dec 2018 15:23:33 +0000 (UTC)
Message-Id: <46e2533084dc3255a1d67553b682bd4b9642b176.1544800765.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2] powerpc/mm: make NULL pointer deferences explicit on bad
 page faults.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 14 Dec 2018 15:23:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As several other arches including x86, this patch makes it explicit
that a bad page fault is a NULL pointer dereference when the fault
address is lower than PAGE_SIZE

In the mean time, this page makes all bad_page_fault() messages shorter
so that they remain on one single line. And it prefixes them by "BUG: "
so that they get easily greped.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v2: Taking into account comments from Michael

 arch/powerpc/mm/fault.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 01b9bcc7fa85..3398291f4785 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -636,21 +636,24 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
 	switch (TRAP(regs)) {
 	case 0x300:
 	case 0x380:
-		printk(KERN_ALERT "Unable to handle kernel paging request for "
-			"data at address 0x%08lx\n", regs->dar);
+		if (regs->dar < PAGE_SIZE)
+			pr_alert("BUG: Kernel NULL pointer dereference");
+		else
+			pr_alert("BUG: Unable to handle kernel data access");
+		pr_cont(" at 0x%08lx\n", regs->dar);
 		break;
 	case 0x400:
 	case 0x480:
-		printk(KERN_ALERT "Unable to handle kernel paging request for "
-			"instruction fetch\n");
+		pr_alert("BUG: Unable to handle kernel instruction fetch%s",
+			 regs->nip < PAGE_SIZE ? " (NULL pointer ?)\n" : "\n");
 		break;
 	case 0x600:
-		printk(KERN_ALERT "Unable to handle kernel paging request for "
-			"unaligned access at address 0x%08lx\n", regs->dar);
+		pr_alert("BUG: Unable to handle kernel unaligned access at 0x%08lx\n",
+			 regs->dar);
 		break;
 	default:
-		printk(KERN_ALERT "Unable to handle kernel paging request for "
-			"unknown fault\n");
+		pr_alert("BUG: Unable to handle unknown paging fault at 0x%08lx\n",
+			 regs->dar);
 		break;
 	}
 	printk(KERN_ALERT "Faulting instruction address: 0x%08lx\n",
-- 
2.13.3

