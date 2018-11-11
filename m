Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC58C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84F120866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXb0gJGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C84F120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbeKLJmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:42:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:37518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732819AbeKLIS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:18:29 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0112D22353;
        Sun, 11 Nov 2018 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975314;
        bh=olR7zK+EoOQ0zjNDrS72SGG4gJ/leF+c9/EZG2CGxEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GXb0gJGcN95Lq1SS0PYj+wzt8OPIzdFTD760nqgI60s75HG4OaojdvSPs7wsS7M3h
         jWSulBBsN7BcmD436KCCuGJWEh/37U6WJ3D5fkNIlAAnh3Hme8BERx66AHzrdGJrVc
         SAtbYiXtlnmmbYgkvVUAvKdg8mesSXcgm8NJpyTQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sander Eikelenboom <linux@eikelenboom.it>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: [PATCH 4.19 299/361] xen: fix xen_qlock_wait()
Date:   Sun, 11 Nov 2018 14:20:46 -0800
Message-Id: <20181111221657.349117875@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221619.915519183@linuxfoundation.org>
References: <20181111221619.915519183@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

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


