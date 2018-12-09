Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C6AC07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A635020661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A635020661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbeLIWIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:08:15 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:37306 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbeLIWIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:08:11 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73I-0002pp-Fg; Sun, 09 Dec 2018 21:55:52 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72b-0003K1-Bv; Sun, 09 Dec 2018 21:55:09 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Dave Airlie" <airlied@redhat.com>,
        "Mikulas Patocka" <mpatocka@redhat.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.373387121@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 087/328] udl-kms: handle allocation failure
In-Reply-To: <lsq.1544392232.713909046@decadent.org.uk>
X-SA-Exim-Connect-IP: 81.174.156.145
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.62-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 542bb9788a1f485eb1a2229178f665d8ea166156 upstream.

Allocations larger than PAGE_ALLOC_COSTLY_ORDER are unreliable and they
may fail anytime. This patch fixes the udl kms driver so that when a large
alloactions fails, it tries to do multiple smaller allocations.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/gpu/drm/udl/udl_main.c | 28 ++++++++++++++++++----------
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
 
-		buf = usb_alloc_coherent(udl->ddev->usbdev, MAX_TRANSFER, GFP_KERNEL,
+		buf = usb_alloc_coherent(udl->ddev->usbdev, size, GFP_KERNEL,
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

