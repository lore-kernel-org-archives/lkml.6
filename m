Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F0C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B69E2176F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277080;
	bh=FegBfmSuUWa5hJFftPkBj0mQTOIHo7HNVlD3rJnTSJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JbBTu+TIK0WbOLQaFrnkmVlGsu4TwB9SieK1faN2dygvM9GG2euZl0Ipoe9ZHaDxi
	 W6uTyIwKu9lcw6PwMxdR9Ijm2IEf4xz4wH54v08IpLbZVundl+wrIpPQKaEuUI0jK3
	 f46DXINup47BTBUbUMV2GQyTQn143qk64MHzGhoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731051AbfBDKoj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:44:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:42454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731037AbfBDKoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:44:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E81792070C;
        Mon,  4 Feb 2019 10:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277076;
        bh=FegBfmSuUWa5hJFftPkBj0mQTOIHo7HNVlD3rJnTSJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BWb10m08D+6av/dLTNWkBjA1LDPoUpQUCSkT9CtbvGfdRswpxwqlB8Y9b/KTgd3oX
         lzZuxNzSaF9El33iFdJrm/RcR0HPZkzpoScWaY5qQ4C5EvwI3qHW8Hwj6Ew9SNUJ84
         uke6vSmFMuNiujQ35Z5poir0QU21fxL57JZr8634=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 14/46] virtio_net: Fix not restoring real_num_rx_queues
Date:   Mon,  4 Feb 2019 11:36:45 +0100
Message-Id: <20190204103611.151448514@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
References: <20190204103608.651205056@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

[ Upstream commit 188313c137c4f76afd0862f50dbc185b198b9e2a ]

When _virtnet_set_queues() failed we did not restore real_num_rx_queues.
Fix this by placing the change of real_num_rx_queues after
_virtnet_set_queues().
This order is also in line with virtnet_set_channels().

Fixes: 4941d472bf95 ("virtio-net: do not reset during XDP set")
Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Acked-by: Jason Wang <jasowang@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/virtio_net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2031,10 +2031,10 @@ static int virtnet_xdp_set(struct net_de
 		}
 	}
 
-	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
 	if (err)
 		goto err;
+	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	vi->xdp_queue_pairs = xdp_qp;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {


