Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561B1C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEBA20859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 17:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="JP4IXofS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBTRaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 12:30:04 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:40285 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbfBTR3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 12:29:17 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 444PjQ5njhz9v0gG;
        Wed, 20 Feb 2019 18:29:14 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=JP4IXofS; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id edA4ubqd21xz; Wed, 20 Feb 2019 18:29:14 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 444PjQ4kdXz9v0g0;
        Wed, 20 Feb 2019 18:29:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1550683754; bh=4BFSbPMUv8srPIHFQh77ZJKp9w0Q9MQxtL2VVB5bt/c=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=JP4IXofSq5vhxJAAJTxgGmCvDtX4lZ5Z3kRdWu/Rks8p41badOWbTZ7JUr2frz4kU
         PqJaR8UN7MfR4VgQjkkteb64MZS+g22dLP+MEU9sokj5iZIlHBZdezZEPUucSC5ocR
         I4cnPNI2sG33FkSfuuKt2FjWPcRBPS8lEGwRO+ck=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 55B088B84F;
        Wed, 20 Feb 2019 18:29:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Grzk_ZjX2kob; Wed, 20 Feb 2019 18:29:16 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.231.2])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3DD188B84A;
        Wed, 20 Feb 2019 18:29:16 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 25AF76E85E; Wed, 20 Feb 2019 17:29:16 +0000 (UTC)
Message-Id: <4d63467db0d25d51c3f9b9e2fb320f8cdfdef3d3.1550648295.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3 09/16] powerpc/mmu: add is_strict_kernel_rwx() helper
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, j.neuschaefer@gmx.net
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 20 Feb 2019 17:29:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper to know whether STRICT_KERNEL_RWX is enabled.

This is based on rodata_enabled flag which is defined only
when CONFIG_STRICT_KERNEL_RWX is selected.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu.h | 11 +++++++++++
 arch/powerpc/mm/init_32.c      |  4 +---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 6d22a8e78fe2..d34ad1657d7b 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -289,6 +289,17 @@ static inline u16 get_mm_addr_key(struct mm_struct *mm, unsigned long address)
 }
 #endif /* CONFIG_PPC_MEM_KEYS */
 
+#ifdef CONFIG_STRICT_KERNEL_RWX
+static inline bool strict_kernel_rwx_enabled(void)
+{
+	return rodata_enabled;
+}
+#else
+static inline bool strict_kernel_rwx_enabled(void)
+{
+	return false;
+}
+#endif
 #endif /* !__ASSEMBLY__ */
 
 /* The kernel use the constants below to index in the page sizes array.
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 3e59e5d64b01..ee5a430b9a18 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -108,12 +108,10 @@ static void __init MMU_setup(void)
 		__map_without_bats = 1;
 		__map_without_ltlbs = 1;
 	}
-#ifdef CONFIG_STRICT_KERNEL_RWX
-	if (rodata_enabled) {
+	if (strict_kernel_rwx_enabled()) {
 		__map_without_bats = 1;
 		__map_without_ltlbs = 1;
 	}
-#endif
 }
 
 /*
-- 
2.13.3

