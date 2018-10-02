Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832C0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24220208AE
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24220208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbeJBUTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:19:53 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36260 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733177AbeJBUTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:19:52 -0400
Received: from localhost (24-104-73-23-ip-static.hfc.comcastbusiness.net [24.104.73.23])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6D5B6B4B;
        Tue,  2 Oct 2018 13:36:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 18/94] media: fsl-viu: fix error handling in viu_of_probe()
Date:   Tue,  2 Oct 2018 06:24:32 -0700
Message-Id: <20181002132501.739981466@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002132500.494838053@linuxfoundation.org>
References: <20181002132500.494838053@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexey Khoroshilov <khoroshilov@ispras.ru>

[ Upstream commit 662a99e145661c2b35155cf375044deae9b79896 ]

viu_of_probe() ignores fails in i2c_get_adapter(),
tries to unlock uninitialized mutex on error path.

The patch streamlining the error handling in viu_of_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/fsl-viu.c |   38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

--- a/drivers/media/platform/fsl-viu.c
+++ b/drivers/media/platform/fsl-viu.c
@@ -1417,7 +1417,7 @@ static int viu_of_probe(struct platform_
 				     sizeof(struct viu_reg), DRV_NAME)) {
 		dev_err(&op->dev, "Error while requesting mem region\n");
 		ret = -EBUSY;
-		goto err;
+		goto err_irq;
 	}
 
 	/* remap registers */
@@ -1425,7 +1425,7 @@ static int viu_of_probe(struct platform_
 	if (!viu_regs) {
 		dev_err(&op->dev, "Can't map register set\n");
 		ret = -ENOMEM;
-		goto err;
+		goto err_irq;
 	}
 
 	/* Prepare our private structure */
@@ -1433,7 +1433,7 @@ static int viu_of_probe(struct platform_
 	if (!viu_dev) {
 		dev_err(&op->dev, "Can't allocate private structure\n");
 		ret = -ENOMEM;
-		goto err;
+		goto err_irq;
 	}
 
 	viu_dev->vr = viu_regs;
@@ -1449,16 +1449,21 @@ static int viu_of_probe(struct platform_
 	ret = v4l2_device_register(viu_dev->dev, &viu_dev->v4l2_dev);
 	if (ret < 0) {
 		dev_err(&op->dev, "v4l2_device_register() failed: %d\n", ret);
-		goto err;
+		goto err_irq;
 	}
 
 	ad = i2c_get_adapter(0);
+	if (!ad) {
+		ret = -EFAULT;
+		dev_err(&op->dev, "couldn't get i2c adapter\n");
+		goto err_v4l2;
+	}
 
 	v4l2_ctrl_handler_init(&viu_dev->hdl, 5);
 	if (viu_dev->hdl.error) {
 		ret = viu_dev->hdl.error;
 		dev_err(&op->dev, "couldn't register control\n");
-		goto err_vdev;
+		goto err_i2c;
 	}
 	/* This control handler will inherit the control(s) from the
 	   sub-device(s). */
@@ -1476,7 +1481,7 @@ static int viu_of_probe(struct platform_
 	vdev = video_device_alloc();
 	if (vdev == NULL) {
 		ret = -ENOMEM;
-		goto err_vdev;
+		goto err_hdl;
 	}
 
 	*vdev = viu_template;
@@ -1497,7 +1502,7 @@ static int viu_of_probe(struct platform_
 	ret = video_register_device(viu_dev->vdev, VFL_TYPE_GRABBER, -1);
 	if (ret < 0) {
 		video_device_release(viu_dev->vdev);
-		goto err_vdev;
+		goto err_unlock;
 	}
 
 	/* enable VIU clock */
@@ -1505,12 +1510,12 @@ static int viu_of_probe(struct platform_
 	if (IS_ERR(clk)) {
 		dev_err(&op->dev, "failed to lookup the clock!\n");
 		ret = PTR_ERR(clk);
-		goto err_clk;
+		goto err_vdev;
 	}
 	ret = clk_prepare_enable(clk);
 	if (ret) {
 		dev_err(&op->dev, "failed to enable the clock!\n");
-		goto err_clk;
+		goto err_vdev;
 	}
 	viu_dev->clk = clk;
 
@@ -1521,7 +1526,7 @@ static int viu_of_probe(struct platform_
 	if (request_irq(viu_dev->irq, viu_intr, 0, "viu", (void *)viu_dev)) {
 		dev_err(&op->dev, "Request VIU IRQ failed.\n");
 		ret = -ENODEV;
-		goto err_irq;
+		goto err_clk;
 	}
 
 	mutex_unlock(&viu_dev->lock);
@@ -1529,16 +1534,19 @@ static int viu_of_probe(struct platform_
 	dev_info(&op->dev, "Freescale VIU Video Capture Board\n");
 	return ret;
 
-err_irq:
-	clk_disable_unprepare(viu_dev->clk);
 err_clk:
-	video_unregister_device(viu_dev->vdev);
+	clk_disable_unprepare(viu_dev->clk);
 err_vdev:
-	v4l2_ctrl_handler_free(&viu_dev->hdl);
+	video_unregister_device(viu_dev->vdev);
+err_unlock:
 	mutex_unlock(&viu_dev->lock);
+err_hdl:
+	v4l2_ctrl_handler_free(&viu_dev->hdl);
+err_i2c:
 	i2c_put_adapter(ad);
+err_v4l2:
 	v4l2_device_unregister(&viu_dev->v4l2_dev);
-err:
+err_irq:
 	irq_dispose_mapping(viu_irq);
 	return ret;
 }


