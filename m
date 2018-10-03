Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A81C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A503A21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQlB6qUE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A503A21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbeJDAHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:11 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:36817 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:11 -0400
Received: by mail-qt1-f202.google.com with SMTP id u28-v6so5794354qtu.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=C004DOwT6NID5heV2WJGLPCnOGxQPBgCic5gZ0Jwtc0=;
        b=vQlB6qUEUMXLPsFDifHnuFrWDOZ9ryfey/Sr1EcdCbrWMc+e50dD6GKIRbM2g2kxTP
         TwXbqG8tITAhkr0NDihrSGMbK7b3ioAn4PKYwrgpbshY1nMfLlk9mt8rHZuL641XVBI2
         kt5K8c6zZkfeKlevYXly9ndeZFkfTA+LbbN067wgRn8/CJgbskeOGrxNMm+SSsJFme+U
         Aca/HVEwX6tpllFJ2zNMFpqfzFSmVUclQjQSkL8Cmlz2aQUbVRGB8RtsNpQqzBwvQms3
         limQRhJDU5nYNp2AkLC68fMqQkdwBvHrdcPr9jbArmcPI7RYdLdWLwh1FKSfN33dGFhw
         A0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=C004DOwT6NID5heV2WJGLPCnOGxQPBgCic5gZ0Jwtc0=;
        b=OaGuQyBOxL3wYFXSqHJQCHY4V1qICmy3AS+PHr/SvSVEo0emDBvETJ8ScmhCoQlpck
         B1XSesVsFNXxc7oVrwS6ErgxBfakdDjDa6hevqY6KF8klSt0Jbr/M3FLmv7Qi3+mGk7v
         YW8gS9yzysPkprneBPVPd8c6opyE+2rW4CYq/R/Y7XXykSlIV61vc4MD/jRpdkpwSMXs
         pN224ly4RPP6+Vkfhuuu29rxELownWKAYhcf693q7K9Zdua75QNHE1a5Ww0RiMhtBfum
         hqJ7uNKl6pzKFx2+jlHiWuYl9QeTd29UW7Ketb3VQxBku7jXWasx1adauiTJrAYXncm4
         aFcg==
X-Gm-Message-State: ABuFfohTdXFo1wQGef00YTqPYGmicBwqVUXv6ZxM48kPrVgQHbSav4bn
        ++MsiW68oyTCEH8y5kgkiRNskCJ+
X-Google-Smtp-Source: ACcGV62bBcbu+deCefwgIEF5DlWnlAEVvpDlbUm4JKy/ovE1u7Yg+GePWpRQkGQnxu5wPnChtSc4hLv8
X-Received: by 2002:aed:2541:: with SMTP id w1-v6mr1753017qtc.27.1538587073294;
 Wed, 03 Oct 2018 10:17:53 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:08 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-3-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 03/15] platform: goldfish: pipe: Move the file-scope
 goldfish_pipe_dev variable into the driver state
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

