Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A57620818
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b47PO4R1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A57620818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390991AbeKLItU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:49:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:53628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390750AbeKLIWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:38 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CC2D22353;
        Sun, 11 Nov 2018 22:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975560;
        bh=VtV1hfBzQfYRFrVNG7Ujo0YlOf9nbAMpxolRUBwy/oM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b47PO4R17oTmNZo6niFCLisChySZUsfACZ6JGYFnq2JOQCsBmsHKhDWv+dy/sxLNC
         ydWglioSk6uGiFmVuHxwh+13FOUmxufm/DxDe3kzlR74JBee2m7TjcmC1MkvjI1RUA
         51TE0X1C1YzR48Wq5zrZppK7mibr8vkrxQILOCRY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman.Long@hp.com, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 4.14 121/222] xen: make xen_qlock_wait() nestable
Date:   Sun, 11 Nov 2018 14:23:38 -0800
Message-Id: <20181111221658.549686523@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
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

commit a856531951dc8094359dfdac21d59cee5969c18e upstream.

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
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/spinlock.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -40,29 +40,25 @@ static void xen_qlock_kick(int cpu)
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


