Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27261C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC88C2075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC88C2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeIFNZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 09:25:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:49914 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbeIFNZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 09:25:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 425Z6m2fpjz9ttFT;
        Thu,  6 Sep 2018 10:51:12 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id H6-Z_auY9J0B; Thu,  6 Sep 2018 10:51:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 425Z6m2BgHz9ttCM;
        Thu,  6 Sep 2018 10:51:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DE4018B8E8;
        Thu,  6 Sep 2018 10:51:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qGHUpGmbplrd; Thu,  6 Sep 2018 10:51:13 +0200 (CEST)
Received: from pc16082vm.idsi0.si.c-s.fr (unknown [192.168.232.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B0C5F8B755;
        Thu,  6 Sep 2018 10:51:13 +0200 (CEST)
Received: by pc16082vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8A021715BF; Thu,  6 Sep 2018 08:51:13 +0000 (UTC)
Message-Id: <3f5e23cc370269e752adc8b04340ebed72347fbf.1536180109.git.christophe.leroy@c-s.fr>
In-Reply-To: <02de5baec443d7c6f96cb2d197e08058c435c40a.1536180109.git.christophe.leroy@c-s.fr>
References: <02de5baec443d7c6f96cb2d197e08058c435c40a.1536180109.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/2] powerpc/process: Constify the number of insns printed
 by show instructions functions.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, muriloo@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu,  6 Sep 2018 08:51:13 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

instructions_to_print var is assigned value 16 and there is no
way to change it.

This patch replaces it by a constant.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/process.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 31d5d8a2ead6..c9a77512d0a8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1260,17 +1260,16 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	return last;
 }
 
-static int instructions_to_print = 16;
+#define NR_INSN_TO_PRINT	16
 
 static void show_instructions(struct pt_regs *regs)
 {
 	int i;
-	unsigned long pc = regs->nip - (instructions_to_print * 3 / 4 *
-			sizeof(int));
+	unsigned long pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
 
 	printk("Instruction dump:");
 
-	for (i = 0; i < instructions_to_print; i++) {
+	for (i = 0; i < NR_INSN_TO_PRINT; i++) {
 		int instr;
 
 		if (!(i % 8))
@@ -1303,11 +1302,11 @@ static void show_instructions(struct pt_regs *regs)
 void show_user_instructions(struct pt_regs *regs)
 {
 	unsigned long pc;
-	int n = instructions_to_print;
+	int n = NR_INSN_TO_PRINT;
 	struct seq_buf s;
 	char buf[96]; /* enough for 8 times 9 + 2 chars */
 
-	pc = regs->nip - (instructions_to_print * 3 / 4 * sizeof(int));
+	pc = regs->nip - (NR_INSN_TO_PRINT * 3 / 4 * sizeof(int));
 
 	seq_buf_init(&s, buf, sizeof(buf));
 
-- 
2.13.3

