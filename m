Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2692C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F4E32148E
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RwZmxNY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbfA2KuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:50:09 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:43324 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfA2Ktu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:49:50 -0500
Received: from mailhost.synopsys.com (unknown [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 0108824E1042;
        Tue, 29 Jan 2019 02:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548758990; bh=J0HaC3Vqy5ZDjyU8yn6oPWQX/qvRtFmGvycx9pwDCLc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RwZmxNY/G2HxhrrNmuCzPeRVwsiCzrg9jW/8lca8FuZNGucN+ZrU8geeutFVQiv0t
         Mp4vVVzl4Ns/7CI4yrimgaHHrXA+i0CiozIQmnzqHhzjUmMrtlh3F6VkrE2i9Os0NL
         phQ62RHYQRA9X9811G7KnE8otIujygQTv/oBGcGAvtSit+R/AvNJ51A+oodMhhrSbp
         txuGYrOGN78jqcT4ymAf2X8LirliwSFADqFjSI8xj56zMxjMss43TAw5TYFQYrOlrP
         e+Hjz2rnNKd6DCDDL/jc9QQgj5TsGpOEANQ6wWxBgMod26Uqi6vttjoWd/czl0/zp+
         /5ImpMPfOzi6A==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id A08ECA0096;
        Tue, 29 Jan 2019 10:49:48 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 2/5] ARCv2: introduce unaligned access under a Kconfig option
Date:   Tue, 29 Jan 2019 13:49:39 +0300
Message-Id: <20190129104942.31705-3-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
References: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As of today we enable unaligned access unconditionally on ARCv2.
Lets move it under Kconfig option so we can disable it in case of
using HW configuration which lacks of it.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/Kconfig                      | 8 ++++++++
 arch/arc/include/asm/irqflags-arcv2.h | 4 ++++
 arch/arc/kernel/intc-arcv2.c          | 4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

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
 
diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index 067ea362fb3e..84b1c7157d1b 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -93,7 +93,9 @@ void arc_init_IRQ(void)
 
 	/* setup status32, don't enable intr yet as kernel doesn't want */
 	tmp = read_aux_reg(ARC_REG_STATUS32);
-	tmp |= STATUS_AD_MASK | (ARCV2_IRQ_DEF_PRIO << 1);
+	if (IS_ENABLED(ARC_USE_UNALIGNED_MEM_ACCESS))
+		tmp |= STATUS_AD_MASK;
+	tmp |= ARCV2_IRQ_DEF_PRIO << 1;
 	tmp &= ~STATUS_IE_MASK;
 	asm volatile("kflag %0	\n"::"r"(tmp));
 }
-- 
2.14.5

