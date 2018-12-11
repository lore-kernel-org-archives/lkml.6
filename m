Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B73C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723D42084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544786;
	bh=/2Z239wGWguSJCC7qSx2F9rNj3qiFW/jM5Ai4ZTUjGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oYl2UkgkoGqqUL1RfrUIbg7y9Afoh8QAnJ8ccbars/MP6EgtwIEXyl0lppkafkJdo
	 XDQLiVK89W+0NshzG8jvUcdQmLs3pnW6fnUq6fZGB21qNHwPNn6fR/9rI/MwEAbi75
	 4RRQESv8H+i4r4Qg3IheRqSulbmpQt1gY0qtKoV4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723D42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbeLKQNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:13:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729189AbeLKPuF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:50:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 745C42146E;
        Tue, 11 Dec 2018 15:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543404;
        bh=/2Z239wGWguSJCC7qSx2F9rNj3qiFW/jM5Ai4ZTUjGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NcVwWodcogqKhxOSLaZbm9Ao+FeU7/Eajc6K6Xep7KaQtlj7PyT3DSCMqaM0B8WCr
         5JkZjeUxQDDLdrDwe7aabdU74P3+8m6CsWppximwmzZ2qsErmLx5aDZwaZnakNhwQK
         FpM/mLVdqFOZ/snbmnzOWoTfAKaAOfy4iELEURLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com,
        syzbot+d5a0a170c5069658b141@syzkaller.appspotmail.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        syzbot+bd391451452fb0b93039@syzkaller.appspotmail.com
Subject: [PATCH 4.9 38/51] vhost/vsock: fix use-after-free in network stack callers
Date:   Tue, 11 Dec 2018 16:41:46 +0100
Message-Id: <20181211151617.160217603@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151612.328911565@linuxfoundation.org>
References: <20181211151612.328911565@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 834e772c8db0c6a275d75315d90aba4ebbb1e249 ]

If the network stack calls .send_pkt()/.cancel_pkt() during .release(),
a struct vhost_vsock use-after-free is possible.  This occurs because
.release() does not wait for other CPUs to stop using struct
vhost_vsock.

Switch to an RCU-enabled hashtable (indexed by guest CID) so that
.release() can wait for other CPUs by calling synchronize_rcu().  This
also eliminates vhost_vsock_lock acquisition in the data path so it
could have a positive effect on performance.

This is CVE-2018-14625 "kernel: use-after-free Read in vhost_transport_send_pkt".

Cc: stable@vger.kernel.org
Reported-and-tested-by: syzbot+bd391451452fb0b93039@syzkaller.appspotmail.com
Reported-by: syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com
Reported-by: syzbot+d5a0a170c5069658b141@syzkaller.appspotmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vsock.c | 57 +++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 6bca57896915..f800f89068db 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -15,6 +15,7 @@
 #include <net/sock.h>
 #include <linux/virtio_vsock.h>
 #include <linux/vhost.h>
+#include <linux/hashtable.h>
 
 #include <net/af_vsock.h>
 #include "vhost.h"
