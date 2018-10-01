Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D361C64EAD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5CC2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 07:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E5CC2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeJANxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 09:53:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:56342 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728685AbeJANxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 09:53:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AC52CAD5A;
        Mon,  1 Oct 2018 07:16:53 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org
Cc:     boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, Juergen Gross <jgross@suse.com>,
        stable@vger.kernel.org, Waiman.Long@hp.com, peterz@infradead.org
Subject: [PATCH 1/2] xen: fix race in xen_qlock_wait()
Date:   Mon,  1 Oct 2018 09:16:40 +0200
Message-Id: <20181001071641.19282-2-jgross@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181001071641.19282-1-jgross@suse.com>
References: <20181001071641.19282-1-jgross@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following situation a vcpu waiting for a lock might not be
woken up from xen_poll_irq():

CPU 1:                CPU 2:                      CPU 3:
takes a spinlock
                      tries to get lock
                      -> xen_qlock_wait()
                        -> xen_clear_irq_pending()
frees the lock
-> xen_qlock_kick(cpu2)

takes lock again
                                                  tries to get lock
                                                  -> *lock = _Q_SLOW_VAL
                        -> *lock == _Q_SLOW_VAL ?
                        -> xen_poll_irq()
frees the lock
-> xen_qlock_kick(cpu3)

And cpu 2 will sleep forever.

This can be avoided easily by modifying xen_qlock_wait() to call
xen_poll_irq() only if the related irq was not pending and to call
xen_clear_irq_pending() only if it was pending.

Cc: stable@vger.kernel.org
Cc: Waiman.Long@hp.com
Cc: peterz@infradead.org
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/spinlock.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/x86/xen/spinlock.c b/arch/x86/xen/spinlock.c
index 973f10e05211..cd210a4ba7b1 100644
--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -45,17 +45,12 @@ static void xen_qlock_wait(u8 *byte, u8 val)
 	if (irq == -1)
 		return;
 
-	/* clear pending */
-	xen_clear_irq_pending(irq);
-	barrier();
+	/* If irq pending already clear it and return. */
+	if (xen_test_irq_pending(irq)) {
+		xen_clear_irq_pending(irq);
+		return;
+	}
 
-	/*
-	 * We check the byte value after clearing pending IRQ to make sure
-	 * that we won't miss a wakeup event because of the clearing.
-	 *
-	 * The sync_clear_bit() call in xen_clear_irq_pending() is atomic.
-	 * So it is effectively a memory barrier for x86.
-	 */
 	if (READ_ONCE(*byte) != val)
 		return;
 
-- 
2.16.4

