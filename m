Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE0DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9C120866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:19:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F9C120866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbeILFUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:20:52 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:51530 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeILFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:20:30 -0400
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
        id 3C3672A7D2; Tue, 11 Sep 2018 20:18:44 -0400 (EDT)
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     <linuxppc-dev@lists.ozlabs.org>, <linux-m68k@lists.linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Message-Id: <40e706689c8fb6e2adfed4a4d2794f5f8ff384d1.1536709753.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1536709753.git.fthain@telegraphics.com.au>
References: <cover.1536709753.git.fthain@telegraphics.com.au>
From:   Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4/7] macintosh/via-macii: Remove BUG_ON assertions
Date:   Tue, 11 Sep 2018 20:18:44 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BUG_ON assertions I added to the via-macii driver over a decade ago
haven't fired AFAIK. Some can never fire (by inspection). One assertion
checks for a NULL pointer, but that would merely substitute a BUG crash
for an Oops crash. Remove the pointless BUG_ON assertions and replace
the others with a WARN_ON and an array bounds check.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-macii.c | 49 +++++++------------------------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/macintosh/via-macii.c b/drivers/macintosh/via-macii.c
index 36a4f49e79b5..7e0e32fa7eb2 100644
--- a/drivers/macintosh/via-macii.c
+++ b/drivers/macintosh/via-macii.c
@@ -120,23 +120,6 @@ static int srq_asserted;     /* have to poll for the device that asserted it */
 static int command_byte;         /* the most recent command byte transmitted */
 static int autopoll_devs;      /* bits set are device addresses to be polled */
 
-/* Sanity check for request queue. Doesn't check for cycles. */
-static int request_is_queued(struct adb_request *req) {
-	struct adb_request *cur;
-	unsigned long flags;
-	local_irq_save(flags);
-	cur = current_req;
-	while (cur) {
-		if (cur == req) {
-			local_irq_restore(flags);
-			return 1;
-		}
-		cur = cur->next;
-	}
-	local_irq_restore(flags);
-	return 0;
-}
-
 /* Check for MacII style ADB */
 static int macii_probe(void)
 {
@@ -213,8 +196,6 @@ static void macii_queue_poll(void)
 	else
 		next_device = ffs(autopoll_devs) - 1;
 
-	BUG_ON(request_is_queued(&req));
-
 	adb_request(&req, NULL, ADBREQ_NOSEND, 1,
 	            ADB_READREG(next_device, 0));
 
@@ -237,18 +218,13 @@ static int macii_send_request(struct adb_request *req, int sync)
 	int err;
 	unsigned long flags;
 
-	BUG_ON(request_is_queued(req));
-
 	local_irq_save(flags);
 	err = macii_write(req);
 	local_irq_restore(flags);
 
-	if (!err && sync) {
-		while (!req->complete) {
+	if (!err && sync)
+		while (!req->complete)
 			macii_poll();
-		}
-		BUG_ON(request_is_queued(req));
-	}
 
 	return err;
 }
@@ -327,9 +303,6 @@ static int macii_reset_bus(void)
 {
 	static struct adb_request req;
 	
-	if (request_is_queued(&req))
-		return 0;
-
 	/* Command = 0, Address = ignored */
 	adb_request(&req, NULL, ADBREQ_NOSEND, 1, ADB_BUSRESET);
 	macii_send_request(&req, 1);
@@ -347,10 +320,6 @@ static void macii_start(void)
 
 	req = current_req;
 
-	BUG_ON(req == NULL);
-
-	BUG_ON(macii_state != idle);
-
 	/* Now send it. Be careful though, that first byte of the request
 	 * is actually ADB_PACKET; the real data begins at index 1!
 	 * And req->nbytes is the number of bytes of real data plus one.
@@ -388,7 +357,6 @@ static void macii_start(void)
 static irqreturn_t macii_interrupt(int irq, void *arg)
 {
 	int x;
-	static int entered;
 	struct adb_request *req;
 
 	if (!arg) {
@@ -399,8 +367,6 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 			return IRQ_NONE;
 	}
 
-	BUG_ON(entered++);
-
 	last_status = status;
 	status = via[B] & (ST_MASK|CTLR_IRQ);
 
@@ -409,7 +375,7 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 			if (reading_reply) {
 				reply_ptr = current_req->reply;
 			} else {
-				BUG_ON(current_req != NULL);
+				WARN_ON(current_req);
 				reply_ptr = reply_buf;
 			}
 
@@ -474,8 +440,8 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 
 		case reading:
 			x = via[SR];
-			BUG_ON((status & ST_MASK) == ST_CMD ||
-			       (status & ST_MASK) == ST_IDLE);
+			WARN_ON((status & ST_MASK) == ST_CMD ||
+				(status & ST_MASK) == ST_IDLE);
 
 			/* Bus timeout with SRQ sequence:
 			 *     data is "XX FF"      while CTLR_IRQ is "L L"
@@ -502,8 +468,8 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 				}
 			}
 
-			if (macii_state == reading) {
-				BUG_ON(reply_len > 15);
+			if (macii_state == reading &&
+			    reply_len < ARRAY_SIZE(reply_buf)) {
 				reply_ptr++;
 				*reply_ptr = x;
 				reply_len++;
@@ -546,6 +512,5 @@ static irqreturn_t macii_interrupt(int irq, void *arg)
 		break;
 	}
 
-	entered--;
 	return IRQ_HANDLED;
 }
-- 
2.16.4

