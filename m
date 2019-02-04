Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D6AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AFF2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278110;
	bh=VHuAb/pVlV0Qy9UqLuwV9nBE8QbKvN1NvZMNiL+3Fgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gbpmnUW20w5tf7GkuiiSRT66J8yuJ4E7gS2kG0rM7BQ2ZrVjv3D/OL1nsZdA/je6D
	 NZlmDxxwdmIeEFKnl3BmawbbeIj57bLX/sgEspVmO5wHWYAPAcvdcxoz3jZ0jF0tX0
	 nVCrOCMFvw3Fxos5Bi6u9vAHbzGdT9/I2gu9AauI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731703AbfBDKru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbfBDKrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C342217D6;
        Mon,  4 Feb 2019 10:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277265;
        bh=VHuAb/pVlV0Qy9UqLuwV9nBE8QbKvN1NvZMNiL+3Fgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=We+zHMuQiXjHV/+erI80zngkTRugKoGz4bGvrPvFl9yHI8jqNmOmlPQ5v7EyUQGYN
         /05e/8ktLD49bB7PiH2955rNgTw2ivjMZWr4qf0GiKJCXDXPO/UFz/9wBxzPdFI8zh
         3RxEr9aOAWyl6ia+HHRYQouB9Wp8ccJTAD7+7bPI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 30/74] virtio_net: Dont process redirected XDP frames when XDP is disabled
Date:   Mon,  4 Feb 2019 11:36:43 +0100
Message-Id: <20190204103623.373274252@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit 03aa6d34868c07b2b1b8b2db080602d7ec528173 ]

Commit 8dcc5b0ab0ec ("virtio_net: fix ndo_xdp_xmit crash towards dev not
ready for XDP") tried to avoid access to unexpected sq while XDP is
disabled, but was not complete.

There was a small window which causes out of bounds sq access in
virtnet_xdp_xmit() while disabling XDP.

An example case of
 - curr_queue_pairs = 6 (2 for SKB and 4 for XDP)
 - online_cpu_num = xdp_queue_paris = 4
when XDP is enabled:

CPU 0                         CPU 1
(Disabling XDP)               (Processing redirected XDP frames)

                              virtnet_xdp_xmit()
virtnet_xdp_set()
 _virtnet_set_queues()
  set curr_queue_pairs (2)
                               check if rq->xdp_prog is not NULL
                               virtnet_xdp_sq(vi)
                                qp = curr_queue_pairs -
                                     xdp_queue_pairs +
                                     smp_processor_id()
                                   = 2 - 4 + 1 = -1
                                sq = &vi->sq[qp] // out of bounds access
  set xdp_queue_pairs (0)
  rq->xdp_prog = NULL

Basically we should not change curr_queue_pairs and xdp_queue_pairs
while someone can read the values. Thus, when disabling XDP, assign NULL
to rq->xdp_prog first, and wait for RCU grace period, then change
xxx_queue_pairs.
Note that we need to keep the current order when enabling XDP though.

- v2: Make rcu_assign_pointer/synchronize_net conditional instead of
      _virtnet_set_queues.

Fixes: 186b3c998c50 ("virtio-net: support XDP_REDIRECT")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2360,6 +2360,10 @@ static int virtnet_xdp_set(struct net_de
 		return -ENOMEM;
 	}
 
+	old_prog = rtnl_dereference(vi->rq[0].xdp_prog);
+	if (!prog && !old_prog)
+		return 0;
+
 	if (prog) {
 		prog = bpf_prog_add(prog, vi->max_queue_pairs - 1);
 		if (IS_ERR(prog))
@@ -2374,21 +2378,30 @@ static int virtnet_xdp_set(struct net_de
 		}
 	}
 
+	if (!prog) {
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			rcu_assign_pointer(vi->rq[i].xdp_prog, prog);
+			if (i == 0)
+				virtnet_restore_guest_offloads(vi);
+		}
+		synchronize_net();
+	}
+
 	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
 	if (err)
 		goto err;
 	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	vi->xdp_queue_pairs = xdp_qp;
 
-	for (i = 0; i < vi->max_queue_pairs; i++) {
-		old_prog = rtnl_dereference(vi->rq[i].xdp_prog);
-		rcu_assign_pointer(vi->rq[i].xdp_prog, prog);
-		if (i == 0) {
-			if (!old_prog)
+	if (prog) {
+		for (i = 0; i < vi->max_queue_pairs; i++) {
+			rcu_assign_pointer(vi->rq[i].xdp_prog, prog);
+			if (i == 0 && !old_prog)
 				virtnet_clear_guest_offloads(vi);
-			if (!prog)
-				virtnet_restore_guest_offloads(vi);
 		}
+	}
+
+	for (i = 0; i < vi->max_queue_pairs; i++) {
 		if (old_prog)
 			bpf_prog_put(old_prog);
 		if (netif_running(dev)) {
@@ -2401,6 +2414,12 @@ static int virtnet_xdp_set(struct net_de
 	return 0;
 
 err:
+	if (!prog) {
+		virtnet_clear_guest_offloads(vi);
+		for (i = 0; i < vi->max_queue_pairs; i++)
+			rcu_assign_pointer(vi->rq[i].xdp_prog, old_prog);
+	}
+
 	if (netif_running(dev)) {
 		for (i = 0; i < vi->max_queue_pairs; i++) {
 			virtnet_napi_enable(vi->rq[i].vq, &vi->rq[i].napi);


