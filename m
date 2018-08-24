Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BBAC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C082168B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 08:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C082168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbeHXM1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:27:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbeHXM1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:27:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AFB8804B9F4;
        Fri, 24 Aug 2018 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-158.pek2.redhat.com [10.72.12.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EAEB62026D6D;
        Fri, 24 Aug 2018 08:53:24 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterx@redhat.com
Subject: [PATCH net] vhost: correctly check the iova range when waking virtqueue
Date:   Fri, 24 Aug 2018 16:53:13 +0800
Message-Id: <20180824085313.21798-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 24 Aug 2018 08:53:32 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Fri, 24 Aug 2018 08:53:32 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jasowang@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't wakeup the virtqueue if the first byte of pending iova range
is the last byte of the range we just got updated. This will lead a
virtqueue to wait for IOTLB updating forever. Fixing by correct the
check and wake up the virtqueue in this case.

Fixes: 6b1e6cc7855b ("vhost: new device IOTLB API")
Reported-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
The patch is needed for -stable.
---
 drivers/vhost/vhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 96c1d8400822..b13c6b4b2c66 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -952,7 +952,7 @@ static void vhost_iotlb_notify_vq(struct vhost_dev *d,
 	list_for_each_entry_safe(node, n, &d->pending_list, node) {
 		struct vhost_iotlb_msg *vq_msg = &node->msg.iotlb;
 		if (msg->iova <= vq_msg->iova &&
-		    msg->iova + msg->size - 1 > vq_msg->iova &&
+		    msg->iova + msg->size - 1 >= vq_msg->iova &&
 		    vq_msg->type == VHOST_IOTLB_MISS) {
 			vhost_poll_queue(&node->vq->poll);
 			list_del(&node->node);
-- 
2.17.1

