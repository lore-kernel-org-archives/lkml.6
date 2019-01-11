Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90B4C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92D12146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 12:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731862AbfAKMIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 07:08:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:45808 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbfAKMII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 07:08:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7653AABD4;
        Fri, 11 Jan 2019 12:08:07 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        hans@knorrie.org, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] xen: Fix x86 sched_clock() interface for xen
Date:   Fri, 11 Jan 2019 13:08:05 +0100
Message-Id: <20190111120805.24852-1-jgross@suse.com>
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
 arch/x86/xen/time.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 72bf446c3fee..3c1dfdf26284 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -379,12 +379,15 @@ static const struct pv_time_ops xen_time_ops __initconst = {
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
 
@@ -404,7 +407,7 @@ void xen_restore_time_memory_area(void)
 	int ret;
 
 	if (!xen_clock)
-		return;
+		goto out;
 
 	t.addr.v = &xen_clock->pvti;
 
@@ -421,6 +424,11 @@ void xen_restore_time_memory_area(void)
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

