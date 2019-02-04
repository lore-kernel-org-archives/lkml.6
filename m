Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5BEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7942070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276870;
	bh=bAKVwpBcFHOJEXI6Beq+qtmzrKLq70+vP8MzAObvxvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wiTsAGzFuQ6tCvo6OfR2pV+dn/ij/1aTILJCjuhPqAT5OAKNJPEIMnMVz55GOT8pG
	 vgh2DRwW5D0pwKHuRMYgkwbb9glKVPve60NC/yNbbWie8Wzj71HZLjAWzNBCT2bWUM
	 Z5g3HuQVQMnM+8VZYSoAZt6jOqN1uWTWnk3D9e0Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730209AbfBDKlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:41:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730198AbfBDKlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C02D92070C;
        Mon,  4 Feb 2019 10:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276866;
        bh=bAKVwpBcFHOJEXI6Beq+qtmzrKLq70+vP8MzAObvxvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DEo/EDApQ/JbA5XaEgYkQJupYVSMtUZS38Zmm2BzjAH1onRAtjb06amEIACJ0+/UL
         4/gIQ0LZb1ywJCJeGk+39a62e6Na9vV/9JlfdfpyOMjyqH1vYg9VKJeFV96WAiZlAt
         la576a1euBqtIXk+MSGlcn3i75sM7GgFjjmP9rf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kyungtae Kim <kt0755@gmail.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Andre Naujoks <nautsch2@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 4.4 22/65] can: bcm: check timer values before ktime conversion
Date:   Mon,  4 Feb 2019 11:36:15 +0100
Message-Id: <20190204103614.363463432@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Hartkopp <socketcan@hartkopp.net>

commit 93171ba6f1deffd82f381d36cb13177872d023f6 upstream.

Kyungtae Kim detected a potential integer overflow in bcm_[rx|tx]_setup()
when the conversion into ktime multiplies the given value with NSEC_PER_USEC
(1000).

Reference: https://marc.info/?l=linux-can&m=154732118819828&w=2

Add a check for the given tv_usec, so that the value stays below one second.
Additionally limit the tv_sec value to a reasonable value for CAN related
use-cases of 400 days and ensure all values to be positive.

Reported-by: Kyungtae Kim <kt0755@gmail.com>
Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-stable <stable@vger.kernel.org> # versions 2.6.26 to 4.7
Tested-by: Kyungtae Kim <kt0755@gmail.com>
Acked-by: Andre Naujoks <nautsch2@gmail.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/can/bcm.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

--- a/net/can/bcm.c
+++ b/net/can/bcm.c
@@ -67,6 +67,9 @@
  */
 #define MAX_NFRAMES 256
 
+/* limit timers to 400 days for sending/timeouts */
+#define BCM_TIMER_SEC_MAX (400 * 24 * 60 * 60)
+
 /* use of last_frames[index].can_dlc */
 #define RX_RECV    0x40 /* received data for this element */
 #define RX_THR     0x80 /* element not been sent due to throttle feature */
@@ -136,6 +139,22 @@ static inline ktime_t bcm_timeval_to_kti
 	return ktime_set(tv.tv_sec, tv.tv_usec * NSEC_PER_USEC);
 }
 
+/* check limitations for timeval provided by user */
+static bool bcm_is_invalid_tv(struct bcm_msg_head *msg_head)
+{
+	if ((msg_head->ival1.tv_sec < 0) ||
+	    (msg_head->ival1.tv_sec > BCM_TIMER_SEC_MAX) ||
+	    (msg_head->ival1.tv_usec < 0) ||
+	    (msg_head->ival1.tv_usec >= USEC_PER_SEC) ||
+	    (msg_head->ival2.tv_sec < 0) ||
+	    (msg_head->ival2.tv_sec > BCM_TIMER_SEC_MAX) ||
+	    (msg_head->ival2.tv_usec < 0) ||
+	    (msg_head->ival2.tv_usec >= USEC_PER_SEC))
+		return true;
+
+	return false;
+}
+
 #define CFSIZ sizeof(struct can_frame)
 #define OPSIZ sizeof(struct bcm_op)
 #define MHSIZ sizeof(struct bcm_msg_head)
@@ -855,6 +874,10 @@ static int bcm_tx_setup(struct bcm_msg_h
 	if (msg_head->nframes < 1 || msg_head->nframes > MAX_NFRAMES)
 		return -EINVAL;
 
+	/* check timeval limitations */
+	if ((msg_head->flags & SETTIMER) && bcm_is_invalid_tv(msg_head))
+		return -EINVAL;
+
 	/* check the given can_id */
 	op = bcm_find_op(&bo->tx_ops, msg_head->can_id, ifindex);
 
@@ -1020,6 +1043,10 @@ static int bcm_rx_setup(struct bcm_msg_h
 	     (!(msg_head->can_id & CAN_RTR_FLAG))))
 		return -EINVAL;
 
+	/* check timeval limitations */
+	if ((msg_head->flags & SETTIMER) && bcm_is_invalid_tv(msg_head))
+		return -EINVAL;
+
 	/* check the given can_id */
 	op = bcm_find_op(&bo->rx_ops, msg_head->can_id, ifindex);
 	if (op) {


