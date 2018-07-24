Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1152AC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C676D205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:53:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C676D205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388480AbeGXM7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:59:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57527 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388254AbeGXM7U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:59:20 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 66F9820756; Tue, 24 Jul 2018 13:53:11 +0200 (CEST)
Received: from localhost (176.199.29.109.rev.sfr.net [109.29.199.176])
        by mail.bootlin.com (Postfix) with ESMTPSA id 1D50C203EC;
        Tue, 24 Jul 2018 13:53:11 +0200 (CEST)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Hanna Hawa <hannah@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 1/2] sparc: move MSI related definitions to where they are used
Date:   Tue, 24 Jul 2018 13:53:04 +0200
Message-Id: <20180724115305.11289-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The definitions in arch/sparc/include/asm/msi.h are only used in
arch/sparc/mm/srmmu.c, so it makes sense to have them in the C file
directly.

In addition, having a custom arch/sparc/include/asm/msi.h prevents
from using the asm-generic version of this header, which is necessary
to be able to include <linux/msi.h> when CONFIG_GENERIC_MSI_IRQ_DOMAIN
is enabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
---
 arch/sparc/include/asm/msi.h | 32 --------------------------------
 arch/sparc/mm/srmmu.c        | 20 +++++++++++++++++++-
 2 files changed, 19 insertions(+), 33 deletions(-)
 delete mode 100644 arch/sparc/include/asm/msi.h

diff --git a/arch/sparc/include/asm/msi.h b/arch/sparc/include/asm/msi.h
deleted file mode 100644
index 3c17c1074431..000000000000
--- a/arch/sparc/include/asm/msi.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * msi.h:  Defines specific to the MBus - Sbus - Interface.
- *
- * Copyright (C) 1996 David S. Miller (davem@caip.rutgers.edu)
- * Copyright (C) 1996 Eddie C. Dost   (ecd@skynet.be)
- */
-
-#ifndef _SPARC_MSI_H
-#define _SPARC_MSI_H
-
-/*
- * Locations of MSI Registers.
- */
-#define MSI_MBUS_ARBEN	0xe0001008	/* MBus Arbiter Enable register */
-
-/*
- * Useful bits in the MSI Registers.
- */
-#define MSI_ASYNC_MODE  0x80000000	/* Operate the MSI asynchronously */
-
-
-static inline void msi_set_sync(void)
-{
-	__asm__ __volatile__ ("lda [%0] %1, %%g3\n\t"
-			      "andn %%g3, %2, %%g3\n\t"
-			      "sta %%g3, [%0] %1\n\t" : :
-			      "r" (MSI_MBUS_ARBEN),
-			      "i" (ASI_M_CTL), "r" (MSI_ASYNC_MODE) : "g3");
-}
-
-#endif /* !(_SPARC_MSI_H) */
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index 1d70c3f6d986..be9cb0065179 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -37,7 +37,6 @@
 #include <asm/mbus.h>
 #include <asm/page.h>
 #include <asm/asi.h>
-#include <asm/msi.h>
 #include <asm/smp.h>
 #include <asm/io.h>
 
@@ -116,6 +115,25 @@ static inline void srmmu_ctxd_set(ctxd_t *ctxp, pgd_t *pgdp)
 	set_pte((pte_t *)ctxp, pte);
 }
 
+/*
+ * Locations of MSI Registers.
+ */
+#define MSI_MBUS_ARBEN	0xe0001008	/* MBus Arbiter Enable register */
+
+/*
+ * Useful bits in the MSI Registers.
+ */
+#define MSI_ASYNC_MODE  0x80000000	/* Operate the MSI asynchronously */
+
+static void msi_set_sync(void)
+{
+	__asm__ __volatile__ ("lda [%0] %1, %%g3\n\t"
+			      "andn %%g3, %2, %%g3\n\t"
+			      "sta %%g3, [%0] %1\n\t" : :
+			      "r" (MSI_MBUS_ARBEN),
+			      "i" (ASI_M_CTL), "r" (MSI_ASYNC_MODE) : "g3");
+}
+
 void pmd_set(pmd_t *pmdp, pte_t *ptep)
 {
 	unsigned long ptp;	/* Physical address, shifted right by 4 */
-- 
2.14.4

