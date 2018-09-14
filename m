Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73563C4161C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2783C20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B+uwYASN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2783C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbeIODLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 23:11:19 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:23763 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbeIODLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 23:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1536962098; x=1568498098;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=rEzYxMS1WWw1ZPTVuVRsKdHaMeMfJ1SMBUMSHZJL014=;
  b=B+uwYASNZs+Uus/rji0wubwlFous8O7nwEHEpMQv57YckX1z7RsTddEf
   kcaqr7B/g6hJTQHaEO8VY4f8BHRylWoGVkKLdezW0ihSR/xZFAT3wlFax
   yrJTmdLbavIYJLh9zd1ugCFJhhiDT8xMj/L5lCg8COXbGBzcW5PFMFgZD
   KeExjEc+qbH5EocpT48BSqA1Gmo+cgLutBLOJNgHPaX+0lvcQPUnLUpmn
   2lPKGVqGja3V4E8mqIXgHdWZNHIjykyfNQB1+KOT4IataMdMubdJoXOXb
   BNh885fNt5H5U3bNrDxCeRqT0EqEpDThdxi/bh7Tb5UOMYYk3vzkByy9D
   Q==;
X-IronPort-AV: E=Sophos;i="5.53,374,1531756800"; 
   d="scan'208";a="89803051"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2018 05:54:58 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 14 Sep 2018 14:41:23 -0700
Received: from jedi-01.sdcorp.global.sandisk.com (HELO jedi-01.int.fusionio.com) ([10.11.143.218])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Sep 2018 14:54:58 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     palmer@sifive.com, linux-riscv@lists.infradead.org,
        hch@infradead.org
Cc:     anup@brainfault.org, atish.patra@wdc.com, mark.rutland@arm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Damien.LeMoal@wdc.com, marc.zyngier@arm.com, robh@kernel.org
Subject: [RFC 3/3] RISC-V: Remove per cpu clocksource
Date:   Fri, 14 Sep 2018 14:54:56 -0700
Message-Id: <1536962096-233842-4-git-send-email-atish.patra@wdc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
References: <1536962096-233842-1-git-send-email-atish.patra@wdc.com>
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
index 335bdb91..537c5c70 100644
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
@@ -101,7 +101,6 @@ static long __init riscv_timebase_frequency(struct device_node *node)
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
 	int cpuid, hartid, error;
-	struct clocksource *cs;
 
 	hartid = riscv_of_processor_hartid(n);
 	cpuid = riscv_hartid_to_cpuid(hartid);
@@ -110,8 +109,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		return 0;
 
 	riscv_timebase = riscv_timebase_frequency(n);
-	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
-	clocksource_register_hz(cs, riscv_timebase);
+	clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
-- 
2.7.4

