Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2511FC64EAD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6335206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 21:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6335206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbeI3E3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 00:29:10 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51661 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728080AbeI3ESY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 00:18:24 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N63-0000H0-5E; Sat, 29 Sep 2018 22:48:19 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1g6N5z-0006yl-Lx; Sat, 29 Sep 2018 22:48:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Finn Thain" <fthain@telegraphics.com.au>,
        "Stan Johnson" <userm57@yahoo.com>,
        "Michael Ellerman" <mpe@ellerman.id.au>
Date:   Sat, 29 Sep 2018 22:43:07 +0100
Message-ID: <lsq.1538257387.184916633@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 123/131] via-cuda: Use spinlock_irq_save/restore
 instead of enable/disable_irq
In-Reply-To: <lsq.1538257386.330095874@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.59-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit ac39452e942af6a212e8f89e8a36b71354323845 upstream.

The cuda_start() function uses spinlock_irq_save/restore for mutual
exclusion. Let's have cuda_poll() do the same when polling the VIA
interrupt.

The benefit to disabling local irqs when the interrupt is being polled
is that the interrupt handler now has the same timing properties
regardless of whether it is invoked normally or from cuda_poll().

This driver was written back when local irqs remained enabled during
execution of interrupt handlers and cuda_poll() was probably trying
to achieve the same effect by use of enable/disable_irq.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/macintosh/via-cuda.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -432,26 +432,20 @@ cuda_start(void)
 void
 cuda_poll(void)
 {
-    /* cuda_interrupt only takes a normal lock, we disable
-     * interrupts here to avoid re-entering and thus deadlocking.
-     */
-    if (cuda_irq)
-	disable_irq(cuda_irq);
-    cuda_interrupt(0, NULL);
-    if (cuda_irq)
-	enable_irq(cuda_irq);
+	cuda_interrupt(0, NULL);
 }
 
 static irqreturn_t
 cuda_interrupt(int irq, void *arg)
 {
+    unsigned long flags;
     int status;
     struct adb_request *req = NULL;
     unsigned char ibuf[16];
     int ibuf_len = 0;
     int complete = 0;
     
-    spin_lock(&cuda_lock);
+    spin_lock_irqsave(&cuda_lock, flags);
 
     /* On powermacs, this handler is registered for the VIA IRQ. But they use
      * just the shift register IRQ -- other VIA interrupt sources are disabled.
@@ -464,7 +458,7 @@ cuda_interrupt(int irq, void *arg)
 #endif
     {
         if ((in_8(&via[IFR]) & SR_INT) == 0) {
-            spin_unlock(&cuda_lock);
+            spin_unlock_irqrestore(&cuda_lock, flags);
             return IRQ_NONE;
         } else {
             out_8(&via[IFR], SR_INT);
@@ -593,7 +587,7 @@ cuda_interrupt(int irq, void *arg)
     default:
 	printk("cuda_interrupt: unknown cuda_state %d?\n", cuda_state);
     }
-    spin_unlock(&cuda_lock);
+    spin_unlock_irqrestore(&cuda_lock, flags);
     if (complete && req) {
     	void (*done)(struct adb_request *) = req->done;
     	mb();

