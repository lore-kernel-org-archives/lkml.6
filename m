Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0556C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 624752087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T5H3EayT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 624752087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbeLCU5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:57:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19087 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeLCU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543870660; x=1575406660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=lowe9NWClqF4E9Y9BpuPy3f7/a/C7Daf2aZ8bK5IdEg=;
  b=T5H3EayTfLgQn7BluF7cj9Z++NZH/KcMymlz/7Wi/RHyy8sfuOKaS3Ni
   4YpxGg9e2kNV2adTe+R4CQH/J5ZhYMYA26dDRgVNQTYjkJ/qb77N0T0H/
   mOk1OaBkyN11hiVpNcmoA2BYO4r9WYjLylZ1I4OHILwoXqTzToNVax9zH
   3y4DdhAl+u4JPZoDeshS0p/juyfnsaFnR1i1D/WTxCxoBg+CghG2pw6zL
   xRcifJfqtG7LgU68JGtVyyd1qtTA7ICtDM99m8XwOGd+4gFHwYKFw1+Cr
   U7AfVmlg1cpZDFb+k0QtlomBklnWol5FwfF3sUIlq5jDYtZS2UEZQinPW
   g==;
X-IronPort-AV: E=Sophos;i="5.56,311,1539619200"; 
   d="scan'208";a="100519859"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2018 04:57:39 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 03 Dec 2018 12:39:55 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2018 12:57:39 -0800
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
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 2/4] RISC-V: Support per-hart timebase-frequency
Date:   Mon,  3 Dec 2018 12:57:29 -0800
Message-Id: <1543870651-16669-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543870651-16669-1-git-send-email-atish.patra@wdc.com>
References: <1543870651-16669-1-git-send-email-atish.patra@wdc.com>
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
 drivers/clocksource/riscv_timer.c | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 8 deletions(-)

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
index 084e97dc..96af7058 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -83,6 +83,26 @@ void riscv_timer_interrupt(void)
 	evdev->event_handler(evdev);
 }
 
+static long __init riscv_timebase_frequency(struct device_node *node)
+{
+	u32 timebase;
+
+	if (!of_property_read_u32(node, "timebase-frequency", &timebase))
+		return timebase;
+
+	/*
+	 * As per the DT specification, timebase-frequency should be present
+	 * under individual cpu node. Unfortunately, there are already available
+	 * HiFive Unleashed devices where the timebase-frequency entry is under
+	 * CPUs. check under parent "cpus" node to cover those devices.
+	 */
+	if (!of_property_read_u32(node->parent, "timebase-frequency",
+				  &timebase))
+		return timebase;
+
+	panic("RISC-V system with no 'timebase-frequency' in DTS\n");
+}
+
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
 	int cpuid, hartid, error;
@@ -94,6 +114,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	/* This should be called only for boot cpu */
+	riscv_timebase = riscv_timebase_frequency(n);
 	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
 	clocksource_register_hz(cs, riscv_timebase);
 
-- 
2.7.4

