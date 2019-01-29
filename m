Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9306CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63243214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 16:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="YtwnFWbi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfA2Q2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 11:28:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:65031 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbfA2Q2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 11:28:32 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 43psPT0TmPz9v2km;
        Tue, 29 Jan 2019 17:28:29 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=YtwnFWbi; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id C5icorkRXm5E; Tue, 29 Jan 2019 17:28:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 43psPS6VBnz9v2kg;
        Tue, 29 Jan 2019 17:28:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1548779308; bh=9sW9e9KLj7n9ktYaUM5YdYnUm85NAdf/zI5zcZYMq0Y=;
        h=From:Subject:To:Cc:Date:From;
        b=YtwnFWbixQVkMqIfIbobYenx6rIEiBGy4Uq+5W8sshn18v5julncU+7VfaD5jfDrv
         MmPQvbvX8btvHuBNtdgX+J64FDNBBj2n9wn4KvRm0WgqWL4aBO+42JeGi+uZ49yNbL
         q2oCYPLlQaxOWrQ01qxkEdg1nsTCYtdOMzUO2QHQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 73F178B7E6;
        Tue, 29 Jan 2019 17:28:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id c-Auzt26jUH4; Tue, 29 Jan 2019 17:28:30 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4ABD78B755;
        Tue, 29 Jan 2019 17:28:30 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0DF0672DF1; Tue, 29 Jan 2019 16:28:29 +0000 (UTC)
Message-Id: <1b13936c5ee1dceb8fec9251aff0b5cda9fd2ace.1548737151.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/traps: fix the message printed when stack overflows
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 29 Jan 2019 16:28:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today's message is useless:

[   42.253267] Kernel stack overflow in process (ptrval), r1=c65500b0

This patch fixes it:

[   66.905235] Kernel stack overflow in process sh[356], r1=c65560b0

Fixes: ad67b74d2469 ("printk: hash addresses printed with %p")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 5e917a84f949..ca8f86ea0345 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1535,8 +1535,8 @@ void alignment_exception(struct pt_regs *regs)
 
 void StackOverflow(struct pt_regs *regs)
 {
-	printk(KERN_CRIT "Kernel stack overflow in process %p, r1=%lx\n",
-	       current, regs->gpr[1]);
+	printk(KERN_CRIT "Kernel stack overflow in process %s[%d], r1=%lx\n",
+	       current->comm, current->pid, regs->gpr[1]);
 	debugger(regs);
 	show_regs(regs);
 	panic("kernel stack overflow");
-- 
2.13.3

