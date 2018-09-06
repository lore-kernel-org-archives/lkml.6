Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D8FC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21C462075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 08:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GLi8TpBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C462075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbeIFMju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:39:50 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:53549 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbeIFMjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536221195; x=1567757195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+CEiDi1CN/NS9RMPq8yN//knmgexLiYbFFu89W/GRSk=;
  b=GLi8TpBKLeaZcAZwVOT95WAd/DsJVtG6xeALpbPajta+Q7Uicpngs1u4
   w2VlWOlg2PNMCa58IzZE9YBXjcI3+UOWkrXOtWr5da5cm7lI+msXfSXU/
   U0Harv4WvqyWnTDJCAMjrLldLx3XKV7KJpkN6WqAMGutTtCOuMvn8pJ9z
   StnhiQAK/Ezm2c7yODZev8/+lXSF2DAUKNRy89R4Z/gIu2NJMIxqWgKb4
   E/vTl9+fHOgO0udiG9kIhTzzcwOLQ/tsQsNEL+f0HM0SlcqNiWFm/21Sz
   3mjHUXhb395pcAtdBcitqkuSkoHGxNyBY5QhEq0XnzEQO7lZOYs+77XRl
   g==;
X-IronPort-AV: E=Sophos;i="5.53,337,1531756800"; 
   d="scan'208";a="186673953"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Sep 2018 16:06:34 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 06 Sep 2018 00:52:13 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Sep 2018 01:05:38 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org, anup@brainfault.org
Cc:     mark.rutland@arm.com, atish.patra@wdc.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Damien.LeMoal@wdc.com,
        marc.zyngier@arm.com, jeremy.linton@arm.com,
        gregkh@linuxfoundation.org, jason@lakedaemon.net,
        catalin.marinas@arm.com, dmitriy@oss-tech.org,
        ard.biesheuvel@linaro.org
Subject: [PATCH v3 06/12] RISC-V: Rename riscv_of_processor_hart to riscv_of_processor_hartid
Date:   Thu,  6 Sep 2018 01:05:29 -0700
Message-Id: <1536221135-182613-7-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
References: <1536221135-182613-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@sifive.com>

It's a bit confusing exactly what this function does: it actually
returns the hartid of an OF processor node, failing with -1 on invalid
nodes.  I've changed the name to _hartid() in order to make that a bit
more clear, as well as adding a comment.

Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
[Atish: code comment formatting update]
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/processor.h | 2 +-
 arch/riscv/kernel/cpu.c            | 7 +++++--
 arch/riscv/kernel/smpboot.c        | 2 +-
 drivers/clocksource/riscv_timer.c  | 2 +-
 drivers/irqchip/irq-sifive-plic.c  | 2 +-
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 3fe4af81..50de774d 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -88,7 +88,7 @@ static inline void wait_for_interrupt(void)
 }
 
 struct device_node;
-extern int riscv_of_processor_hart(struct device_node *node);
+int riscv_of_processor_hartid(struct device_node *node);
 
 extern void riscv_fill_hwcap(void);
 
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index b10cf054..04c0bcf2 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -15,8 +15,11 @@
 #include <linux/seq_file.h>
 #include <linux/of.h>
 
-/* Return -1 if not a valid hart */
-int riscv_of_processor_hart(struct device_node *node)
+/*
+ * Returns the hart ID of the given device tree node, or -1 if the device tree
+ * node isn't a RISC-V hart.
+ */
+int riscv_of_processor_hartid(struct device_node *node)
 {
 	const char *isa, *status;
 	u32 hart;
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 670749ec..cfb0b02d 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -53,7 +53,7 @@ void __init setup_smp(void)
 	int hart, im_okay_therefore_i_am = 0;
 
 	while ((dn = of_find_node_by_type(dn, "cpu"))) {
-		hart = riscv_of_processor_hart(dn);
+		hart = riscv_of_processor_hartid(dn);
 		if (hart >= 0) {
 			set_cpu_possible(hart, true);
 			set_cpu_present(hart, true);
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 4e8b347e..ad7453fc 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -84,7 +84,7 @@ void riscv_timer_interrupt(void)
 
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
-	int cpu_id = riscv_of_processor_hart(n), error;
+	int cpu_id = riscv_of_processor_hartid(n), error;
 	struct clocksource *cs;
 
 	if (cpu_id != smp_processor_id())
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 532e9d68..c55eaa31 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -176,7 +176,7 @@ static int plic_find_hart_id(struct device_node *node)
 {
 	for (; node; node = node->parent) {
 		if (of_device_is_compatible(node, "riscv"))
-			return riscv_of_processor_hart(node);
+			return riscv_of_processor_hartid(node);
 	}
 
 	return -1;
-- 
2.7.4

