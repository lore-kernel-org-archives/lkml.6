Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBE5C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE9220850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ESK6aDtJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE9220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbeLCU5z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:57:55 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:19091 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeLCU5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1543870660; x=1575406660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=gT+4+YOy/e4V5jGHXisg1EpxZnAGQEmnG+MEmJ2rGdI=;
  b=ESK6aDtJxcTImhXj00PY8tz7ZW6HutsBZa0VB4Xt2x1s1zqUa+icdUTF
   ZGJh/6m/KzrMb/kR79njuCaQ+oXjN+BxRid5d6Jv3C0SAx8BqmPqkro3w
   oL7OHPLHVzyGcEVoRs3OoW7WwaTUGN/AqWU/VM3lzilYXUfBqc9WLQUeB
   Mp/y6aYkT4k8a2RnaOBD+phc4DOtKm3NyHKcUNU8NU6twLT68ELIdT4lD
   21YGpW5tHR1wZ0G1FXq8e9DmTbBuT589oXYHHCcQd7eQKv2Jrl1njT/mq
   k/PAEqa9ZmGjFVrFXNLiqVg3Conby1WeabPPO/PqGuHmfX1y7O5Ivv2yV
   g==;
X-IronPort-AV: E=Sophos;i="5.56,311,1539619200"; 
   d="scan'208";a="100519861"
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
Subject: [PATCH 3/4] RISC-V: Remove per cpu clocksource
Date:   Mon,  3 Dec 2018 12:57:30 -0800
Message-Id: <1543870651-16669-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543870651-16669-1-git-send-email-atish.patra@wdc.com>
References: <1543870651-16669-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one clocksource in RISC-V. The boot cpu initializes
that clocksource. No need to keep a percpu data structure.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 drivers/clocksource/riscv_timer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 96af7058..39de6e49 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -49,7 +49,7 @@ static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
 	return get_cycles64();
 }
 
-static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
+static struct clocksource riscv_clocksource = {
 	.name		= "riscv_clocksource",
 	.rating		= 300,
 	.mask		= CLOCKSOURCE_MASK(BITS_PER_LONG),
@@ -106,7 +106,6 @@ static long __init riscv_timebase_frequency(struct device_node *node)
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
 	int cpuid, hartid, error;
-	struct clocksource *cs;
 
 	hartid = riscv_of_processor_hartid(n);
 	cpuid = riscv_hartid_to_cpuid(hartid);
@@ -116,8 +115,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 
 	/* This should be called only for boot cpu */
 	riscv_timebase = riscv_timebase_frequency(n);
-	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
-	clocksource_register_hz(cs, riscv_timebase);
+	clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
-- 
2.7.4

