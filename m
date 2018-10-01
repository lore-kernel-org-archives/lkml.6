Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AEBC64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45D572089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:17:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D572089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbeJANxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:53:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:56370 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728785AbeJANxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:53:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C0DB2AE15;
        Mon,  1 Oct 2018 07:16:53 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org, Waiman.Long@hp.com, peterz@infradead.org
Subject: [PATCH 2/2] xen: make xen_qlock_wait() nestable
Date:   Mon,  1 Oct 2018 09:16:41 +0200
Message-Id: <20181001071641.19282-3-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181001071641.19282-1-jgross@suse.com>
References: <20181001071641.19282-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_qlock_wait() isn't safe for nested calls due to interrupts. A call
of xen_qlock_kick() might be ignored in case a deeper nesting level
was active right before the call of xen_poll_irq():

CPU 1:                                   CPU 2:
spin_lock(lock1)
                                         spin_lock(lock1)
                                         -> xen_qlock_wait()
                                            -> xen_clear_irq_pending()
                                            Interrupt happens
spin_unlock(lock1)
-> xen_qlock_kick(CPU 2)
spin_lock_irqsave(lock2)
                                         spin_lock_irqsave(lock2)
                                         -> xen_qlock_wait()
                                            -> xen_clear_irq_pending()
                                               clears kick for lock1
                                            -> xen_poll_irq()
spin_unlock_irq_restore(lock2)
-> xen_qlock_kick(CPU 2)
                                            wakes up
                                         spin_unlock_irq_restore(lock2)
                                         IRET
                                           resumes in xen_qlock_wait()
                                           -> xen_poll_irq()
                                           never wakes up

The solution is to disable interrupts in xen_qlock_wait() and not to
poll for the irq in case xen_qlock_wait() is called in nmi context.

Cc: stable@vger.kernel.org
Cc: Waiman.Long@hp.com
Cc: peterz@infradead.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/spinlock.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index cd210a4ba7b1..e8d880e98057 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -39,29 +39,25 @@ static void xen_qlock_kick(int cpu)
  */
 static void xen_qlock_wait(u8 *byte, u8 val)
 {
+	unsigned long flags;
 	int irq = __this_cpu_read(lock_kicker_irq);
 
 	/* If kicker interrupts not initialized yet, just spin */
-	if (irq == -1)
+	if (irq == -1 || in_nmi())
 		return;
 
-	/* If irq pending already clear it and return. */
+	/* Guard against reentry. */
+	local_irq_save(flags);
+
+	/* If irq pending already clear it. */
 	if (xen_test_irq_pending(irq)) {
 		xen_clear_irq_pending(irq);
-		return;
+	} else if (READ_ONCE(*byte) == val) {
+		/* Block until irq becomes pending (or a spurious wakeup) */
+		xen_poll_irq(irq);
 	}
 
-	if (READ_ONCE(*byte) != val)
-		return;
-
-	/*
-	 * If an interrupt happens here, it will leave the wakeup irq
-	 * pending, which will cause xen_poll_irq() to return
-	 * immediately.
-	 */
-
-	/* Block until irq becomes pending (or perhaps a spurious wakeup) */
-	xen_poll_irq(irq);
+	local_irq_restore(flags);
 }
 
 static irqreturn_t dummy_handler(int irq, void *dev_id)
-- 
2.16.4

