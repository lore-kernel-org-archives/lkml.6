Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893C4C282CB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD6920823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 11:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549278118;
	bh=ie8Gc3vR7wVwahHINCneZBQf31kCq+0K6DFFzwEq7qU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P26xrH43tlR1QljCAGHSnnhUFwKT1//ufbaljXCAchIKK/gF9RlVfVnbo7l2xnDtB
	 IhHnomiJsMkVTcXAuTa+vPC9OOhMX1V9uZzBU4JHfy1J5du+gZWrlrNjUht7FDljm2
	 XVJcNW5CEjqOjsoApqLNnAL61KcUY6lUgBUG7kfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731726AbfBDLB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 06:01:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:45886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731679AbfBDKrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:47:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7938B217FA;
        Mon,  4 Feb 2019 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277263;
        bh=ie8Gc3vR7wVwahHINCneZBQf31kCq+0K6DFFzwEq7qU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pru1gHJyonGSt12ST7ZcccN5VNQrRkSzevdgvabTKg5xsGKSNeyJkcu4OEVXUGuBl
         IdPK4ko4RuOmtZma9bx9jrLPD53oRxYiOt+NGN6EOfWwdYxYLKUc8N5FXQMBVyACiR
         On8nFyrOh6Lifw2wAe1Wul6ePW7Pywb7dLOBmAJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 29/74] virtio_net: Fix out of bounds access of sq
Date:   Mon,  4 Feb 2019 11:36:42 +0100
Message-Id: <20190204103623.299485199@linuxfoundation.org>
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

[ Upstream commit 1667c08a9d31c7cdf09f4890816bfbf20b685495 ]

When XDP is disabled, curr_queue_pairs + smp_processor_id() can be
larger than max_queue_pairs.
There is no guarantee that we have enough XDP send queues dedicated for
each cpu when XDP is disabled, so do not count drops on sq in that case.

Fixes: 5b8f3c8d30a6 ("virtio_net: Add XDP related stats")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |   17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -490,20 +490,17 @@ static int virtnet_xdp_xmit(struct net_d
 	int ret, err;
 	int i;
 
-	sq = virtnet_xdp_sq(vi);
-
-	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK)) {
-		ret = -EINVAL;
-		drops = n;
-		goto out;
-	}
-
 	/* Only allow ndo_xdp_xmit if XDP is loaded on dev, as this
 	 * indicate XDP resources have been successfully allocated.
 	 */
 	xdp_prog = rcu_dereference(rq->xdp_prog);
-	if (!xdp_prog) {
-		ret = -ENXIO;
+	if (!xdp_prog)
+		return -ENXIO;
+
+	sq = virtnet_xdp_sq(vi);
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK)) {
+		ret = -EINVAL;
 		drops = n;
 		goto out;
 	}


