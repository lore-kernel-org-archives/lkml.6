Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B48C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6C86214C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l24bqA+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6C86214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404665AbeKTDWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:22:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403956AbeKTDWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:22:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8157206BA;
        Mon, 19 Nov 2018 16:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646672;
        bh=FaB3ja4W6D0/7o1+84j67F1IBOFaz3Q1G8zQ5cuOPsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l24bqA+/Ci3DHvVfMoW2EmR9kpjd4Nn1Un8ska5JJan5GXtl9q7+YONU7vvqVjYg8
         pwSb0MJHUhJ07JT7GnW3AJip9/QAVoYWyTsNGhksf1oD//BN3QAjAm4obulyTEbZ6k
         L5Xgfd+/f1toAT3U2rBTurj8uKL2/p1lIjwEzStk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Waiman.Long@hp.com, peterz@infradead.org,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>
Subject: [PATCH 4.4 046/160] xen: fix race in xen_qlock_wait()
Date:   Mon, 19 Nov 2018 17:28:05 +0100
Message-Id: <20181119162635.968352681@linuxfoundation.org>
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
@@ -47,17 +47,12 @@ static void xen_qlock_wait(u8 *byte, u8
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
 


