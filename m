Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B48C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3585D20881
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 10:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i5URn9Si"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbfA2Kty (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 05:49:54 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:46392 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbfA2Ktv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 05:49:51 -0500
Received: from mailhost.synopsys.com (dc2-mailhost1.synopsys.com [10.12.135.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id A0B6710C11FC;
        Tue, 29 Jan 2019 02:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548758991; bh=WSJDjd3/oVJABGK0l9Hp5QCULSLXnEApOGjWPqPwE3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i5URn9Si6qh2AeflkpgQwV4ml/MenOQJ+py/OzLqjhYeGlDOBmWRCo5/EgVoOkS9X
         4y9JGN7g+TC7Lx2HfWy9a8VS+BIdazt0ya3dY3Nc2fxZWk1XnXvFga5I8SLZOeKGID
         NrjxWFrxMt4LJtXBv/a2M9SnZfTyFLUuYltmNHRmdtLph5F0X/LOaBGjkvWZ7yMtAc
         7pDnCC05mwswuDCBLQLxIsZAVGbkAteWdJfGNCZG8ZNrSFlosVdFiVmPAwquQgjJ9d
         d8PYsGl0SP3b5OpGTILqO5zPbyFJPa4eFElrnYsPQqIej0LN+v/+vUV5po0x38fzin
         UZK1e1VmkaFug==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.46])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4D6C4A0070;
        Tue, 29 Jan 2019 10:49:50 +0000 (UTC)
From:   Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>
Subject: [PATCH 3/5] ARCv2: Enable unaligned access in early ASM code
Date:   Tue, 29 Jan 2019 13:49:40 +0300
Message-Id: <20190129104942.31705-4-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
References: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though we do enable AD bit in arc_init_IRQ() we need to do
it in early ASM code otherwise we may face unaligned data until
we reach arc_init_IRQ() because GCC starting from v8.1.0 actively
generates unaligned data as it assumes that:
 * ARCv2 always has support of unaliged data
 * This support is turned on in runtime

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 arch/arc/kernel/head.S       | 14 ++++++++++++++
 arch/arc/kernel/intc-arcv2.c |  2 --
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 8b90d25a15cc..ffe3d384fca5 100644
--- a/arch/arc/kernel/head.S
+++ b/arch/arc/kernel/head.S
@@ -17,6 +17,9 @@
 #include <asm/entry.h>
 #include <asm/arcregs.h>
 #include <asm/cache.h>
+#ifdef CONFIG_ISA_ARCV2
+#include <asm/irqflags-arcv2.h>
+#endif
 
 .macro CPU_EARLY_SETUP
 
@@ -47,6 +50,17 @@
 	sr	r5, [ARC_REG_DC_CTRL]
 
 1:
+
+	; Enable / disable HW handling of unaligned access in the CPU.
+#ifdef CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS
+	kflag	STATUS_AD_MASK
+#else
+	; Handling of unaligned access is disabled by default but we disable it
+	; manually in case of any bootloader enabled it earlier.
+	lr	r5, [ARC_REG_STATUS32]
+	bclr	r5, r5, STATUS_AD_BIT
+	kflag	r5
+#endif
 .endm
 
 	.section .init.text, "ax",@progbits
diff --git a/arch/arc/kernel/intc-arcv2.c b/arch/arc/kernel/intc-arcv2.c
index 84b1c7157d1b..6359896da1ea 100644
--- a/arch/arc/kernel/intc-arcv2.c
+++ b/arch/arc/kernel/intc-arcv2.c
@@ -93,8 +93,6 @@ void arc_init_IRQ(void)
 
 	/* setup status32, don't enable intr yet as kernel doesn't want */
 	tmp = read_aux_reg(ARC_REG_STATUS32);
-	if (IS_ENABLED(ARC_USE_UNALIGNED_MEM_ACCESS))
-		tmp |= STATUS_AD_MASK;
 	tmp |= ARCV2_IRQ_DEF_PRIO << 1;
 	tmp &= ~STATUS_IE_MASK;
 	asm volatile("kflag %0	\n"::"r"(tmp));
-- 
2.14.5

