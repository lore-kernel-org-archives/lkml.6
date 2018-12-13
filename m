Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57FDC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8286C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dNEOJ0Hp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8286C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728822AbeLMXPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:15:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15460 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbeLMXOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544742896; x=1576278896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=dxBtfF9Jex9DE2/3vLUN+wWRwkF14HDcarpu+1RMLOM=;
  b=dNEOJ0Hp/SkuxZrKChfCUS9ZJ49qDkpNoLU7U1WBYXiHdHyM8O79foRb
   gQr17SRHBfxyWxV/du60U6G7o6aGn1E7I/2C/d2OC2IDx52ilym7KthqD
   XhL8/1FYI5HYerQBT8vwWKmRt8h7Ll7y+Mo6js1uD/++A95ThmckhaXoC
   OCdZ8eqXQ9NwmjDK4sSlsl2fNvpwGs4V+aC/EW0ZYCG6gjVELrQTCX7r+
   6dQcY+ix4Fm6fE/1HCpt1h0WuIvyjPsgyt6wAUgakQrg9gmXl42lisu3m
   Nsu5H82wYJTIWxxcxhYd59jppfsuH4RAVPJDDfbw4b0A/5roYBCarUYkG
   g==;
X-IronPort-AV: E=Sophos;i="5.56,350,1539619200"; 
   d="scan'208";a="194445537"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2018 07:14:55 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Dec 2018 14:57:20 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2018 15:14:53 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 2/4] RISC-V: Support per-hart timebase-frequency
Date:   Thu, 13 Dec 2018 15:14:27 -0800
Message-Id: <1544742869-19980-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544742869-19980-1-git-send-email-atish.patra@wdc.com>
References: <1544742869-19980-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the updated DT specs and read the timebase-frequency
from the boot cpu. Keep the old DT reading as well for backward
compatibility. This patch is rework of old patch from Palmer.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/time.c          |  9 +--------
 drivers/clocksource/riscv_timer.c | 31 +++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/time.c b/arch/riscv/kernel/time.c
index 1911c8f6..225fe743 100644
--- a/arch/riscv/kernel/time.c
+++ b/arch/riscv/kernel/time.c
@@ -20,14 +20,7 @@ unsigned long riscv_timebase;
 
 void __init time_init(void)
 {
-	struct device_node *cpu;
-	u32 prop;
-
-	cpu = of_find_node_by_path("/cpus");
-	if (!cpu || of_property_read_u32(cpu, "timebase-frequency", &prop))
-		panic(KERN_WARNING "RISC-V system with no 'timebase-frequency' in DTS\n");
-	riscv_timebase = prop;
+	timer_probe();
 
 	lpj_fine = riscv_timebase / HZ;
-	timer_probe();
 }
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 084e97dc..75262409 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -83,6 +83,35 @@ void riscv_timer_interrupt(void)
 	evdev->event_handler(evdev);
 }
 
+static void __init riscv_timebase_frequency(struct device_node *node,
+					    int hartid)
+{
+	u32 timebase;
+
+	if (!of_property_read_u32(node, "timebase-frequency", &timebase))
+		goto check;
+
+	/*
+	 * As per the DT specification, timebase-frequency should be present
+	 * under individual cpu node. Unfortunately, there are already available
+	 * HiFive Unleashed devices where the timebase-frequency entry is under
+	 * CPUs. check under parent "cpus" node to cover those devices.
+	 */
+	if (!of_property_read_u32(node->parent, "timebase-frequency",
+				  &timebase))
+		goto check;
+
+	panic("RISC-V system with no timebase-frequency in DTS for hart [%d]\n",
+	      hartid);
+
+check:
+	/* RISC-V ISA specification mandates that every cpu has a timer */
+	if (!riscv_timebase)
+		riscv_timebase = timebase;
+	else if (riscv_timebase && riscv_timebase != timebase)
+		pr_warn("RISC-V system with different timebase-frequency\n");
+}
+
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
 	int cpuid, hartid, error;
@@ -90,10 +119,12 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 
 	hartid = riscv_of_processor_hartid(n);
 	cpuid = riscv_hartid_to_cpuid(hartid);
+	riscv_timebase_frequency(n, hartid);
 
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	/* This should be called only for boot cpu */
 	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
 	clocksource_register_hz(cs, riscv_timebase);
 
-- 
2.7.4

