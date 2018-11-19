Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06A0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A5B42151B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fI6c3lhV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A5B42151B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405035AbeKTDXY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403980AbeKTDXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:23:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87BC4214D9;
        Mon, 19 Nov 2018 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646748;
        bh=5C58OQkm/9HwIsC3tycs8VrqD6+IFEA8GhBdIzQz2Ng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fI6c3lhVyvnqjwFUeYt+8vIUcI3T0v9RT8ZUphDVo5sHupzWaSI6+AzrcksphqvIA
         SA3aEwCbQCEvRRMREWv00v2zhntPlO0j8GCVquLXJqFJoGvhXBuUDWj1IAicDJQsVq
         rk4hE0esZNuzpYAcqqqeXnE+WhJmKq3uQjtDfIWM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sander Eikelenboom <linux@eikelenboom.it>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.4 076/160] xen: fix xen_qlock_wait()
Date:   Mon, 19 Nov 2018 17:28:35 +0100
Message-Id: <20181119162638.616346715@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
References: <20181119162630.031306128@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit d3132b3860f6cf35ff7609a76bbcdbb814bd027c upstream.

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
Reported-by: Sander Eikelenboom <linux@eikelenboom.it>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Tested-by: Sander Eikelenboom <linux@eikelenboom.it>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/spinlock.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -8,6 +8,7 @@
 #include <linux/log2.h>
 #include <linux/gfp.h>
 #include <linux/slab.h>
+#include <linux/atomic.h>
 
 #include <asm/paravirt.h>
 
@@ -19,6 +20,7 @@
 
 static DEFINE_PER_CPU(int, lock_kicker_irq) = -1;
 static DEFINE_PER_CPU(char *, irq_name);
+static DEFINE_PER_CPU(atomic_t, xen_qlock_wait_nest);
 static bool xen_pvspin = true;
 
 #ifdef CONFIG_QUEUED_SPINLOCKS
@@ -41,25 +43,25 @@ static void xen_qlock_kick(int cpu)
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
 
 #else /* CONFIG_QUEUED_SPINLOCKS */


