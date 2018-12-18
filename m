Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E916C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4B5218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="atusBLcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeLRVaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:30:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37133 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeLRV3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:29:40 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so4271827wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 13:29:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HuxNRSLo1Y/SD7lAUX6QeRhvOXk945RDrLuI7e8huwc=;
        b=atusBLcCLc2S/PnQIGuPkwaWqoeJ6o1qCwBPOsDx85VjmTYC0rvdf+OkM/cQ4XNNXZ
         +DFmvR9qAtYuhV268U9V2pz7MRJ+VD4qoh1mN8iP143Vl8F7cpqVUCdwHiT5VbSmQQr0
         i1FOfio58SrDoVxkYVf7dJskuiT8wr9xmN764=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HuxNRSLo1Y/SD7lAUX6QeRhvOXk945RDrLuI7e8huwc=;
        b=DSUdq34C68ElQNEPGSgtmwvr7iRauPzx+lp41JS7mouINy0Ta9dG+QVE+Fezb0qkYG
         DECiKXkfzVcHpXCn6TObAv3ph3oEijhmCEuhYqqB/Lqr4ZpquR/3wWHBfHY9b/sucwsm
         Ycyw6w2BelX7wOrkNP0mKiSPbgpsl6wbm2eRzYNQ7KZVIGaRaCdU/bNVjsOUKfsbHnh2
         ohCzzAyhTer0pNIKTRKdMVZr11oANZtomgnvxdPTR0Aq3rRnoGcprYgSbu1M0YHN8Pt5
         /mbPax9sG42NAq5VVViXucdTEcNsdjNkkhKFjXp2CmKItolbmnXEgG8f3yKWsVoQd85p
         qZZQ==
X-Gm-Message-State: AA+aEWZZTJLXKJOwv4ntlbUbNIg/pMBi7OsZm8B2cy1TpLfuyQ6CF/rS
        LDQiXHkV7AMyGX7IvQ06+Vj4G7yaxTM=
X-Google-Smtp-Source: AFSGD/V1T4DONWUr6IaFJgBR3PuM0TVp/xv+chpP/j5o7RP2FzPqAwaU6SU7Di30AjuADT8agOcFlw==
X-Received: by 2002:a1c:5892:: with SMTP id m140mr4706654wmb.60.1545168578695;
        Tue, 18 Dec 2018 13:29:38 -0800 (PST)
Received: from localhost.localdomain (105.50.92.92.rev.sfr.net. [92.92.50.105])
        by smtp.gmail.com with ESMTPSA id o4sm4153485wrq.66.2018.12.18.13.29.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 13:29:38 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [PATCH 19/25] clocksource/drivers/riscv_timer: Provide the sched_clock
Date:   Tue, 18 Dec 2018 22:28:37 +0100
Message-Id: <20181218212844.30445-19-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218212844.30445-1-daniel.lezcano@linaro.org>
References: <d3f1255a-592d-13d9-5d3f-bd3ec7a36742@linaro.org>
 <20181218212844.30445-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup@brainfault.org>

Currently, we don't have a sched_clock registered for RISC-V systems.
This means Linux time keeping will use jiffies (running at HZ) as the
default sched_clock.

To avoid this, we explicity provide sched_clock using RISC-V rdtime
instruction (similar to riscv_timer clocksource).

Signed-off-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig       | 2 +-
 drivers/clocksource/riscv_timer.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c57b156f49a2..a4ae339e0101 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -599,7 +599,7 @@ config ATCPIT100_TIMER
 
 config RISCV_TIMER
 	bool "Timer for the RISC-V platform"
-	depends on RISCV
+	depends on GENERIC_SCHED_CLOCK && RISCV
 	default y
 	select TIMER_PROBE
 	select TIMER_OF
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 084e97dc10ed..431892200a08 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/sched_clock.h>
 #include <asm/smp.h>
 #include <asm/sbi.h>
 
@@ -49,6 +50,11 @@ static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
 	return get_cycles64();
 }
 
+static u64 riscv_sched_clock(void)
+{
+	return get_cycles64();
+}
+
 static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
 	.name		= "riscv_clocksource",
 	.rating		= 300,
@@ -97,6 +103,9 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
 	clocksource_register_hz(cs, riscv_timebase);
 
+	sched_clock_register(riscv_sched_clock,
+			BITS_PER_LONG, riscv_timebase);
+
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
-- 
2.17.1

