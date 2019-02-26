Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FD4C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7719920C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="HNF9X82C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbfBZSSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:18:53 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28804 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbfBZSSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:18:50 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4486Wq6GtJz9v6LN;
        Tue, 26 Feb 2019 19:18:47 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=HNF9X82C; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XdqrqwF4cIP6; Tue, 26 Feb 2019 19:18:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4486Wq50z5z9v6L9;
        Tue, 26 Feb 2019 19:18:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1551205127; bh=phBk+r7PeUz0uTJRypnFHUf3M0wwTCSFOcNFBfGPvaA=;
        h=From:Subject:To:Cc:Date:From;
        b=HNF9X82CFB60ZHYJmr21oFwBOumBLvwxZv2TxbVJtxOwNFihQnV2cuMIIV06isjQt
         /NuCOOeLJKPQICSxrJj60MJrxOtTMYIduVcOR3L2E2wVNW6OePBm5xshwwlZp7b1ca
         TsWxFrMte8faT+XhzSZRzi0hSJcfcKD8LU762OnA=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 649A78B97A;
        Tue, 26 Feb 2019 19:18:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id rBvg0048uCIk; Tue, 26 Feb 2019 19:18:49 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3DE9C8B96A;
        Tue, 26 Feb 2019 19:18:49 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D12826F7B5; Tue, 26 Feb 2019 18:18:48 +0000 (UTC)
Message-Id: <dccb392cd3e2b1825608576ecf2487cc5d84466d.1551205086.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/fsl: Fix the flush of branch predictor.
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Diana Craciun <diana.craciun@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 26 Feb 2019 18:18:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit identified below adds MC_BTB_FLUSH macro only when
CONFIG_PPC_FSL_BOOK3E is defined. This results in the following error
on some configs (seen several times with kisskb randconfig_defconfig)

arch/powerpc/kernel/exceptions-64e.S:576: Error: Unrecognized opcode: `mc_btb_flush'
make[3]: *** [scripts/Makefile.build:367: arch/powerpc/kernel/exceptions-64e.o] Error 1
make[2]: *** [scripts/Makefile.build:492: arch/powerpc/kernel] Error 2
make[1]: *** [Makefile:1043: arch/powerpc] Error 2
make: *** [Makefile:152: sub-make] Error 2

This patch adds a blank definition of MC_BTB_FLUSH for other cases.

Fixes: 10c5e83afd4a ("powerpc/fsl: Flush the branch predictor at each kernel entry (64bit)")
Cc: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/exceptions-64e.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 4549ce8d4637..49381f32b374 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -338,6 +338,7 @@ ret_from_mc_except:
 #define GEN_BTB_FLUSH
 #define CRIT_BTB_FLUSH
 #define DBG_BTB_FLUSH
+#define MC_BTB_FLUSH
 #define GDBELL_BTB_FLUSH
 #endif
 
-- 
2.13.3