@@ -27,14 +28,14 @@ enum {
 
 /* Used to track all the vhost_vsock instances on the system. */
 static DEFINE_SPINLOCK(vhost_vsock_lock);
-static LIST_HEAD(vhost_vsock_list);
+static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
 
 struct vhost_vsock {
 	struct vhost_dev dev;
 	struct vhost_virtqueue vqs[2];
 
-	/* Link to global vhost_vsock_list, protected by vhost_vsock_lock */
-	struct list_head list;
+	/* Link to global vhost_vsock_hash, writes use vhost_vsock_lock */
+	struct hlist_node hash;
 
 	struct vhost_work send_pkt_work;
 	spinlock_t send_pkt_list_lock;
@@ -50,11 +51,14 @@ static u32 vhost_transport_get_local_cid(void)
 	return VHOST_VSOCK_DEFAULT_HOST_CID;
 }
 
-static struct vhost_vsock *__vhost_vsock_get(u32 guest_cid)
+/* Callers that dereference the return value must hold vhost_vsock_lock or the
+ * RCU read lock.
+ */
+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
 {
 	struct vhost_vsock *vsock;
 
-	list_for_each_entry(vsock, &vhost_vsock_list, list) {
+	hash_for_each_possible_rcu(vhost_vsock_hash, vsock, hash, guest_cid) {
 		u32 other_cid = vsock->guest_cid;
 
 		/* Skip instances that have no CID yet */
@@ -69,17 +73,6 @@ static struct vhost_vsock *__vhost_vsock_get(u32 guest_cid)
 	return NULL;
 }
 
-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
-{
-	struct vhost_vsock *vsock;
-
-	spin_lock_bh(&vhost_vsock_lock);
-	vsock = __vhost_vsock_get(guest_cid);
-	spin_unlock_bh(&vhost_vsock_lock);
-
-	return vsock;
-}
-
 static void
 vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			    struct vhost_virtqueue *vq)
@@ -206,9 +199,12 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
 	struct vhost_virtqueue *vq;
 	int len = pkt->len;
 
+	rcu_read_lock();
+
 	/* Find the vhost_vsock according to guest context id  */
 	vsock = vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid));
 	if (!vsock) {
+		rcu_read_unlock();
 		virtio_transport_free_pkt(pkt);
 		return -ENODEV;
 	}
@@ -223,6 +219,8 @@ vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
 	spin_unlock_bh(&vsock->send_pkt_list_lock);
 
 	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
+
+	rcu_read_unlock();
 	return len;
 }
 
@@ -232,12 +230,15 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	struct vhost_vsock *vsock;
 	struct virtio_vsock_pkt *pkt, *n;
 	int cnt = 0;
+	int ret = -ENODEV;
 	LIST_HEAD(freeme);
 
+	rcu_read_lock();
+
 	/* Find the vhost_vsock according to guest context id  */
 	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
 	if (!vsock)
-		return -ENODEV;
+		goto out;
 
 	spin_lock_bh(&vsock->send_pkt_list_lock);
 	list_for_each_entry_safe(pkt, n, &vsock->send_pkt_list, list) {
@@ -263,7 +264,10 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 			vhost_poll_queue(&tx_vq->poll);
 	}
 
-	return 0;
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 static struct virtio_vsock_pkt *
@@ -529,10 +533,6 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 	spin_lock_init(&vsock->send_pkt_list_lock);
 	INIT_LIST_HEAD(&vsock->send_pkt_list);
 	vhost_work_init(&vsock->send_pkt_work, vhost_transport_send_pkt_work);
-
-	spin_lock_bh(&vhost_vsock_lock);
-	list_add_tail(&vsock->list, &vhost_vsock_list);
-	spin_unlock_bh(&vhost_vsock_lock);
 	return 0;
 
 out:
@@ -573,9 +573,13 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	struct vhost_vsock *vsock = file->private_data;
 
 	spin_lock_bh(&vhost_vsock_lock);
-	list_del(&vsock->list);
+	if (vsock->guest_cid)
+		hash_del_rcu(&vsock->hash);
 	spin_unlock_bh(&vhost_vsock_lock);
 
+	/* Wait for other CPUs to finish using vsock */
+	synchronize_rcu();
+
 	/* Iterating over all connections for all CIDs to find orphans is
 	 * inefficient.  Room for improvement here. */
 	vsock_for_each_connected_socket(vhost_vsock_reset_orphans);
@@ -616,12 +620,17 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
 
 	/* Refuse if CID is already in use */
 	spin_lock_bh(&vhost_vsock_lock);
-	other = __vhost_vsock_get(guest_cid);
+	other = vhost_vsock_get(guest_cid);
 	if (other && other != vsock) {
 		spin_unlock_bh(&vhost_vsock_lock);
 		return -EADDRINUSE;
 	}
+
+	if (vsock->guest_cid)
+		hash_del_rcu(&vsock->hash);
+
 	vsock->guest_cid = guest_cid;
+	hash_add_rcu(vhost_vsock_hash, &vsock->hash, guest_cid);
 	spin_unlock_bh(&vhost_vsock_lock);
 
 	return 0;
-- 
2.19.1



