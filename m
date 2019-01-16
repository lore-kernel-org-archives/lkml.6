Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC85C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B95B6206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WG6UaZdo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389938AbfAPLaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:30:00 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:35134 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbfAPL37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:29:59 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 585BC10C1697;
        Wed, 16 Jan 2019 03:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547638199; bh=Iw+zRKuRoIoH938bFhR1Jw1gSkH7rV72vaaoMpcM4nM=;
        h=From:To:Cc:Subject:Date:From;
        b=WG6UaZdoruqEIjmq8i9wpwRHt6Eo63iErLYqEd5P9VG8xIhCdP2ukD13LJqeY2flD
         u9kJm5qYVYStMR6hU9+a1hl/WqgGLjY2VB5t6dXHOePD8vlSFHezAYoWAfcswkL8c1
         74+BUdJMlhUwcQohI9JJjBnHGlaCs9QaSQ64peLaUvJ8QyMUU+1ArE2mjex7Ujtzdr
         JZisaPio26zXEPj09PGEORo+nkPRIxUpZCXh+/2PZb66iwCcXDa8DtlzDhp5CA99cw
         9k9Lepe7vBGyAA6u6Bn+1gg6gDrHZCLxopsvpSkUYIVF+dmWL6mwDU8/4PZr3fbThP
         vBVmUABNK4o3g==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.66])
        by mailhost.synopsys.com (Postfix) with ESMTP id E744F44D7;
        Wed, 16 Jan 2019 03:29:56 -0800 (PST)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 1/2] ARCv2: Enable unaligned access in early ASM code
Date:   Wed, 16 Jan 2019 14:29:50 +0300
Message-Id: <20190116112951.10641-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.5
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
 arch/arc/kernel/head.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
index 8b90d25a15cc..d5b7a572365a 100644
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
 
@@ -47,6 +50,13 @@
 	sr	r5, [ARC_REG_DC_CTRL]
 
 1:
+
+#ifdef CONFIG_ISA_ARCV2
+	; Enable handling of unaligned access in the CPU as by default
+	; this HW feature is disabled while GCC starting from 8.1.0
+	; unconditionally uses it for ARC HS cores.
+	flag    1 << STATUS_AD_BIT
+#endif
 .endm
 
 	.section .init.text, "ax",@progbits
-- 
2.14.5

