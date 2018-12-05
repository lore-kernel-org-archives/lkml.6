Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53029C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E9D20661
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E9D20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeLECdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:33:23 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:48644 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbeLECdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:33:22 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 2FD90F9C8DFE37CEEC31;
        Wed,  5 Dec 2018 10:33:19 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wB52XFD9080860;
        Wed, 5 Dec 2018 10:33:15 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018120510333562-14808102 ;
          Wed, 5 Dec 2018 10:33:35 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     boris.ostrovsky@oracle.com
Cc:     jgross@suse.com, sstabellini@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, wang.yi59@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v6] pvcalls-front: Avoid get_free_pages(GFP_KERNEL) under spinlock
Date:   Wed, 5 Dec 2018 10:35:50 +0800
Message-Id: <1543977350-19771-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-12-05 10:33:35,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-12-05 10:33:08,
        Serialize complete at 2018-12-05 10:33:08
X-MAIL: mse01.zte.com.cn wB52XFD9080860
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that we call this with a spin lock held.
The call tree is:
pvcalls_front_accept() holds bedata->socket_lock.
    -> create_active()
        -> __get_free_pages() uses GFP_KERNEL

The create_active() function is only called from pvcalls_front_accept()
with a spin_lock held, The allocation is not allowed to sleep and
GFP_KERNEL is not sufficient.

This issue was detected by using the Coccinelle software.

v2: Add a function doing the allocations which is called
    outside the lock and passing the allocated data to
    create_active().

v3: Use the matching deallocators i.e., free_page()
    and free_pages(), respectively.

v4: It would be better to pre-populate map (struct sock_mapping),
    rather than introducing one more new struct.

v5: Since allocating the data outside of this call it should also
    be freed outside, when create_active() fails.
    Move kzalloc(sizeof(*map2), GFP_ATOMIC) outside spinlock and
    use GFP_KERNEL instead.

v6: Drop the superfluous calls.

Suggested-by: Juergen Gross <jgross@suse.com>
Suggested-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Suggested-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: xen-devel@lists.xenproject.org
CC: linux-kernel@vger.kernel.org
---
 drivers/xen/pvcalls-front.c | 81 +++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 22 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 77224d8f3e6f..3324fcc4596d 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -335,6 +335,39 @@ int pvcalls_front_socket(struct socket *sock)
 	return ret;
 }
 
+static void free_active_ring(struct sock_mapping *map)
+{
+	free_pages((unsigned long)map->active.data.in,
+			map->active.ring->ring_order);
+	free_page((unsigned long)map->active.ring);
+}
+
+static int alloc_active_ring(struct sock_mapping *map)
+{
+	void *bytes;
+
+	map->active.ring = (struct pvcalls_data_intf *)
+		get_zeroed_page(GFP_KERNEL);
+	if (!map->active.ring)
+		goto out;
+
+	map->active.ring->ring_order = PVCALLS_RING_ORDER;
+	bytes = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					PVCALLS_RING_ORDER);
+	if (!bytes)
+		goto out;
+
+	map->active.data.in = bytes;
+	map->active.data.out = bytes +
+		XEN_FLEX_RING_SIZE(PVCALLS_RING_ORDER);
+
+	return 0;
+
+out:
+	free_active_ring(map);
+	return -ENOMEM;
+}
+
 static int create_active(struct sock_mapping *map, int *evtchn)
 {
 	void *bytes;
@@ -343,15 +376,7 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 	*evtchn = -1;
 	init_waitqueue_head(&map->active.inflight_conn_req);
 
-	map->active.ring = (struct pvcalls_data_intf *)
-		__get_free_page(GFP_KERNEL | __GFP_ZERO);
-	if (map->active.ring == NULL)
-		goto out_error;
-	map->active.ring->ring_order = PVCALLS_RING_ORDER;
-	bytes = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					PVCALLS_RING_ORDER);
-	if (bytes == NULL)
-		goto out_error;
+	bytes = map->active.data.in;
 	for (i = 0; i < (1 << PVCALLS_RING_ORDER); i++)
 		map->active.ring->ref[i] = gnttab_grant_foreign_access(
 			pvcalls_front_dev->otherend_id,
@@ -361,10 +386,6 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 		pvcalls_front_dev->otherend_id,
 		pfn_to_gfn(virt_to_pfn((void *)map->active.ring)), 0);
 
-	map->active.data.in = bytes;
-	map->active.data.out = bytes +
-		XEN_FLEX_RING_SIZE(PVCALLS_RING_ORDER);
-
 	ret = xenbus_alloc_evtchn(pvcalls_front_dev, evtchn);
 	if (ret)
 		goto out_error;
@@ -385,8 +406,6 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 out_error:
 	if (*evtchn >= 0)
 		xenbus_free_evtchn(pvcalls_front_dev, *evtchn);
-	free_pages((unsigned long)map->active.data.in, PVCALLS_RING_ORDER);
-	free_page((unsigned long)map->active.ring);
 	return ret;
 }
 
@@ -406,17 +425,24 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
 		return PTR_ERR(map);
 
 	bedata = dev_get_drvdata(&pvcalls_front_dev->dev);
+	ret = alloc_active_ring(map);
+	if (ret < 0) {
+		pvcalls_exit_sock(sock);
+		return ret;
+	}
 
 	spin_lock(&bedata->socket_lock);
 	ret = get_request(bedata, &req_id);
 	if (ret < 0) {
 		spin_unlock(&bedata->socket_lock);
+		free_active_ring(map);
 		pvcalls_exit_sock(sock);
 		return ret;
 	}
 	ret = create_active(map, &evtchn);
 	if (ret < 0) {
 		spin_unlock(&bedata->socket_lock);
+		free_active_ring(map);
 		pvcalls_exit_sock(sock);
 		return ret;
 	}
@@ -780,25 +806,36 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
 		}
 	}
 
-	spin_lock(&bedata->socket_lock);
-	ret = get_request(bedata, &req_id);
-	if (ret < 0) {
+	map2 = kzalloc(sizeof(*map2), GFP_KERNEL);
+	if (map2 == NULL) {
 		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
 			  (void *)&map->passive.flags);
-		spin_unlock(&bedata->socket_lock);
+		pvcalls_exit_sock(sock);
+		return -ENOMEM;
+	}
+	ret = alloc_active_ring(map2);
+	if (ret < 0) {
+		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
+				(void *)&map->passive.flags);
+		kfree(map2);
 		pvcalls_exit_sock(sock);
 		return ret;
 	}
-	map2 = kzalloc(sizeof(*map2), GFP_ATOMIC);
-	if (map2 == NULL) {
+	spin_lock(&bedata->socket_lock);
+	ret = get_request(bedata, &req_id);
+	if (ret < 0) {
 		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
 			  (void *)&map->passive.flags);
 		spin_unlock(&bedata->socket_lock);
+		free_active_ring(map2);
+		kfree(map2);
 		pvcalls_exit_sock(sock);
-		return -ENOMEM;
+		return ret;
 	}
+
 	ret = create_active(map2, &evtchn);
 	if (ret < 0) {
+		free_active_ring(map2);
 		kfree(map2);
 		clear_bit(PVCALLS_FLAG_ACCEPT_INFLIGHT,
 			  (void *)&map->passive.flags);
-- 
2.19.1

