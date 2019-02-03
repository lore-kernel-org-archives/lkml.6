Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B13C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B71218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfBCNys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:54:48 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54488 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729062AbfBCNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEL-0003tg-2q; Sun, 03 Feb 2019 13:54:41 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9r-0007P2-QP; Sun, 03 Feb 2019 14:50:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Cornelia Huck" <cohuck@redhat.com>,
        "Colin Ian King" <colin.king@canonical.com>,
        "Halil Pasic" <pasic@linux.ibm.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.124668300@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 272/305] virtio/s390: fix race in ccw_io_helper()
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Halil Pasic <pasic@linux.ibm.com>

commit 78b1a52e05c9db11d293342e8d6d8a230a04b4e7 upstream.

While ccw_io_helper() seems like intended to be exclusive in a sense that
it is supposed to facilitate I/O for at most one thread at any given
time, there is actually nothing ensuring that threads won't pile up at
vcdev->wait_q. If they do, all threads get woken up and see the status
that belongs to some other request than their own. This can lead to bugs.
For an example see:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1788432

This race normally does not cause any problems. The operations provided
by struct virtio_config_ops are usually invoked in a well defined
sequence, normally don't fail, and are normally used quite infrequent
too.

Yet, if some of the these operations are directly triggered via sysfs
attributes, like in the case described by the referenced bug, userspace
is given an opportunity to force races by increasing the frequency of the
given operations.

Let us fix the problem by ensuring, that for each device, we finish
processing the previous request before starting with a new one.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Colin Ian King <colin.king@canonical.com>
Message-Id: <20180925121309.58524-3-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/kvm/virtio_ccw.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -57,6 +57,7 @@ struct virtio_ccw_device {
 	int err;
 	wait_queue_head_t wait_q;
 	spinlock_t lock;
+	struct mutex io_lock; /* Serializes I/O requests */
 	struct list_head virtqueues;
 	unsigned long indicators;
 	unsigned long indicators2;
@@ -282,6 +283,7 @@ static int ccw_io_helper(struct virtio_c
 	unsigned long flags;
 	int flag = intparm & VIRTIO_CCW_INTPARM_MASK;
 
+	mutex_lock(&vcdev->io_lock);
 	do {
 		spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
 		ret = ccw_device_start(vcdev->cdev, ccw, intparm, 0, 0);
@@ -294,7 +296,9 @@ static int ccw_io_helper(struct virtio_c
 		cpu_relax();
 	} while (ret == -EBUSY);
 	wait_event(vcdev->wait_q, doing_io(vcdev, flag) == 0);
-	return ret ? ret : vcdev->err;
+	ret = ret ? ret : vcdev->err;
+	mutex_unlock(&vcdev->io_lock);
+	return ret;
 }
 
 static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
@@ -1086,6 +1090,7 @@ static int virtio_ccw_online(struct ccw_
 	init_waitqueue_head(&vcdev->wait_q);
 	INIT_LIST_HEAD(&vcdev->virtqueues);
 	spin_lock_init(&vcdev->lock);
+	mutex_init(&vcdev->io_lock);
 
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	dev_set_drvdata(&cdev->dev, vcdev);

