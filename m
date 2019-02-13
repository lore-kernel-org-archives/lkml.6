Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D20C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA5F6222AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:18:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EdSHYn9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394586AbfBMUS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:18:28 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:65222 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394569AbfBMUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550089102; x=1581625102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LuHhF9t57ihPno63oc42DW7mqejQI1UJBdnLjc5u4ww=;
  b=EdSHYn9J/qotng5soacf9wlM+VHH/NPXxQBrFIrUnsXwYVIxKrBGuDwk
   1JSQakp494NdPNjcaCNs20lVfsQ3btARKWdHjaNPcOP0i7bhbIUmanrjq
   qrzXYOEtZrl/plvswbSHpHJVmRmqOJQpkGgQ9kyu7vh4OtrjJAUFDCpi9
   Q1ogWXTxgkfy7jWEEgd8dxSFwijqCj3Y1RfOU7dj2/E3Ex9yaNos5WXOB
   rMrGpna6YP2W7M38R4Bx6D2EvyepOB4IJaUJzXMJhhLGg1njVxPTiak6H
   gDLS47k/vCFyRgn9vn92cLzFglNIJq29ai/QVisNloFE//kUWbdaCXqVR
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,366,1544457600"; 
   d="scan'208";a="106167295"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2019 04:18:22 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Feb 2019 11:58:56 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2019 12:18:23 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [v5 PATCH 8/8] RISC-V: Assign hwcap as per comman capabilities.
Date:   Wed, 13 Feb 2019 12:18:12 -0800
Message-Id: <1550089092-28783-9-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
References: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
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
index e7a4701f..bc29b010 100644
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
+			continue;
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

