Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E792EC67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57CE20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 23:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="cj9YYHeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57CE20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbeLMXPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 18:15:10 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15458 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbeLMXOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 18:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1544742896; x=1576278896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BHWX4R4PvQqPuiagEVF3DBhfwi4Xf90NcYD4tNuJ0oY=;
  b=cj9YYHegmMS0fKsBSJC5NjLxA82BcDORRr2CNoeoumpUTvdzmmPpIMKO
   B67nq0qogSlTQtt8b9lYHQeJrA2FXBddBnLmDW41Y0r8j31c240A52ha/
   BPsXGsy/yAVGsIi25HWhVBJMZ5q7sg41IJGP8yMHeSHvp27VDXhofV6i3
   Jo1Op7DjQBblo9D6nT8i3H/vsbtMdFhl/U+/ouQPN56x5AzRUac67B/1S
   2STUjlRUQ7iyEl08iHjCOovTJYKXaKpr04lHfZTBqigx7shnWhTkoN3RA
   CaxthHKU15ZdaeqEFnYGyqFxM6Zv8cxtT0s49NUVwsvnIwrTUEG+ndYvh
   g==;
X-IronPort-AV: E=Sophos;i="5.56,350,1539619200"; 
   d="scan'208";a="194445539"
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
Subject: [PATCH v2 3/4] RISC-V: Remove per cpu clocksource
Date:   Thu, 13 Dec 2018 15:14:28 -0800
Message-Id: <1544742869-19980-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544742869-19980-1-git-send-email-atish.patra@wdc.com>
References: <1544742869-19980-1-git-send-email-atish.patra@wdc.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only one clocksource in RISC-V. The boot cpu initializes
that clocksource. No need to keep a percpu data structure.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
---
 drivers/clocksource/riscv_timer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 75262409..c9e65086 100644
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
@@ -115,7 +115,6 @@ static void __init riscv_timebase_frequency(struct device_node *node,
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
 	int cpuid, hartid, error;
-	struct clocksource *cs;
 
 	hartid = riscv_of_processor_hartid(n);
 	cpuid = riscv_hartid_to_cpuid(hartid);
@@ -125,8 +124,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		return 0;
 
 	/* This should be called only for boot cpu */
-	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
-	clocksource_register_hz(cs, riscv_timebase);
+	clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
-- 
2.7.4

