Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11038C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A6B20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rqqMkJcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A6B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeLMXO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:14:58 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15458 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbeLMXOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:14:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544742897; x=1576278897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=b5KAQRZJT4zUe1BE7oYg6So4dJiL7LJW7fLH12Vxeuo=;
  b=rqqMkJcEi/7LEwDy3N8BQPdrFgPUpyUTm3ze8vaZnjyPeJxoQFcPi5lt
   82ggJSAhx1uinRe8m1RG3IPgR9MHS0aJF4YwYvymYQBg+i9FdTzNxmYuE
   0ga6LEt33zRqInyZ+z0qOPjgFdhgj/wGdKrIWR0bdgAj0jx7cCcnjfllc
   35LTGjFJGja80RSdAaHO/T1R+Ps0VqMM+VM/yqA86MwEdJY6Q6OS8LWXS
   TiR+7/UYnQ7GpXGO+BhsEWiLZrv30kWMBEb1YXEItFKh+4JRgk8I1Jdcj
   7p8SZftyuzVRl6dSOlXp/kCmpNac9K37R00CG9RMVbh8itFJRhmPknfvG
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,350,1539619200"; 
   d="scan'208";a="194445541"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Dec 2018 07:14:56 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 13 Dec 2018 14:57:21 -0800
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Dec 2018 15:14:54 -0800
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
Subject: [PATCH v2 4/4] RISC-V: Fix non-smp kernel boot on SMP systems
Date:   Thu, 13 Dec 2018 15:14:29 -0800
Message-Id: <1544742869-19980-5-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544742869-19980-1-git-send-email-atish.patra@wdc.com>
References: <1544742869-19980-1-git-send-email-atish.patra@wdc.com>
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
 drivers/clocksource/riscv_timer.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index c9e65086..c1e1260e 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -117,6 +117,11 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	int cpuid, hartid, error;
 
 	hartid = riscv_of_processor_hartid(n);
+	if (hartid < 0) {
+		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
+			n, hartid);
+		return hartid;
+	}
 	cpuid = riscv_hartid_to_cpuid(hartid);
 	riscv_timebase_frequency(n, hartid);
 
@@ -124,14 +129,19 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		return 0;
 
 	/* This should be called only for boot cpu */
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

