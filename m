Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E623DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB137205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543997;
	bh=YGoYFKU9MHgWINLcKbW+v0gW2ztLPjUdDRWvDvxCUMo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GtVLPknMTmb4BFTqDgG+Qo5se1SXrBZH0QatWwt0LLJbI+GM3vWn7ex4QR9EDHdiE
	 Ue3SDG4pJYfZa9hscHvzKbUlrUFtsB35cI1y04A2djsKqtckbN2l7AcML8aCPlF12z
	 otYBR0JZeVEKQjzdnZ0A3RJlZH6fC44jrmKfCiNM=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB137205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731032AbeLKP6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:48034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727061AbeLKP6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:58:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40653205C9;
        Tue, 11 Dec 2018 15:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543912;
        bh=YGoYFKU9MHgWINLcKbW+v0gW2ztLPjUdDRWvDvxCUMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qJWEWYEL2QOsYHK5N9/K581GjA8dPM3ft6fs2iYTCfrEjjemgcNWMsSFQpyYMirD7
         6vm7A7dSaxHXJAGF1zQB+QhjOUtV5ernV/DZR1MK4DcENqghEusuHToYhuqbyac0BD
         7nPOuEitHl23MGXzQnaZVgr+J+dSuV9ZycXFdKYk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 4.19 077/118] virtio/s390: avoid race on vcdev->config
Date:   Tue, 11 Dec 2018 16:41:36 +0100
Message-Id: <20181211151647.367917105@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -828,6 +828,7 @@ static void virtio_ccw_get_config(struct
 	int ret;
 	struct ccw1 *ccw;
 	void *config_area;
+	unsigned long flags;
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
@@ -846,11 +847,13 @@ static void virtio_ccw_get_config(struct
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
@@ -864,6 +867,7 @@ static void virtio_ccw_set_config(struct
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct ccw1 *ccw;
 	void *config_area;
+	unsigned long flags;
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
 	if (!ccw)
@@ -876,9 +880,11 @@ static void virtio_ccw_set_config(struct
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


