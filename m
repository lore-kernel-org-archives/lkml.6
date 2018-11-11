Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698B1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 338C82084C
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUQcH5b2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 338C82084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389268AbeKLJQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:16:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388968AbeKLIUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:41 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 800BE21508;
        Sun, 11 Nov 2018 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975445;
        bh=X6XbVsbKKZBAvFNXBHuMhobf9mM4rPskeWrOcbv/iyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZUQcH5b2FQM/Uu1EwOTuw3sVZ/2skX+s+w15xgThsj190irT3DGOn3is9yAnQ1wuZ
         BmW64psyQS5eNnHi4//Av3bsH8Bdf+6jlfxB5/69MCMYeuQes7v5jslnK3fcAuev+c
         bj3+Wd3e26DupJKjEpsbaD+cQLKmQ7g2oSYZOO94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman.Long@hp.com, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 4.18 199/350] xen: fix race in xen_qlock_wait()
Date:   Sun, 11 Nov 2018 14:21:03 -0800
Message-Id: <20181111221716.359712031@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Juergen Gross <jgross@suse.com>

commit 2ac2a7d4d9ff4e01e36f9c3d116582f6f655ab47 upstream.

In the following situation a vcpu waiting for a lock might not be
woken up from xen_poll_irq():

CPU 1:                CPU 2:                      CPU 3:
takes a spinlock
                      tries to get lock
                      -> xen_qlock_wait()
frees the lock
-> xen_qlock_kick(cpu2)
                        -> xen_clear_irq_pending()

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
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/xen/spinlock.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

--- a/arch/x86/xen/spinlock.c
+++ b/arch/x86/xen/spinlock.c
@@ -45,17 +45,12 @@ static void xen_qlock_wait(u8 *byte, u8
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
 


