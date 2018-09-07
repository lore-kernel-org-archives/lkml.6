Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A94EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3A120645
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3A120645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbeIHCIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 22:08:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46920 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbeIHCIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 22:08:15 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48791F07;
        Fri,  7 Sep 2018 21:25:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 4.18 126/145] udlfb: handle allocation failure
Date:   Fri,  7 Sep 2018 23:09:52 +0200
Message-Id: <20180907210913.301071343@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 080fb5240bdcabed7387b814139c3ea172d59fc5 upstream.

Allocations larger than PAGE_ALLOC_COSTLY_ORDER are unreliable and they
may fail anytime. This patch fixes the udlfb driver so that when a large
alloactions fails, it tries to do multiple smaller allocations.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/fbdev/udlfb.c |   26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1843,17 +1843,22 @@ static void dlfb_free_urb_list(struct dl
 
 static int dlfb_alloc_urb_list(struct dlfb_data *dlfb, int count, size_t size)
 {
-	int i = 0;
 	struct urb *urb;
 	struct urb_node *unode;
 	char *buf;
+	size_t wanted_size = count * size;
 
 	spin_lock_init(&dlfb->urbs.lock);
 
+retry:
 	dlfb->urbs.size = size;
 	INIT_LIST_HEAD(&dlfb->urbs.list);
 
-	while (i < count) {
+	sema_init(&dlfb->urbs.limit_sem, 0);
+	dlfb->urbs.count = 0;
+	dlfb->urbs.available = 0;
+
+	while (dlfb->urbs.count * size < wanted_size) {
 		unode = kzalloc(sizeof(*unode), GFP_KERNEL);
 		if (!unode)
 			break;
@@ -1866,11 +1871,16 @@ static int dlfb_alloc_urb_list(struct dl
 		}
 		unode->urb = urb;
 
-		buf = usb_alloc_coherent(dlfb->udev, MAX_TRANSFER, GFP_KERNEL,
+		buf = usb_alloc_coherent(dlfb->udev, size, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			kfree(unode);
 			usb_free_urb(urb);
+			if (size > PAGE_SIZE) {
+				size /= 2;
+				dlfb_free_urb_list(dlfb);
+				goto retry;
+			}
 			break;
 		}
 
@@ -1881,14 +1891,12 @@ static int dlfb_alloc_urb_list(struct dl
 
 		list_add_tail(&unode->entry, &dlfb->urbs.list);
 
-		i++;
+		up(&dlfb->urbs.limit_sem);
+		dlfb->urbs.count++;
+		dlfb->urbs.available++;
 	}
 
-	sema_init(&dlfb->urbs.limit_sem, i);
-	dlfb->urbs.count = i;
-	dlfb->urbs.available = i;
-
-	return i;
+	return dlfb->urbs.count;
 }
 
 static struct urb *dlfb_get_urb(struct dlfb_data *dlfb)


