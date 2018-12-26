Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E67C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D690B218A5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 23:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n2QcCbt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeLZXJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 18:09:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:20034 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbeLZXJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 18:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545865762; x=1577401762;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Al1RyQfl0mslg7dvwfKrlns3Gv2SeAFssupFxW5Hyac=;
  b=n2QcCbt65dj/bJrepwrC+JbGh5zaHef4RyHarL2+bexPkrBdSjtX7yUG
   W+3dytuckekDApy7pokZ5001kRF/ycwIkBhxbulbyLdq+4PQRXxioPK4u
   6oFQ5iuNmqoVNz9iCo0mNBy3n70EttV+rJnrohUYbAWTAH2G/EHFgsYRu
   crNpE2JcaK1216gnL9cvaD6+wH5+w0594Op/8ighZfRuuNW87OECGwI5n
   ETFAWouENe/3BxDFgGMVlBJRKv+H1qY+EjZh57K4IxkuqvEJNAwY9Q5op
   UexsmU1nbAiwpedguMqLWs0EWueItaiWPVYbTVGxeMKoIL8HstYsX57zo
   A==;
X-IronPort-AV: E=Sophos;i="5.56,401,1539619200"; 
   d="scan'208";a="98702985"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Dec 2018 07:09:08 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 26 Dec 2018 14:49:52 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Dec 2018 15:09:08 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-riscv@lists.infradead.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?q?Patrick=20St=C3=A4hlin?= <me@packi.ch>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: [PATCH 3/3] RISC-V: Fix non-smp kernel boot on SMP systems
Date:   Wed, 26 Dec 2018 15:09:01 -0800
Message-Id: <1545865741-22795-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545865741-22795-1-git-send-email-atish.patra@wdc.com>
References: <1545865741-22795-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In non-smp configuration, hartid can be higher that NR_CPUS.
riscv_of_processor_hartid should not be compared to hartid to
NR_CPUS in that case. Moreover, this function checks all the
DT properties of a hart node. NR_CPUS comparison seems out of
place.

Do cpuid comparison with NR_CPUs in smp setup code. Update the
drivers to handle appropriate code as well.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/cpu.c           |  4 ----
 arch/riscv/kernel/smp.c           |  1 -
 arch/riscv/kernel/smpboot.c       |  5 +++++
 drivers/clocksource/riscv_timer.c | 21 ++++++++++++++++++---
 drivers/irqchip/irq-sifive-plic.c |  5 +++++
 5 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index b4a7d442..251ffab6 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -34,10 +34,6 @@ int riscv_of_processor_hartid(struct device_node *node)
 		pr_warn("Found CPU without hart ID\n");
 		return -(ENODEV);
 	}
-	if (hart >= NR_CPUS) {
-		pr_info("Found hart ID %d, which is above NR_CPUs.  Disabling this hart\n", hart);
-		return -(ENODEV);
-	}
 
 	if (of_property_read_string(node, "status", &status)) {
 		pr_warn("CPU with hartid=%d has no \"status\" property\n", hart);
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 57b1383e..9ea7ac7d 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -49,7 +49,6 @@ int riscv_hartid_to_cpuid(int hartid)
 			return i;
 
 	pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
-	BUG();
 	return i;
 }
 
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index bb8cd242..05291840 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -66,6 +66,11 @@ void __init setup_smp(void)
 			found_boot_cpu = 1;
 			continue;
 		}
+		if (cpuid >= NR_CPUS) {
+			pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
+				cpuid, hart);
+			break;
+		}
 
 		cpuid_to_hartid_map(cpuid) = hart;
 		set_cpu_possible(cpuid, true);
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 084e97dc..acf2af10 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -89,20 +89,35 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	struct clocksource *cs;
 
 	hartid = riscv_of_processor_hartid(n);
+	if (hartid < 0) {
+		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
+			n, hartid);
+		return hartid;
+	}
 	cpuid = riscv_hartid_to_cpuid(hartid);
 
+	if (cpuid < 0)
+		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
+
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	pr_err("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
+	       __func__, cpuid, hartid);
 	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
-	clocksource_register_hz(cs, riscv_timebase);
+	error = clocksource_register_hz(cs, riscv_timebase);
 
+	if (error) {
+		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
+		       error, cpuid);
+		return error;
+	}
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
 	if (error)
-		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
-		       error, cpuid);
+		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
+		       error);
 	return error;
 }
 
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 357e9daf..254ecd76 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -237,6 +237,11 @@ static int __init plic_init(struct device_node *node,
 		}
 
 		cpu = riscv_hartid_to_cpuid(hartid);
+		if (cpu < 0) {
+			pr_warn("Invalid cpuid for context %d\n", i);
+			continue;
+		}
+
 		handler = per_cpu_ptr(&plic_handlers, cpu);
 		handler->present = true;
 		handler->ctxid = i;
-- 
2.7.4

