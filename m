Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D0FC282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FF620989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fnHp2P0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfA3QdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:33:11 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:53334 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732083AbfA3Qcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:32:51 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 844B324E2587;
        Wed, 30 Jan 2019 08:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548865971; bh=odNaOrVb+G1TqEM4piwYUXxpwVGxK17Wh/MhxwgDpSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fnHp2P0nLYJcdYgKAyPvMa1ERLwBro2k1+afBTHHo8glikE6c6iHvF6BD3SWTL6Kq
         LmxjLwlo669EvFfvCcvslx31jHXQuZvS1olZTY2iA7Di7u4zMGDzL7vaVJqGIi88Hi
         174XHsOKzAe4CoU6AyrL2Rx5SW8lNDLR6ClUchUv4QS6RvVNOC7xVmAMa9Um9bbaVL
         8AyMgHd6MNC2T2U61e/8wQGoMJuMsAhZ6LBgA5316+UHsNxvHy8XsdPehnN0kua5vV
         AmJx4eiZe+KgK6/JVFUzmrLTMYv5hAZlqi8aXf9dmb/gz/AKUeGGBtxYDmwKJCyXBj
         sYW0T90cyQNmg==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2FB52A008B;
        Wed, 30 Jan 2019 16:32:50 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH v2 2/5] ARCv2: introduce unaligned access under a Kconfig option
Date:   Wed, 30 Jan 2019 19:32:41 +0300
Message-Id: <20190130163244.10870-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190130163244.10870-1-Eugeniy.Paltsev@synopsys.com>
References: <20190130163244.10870-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today we enable unaligned access unconditionally on ARCv2.
Lets move it under Kconfig option so we can disable it in case of
using HW configuration which lacks of it.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                      |  8 ++++++++
 arch/arc/include/asm/irqflags-arcv2.h |  4 ++++
 arch/arc/kernel/head.S                | 14 +++++++++-----
 arch/arc/kernel/intc-arcv2.c          |  2 +-
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 376366a7db81..37c8aeefa3a5 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -387,6 +387,14 @@ config ARC_HAS_SWAPE
 
 if ISA_ARCV2
 
+config ARC_USE_UNALIGNED_MEM_ACCESS
+	bool "Handle unaligned access in HW and use it"
+	default y
+	help
+	  The ARC HS architecture supports unaligned memory access
+	  which is disabled by default. Enable unaligned access in
+	  hardware and use it in software.
+
 config ARC_HAS_LL64
 	bool "Insn: 64bit LDD/STD"
 	help
diff --git a/arch/arc/include/asm/irqflags-arcv2.h b/arch/arc/include/asm/irqflags-arcv2.h
index 8a4f77ea3238..9b911e2c6b31 100644
--- a/arch/arc/include/asm/irqflags-arcv2.h
+++ b/arch/arc/include/asm/irqflags-arcv2.h
@@ -44,8 +44,12 @@
 #define ARCV2_IRQ_DEF_PRIO	1
 
 /* seed value for status register */
+#ifdef CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS
 #define ISA_INIT_STATUS_BITS	(STATUS_IE_MASK | STATUS_AD_MASK | \
 					(ARCV2_IRQ_DEF_PRIO << 1))
+#else
+#define ISA_INIT_STATUS_BITS	(STATUS_IE_MASK | (ARCV2_IRQ_DEF_PRIO << 1))
+#endif /* CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS */
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 25b3a247e11c..bd24ba0e0264 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -49,11 +49,15 @@
 
 1:
 
-#ifdef CONFIG_ISA_ARCV2
-	; Enable unaligned access as disabled by default in hw while
-	; gcc 8.1.0 onwards (ARC GNU 2018.03) unconditionally generates
-	; code for unaligned accesses
-	flag    1 << STATUS_AD_BIT
+	; Enable / disable HW handling of unaligned access in the CPU.
+#ifdef CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS
+	kflag	STATUS_AD_MASK
+#else
+	; Handling of unaligned access is disabled by default but we disable it
+	; manually in case of any bootloader enabled it earlier.
+	lr	r5, [ARC_REG_STATUS32]
+	bclr	r5, r5, STATUS_AD_BIT
+	kflag	r5
 #endif
 .endm
 
diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index 067ea362fb3e..6359896da1ea 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -93,7 +93,7 @@ void arc_init_IRQ(void)
 
 	/* setup status32, don't enable intr yet as kernel doesn't want */
 	tmp = read_aux_reg(ARC_REG_STATUS32);
-	tmp |= STATUS_AD_MASK | (ARCV2_IRQ_DEF_PRIO << 1);
+	tmp |= ARCV2_IRQ_DEF_PRIO << 1;
 	tmp &= ~STATUS_IE_MASK;
 	asm volatile("kflag %0	\n"::"r"(tmp));
 }
-- 
2.14.5

