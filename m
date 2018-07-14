Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12624ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C909F20837
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 08:48:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C909F20837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeGNJGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 05:06:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726657AbeGNJGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 05:06:53 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 279BF5C629A0C;
        Sat, 14 Jul 2018 16:48:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.16.168) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.382.0; Sat, 14 Jul 2018
 16:48:18 +0800
From:   jiangyiwen <jiangyiwen@huawei.com>
Subject: [V9fs-developer] [PATCH] net/9p: Fix a deadlock case in the virtio
 transport
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Ron Minnich <rminnich@sandia.gov>,
        Latchesar Ionkov <lucho@ionkov.net>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <v9fs-developer@lists.sourceforge.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Message-ID: <5B49B8CF.40709@huawei.com>
Date:   Sat, 14 Jul 2018 16:48:15 +0800
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

When client has multiple threads that issue io requests all the
time, and the server has a very good performance, it may cause
cpu is running in the irq context for a long time because it can
check virtqueue has buf in the *while* loop.

So we should keep chan->lock in the whole loop.

Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
---
 net/9p/trans_virtio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 05006cb..9b0f5f2 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -148,20 +148,18 @@ static void req_done(struct virtqueue *vq)

 	p9_debug(P9_DEBUG_TRANS, ": request done\n");

+	spin_lock_irqsave(&chan->lock, flags);
 	while (1) {
-		spin_lock_irqsave(&chan->lock, flags);
 		req = virtqueue_get_buf(chan->vq, &len);
-		if (req == NULL) {
-			spin_unlock_irqrestore(&chan->lock, flags);
+		if (req == NULL)
 			break;
-		}
 		chan->ring_bufs_avail = 1;
-		spin_unlock_irqrestore(&chan->lock, flags);
 		/* Wakeup if anyone waiting for VirtIO ring space. */
 		wake_up(chan->vc_wq);
 		if (len)
 			p9_client_cb(chan->client, req, REQ_STATUS_RCVD);
 	}
+	spin_unlock_irqrestore(&chan->lock, flags);
 }

 /**
-- 
1.8.3.1

