Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4732AC282DA
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20A20218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbfBCNyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:54:51 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:54494 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728421AbfBCNym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:54:42 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqIEL-0003th-7e; Sun, 03 Feb 2019 13:54:41 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9r-0007Oy-NB; Sun, 03 Feb 2019 14:50:03 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Halil Pasic" <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Cornelia Huck" <cohuck@redhat.com>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.887204213@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 271/305] virtio/s390: avoid race on vcdev->config
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

commit 2448a299ec416a80f699940a86f4a6d9a4f643b1 upstream.

Currently we have a race on vcdev->config in virtio_ccw_get_config() and
in virtio_ccw_set_config().

This normally does not cause problems, as these are usually infrequent
operations. However, for some devices writing to/reading from the config
space can be triggered through sysfs attributes. For these, userspace can
force the race by increasing the frequency.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20180925121309.58524-2-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/s390/kvm/virtio_ccw.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -741,6 +741,7 @@ static void virtio_ccw_get_config(struct
 	int ret;
 	struct ccw1 *ccw;
 	void *config_area;
+	unsigned long flags;
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
@@ -759,11 +760,13 @@ static void virtio_ccw_get_config(struct
 	if (ret)
 		goto out_free;
 
+	spin_lock_irqsave(&vcdev->lock, flags);
 	memcpy(vcdev->config, config_area, offset + len);
-	if (buf)
-		memcpy(buf, &vcdev->config[offset], len);
 	if (vcdev->config_ready < offset + len)
 		vcdev->config_ready = offset + len;
+	spin_unlock_irqrestore(&vcdev->lock, flags);
+	if (buf)
+		memcpy(buf, config_area + offset, len);
 
 out_free:
 	kfree(config_area);
@@ -777,6 +780,7 @@ static void virtio_ccw_set_config(struct
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct ccw1 *ccw;
 	void *config_area;
+	unsigned long flags;
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
@@ -789,9 +793,11 @@ static void virtio_ccw_set_config(struct
 	/* Make sure we don't overwrite fields. */
 	if (vcdev->config_ready < offset)
 		virtio_ccw_get_config(vdev, 0, NULL, offset);
+	spin_lock_irqsave(&vcdev->lock, flags);
 	memcpy(&vcdev->config[offset], buf, len);
 	/* Write the config area to the host. */
 	memcpy(config_area, vcdev->config, sizeof(vcdev->config));
+	spin_unlock_irqrestore(&vcdev->lock, flags);
 	ccw->cmd_code = CCW_CMD_WRITE_CONF;
 	ccw->flags = 0;
 	ccw->count = offset + len;

