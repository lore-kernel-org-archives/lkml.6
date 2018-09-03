Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04598C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7C920869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 16:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC7C920869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeICVNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 17:13:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36720 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727776AbeICVNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 17:13:06 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6E584BA2;
        Mon,  3 Sep 2018 16:52:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Dave Airlie <airlied@redhat.com>
Subject: [PATCH 3.18 46/56] udl-kms: handle allocation failure
Date:   Mon,  3 Sep 2018 18:49:36 +0200
Message-Id: <20180903164926.352127871@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903164924.078355019@linuxfoundation.org>
References: <20180903164924.078355019@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 542bb9788a1f485eb1a2229178f665d8ea166156 upstream.

Allocations larger than PAGE_ALLOC_COSTLY_ORDER are unreliable and they
may fail anytime. This patch fixes the udl kms driver so that when a large
alloactions fails, it tries to do multiple smaller allocations.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/udl/udl_main.c |   28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -171,17 +171,22 @@ static void udl_free_urb_list(struct drm
 static int udl_alloc_urb_list(struct drm_device *dev, int count, size_t size)
 {
 	struct udl_device *udl = dev->dev_private;
-	int i = 0;
 	struct urb *urb;
 	struct urb_node *unode;
 	char *buf;
+	size_t wanted_size = count * size;
 
 	spin_lock_init(&udl->urbs.lock);
 
+retry:
 	udl->urbs.size = size;
 	INIT_LIST_HEAD(&udl->urbs.list);
 
-	while (i < count) {
+	sema_init(&udl->urbs.limit_sem, 0);
+	udl->urbs.count = 0;
+	udl->urbs.available = 0;
+
+	while (udl->urbs.count * size < wanted_size) {
 		unode = kzalloc(sizeof(struct urb_node), GFP_KERNEL);
 		if (!unode)
 			break;
@@ -197,11 +202,16 @@ static int udl_alloc_urb_list(struct drm
 		}
 		unode->urb = urb;
 
-		buf = usb_alloc_coherent(udl->udev, MAX_TRANSFER, GFP_KERNEL,
+		buf = usb_alloc_coherent(udl->udev, size, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			kfree(unode);
 			usb_free_urb(urb);
+			if (size > PAGE_SIZE) {
+				size /= 2;
+				udl_free_urb_list(dev);
+				goto retry;
+			}
 			break;
 		}
 
@@ -212,16 +222,14 @@ static int udl_alloc_urb_list(struct drm
 
 		list_add_tail(&unode->entry, &udl->urbs.list);
 
-		i++;
+		up(&udl->urbs.limit_sem);
+		udl->urbs.count++;
+		udl->urbs.available++;
 	}
 
-	sema_init(&udl->urbs.limit_sem, i);
-	udl->urbs.count = i;
-	udl->urbs.available = i;
-
-	DRM_DEBUG("allocated %d %d byte urbs\n", i, (int) size);
+	DRM_DEBUG("allocated %d %d byte urbs\n", udl->urbs.count, (int) size);
 
-	return i;
+	return udl->urbs.count;
 }
 
 struct urb *udl_get_urb(struct drm_device *dev)


