Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B2B5C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E992173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfAJKH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:07:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36044 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbfAJKH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:07:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A72FAACD1;
        Thu, 10 Jan 2019 10:07:24 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hans@knorrie.org, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH] xen: Fix x86 sched_clock() interface for xen
Date:   Thu, 10 Jan 2019 11:07:22 +0100
Message-Id: <20190110100722.11216-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f94c8d11699759 ("sched/clock, x86/tsc: Rework the x86 'unstable'
sched_clock() interface") broke Xen guest time handling across
migration:

[  187.249951] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  187.251137] OOM killer disabled.
[  187.251137] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  187.252299] suspending xenstore...
[  187.266987] xen:grant_table: Grant tables using version 1 layout
[18446743811.706476] OOM killer enabled.
[18446743811.706478] Restarting tasks ... done.
[18446743811.720505] Setting capacity to 16777216

Fix that by setting xen_sched_clock_offset at resume time to ensure a
monotonic clock value.

Fixes: f94c8d11699759 ("sched/clock, x86/tsc: Rework the x86 'unstable' sched_clock() interface")
Cc: <stable@vger.kernel.org> # 4.11
Reported-by: Hans van Kranenburg <hans@knorrie.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/suspend.c |  4 ++++
 arch/x86/xen/time.c    | 11 +++++++++++
 arch/x86/xen/xen-ops.h |  2 ++
 3 files changed, 17 insertions(+)

diff --git a/arch/x86/xen/suspend.c b/arch/x86/xen/suspend.c
index 1d83152c761b..45fc9caf3880 100644
--- a/arch/x86/xen/suspend.c
+++ b/arch/x86/xen/suspend.c
@@ -67,6 +67,8 @@ void xen_arch_resume(void)
 {
 	int cpu;
 
+	xen_clocksource_resume();
+
 	on_each_cpu(xen_vcpu_notify_restore, NULL, 1);
 
 	for_each_online_cpu(cpu)
@@ -81,4 +83,6 @@ void xen_arch_suspend(void)
 		xen_pmu_finish(cpu);
 
 	on_each_cpu(xen_vcpu_notify_suspend, NULL, 1);
+
+	xen_clocksource_suspend();
 }
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 72bf446c3fee..117ce958ffe6 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -32,6 +32,7 @@
 #define TIMER_SLOP	100000
 
 static u64 xen_sched_clock_offset __read_mostly;
+static u64 xen_clock_value_saved;
 
 /* Get the TSC speed from Xen */
 static unsigned long xen_tsc_khz(void)
@@ -54,6 +55,16 @@ static u64 xen_clocksource_read(void)
 	return ret;
 }
 
+void xen_clocksource_suspend(void)
+{
+	xen_clock_value_saved = xen_clocksource_read() - xen_sched_clock_offset;
+}
+
+void xen_clocksource_resume(void)
+{
+	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
+}
+
 static u64 xen_clocksource_get_cycles(struct clocksource *cs)
 {
 	return xen_clocksource_read();
diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
index 0e60bd918695..a17d3bdab6b8 100644
--- a/arch/x86/xen/xen-ops.h
+++ b/arch/x86/xen/xen-ops.h
@@ -63,6 +63,8 @@ void __init xen_build_dynamic_phys_to_machine(void);
 void __init xen_vmalloc_p2m_tree(void);
 
 void xen_init_irq_ops(void);
+void xen_clocksource_suspend(void);
+void xen_clocksource_resume(void);
 void xen_setup_timer(int cpu);
 void xen_setup_runstate_info(int cpu);
 void xen_teardown_timer(int cpu);
-- 
2.16.4

