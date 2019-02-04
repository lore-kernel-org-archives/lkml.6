Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C6CBC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E48A217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277523;
	bh=CQYr1njkifXLZICY0smbHn+/h2UBDfVc1R4QvrR2CQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uCqW68YTtEwwtUtfvBrtWtaIAk7WxaD8nLYQJsmSoQwsUvMS3+dcdwDjbOs/mViWl
	 Ek5QCO6tj/OHcwWMVT3XdtcTH6lq3XckzHYzq5JcPJXtD8zbMEQRNdSMANYHZX3Anp
	 lomld7MHOmIvxRxJT6/CG/ui0UG+d+5SMxUgrx+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732100AbfBDKwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:52:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732504AbfBDKv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:51:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE3902070C;
        Mon,  4 Feb 2019 10:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277516;
        bh=CQYr1njkifXLZICY0smbHn+/h2UBDfVc1R4QvrR2CQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m6U/l5DddWFg5vXJ2YBVwKAQX6fa0M1W+6j9F2R0cSwguhgj3e+T+3LtrLFrCjsk3
         WagGRkLGDQJHHb+9hREY40izRXTz6IkCeNY1mxjcW35Q1OAGZGJUqsTPS/Crv04AnD
         ucnwG++OYwA7nxFbMtIBmShmQpuEVY8ayLIYyPVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 30/80] virtio_net: Fix out of bounds access of sq
Date:   Mon,  4 Feb 2019 11:36:50 +0100
Message-Id: <20190204103624.131129441@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103620.287366543@linuxfoundation.org>
References: <20190204103620.287366543@linuxfoundation.org>
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


