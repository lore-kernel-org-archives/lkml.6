Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CB6C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2860A222AC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 20:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RVUWr1Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436626AbfBMUSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 15:18:39 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:65222 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394564AbfBMUSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 15:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1550089102; x=1581625102;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=vnRdayaz5Pz6NDhpDj4PwPWoeZAvCxUKf5wSxkfkfNk=;
  b=RVUWr1Uke1QhInA4f4nnTiKa9LB0CYYazHLFiTaSHtacyWu8+DCBEP0P
   ifHKq4rrHk6SVDvTW8FIQGN/q1sxMq+t3RwVuzWpqy3BpFRJK4wl83xGr
   NP/8vmCn4lBJYj2hD+ybHuTFlpjEXzmHXHP4o5fWK2eSY3I3qAQNi9ZWb
   1JJX5auf3VRm9HrELFiq3Rl1JBHvnBP5jVObampV1qKuUwjP7f2N0BIuZ
   xQccllc1BDlhai8rffvkHT7dv5aGfqfxSf0ZJVorvzNHyxTNdiLVD/hcr
   fhqeVpurEBIwuV+KEX77tYZx3HNy/yEul4ByGZ5fTAtYBS0+Nb/JENnVa
   g==;
X-IronPort-AV: E=Sophos;i="5.58,366,1544457600"; 
   d="scan'208";a="106167287"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Feb 2019 04:18:21 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Feb 2019 11:58:55 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Feb 2019 12:18:22 -0800
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
Subject: [v5 PATCH 6/8] clocksource/drivers/riscv: Add required checks during clock source init
Date:   Wed, 13 Feb 2019 12:18:10 -0800
Message-Id: <1550089092-28783-7-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
References: <1550089092-28783-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, clocksource registration happens for an invalid cpu for
non-smp kernels. This lead to kernel panic as cpu hotplug registration
will fail for those cpus. Moreover, riscv_hartid_to_cpuid can return
errors now.

Do not proceed if hartid or cpuid is invalid. Take this opprtunity to
print appropriate error strings for different failure cases.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 43189220..e8163693 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -95,13 +95,30 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	struct clocksource *cs;
 
 	hartid = riscv_of_processor_hartid(n);
+	if (hartid < 0) {
+		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
+			n, hartid);
+		return hartid;
+	}
+
 	cpuid = riscv_hartid_to_cpuid(hartid);
+	if (cpuid < 0) {
+		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
+		return cpuid;
+	}
 
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
+	       __func__, cpuid, hartid);
 	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
-	clocksource_register_hz(cs, riscv_timebase);
+	error = clocksource_register_hz(cs, riscv_timebase);
+	if (error) {
+		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
+		       error, cpuid);
+		return error;
+	}
 
 	sched_clock_register(riscv_sched_clock,
 			BITS_PER_LONG, riscv_timebase);
@@ -110,8 +127,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
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

