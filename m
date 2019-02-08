Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B97EC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB4B520869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bmQLFtaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbfBHBvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:51:54 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13347 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfBHBvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549590699; x=1581126699;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ZvCXzp8StVNSMAn/qR+TnMWcDQTO4o6GC0MhJ3P3W7o=;
  b=bmQLFtaWXvaLxuymJzD6g+WnApCuWpZl4Hlmc/FoOAqRFOWIh+EvnPj/
   sa2Vm6CoAKL3+k4i7dMDucsTyQyMneaVyEcoIU/W1KlWOfM4ZBIiGDc88
   N8g8WSw8WSz1+szvcQDOMQLhO3vqlsSFQ14YN5qG7Ep+PiNpeLx7a9vg5
   zoWUod4/43RPQYKzX4t1UtUjrEY4mdWJfYqlU+6sMzdvsosx7MPtXPD7b
   vNaAdy4ceYRnvSlmOv4hzL+JHD04oX4JHffNWwQCeQeCbhwUTAuCVI1W0
   X3yX3jmjUwkWEvr6Q2hkDI/TW+5yJTZgkC1Vxp1KeieGcgMz/cDX5ONaD
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,346,1544457600"; 
   d="scan'208";a="100752826"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2019 09:51:38 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Feb 2019 17:32:21 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2019 17:51:38 -0800
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
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [v3 PATCH 8/8] RISC-V: Assign hwcap only according to boot cpu.
Date:   Thu,  7 Feb 2019 17:51:21 -0800
Message-Id: <1549590681-24125-9-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we set hwcap based on first valid cpu from
DT. This may not be correct always as that CPU might not
be current booting cpu.

Set hwcap based on the boot cpu instead of first
valid CPU from DT. Add a sanity check to identify if any
hwcap do not match.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpufeature.c | 52 +++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 16 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index a6e369ed..ed8f0c28 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <asm/processor.h>
 #include <asm/hwcap.h>
+#include <asm/smp.h>
 
 unsigned long elf_hwcap __read_mostly;
 #ifdef CONFIG_FPU
@@ -32,6 +33,8 @@ void riscv_fill_hwcap(void)
 	const char *isa;
 	size_t i;
 	static unsigned long isa2hwcap[256] = {0};
+	int hartid;
+	unsigned long temp_hwcap = 0, boot_hwcap = 0;
 
 	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m'] = isa2hwcap['M'] = COMPAT_HWCAP_ISA_M;
@@ -43,27 +46,44 @@ void riscv_fill_hwcap(void)
 	elf_hwcap = 0;
 
 	/*
-	 * We don't support running Linux on hertergenous ISA systems.  For
-	 * now, we just check the ISA of the first "okay" processor.
+	 * We don't support running Linux on hertergenous ISA systems.
+	 * But first "okay" processor might not be the boot cpu.
+	 * Check the ISA of boot cpu.
 	 */
-	while ((node = of_find_node_by_type(node, "cpu")))
-		if (riscv_of_processor_hartid(node) >= 0)
-			break;
-	if (!node) {
-		pr_warning("Unable to find \"cpu\" devicetree entry");
-		return;
-	}
+	while ((node = of_find_node_by_type(node, "cpu"))) {
+		if (!node) {
+			pr_warn("Unable to find \"cpu\" devicetree entry");
+			return;
+		}
+
+		hartid = riscv_of_processor_hartid(node);
+		if (hartid < 0)
+			continue;
 
-	if (of_property_read_string(node, "riscv,isa", &isa)) {
-		pr_warning("Unable to find \"riscv,isa\" devicetree entry");
+		if (of_property_read_string(node, "riscv,isa", &isa)) {
+			pr_warn("Unable to find \"riscv,isa\" devicetree entry");
+			of_node_put(node);
+			return;
+		}
 		of_node_put(node);
-		return;
-	}
-	of_node_put(node);
 
-	for (i = 0; i < strlen(isa); ++i)
-		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
+		for (i = 0; i < strlen(isa); ++i)
+			temp_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
+		/*
+		 * All "okay" hart should have same isa. We don't know how to
+		 * handle if they don't. Throw a warning for now.
+		 */
+		if (elf_hwcap && temp_hwcap != elf_hwcap)
+			pr_warn("isa mismatch: 0x%lx != 0x%lx\n",
+				elf_hwcap, temp_hwcap);
+
+		if (hartid == boot_cpu_hartid)
+			boot_hwcap = temp_hwcap;
+		elf_hwcap = temp_hwcap;
+		temp_hwcap = 0;
+	}
 
+	elf_hwcap = boot_hwcap;
 	/* We don't support systems with F but without D, so mask those out
 	 * here. */
 	if ((elf_hwcap & COMPAT_HWCAP_ISA_F) && !(elf_hwcap & COMPAT_HWCAP_ISA_D)) {
-- 
2.7.4

