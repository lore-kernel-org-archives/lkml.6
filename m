Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B9EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3517120700
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895801;
	bh=mzYsWjHoFpcG7eevJA3ldtl8mFO4u5KDbGzajJOEFFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tf6CfumTjv1w52FJ5aoxvqFWDKbEQk4G5XJXgfNLpyfzC5gseMbXpq1bBGcK0Ac86
	 XHV03q+yZuPFv08Njay9nHAmUD7FL97kKG/XmfVB7hjJitd6dP+73h5mkgKEYvgn4I
	 /GF0+eup3QFPh//B0tnNUMievu++wPNM9yhUoYHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730907AbfBKOgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:36:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:45710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731271AbfBKOge (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:36:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CCAF20818;
        Mon, 11 Feb 2019 14:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895793;
        bh=mzYsWjHoFpcG7eevJA3ldtl8mFO4u5KDbGzajJOEFFo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yW9YS1EsboDKF5gBZW3ofTNUcGNAIR3S+WfUSU/pyrLCLX2XrZ8KpYCZvFcpSQajS
         Kfk7tIV4d6zInKkBQDMZXemNfaH9UerTdpHurPubXL2pjWaIXfbs+ovFsdFlEI3Qnb
         JgNuoyNwj+a7tyHbIWrGwoPaAaVqOpajJXIHWiYQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 307/352] virtio_net: Account for tx bytes and packets on sending xdp_frames
Date:   Mon, 11 Feb 2019 15:18:54 +0100
Message-Id: <20190211141906.393061756@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit 546f28974d771b124fb0bf7b551b343888cf0419 ]

Previously virtnet_xdp_xmit() did not account for device tx counters,
which caused confusions.
To be consistent with SKBs, account them on freeing xdp_frames.

Reported-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -502,6 +502,8 @@ static int virtnet_xdp_xmit(struct net_d
 	struct bpf_prog *xdp_prog;
 	struct send_queue *sq;
 	unsigned int len;
+	int packets = 0;
+	int bytes = 0;
 	int drops = 0;
 	int kicks = 0;
 	int ret, err;
@@ -525,10 +527,18 @@ static int virtnet_xdp_xmit(struct net_d
 
 	/* Free up any pending old buffers before queueing new ones. */
 	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
-		if (likely(is_xdp_frame(ptr)))
-			xdp_return_frame(ptr_to_xdp(ptr));
-		else
-			napi_consume_skb(ptr, false);
+		if (likely(is_xdp_frame(ptr))) {
+			struct xdp_frame *frame = ptr_to_xdp(ptr);
+
+			bytes += frame->len;
+			xdp_return_frame(frame);
+		} else {
+			struct sk_buff *skb = ptr;
+
+			bytes += skb->len;
+			napi_consume_skb(skb, false);
+		}
+		packets++;
 	}
 
 	for (i = 0; i < n; i++) {
@@ -548,6 +558,8 @@ static int virtnet_xdp_xmit(struct net_d
 	}
 out:
 	u64_stats_update_begin(&sq->stats.syncp);
+	sq->stats.bytes += bytes;
+	sq->stats.packets += packets;
 	sq->stats.xdp_tx += n;
 	sq->stats.xdp_tx_drops += drops;
 	sq->stats.kicks += kicks;


