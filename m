Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4F7C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57EF217D6
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277582;
	bh=vobCtB7hBtCmakXmttt9ucNjfKg33E3kxnlyF7KnhGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YLICghDRPc2uT5VbLGQsQ0g6HrpmF79FHDUtUU4dOev5hW7xvJ2myjqrKtt+44p8T
	 8NkC4SyFF15RNp5qe2AbwO8R1mzKRSUUf4y7JYFQKum28rQRgBWNiJBYEiU81aQzBK
	 9XU6T0sKjPLW0PceIMDzG+MK+DZd4fIg0T/BovpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbfBDKxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:53:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:50534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732029AbfBDKw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:52:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12CDD217D6;
        Mon,  4 Feb 2019 10:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277576;
        bh=vobCtB7hBtCmakXmttt9ucNjfKg33E3kxnlyF7KnhGA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VPOib87m1QxnCqtp0NDegCbbf0nnr3D1IU1R6NjWtLaz2771PZIDhVW8ZBcZ87WTS
         uewMehsR1/ixPUADBOYVAk2wLygk/gAWSEEkf4mD8xH97noUIVaEjwXEGXsFCmlYyk
         Z+RYJB+MQgiDlff2EaeaNsmwSoJ9AenJDf3RAt7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 29/80] virtio_net: Fix not restoring real_num_rx_queues
Date:   Mon,  4 Feb 2019 11:36:49 +0100
Message-Id: <20190204103623.957256913@linuxfoundation.org>
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
@@ -2426,10 +2426,10 @@ static int virtnet_xdp_set(struct net_de
 		}
 	}
 
-	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
 	if (err)
 		goto err;
+	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
 	vi->xdp_queue_pairs = xdp_qp;
 
 	for (i = 0; i < vi->max_queue_pairs; i++) {


