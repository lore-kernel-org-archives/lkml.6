Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55639ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5BC20853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="g+mXq/ow"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5BC20853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbeIODL2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:11:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23763 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbeIODLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536962098; x=1568498098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=KjhF0aq74P5u/Ce5T4yYLghOI5Au57nuGi2tyLB1IPQ=;
  b=g+mXq/owdiZmkrh53Nh2ri1320uYKN6YTTX5N2sqx/WKsZr4ADuuRdJ8
   gXYb2ACOOusF6A22LjZ89vcMgJRjM2TvpoFC/izzyhrWKupyeqfHXvxlO
   EX+8ZogsgsfWBiTL1xWKIiV9Q13A5apHXNS365Mn5wq32rPRg2KijyGQo
   j1XqBMsc9Xmc1mo9oiFy9dI81Go6pg/fmHQQj8tnu1rg8QpVjEahxEr1J
   4SFFNE8yih42JQdxQfCpnPd5fcWMYEYPPqbwx14VabOyQzqFuPIBU5t6C
   DCCw3+VARhkelR+h0VjW/hFG7hVJhOT5VXLE8zik8M4Bz4ZlcKvbNuAjH
   g==;
X-IronPort-AV: E=Sophos;i="5.53,374,1531756800"; 
   d="scan'208";a="89803046"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2018 05:54:58 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 14 Sep 2018 14:41:23 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Sep 2018 14:54:57 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org
Cc:     anup@brainfault.org, atish.patra@wdc.com, mark.rutland@arm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Damien.LeMoal@wdc.com, marc.zyngier@arm.com, robh@kernel.org
Subject: [RFC 2/3] RISC-V:Support per-hart timebase-frequency
Date:   Fri, 14 Sep 2018 14:54:55 -0700
Message-Id: <1536962096-233842-3-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
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
 drivers/clocksource/riscv_timer.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+), 8 deletions(-)

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
index 084e97dc..335bdb91 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -83,6 +83,21 @@ void riscv_timer_interrupt(void)
 	evdev->event_handler(evdev);
 }
 
+static long __init riscv_timebase_frequency(struct device_node *node)
+{
+	u32 timebase;
+
+	if (!of_property_read_u32(node, "timebase-frequency", &timebase))
+		return timebase;
+
+	/* check under parent "cpus" node */
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
@@ -94,6 +109,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	riscv_timebase = riscv_timebase_frequency(n);
 	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
 	clocksource_register_hz(cs, riscv_timebase);
 
-- 
2.7.4

