Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AC9C5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDAF2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543278;
	bh=10HNzsinpM/ebLOFLl6kdEI2bgl51pOXS53D7vwxyis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b+WATBDZ9+WmI6f4T9gyHu2MRjcaXsKs5LzcPGkKmVLLN7zY1vKrENYzY+Erqft5q
	 yqe2jEvSOcQ9TxOVUkrdXdOV7ZDVDDRBQzpXKZF/8CLjmHeCtOemkIXrAaCqCIB+Ji
	 ht1XBj5NlyY2VEHzv1qgqy6TIqKgOZeAYCzjEUCU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CDAF2133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbeLKPr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:47:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:36296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728667AbeLKPrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:47:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C224F2133F;
        Tue, 11 Dec 2018 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543272;
        bh=10HNzsinpM/ebLOFLl6kdEI2bgl51pOXS53D7vwxyis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/dWX/KY04EfZm4eNKTSOrVrxO7J/BQ7WA865ZTIMmTwNAd9qAq+We57CUMWqY7Ir
         HpFASmpAE+qoAnLlkkee+jXZ5sEN2+v+ujsunaw8SC9enf8hfs1pz52TILluK8QFqN
         T6DQItO3J/padZBg9v+37ngO/bz/cOH/h15BDQMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.4 78/91] virtio/s390: avoid race on vcdev->config
Date:   Tue, 11 Dec 2018 16:41:37 +0100
Message-Id: <20181211151612.962127872@linuxfoundation.org>
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

commit 2448a299ec416a80f699940a86f4a6d9a4f643b1 upstream.

Currently we have a race on vcdev->config in virtio_ccw_get_config() and
in virtio_ccw_set_config().

This normally does not cause problems, as these are usually infrequent
operations. However, for some devices writing to/reading from the config
space can be triggered through sysfs attributes. For these, userspace can
force the race by increasing the frequency.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Cc: stable@vger.kernel.org
Message-Id: <20180925121309.58524-2-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/virtio/virtio_ccw.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -833,6 +833,7 @@ static void virtio_ccw_get_config(struct
 	int ret;
 	struct ccw1 *ccw;
 	void *config_area;
+	unsigned long flags;
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
@@ -851,11 +852,13 @@ static void virtio_ccw_get_config(struct
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
@@ -869,6 +872,7 @@ static void virtio_ccw_set_config(struct
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct ccw1 *ccw;
 	void *config_area;
+	unsigned long flags;
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
@@ -881,9 +885,11 @@ static void virtio_ccw_set_config(struct
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


