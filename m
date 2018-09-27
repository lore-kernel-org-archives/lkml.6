Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCBFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B63421580
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:43:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B63421580
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbeI0PAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:00:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbeI0PAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:00:31 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D77DA308403E;
        Thu, 27 Sep 2018 08:43:24 +0000 (UTC)
Received: from jason-ThinkPad-T450s.redhat.com (ovpn-12-198.pek2.redhat.com [10.72.12.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB39D308BDB9;
        Thu, 27 Sep 2018 08:43:13 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     stefanha@redhat.com, mst@redhat.com
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH net] vhost-vsock: fix use after free
Date:   Thu, 27 Sep 2018 16:43:01 +0800
Message-Id: <20180927084301.573-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 27 Sep 2018 08:43:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The access of vsock is not protected by vhost_vsock_lock. This may
lead use after free since vhost_vsock_dev_release() may free the
pointer at the same time.

Fix this by holding the lock during the acess.

Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
Fixes: 16320f363ae1 ("vhost-vsock: add pkt cancel capability")
Fixes: 433fc58e6bf2 ("VSOCK: Introduce vhost_vsock.ko")
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
- The patch is needed for -stable.
---
 drivers/vhost/vsock.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 34bc3ab40c6d..7d0b292867fd 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -210,21 +210,27 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
 	struct vhost_vsock *vsock;
 	int len = pkt->len;
 
+	spin_lock_bh(&vhost_vsock_lock);
+
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid));
+	vsock = __vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid));
 	if (!vsock) {
 		virtio_transport_free_pkt(pkt);
+		spin_unlock_bh(&vhost_vsock_lock);
 		return -ENODEV;
 	}
 
 	if (pkt->reply)
 		atomic_inc(&vsock->queued_replies);
 
-	spin_lock_bh(&vsock->send_pkt_list_lock);
+	spin_lock(&vsock->send_pkt_list_lock);
 	list_add_tail(&pkt->list, &vsock->send_pkt_list);
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
+	spin_unlock(&vsock->send_pkt_list_lock);
 
 	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
+
+	spin_unlock_bh(&vhost_vsock_lock);
+
 	return len;
 }
 
@@ -236,18 +242,22 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	int cnt = 0;
 	LIST_HEAD(freeme);
 
+	spin_lock_bh(&vhost_vsock_lock);
+
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
-	if (!vsock)
+	vsock = __vhost_vsock_get(vsk->remote_addr.svm_cid);
+	if (!vsock) {
+		spin_unlock_bh(&vhost_vsock_lock);
 		return -ENODEV;
+	}
 
-	spin_lock_bh(&vsock->send_pkt_list_lock);
+	spin_lock(&vsock->send_pkt_list_lock);
 	list_for_each_entry_safe(pkt, n, &vsock->send_pkt_list, list) {
 		if (pkt->vsk != vsk)
 			continue;
 		list_move(&pkt->list, &freeme);
 	}
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
+	spin_unlock(&vsock->send_pkt_list_lock);
 
 	list_for_each_entry_safe(pkt, n, &freeme, list) {
 		if (pkt->reply)
@@ -265,6 +275,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 			vhost_poll_queue(&tx_vq->poll);
 	}
 
+	spin_unlock_bh(&vhost_vsock_lock);
+
 	return 0;
 }
 
-- 
2.17.1

