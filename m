Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C2AC282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D752186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 11:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DRemO6fd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbfBLLKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 06:10:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42874 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbfBLLKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 06:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549969890; x=1581505890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=v+wMN1vSHaqQ4Gf9rESAfOfnesAaSkkEfWAzcw8Qr8g=;
  b=DRemO6fd9XUNkO41EAq/aZL9jHrz9Egmpiy9KIkeQ31Xj29tlYcQ/OCp
   qn65+EEVt7/4QaSlIUcNDHzDlD1hUMPlG7t3WQtPC9XLwC/X0YXUm783y
   l7ZE5AugfY2gGSP24W19CD0rtg3UMPXWHXzYTwKozr/gE1e6BbzB88wLN
   M9RkIooPUahxuG7cWvzMvWcypwWm2jydCieCUiOvbZiylSzpWv0A/Hyin
   GNwU9o2EjQPsaFqOL/IXlXiGWkL5koxroReCuBUa0PzOG7jx3Rm9vT7MH
   5/0tDRs4G6SdP/BpSCFyiekek/Wo7Ip17TPGQJP8dLr89jVW1Ck70lR2S
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,361,1544457600"; 
   d="scan'208";a="199201842"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2019 19:11:13 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 12 Feb 2019 02:50:59 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Feb 2019 03:10:23 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v4 PATCH 8/8] RISC-V: Assign hwcap as per comman capabilities.
Date:   Tue, 12 Feb 2019 03:10:12 -0800
Message-Id: <1549969812-22502-9-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
References: <1549969812-22502-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we set hwcap based on first valid hart from DT. This may not
be correct always as that hart might not be current booting cpu or may
have a different capability.

Set hwcap as the capabilities supported by all possible harts with "okay"
status.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index e7a4701f..a1e4fb34 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <asm/processor.h>
 #include <asm/hwcap.h>
+#include <asm/smp.h>
 
 unsigned long elf_hwcap __read_mostly;
 #ifdef CONFIG_FPU
@@ -42,28 +43,30 @@ void riscv_fill_hwcap(void)
 
 	elf_hwcap = 0;
 
-	/*
-	 * We don't support running Linux on hertergenous ISA systems.  For
-	 * now, we just check the ISA of the first "okay" processor.
-	 */
 	for_each_of_cpu_node(node) {
-		if (riscv_of_processor_hartid(node) >= 0)
-			break;
-	}
-	if (!node) {
-		pr_warn("Unable to find \"cpu\" devicetree entry\n");
-		return;
-	}
+		unsigned long this_hwcap = 0;
 
-	if (of_property_read_string(node, "riscv,isa", &isa)) {
-		pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
-		of_node_put(node);
-		return;
-	}
-	of_node_put(node);
+		if (riscv_of_processor_hartid(node) < 0)
+			continue;
 
-	for (i = 0; i < strlen(isa); ++i)
-		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
+		if (of_property_read_string(node, "riscv,isa", &isa)) {
+			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
+			return;
+		}
+
+		for (i = 0; i < strlen(isa); ++i)
+			this_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
+
+		/*
+		 * All "okay" hart should have same isa. Set HWCAP based on
+		 * common capabilities of every "okay" hart, in case they don't
+		 * have.
+		 */
+		if (elf_hwcap)
+			elf_hwcap &= this_hwcap;
+		else
+			elf_hwcap = this_hwcap;
+	}
 
 	/* We don't support systems with F but without D, so mask those out
 	 * here. */
-- 
2.7.4

