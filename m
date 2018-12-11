Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FEFC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AC8A2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544438;
	bh=ScI5zDLBbT1n55CHh7gtXAL9hAN3LXBg3h7epa+nXvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kFLTQZKrW7zKxnf8zbZcsbFBYdfNC0vnsDHqDDf+qmyt1DAh1pjYxIxtU6BuUYacU
	 MF+VurKjkK1JYNFATXpMibs/4XLbryvg/fplRlEvd0FqjVmk6utROFK1loSQ64uh7I
	 cdx0b7qsSxexljsdzJ16KluNloWgIVYnxN8tqkko=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AC8A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbeLKQHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730018AbeLKPxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:53:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C27F420855;
        Tue, 11 Dec 2018 15:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543631;
        bh=ScI5zDLBbT1n55CHh7gtXAL9hAN3LXBg3h7epa+nXvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xr6yspr4hDnUBXl8nIguwOQem52SZnzhyHEZJBAlFE4qBhX5PwmM6B52aQieyinTJ
         jxPaCtE9xJSQnCJR8kyzRiFUbJcxANa4UOzNn6DY0nRlGeSBrRo9ByFIcoFoNrfMeo
         aD5KkCNnF25nwzqmqOo0wBMwl1PWuojb3QAGFWEk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+e3e074963495f92a89ed@syzkaller.appspotmail.com,
        syzbot+d5a0a170c5069658b141@syzkaller.appspotmail.com,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        syzbot+bd391451452fb0b93039@syzkaller.appspotmail.com
Subject: [PATCH 4.14 42/67] vhost/vsock: fix use-after-free in network stack callers
Date:   Tue, 11 Dec 2018 16:41:42 +0100
Message-Id: <20181211151632.522227722@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151630.378216233@linuxfoundation.org>
References: <20181211151630.378216233@linuxfoundation.org>
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

From: Stefan Hajnoczi <stefanha@redhat.com>

commit 834e772c8db0c6a275d75315d90aba4ebbb1e249 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/vhost/vsock.c |   57 ++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

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
@@ -50,11 +51,14 @@ static u32 vhost_transport_get_local_cid
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
@@ -69,17 +73,6 @@ static struct vhost_vsock *__vhost_vsock
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
@@ -210,9 +203,12 @@ vhost_transport_send_pkt(struct virtio_v
 	struct vhost_vsock *vsock;
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
@@ -225,6 +221,8 @@ vhost_transport_send_pkt(struct virtio_v
 	spin_unlock_bh(&vsock->send_pkt_list_lock);
 
 	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
+
+	rcu_read_unlock();
 	return len;
 }
 
@@ -234,12 +232,15 @@ vhost_transport_cancel_pkt(struct vsock_
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
@@ -265,7 +266,10 @@ vhost_transport_cancel_pkt(struct vsock_
 			vhost_poll_queue(&tx_vq->poll);
 	}
 
-	return 0;
+	ret = 0;
+out:
+	rcu_read_unlock();
+	return ret;
 }
 
 static struct virtio_vsock_pkt *
@@ -531,10 +535,6 @@ static int vhost_vsock_dev_open(struct i
 	spin_lock_init(&vsock->send_pkt_list_lock);
 	INIT_LIST_HEAD(&vsock->send_pkt_list);
 	vhost_work_init(&vsock->send_pkt_work, vhost_transport_send_pkt_work);
-
-	spin_lock_bh(&vhost_vsock_lock);
-	list_add_tail(&vsock->list, &vhost_vsock_list);
-	spin_unlock_bh(&vhost_vsock_lock);
 	return 0;
 
 out:
@@ -575,9 +575,13 @@ static int vhost_vsock_dev_release(struc
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
@@ -618,12 +622,17 @@ static int vhost_vsock_set_cid(struct vh
 
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


