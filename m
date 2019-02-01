Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD884C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B3A218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 11:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbfBALmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 06:42:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56732 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfBALmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 06:42:19 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9EECBDF87A;
        Fri,  1 Feb 2019 11:42:18 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-116.ams2.redhat.com [10.36.117.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3CC21001F3C;
        Fri,  1 Feb 2019 11:42:16 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] vsock/virtio: fix kernel panic after device hot-unplug
Date:   Fri,  1 Feb 2019 12:42:06 +0100
Message-Id: <20190201114207.97217-2-sgarzare@redhat.com>
In-Reply-To: <20190201114207.97217-1-sgarzare@redhat.com>
References: <20190201114207.97217-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 01 Feb 2019 11:42:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_vsock_remove() invokes the vsock_core_exit() also if there
are opened sockets for the AF_VSOCK protocol family. In this way
the vsock "transport" pointer is set to NULL, triggering the
kernel panic at the first socket activity.

This patch move the vsock_core_init()/vsock_core_exit() in the
virtio_vsock respectively in module_init and module_exit functions,
that cannot be invoked until there are open sockets.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1609699
Reported-by: Yan Fu <yafu@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 net/vmw_vsock/virtio_transport.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 5d3cce9e8744..9dae54698737 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -75,6 +75,9 @@ static u32 virtio_transport_get_local_cid(void)
 {
 	struct virtio_vsock *vsock = virtio_vsock_get();
 
+	if (!vsock)
+		return VMADDR_CID_ANY;
+
 	return vsock->guest_cid;
 }
 
@@ -584,10 +587,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 
 	virtio_vsock_update_guest_cid(vsock);
 
-	ret = vsock_core_init(&virtio_transport.transport);
-	if (ret < 0)
-		goto out_vqs;
-
 	vsock->rx_buf_nr = 0;
 	vsock->rx_buf_max_nr = 0;
 	atomic_set(&vsock->queued_replies, 0);
@@ -618,8 +617,6 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	mutex_unlock(&the_virtio_vsock_mutex);
 	return 0;
 
-out_vqs:
-	vsock->vdev->config->del_vqs(vsock->vdev);
 out:
 	kfree(vsock);
 	mutex_unlock(&the_virtio_vsock_mutex);
@@ -669,7 +666,6 @@ static void virtio_vsock_remove(struct virtio_device *vdev)
 
 	mutex_lock(&the_virtio_vsock_mutex);
 	the_virtio_vsock = NULL;
-	vsock_core_exit();
 	mutex_unlock(&the_virtio_vsock_mutex);
 
 	vdev->config->del_vqs(vdev);
@@ -702,14 +698,28 @@ static int __init virtio_vsock_init(void)
 	virtio_vsock_workqueue = alloc_workqueue("virtio_vsock", 0, 0);
 	if (!virtio_vsock_workqueue)
 		return -ENOMEM;
+
 	ret = register_virtio_driver(&virtio_vsock_driver);
 	if (ret)
-		destroy_workqueue(virtio_vsock_workqueue);
+		goto out_wq;
+
+	ret = vsock_core_init(&virtio_transport.transport);
+	if (ret)
+		goto out_vdr;
+
+	return 0;
+
+out_vdr:
+	unregister_virtio_driver(&virtio_vsock_driver);
+out_wq:
+	destroy_workqueue(virtio_vsock_workqueue);
 	return ret;
+
 }
 
 static void __exit virtio_vsock_exit(void)
 {
+	vsock_core_exit();
 	unregister_virtio_driver(&virtio_vsock_driver);
 	destroy_workqueue(virtio_vsock_workqueue);
 }
-- 
2.20.1

