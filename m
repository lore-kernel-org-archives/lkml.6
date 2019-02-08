Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32E9C282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A402E20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LnRaU3yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbfBHBvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:51:44 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13347 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfBHBvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1549590698; x=1581126698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=g/mEff0E+PMOEOwbxWDlOfFNXhWP3FWWB/Ym2Qop9J0=;
  b=LnRaU3ywsbyBgVPGl7fGepirbUSED2F5zW88pihlkcwO/9LKslsWVYOB
   +RP3T1v2bM4VtRBCcsBkNM5Q4v8cq8c1I+esa8CwL+NjIANC+Ka2UwdNQ
   s+AIm1hiYqJOLZJ5+y1bQCGhOjZexoqcbQlo9sL6aOCHEwBkYQCtdbzFK
   pYs+64LX9rYToMkXaLmKEnF29zoils4Qlc/FW6+rhOe5eKtOqKi3YPz8l
   8MvVVflsXi4poE852kgNU4Mz3hQEBm0dLfETVz6y9QqAD6sHUP2LYbTPt
   oluSyY62nd4aYDOJcg1pz5VzfQSMNCj5j68cypKwK2xsA3czDVoYER+3D
   Q==;
X-IronPort-AV: E=Sophos;i="5.58,346,1544457600"; 
   d="scan'208";a="100752818"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2019 09:51:37 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 07 Feb 2019 17:32:20 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Feb 2019 17:51:37 -0800
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
Subject: [v3 PATCH 6/8] clocksource/drivers/riscv: Add required checks during clock source init
Date:   Thu,  7 Feb 2019 17:51:19 -0800
Message-Id: <1549590681-24125-7-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
References: <1549590681-24125-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, clocksource registration happens for an invalid cpu
for non-smp kernels. This lead to kernel panic as cpu hotplug
registration will fail for those cpus. Moreover,
riscv_hartid_to_cpuid can return errors now.

Do not proceed if hartid or cpuid is invalid. Take this opprtunity
to print appropriate error strings for different failure cases.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 43189220..3c7ea75b 100644
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

