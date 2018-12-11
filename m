Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969B1C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAE42084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544544984;
	bh=5HoslKBEjUJ/U6RkRMx3XHFgLItsRqP1dmDa8c9C0F0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rHd0V2uyo2jU0BmhpPyCrb7lusasSCJsUbynoI7Nr1cYNGrcHfApvwvFx3VMzgkAw
	 riqgGyjMzBh7G5G0bm6v7H0XpQANlDqa1dr/V76yfYb1+v/m7d9f0xh7gcKhb1GXRa
	 X2ADmoCr2PqWpPArJkC5DX1HKvnwOQ8NH74SaKLs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAE42084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbeLKPsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:48:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:36338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbeLKPr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:47:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB7620989;
        Tue, 11 Dec 2018 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543277;
        bh=5HoslKBEjUJ/U6RkRMx3XHFgLItsRqP1dmDa8c9C0F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0aWqghIMtYJC6Hp3CCd8dX+2WxKfHAXB6CoTixbx2fvDBNS+vM3ysFZ2999A122l0
         ID5Tya2/L8FhTOv2UV9gU7USn3UplIVDQv6HvC41wqO2aGsakVpo1C8UGX2YKjtej0
         TFSJYvmEbGhyGT9Kpp/iim+/Fqziyj4dzenGR0Eo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Colin Ian King <colin.king@canonical.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.4 79/91] virtio/s390: fix race in ccw_io_helper()
Date:   Tue, 11 Dec 2018 16:41:38 +0100
Message-Id: <20181211151613.033769641@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable@vger.kernel.org
Message-Id: <20180925121309.58524-3-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/virtio/virtio_ccw.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -59,6 +59,7 @@ struct virtio_ccw_device {
 	unsigned int revision; /* Transport revision */
 	wait_queue_head_t wait_q;
 	spinlock_t lock;
+	struct mutex io_lock; /* Serializes I/O requests */
 	struct list_head virtqueues;
 	unsigned long indicators;
 	unsigned long indicators2;
@@ -307,6 +308,7 @@ static int ccw_io_helper(struct virtio_c
 	unsigned long flags;
 	int flag = intparm & VIRTIO_CCW_INTPARM_MASK;
 
+	mutex_lock(&vcdev->io_lock);
 	do {
 		spin_lock_irqsave(get_ccwdev_lock(vcdev->cdev), flags);
 		ret = ccw_device_start(vcdev->cdev, ccw, intparm, 0, 0);
@@ -319,7 +321,9 @@ static int ccw_io_helper(struct virtio_c
 		cpu_relax();
 	} while (ret == -EBUSY);
 	wait_event(vcdev->wait_q, doing_io(vcdev, flag) == 0);
-	return ret ? ret : vcdev->err;
+	ret = ret ? ret : vcdev->err;
+	mutex_unlock(&vcdev->io_lock);
+	return ret;
 }
 
 static void virtio_ccw_drop_indicator(struct virtio_ccw_device *vcdev,
@@ -1236,6 +1240,7 @@ static int virtio_ccw_online(struct ccw_
 	init_waitqueue_head(&vcdev->wait_q);
 	INIT_LIST_HEAD(&vcdev->virtqueues);
 	spin_lock_init(&vcdev->lock);
+	mutex_init(&vcdev->io_lock);
 
 	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	dev_set_drvdata(&cdev->dev, vcdev);


