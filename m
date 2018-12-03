Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30A0C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A841020850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MuAxEXQr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A841020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbeLCU5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:57:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19087 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbeLCU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:57:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543870661; x=1575406661;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BSOlOVz1k4WQ8zp+c29OSEXPkk6Skbx3t6enWZR9980=;
  b=MuAxEXQrHwOUlXjCvNQrJeRv8ZrcR779ZE3bmpTlsb/JcnApi8kbijDC
   jcKE8BRNQw16f3oXWJt/P9HTP9ArzvQxuwTvYmTM0FA3o15lYwoYMW27V
   omGnbixUZwCdjYdm2KTAaOuJdhRNkFHqx6hC0y6TLuX49nvVfkuxAM2Yu
   XOAf6n6+WcwFac3sPpZlkN1PMxElSZ2NVc3apyhWHSsvHbbfm7K9y3pN4
   qG//BB0yRSYliM6BlEKIyjzwwY2XfJvEkdjxAEho8kHQL8S0BHpt3yS2x
   x7bVcSnfCK1tRnht9UXJhvjb7hkundfsF0PCtMl/nLwz4NpWcrQziSBP4
   g==;
X-IronPort-AV: E=Sophos;i="5.56,311,1539619200"; 
   d="scan'208";a="100519863"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2018 04:57:40 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 03 Dec 2018 12:39:55 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Dec 2018 12:57:40 -0800
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
Subject: [PATCH 4/4] RISC-V: Fix non-smp kernel boot on SMP systems
Date:   Mon,  3 Dec 2018 12:57:31 -0800
Message-Id: <1543870651-16669-5-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543870651-16669-1-git-send-email-atish.patra@wdc.com>
References: <1543870651-16669-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, clocksource registration happens for an invalid cpu
for non-smp kernels. This lead to kernel panic as cpu hotplug
registration will fail for those cpus.

Do not proceed if hartid is invalid. Take this opprtunity to
print appropriate error strings for different failure cases.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/clocksource/riscv_timer.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 39de6e49..4af4af47 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -108,6 +108,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	int cpuid, hartid, error;
 
 	hartid = riscv_of_processor_hartid(n);
+	if (hartid < 0)
+		return hartid;
 	cpuid = riscv_hartid_to_cpuid(hartid);
 
 	if (cpuid != smp_processor_id())
@@ -115,14 +117,19 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 
 	/* This should be called only for boot cpu */
 	riscv_timebase = riscv_timebase_frequency(n);
-	clocksource_register_hz(&riscv_clocksource, riscv_timebase);
+	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 
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
 
-- 
2.7.4

