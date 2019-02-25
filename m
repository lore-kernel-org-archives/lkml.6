Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4658C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8F12184E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551130377;
	bh=eWg0+60+Qa0GZYf9ZRWqZs1YMk2bSEy3Av9aySzEedo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AV3ek0972bZwk5GIiMqMT5wSg058cQBrhvZD2cg9Z3L1ww1W7b+OLbFutGpreEPf0
	 PrWzuj4PSOVMhNXZytzsrHPm6OlbUkvyE3hSybxJI9OEzkzfp3eTGEdpnrXPRwR+7Z
	 EsSSQQeF7H5thq/uisxRblvqxSsEJ6Mh3HQMnJBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732574AbfBYVcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732556AbfBYVcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:32:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E20421848;
        Mon, 25 Feb 2019 21:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130372;
        bh=eWg0+60+Qa0GZYf9ZRWqZs1YMk2bSEy3Av9aySzEedo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dYA4EwxQ8pABfI/KfJqtj/6CKb73DbtyGxkS8FfX0jrr6dJR1tdGiCvnS3Srh/P5X
         dp3f/feff0cQghgFVEBly602Ou6jQt2dvOoXwPJOfpz0h3Cq7Xk0DEf7vm4qffpSFE
         6mK6mSZA2LM6/cO0V4S0nxesVShgYeX697PLqPf4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Julia Lawall <julia.lawall@lip6.fr>,
        xen-devel@lists.xenproject.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 063/183] pvcalls-front: Avoid get_free_pages(GFP_KERNEL) under spinlock
Date:   Mon, 25 Feb 2019 22:10:36 +0100
Message-Id: <20190225195105.095083797@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
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

[ Upstream commit 9f51c05dc41a6d69423e3d03d18eb7ab22f9ec19 ]

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
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
CC: Julia Lawall <julia.lawall@lip6.fr>
CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
CC: Juergen Gross <jgross@suse.com>
CC: Stefano Stabellini <sstabellini@kernel.org>
CC: xen-devel@lists.xenproject.org
CC: linux-kernel@vger.kernel.org
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/pvcalls-front.c | 81 +++++++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 22 deletions(-)

diff --git a/drivers/xen/pvcalls-front.c b/drivers/xen/pvcalls-front.c
index 01588582ae663..6357160d466ab 100644
--- a/drivers/xen/pvcalls-front.c
+++ b/drivers/xen/pvcalls-front.c
@@ -341,6 +341,39 @@ int pvcalls_front_socket(struct socket *sock)
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
@@ -349,15 +382,7 @@ static int create_active(struct sock_mapping *map, int *evtchn)
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
@@ -367,10 +392,6 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 		pvcalls_front_dev->otherend_id,
 		pfn_to_gfn(virt_to_pfn((void *)map->active.ring)), 0);
 
-	map->active.data.in = bytes;
-	map->active.data.out = bytes +
-		XEN_FLEX_RING_SIZE(PVCALLS_RING_ORDER);
-
 	ret = xenbus_alloc_evtchn(pvcalls_front_dev, evtchn);
 	if (ret)
 		goto out_error;
@@ -391,8 +412,6 @@ static int create_active(struct sock_mapping *map, int *evtchn)
 out_error:
 	if (*evtchn >= 0)
 		xenbus_free_evtchn(pvcalls_front_dev, *evtchn);
-	free_pages((unsigned long)map->active.data.in, PVCALLS_RING_ORDER);
-	free_page((unsigned long)map->active.ring);
 	return ret;
 }
 
@@ -412,17 +431,24 @@ int pvcalls_front_connect(struct socket *sock, struct sockaddr *addr,
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
@@ -784,25 +810,36 @@ int pvcalls_front_accept(struct socket *sock, struct socket *newsock, int flags)
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



