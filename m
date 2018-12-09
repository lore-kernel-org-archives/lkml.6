Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE88BC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E9220661
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E9220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeLIWOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:14:47 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38104 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727019AbeLIWOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:14:45 -0500
Received: from pub.yeoldevic.com ([81.174.156.145] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW73M-0002ib-5j; Sun, 09 Dec 2018 21:55:56 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gW72a-0003HA-B5; Sun, 09 Dec 2018 21:55:08 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Mikulas Patocka" <mpatocka@redhat.com>,
        "Bartlomiej Zolnierkiewicz" <b.zolnierkie@samsung.com>
Date:   Sun, 09 Dec 2018 21:50:33 +0000
Message-ID: <lsq.1544392233.247925224@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 063/328] udlfb: handle allocation failure
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

commit 080fb5240bdcabed7387b814139c3ea172d59fc5 upstream.

Allocations larger than PAGE_ALLOC_COSTLY_ORDER are unreliable and they
may fail anytime. This patch fixes the udlfb driver so that when a large
alloactions fails, it tries to do multiple smaller allocations.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
[bwh: Backported to 3.16:
 - Pointers to struct dlfb_data are named "dev" rather than "dlfb"
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/video/fbdev/udlfb.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1851,17 +1851,22 @@ static void dlfb_free_urb_list(struct dl
 
 static int dlfb_alloc_urb_list(struct dlfb_data *dev, int count, size_t size)
 {
-	int i = 0;
 	struct urb *urb;
 	struct urb_node *unode;
 	char *buf;
+	size_t wanted_size = count * size;
 
 	spin_lock_init(&dev->urbs.lock);
 
+retry:
 	dev->urbs.size = size;
 	INIT_LIST_HEAD(&dev->urbs.list);
 
-	while (i < count) {
+	sema_init(&dev->urbs.limit_sem, 0);
+	dev->urbs.count = 0;
+	dev->urbs.available = 0;
+
+	while (dev->urbs.count * size < wanted_size) {
 		unode = kzalloc(sizeof(struct urb_node), GFP_KERNEL);
 		if (!unode)
 			break;
@@ -1874,11 +1879,16 @@ static int dlfb_alloc_urb_list(struct dl
 		}
 		unode->urb = urb;
 
-		buf = usb_alloc_coherent(dev->udev, MAX_TRANSFER, GFP_KERNEL,
+		buf = usb_alloc_coherent(dev->udev, size, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			kfree(unode);
 			usb_free_urb(urb);
+			if (size > PAGE_SIZE) {
+				size /= 2;
+				dlfb_free_urb_list(dev);
+				goto retry;
+			}
 			break;
 		}
 
@@ -1889,14 +1899,12 @@ static int dlfb_alloc_urb_list(struct dl
 
 		list_add_tail(&unode->entry, &dev->urbs.list);
 
-		i++;
+		up(&dev->urbs.limit_sem);
+		dev->urbs.count++;
+		dev->urbs.available++;
 	}
 
-	sema_init(&dev->urbs.limit_sem, i);
-	dev->urbs.count = i;
-	dev->urbs.available = i;
-
-	return i;
+	return dev->urbs.count;
 }
 
 static struct urb *dlfb_get_urb(struct dlfb_data *dev)