This is the last patch in the series of patches to move file-scope
variables into the driver state. This change will help to introduce
another version of the pipe driver (with different state) for the
older host interface or having several instances of this device.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - Updated the commit message.

 drivers/platform/goldfish/goldfish_pipe.c | 66 +++++++++++++----------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 8ca709b45e1f..4013832f38fb 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -169,6 +169,9 @@ struct goldfish_pipe {
  * waiting to be awoken.
  */
 struct goldfish_pipe_dev {
+	/* A magic number to check if this is an instance of this struct */
+	void *magic;
+
 	/*
 	 * Global device spinlock. Protects the following members:
 	 *  - pipes, pipes_capacity
@@ -215,8 +218,6 @@ struct goldfish_pipe_dev {
 	struct miscdevice miscdev;
 };
 
-static struct goldfish_pipe_dev goldfish_pipe_dev;
-
 static int goldfish_pipe_cmd_locked(struct goldfish_pipe *pipe,
 				    enum PipeCmdCode cmd)
 {
@@ -611,6 +612,9 @@ static void goldfish_interrupt_task(unsigned long dev_addr)
 	}
 }
 
+static void goldfish_pipe_device_deinit(struct platform_device *pdev,
+					struct goldfish_pipe_dev *dev);
+
 /*
  * The general idea of the interrupt handling:
  *
@@ -631,7 +635,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	struct goldfish_pipe_dev *dev = dev_id;
 
-	if (dev != &goldfish_pipe_dev)
+	if (dev->magic != &goldfish_pipe_device_deinit)
 		return IRQ_NONE;
 
 	/* Request the signalled pipes from the device */
@@ -683,6 +687,14 @@ static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
 	return id;
 }
 
+/* A helper function to get the instance of goldfish_pipe_dev from file */
+static struct goldfish_pipe_dev *to_goldfish_pipe_dev(struct file *file)
+{
+	struct miscdevice *miscdev = file->private_data;
+
+	return container_of(miscdev, struct goldfish_pipe_dev, miscdev);
+}
+
 /**
  *	goldfish_pipe_open - open a channel to the AVD
  *	@inode: inode of device
@@ -696,7 +708,7 @@ static int get_free_pipe_id_locked(struct goldfish_pipe_dev *dev)
  */
 static int goldfish_pipe_open(struct inode *inode, struct file *file)
 {
-	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
+	struct goldfish_pipe_dev *dev = to_goldfish_pipe_dev(file);
 	unsigned long flags;
 	int id;
 	int status;
@@ -804,9 +816,9 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 	writel(lower_32_bits(paddr), portl);
 }
 
-static int goldfish_pipe_device_init(struct platform_device *pdev)
+static int goldfish_pipe_device_init(struct platform_device *pdev,
+				     struct goldfish_pipe_dev *dev)
 {
-	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
 	int err;
 
 	tasklet_init(&dev->irq_tasklet, &goldfish_interrupt_task,
@@ -861,26 +873,29 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 		      dev->base + PIPE_REG_OPEN_BUFFER,
 		      dev->base + PIPE_REG_OPEN_BUFFER_HIGH);
 
+	platform_set_drvdata(pdev, dev);
 	return 0;
 }
 
-static void goldfish_pipe_device_deinit(struct platform_device *pdev)
+static void goldfish_pipe_device_deinit(struct platform_device *pdev,
+					struct goldfish_pipe_dev *dev)
 {
-	misc_deregister(&goldfish_pipe_dev.miscdev);
-	tasklet_kill(&goldfish_pipe_dev.irq_tasklet);
-	kfree(goldfish_pipe_dev.pipes);
-	free_page((unsigned long)goldfish_pipe_dev.buffers);
+	misc_deregister(&dev->miscdev);
+	tasklet_kill(&dev->irq_tasklet);
+	kfree(dev->pipes);
+	free_page((unsigned long)dev->buffers);
 }
 
 static int goldfish_pipe_probe(struct platform_device *pdev)
 {
-	int err;
 	struct resource *r;
-	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
+	struct goldfish_pipe_dev *dev;
 
-	/* not thread safe, but this should not happen */
-	WARN_ON(dev->base);
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
 
+	dev->magic = &goldfish_pipe_device_deinit;
 	spin_lock_init(&dev->lock);
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -895,10 +910,9 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	}
 
 	r = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!r) {
-		err = -EINVAL;
-		goto error;
-	}
+	if (!r)
+		return -EINVAL;
+
 	dev->irq = r->start;
 
 	/*
@@ -913,20 +927,14 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	if (WARN_ON(dev->version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
 
-	err = goldfish_pipe_device_init(pdev);
-	if (!err)
-		return 0;
-
-error:
-	dev->base = NULL;
-	return err;
+	return goldfish_pipe_device_init(pdev, dev);
 }
 
 static int goldfish_pipe_remove(struct platform_device *pdev)
 {
-	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
-	goldfish_pipe_device_deinit(pdev);
-	dev->base = NULL;
+	struct goldfish_pipe_dev *dev = platform_get_drvdata(pdev);
+
+	goldfish_pipe_device_deinit(pdev, dev);
 	return 0;
 }
 
-- 
2.19.0.605.g01d371f741-goog

