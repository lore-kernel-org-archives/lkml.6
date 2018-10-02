Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE579C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06732089C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C06732089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbeJBULX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:11:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbeJBULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:11:22 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E8214C47;
        Tue,  2 Oct 2018 13:27:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 037/228] vhost_net: Avoid tx vring kicks during busyloop
Date:   Tue,  2 Oct 2018 06:22:14 -0700
Message-Id: <20181002132501.616925827@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
References: <20181002132459.032960735@linuxfoundation.org>
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

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit 027b17603b030f1334ade079b7a3e986569c956b ]

Under heavy load vhost busypoll may run without suppressing
notification. For example tx zerocopy callback can push tx work while
handle_tx() is running, then busyloop exits due to vhost_has_work()
condition and enables notification but immediately reenters handle_tx()
because the pushed work was tx. In this case handle_tx() tries to
disable notification again, but when using event_idx it by design
cannot. Then busyloop will run without suppressing notification.
Another example is the case where handle_tx() tries to enable
notification but avail idx is advanced so disables it again. This case
also leads to the same situation with event_idx.

The problem is that once we enter this situation busyloop does not work
under heavy load for considerable amount of time, because notification
is likely to happen during busyloop and handle_tx() immediately enables
notification after notification happens. Specifically busyloop detects
notification by vhost_has_work() and then handle_tx() calls
vhost_enable_notify(). Because the detected work was the tx work, it
enters handle_tx(), and enters busyloop without suppression again.
This is likely to be repeated, so with event_idx we are almost not able
to suppress notification in this case.

To fix this, poll the work instead of enabling notification when
busypoll is interrupted by something. IMHO vhost_has_work() is kind of
interruption rather than a signal to completely cancel the busypoll, so
let's run busypoll after the necessary work is done.

Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/vhost/net.c |   35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -396,13 +396,10 @@ static inline unsigned long busy_clock(v
 	return local_clock() >> 10;
 }
 
-static bool vhost_can_busy_poll(struct vhost_dev *dev,
-				unsigned long endtime)
+static bool vhost_can_busy_poll(unsigned long endtime)
 {
-	return likely(!need_resched()) &&
-	       likely(!time_after(busy_clock(), endtime)) &&
-	       likely(!signal_pending(current)) &&
-	       !vhost_has_work(dev);
+	return likely(!need_resched() && !time_after(busy_clock(), endtime) &&
+		      !signal_pending(current));
 }
 
 static void vhost_net_disable_vq(struct vhost_net *n,
@@ -434,7 +431,8 @@ static int vhost_net_enable_vq(struct vh
 static int vhost_net_tx_get_vq_desc(struct vhost_net *net,
 				    struct vhost_virtqueue *vq,
 				    struct iovec iov[], unsigned int iov_size,
-				    unsigned int *out_num, unsigned int *in_num)
+				    unsigned int *out_num, unsigned int *in_num,
+				    bool *busyloop_intr)
 {
 	unsigned long uninitialized_var(endtime);
 	int r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
@@ -443,9 +441,15 @@ static int vhost_net_tx_get_vq_desc(stru
 	if (r == vq->num && vq->busyloop_timeout) {
 		preempt_disable();
 		endtime = busy_clock() + vq->busyloop_timeout;
-		while (vhost_can_busy_poll(vq->dev, endtime) &&
-		       vhost_vq_avail_empty(vq->dev, vq))
+		while (vhost_can_busy_poll(endtime)) {
+			if (vhost_has_work(vq->dev)) {
+				*busyloop_intr = true;
+				break;
+			}
+			if (!vhost_vq_avail_empty(vq->dev, vq))
+				break;
 			cpu_relax();
+		}
 		preempt_enable();
 		r = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 				      out_num, in_num, NULL, NULL);
@@ -501,20 +505,24 @@ static void handle_tx(struct vhost_net *
 	zcopy = nvq->ubufs;
 
 	for (;;) {
+		bool busyloop_intr;
+
 		/* Release DMAs done buffers first */
 		if (zcopy)
 			vhost_zerocopy_signal_used(net, vq);
 
-
+		busyloop_intr = false;
 		head = vhost_net_tx_get_vq_desc(net, vq, vq->iov,
 						ARRAY_SIZE(vq->iov),
-						&out, &in);
+						&out, &in, &busyloop_intr);
 		/* On error, stop handling until the next kick. */
 		if (unlikely(head < 0))
 			break;
 		/* Nothing new?  Wait for eventfd to tell us they refilled. */
 		if (head == vq->num) {
-			if (unlikely(vhost_enable_notify(&net->dev, vq))) {
+			if (unlikely(busyloop_intr)) {
+				vhost_poll_queue(&vq->poll);
+			} else if (unlikely(vhost_enable_notify(&net->dev, vq))) {
 				vhost_disable_notify(&net->dev, vq);
 				continue;
 			}
@@ -663,7 +671,8 @@ static int vhost_net_rx_peek_head_len(st
 		preempt_disable();
 		endtime = busy_clock() + vq->busyloop_timeout;
 
-		while (vhost_can_busy_poll(&net->dev, endtime) &&
+		while (vhost_can_busy_poll(endtime) &&
+		       !vhost_has_work(&net->dev) &&
 		       !sk_has_rx_data(sk) &&
 		       vhost_vq_avail_empty(&net->dev, vq))
 			cpu_relax();


