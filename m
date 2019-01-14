Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64A0C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F7820656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbfANMoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:44:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:34934 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbfANMoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:44:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 522C1AB7D;
        Mon, 14 Jan 2019 12:44:15 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hans@knorrie.org, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH v3] xen: Fix x86 sched_clock() interface for xen
Date:   Mon, 14 Jan 2019 13:44:13 +0100
Message-Id: <20190114124413.3742-1-jgross@suse.com>
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
 arch/x86/xen/time.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 72bf446c3fee..6e29794573b7 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -361,8 +361,6 @@ void xen_timer_resume(void)
 {
 	int cpu;
 
-	pvclock_resume();
-
 	if (xen_clockevent != &xen_vcpuop_clockevent)
 		return;
 
@@ -379,12 +377,15 @@ static const struct pv_time_ops xen_time_ops __initconst = {
 };
 
 static struct pvclock_vsyscall_time_info *xen_clock __read_mostly;
+static u64 xen_clock_value_saved;
 
 void xen_save_time_memory_area(void)
 {
 	struct vcpu_register_time_memory_area t;
 	int ret;
 
+	xen_clock_value_saved = xen_clocksource_read() - xen_sched_clock_offset;
+
 	if (!xen_clock)
 		return;
 
@@ -404,7 +405,7 @@ void xen_restore_time_memory_area(void)
 	int ret;
 
 	if (!xen_clock)
-		return;
+		goto out;
 
 	t.addr.v = &xen_clock->pvti;
 
@@ -421,6 +422,11 @@ void xen_restore_time_memory_area(void)
 	if (ret != 0)
 		pr_notice("Cannot restore secondary vcpu_time_info (err %d)",
 			  ret);
+
+out:
+	/* Need pvclock_resume() before using xen_clocksource_read(). */
+	pvclock_resume();
+	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
 static void xen_setup_vsyscall_time_info(void)
-- 
2.16.4

