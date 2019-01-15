Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94262C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A52B20659
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfAOBe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:34:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48060 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbfAOBe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:34:28 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AAEDC049580;
        Tue, 15 Jan 2019 01:34:28 +0000 (UTC)
Received: from redhat.com (ovpn-124-229.rdu2.redhat.com [10.10.124.229])
        by smtp.corp.redhat.com (Postfix) with SMTP id E68E419744;
        Tue, 15 Jan 2019 01:34:26 +0000 (UTC)
Date:   Mon, 14 Jan 2019 20:34:26 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH net-next] virtio_net: bulk free tx skbs
Message-ID: <20190115012847.14730-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 15 Jan 2019 01:34:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use napi_consume_skb() to get bulk free.  Note that napi_consume_skb is
safe to call in a non-napi context as long as the napi_budget flag is
correct.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

My perf testing setup is down but it works fine on my devel box and
should be fairly uncontroversial.

 drivers/net/virtio_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 023725086046..d76dcc68cbb6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -1343,7 +1343,7 @@ static void free_old_xmit_skbs(struct send_queue *sq)
 		bytes += skb->len;
 		packets++;
 
-		dev_consume_skb_any(skb);
+		napi_consume_skb(skb, use_napi);
 	}
 
 	/* Avoid overhead when no packets have been processed
-- 
MST
