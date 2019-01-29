Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B916C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C350214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762618;
	bh=5m8rru/IuJE55SNaktCJrTxHg5v8a0N10lzNA4VPhwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=viLUekeBxid/ooBnmeRULLTHZluMJyLAJ8vs9EvcI6+CefWdxyo6wcKMhnFwtWlxY
	 a/LwneQ4GnvSwjtWdB+nd4tmbmxUsxq2QVwOq/umlIxiLYgzcHzuJWN1f27j2/EO1i
	 0FsVvgess1XgsM3htN2fwIkxfdhydu839BMC7PmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfA2LuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:41452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731618AbfA2LuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 407E52177E;
        Tue, 29 Jan 2019 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762612;
        bh=5m8rru/IuJE55SNaktCJrTxHg5v8a0N10lzNA4VPhwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZM8XVl2dyKt9SWYwSdcNrbF6jLKjc+0iSb6dXmqgS5c64DzGzNJFRcRkbKjt+GYys
         ADBG9gOPM9N1BvGgMeXTfwh3ADhLPWhAVC9o4q9KI0xByLHnmpAARI2cyyCiLjEY3H
         cOjjKovc1ufy5o19U1VDqWWjPHnE797T9Vj7wsOo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hans van Kranenburg <hans.van.kranenburg@mendix.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.14 65/68] xen: Fix x86 sched_clock() interface for xen
Date:   Tue, 29 Jan 2019 12:36:27 +0100
Message-Id: <20190129113138.034020219@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 867cefb4cb1012f42cada1c7d1f35ac8dd276071 upstream.

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

[boris: replaced pr_info() with pr_info_once() in xen_callback_vector()
 to avoid printing with incorrect timestamp during resume (as we
 haven't re-adjusted the clock yet)]

Fixes: f94c8d11699759 ("sched/clock, x86/tsc: Rework the x86 'unstable' sched_clock() interface")
Cc: <stable@vger.kernel.org> # 4.11
Reported-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Tested-by: Hans van Kranenburg <hans.van.kranenburg@mendix.com>
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/time.c              |   12 +++++++++---
 drivers/xen/events/events_base.c |    2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -361,8 +361,6 @@ void xen_timer_resume(void)
 {
 	int cpu;
 
-	pvclock_resume();
-
 	if (xen_clockevent != &xen_vcpuop_clockevent)
 		return;
 
@@ -379,12 +377,15 @@ static const struct pv_time_ops xen_time
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
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1650,7 +1650,7 @@ void xen_callback_vector(void)
 			xen_have_vector_callback = 0;
 			return;
 		}
-		pr_info("Xen HVM callback vector for event delivery is enabled\n");
+		pr_info_once("Xen HVM callback vector for event delivery is enabled\n");
 		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR,
 				xen_hvm_callback_vector);
 	}


