Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B17C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C65220671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 07:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C65220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbeGSH6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 03:58:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52184 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727288AbeGSH6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 03:58:48 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CCD8453BAE834;
        Thu, 19 Jul 2018 15:17:03 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.382.0; Thu, 19 Jul 2018
 15:17:01 +0800
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>,
        Dominique Martinet <asmadeus@codewreck.org>
From:   jiangyiwen <jiangyiwen@huawei.com>
Subject: [V9fs-developer] [PATCH v3] Fix a hard lockup case in the virtio
 transport
Message-ID: <5B503AEC.5080404@huawei.com>
Date:   Thu, 19 Jul 2018 15:17:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.16.168]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When client has multiple threads that issue io requests
all the time, and the server has a very good performance,
it may cause cpu is running in the irq context for a long
time because it can check virtqueue has buf in the *while*
loop.

So we should keep chan->lock in the whole loop.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 net/9p/trans_virtio.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 05006cb..3589864 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -144,24 +144,25 @@ static void req_done(struct virtqueue *vq)
 	struct virtio_chan *chan = vq->vdev->priv;
 	unsigned int len;
 	struct p9_req_t *req;
+	bool need_wakeup = false;
 	unsigned long flags;

 	p9_debug(P9_DEBUG_TRANS, ": request done\n");

-	while (1) {
-		spin_lock_irqsave(&chan->lock, flags);
-		req = virtqueue_get_buf(chan->vq, &len);
-		if (req == NULL) {
-			spin_unlock_irqrestore(&chan->lock, flags);
-			break;
+	spin_lock_irqsave(&chan->lock, flags);
+	while ((req = virtqueue_get_buf(chan->vq, &len)) != NULL) {
+		if (!chan->ring_bufs_avail) {
+			chan->ring_bufs_avail = 1;
+			need_wakeup = true;
 		}
-		chan->ring_bufs_avail = 1;
-		spin_unlock_irqrestore(&chan->lock, flags);
-		/* Wakeup if anyone waiting for VirtIO ring space. */
-		wake_up(chan->vc_wq);
+
 		if (len)
 			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
 	}
+	spin_unlock_irqrestore(&chan->lock, flags);
+	/* Wakeup if anyone waiting for VirtIO ring space. */
+	if (need_wakeup)
+		wake_up(chan->vc_wq);
 }

 /**
-- 
1.8.3.1

