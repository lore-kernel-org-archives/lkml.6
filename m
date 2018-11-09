Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECF1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5928C2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5928C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeKIVok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:44:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:57342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727742AbeKIVok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:44:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD89AAEA5;
        Fri,  9 Nov 2018 12:04:18 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, sstabellini@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Juergen Gross <jgross@suse.com>, stable@vger.kernel.org
Subject: [PATCH] xen: fix xen_qlock_wait()
Date:   Fri,  9 Nov 2018 13:04:13 +0100
Message-Id: <20181109120413.9539-1-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a856531951dc80 ("xen: make xen_qlock_wait() nestable")
introduced a regression for Xen guests running fully virtualized
(HVM or PVH mode). The Xen hypervisor wouldn't return from the poll
hypercall with interrupts disabled in case of an interrupt (for PV
guests it does).

So instead of disabling interrupts in xen_qlock_wait() use a nesting
counter to avoid calling xen_clear_irq_pending() in case
xen_qlock_wait() is nested.

Fixes: a856531951dc80 ("xen: make xen_qlock_wait() nestable")
Cc: stable@vger.kernel.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/spinlock.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 441c88262169..1c8a8816a402 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -9,6 +9,7 @@
 #include <linux/log2.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
+#include <linux/atomic.h>
 
 #include <asm/paravirt.h>
 #include <asm/qspinlock.h>
@@ -21,6 +22,7 @@
 
 static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
 static DEFINE_PER_CPU(char *, irq_name);
+static DEFINE_PER_CPU(atomic_t, xen_qlock_wait_nest);
 static bool xen_pvspin = true;
 
 static void xen_qlock_kick(int cpu)
@@ -39,25 +41,25 @@ static void xen_qlock_kick(int cpu)
  */
 static void xen_qlock_wait(u8 *byte, u8 val)
 {
-	unsigned long flags;
 	int irq = __this_cpu_read(lock_kicker_irq);
+	atomic_t *nest_cnt = this_cpu_ptr(&xen_qlock_wait_nest);
 
 	/* If kicker interrupts not initialized yet, just spin */
 	if (irq == -1 || in_nmi())
 		return;
 
-	/* Guard against reentry. */
-	local_irq_save(flags);
+	/* Detect reentry. */
+	atomic_inc(nest_cnt);
 
-	/* If irq pending already clear it. */
-	if (xen_test_irq_pending(irq)) {
+	/* If irq pending already and no nested call clear it. */
+	if (atomic_read(nest_cnt) == 1 && xen_test_irq_pending(irq)) {
 		xen_clear_irq_pending(irq);
 	} else if (READ_ONCE(*byte) == val) {
 		/* Block until irq becomes pending (or a spurious wakeup) */
 		xen_poll_irq(irq);
 	}
 
-	local_irq_restore(flags);
+	atomic_dec(nest_cnt);
 }
 
 static irqreturn_t dummy_handler(int irq, void *dev_id)
-- 
2.16.4

