Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75330C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9B820645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tr+JBwTO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9B820645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJCF4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:56:22 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:55084 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCF4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:56:21 -0400
Received: by mail-io1-f74.google.com with SMTP id l24-v6so3837354iok.21
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bt808xPWO7iokz7xZhNlvRo4FLNGh72DZpv+hDCmUM8=;
        b=tr+JBwTOplqP2n9fMrWezCjwOF7lICu7g4m7P1mnAlDH+8ie5swu5Zs7YcNtxPHpRE
         iUu6Ys/YiCNmbTBdDw7THsce621ROrGFbdhpgTl7+qvoa7QmAkDnCL9xSeY+VnJ1FDNd
         tuOK9OosWAgyybJPz1Zz4k2qED65OhjuuiF+zoX+yyGBS2XQxfQd+nfNr+nFot7wwqlv
         ch1g3dRke8vvUZ5wackzI/SwFrPHsrY5bxacyVeAqfuEVDSKGMkLaowplD7Vsl0au5ot
         5okFRxF/Ir5eaSPzhb870Bwy7dOrnKGgkldExbRhk7f3YWS26TSNI/phekKnM0hJBGqk
         PGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bt808xPWO7iokz7xZhNlvRo4FLNGh72DZpv+hDCmUM8=;
        b=r/JkNn198VCdSvr2KvZDTlwystAtAgdq5VResoAVe91RXijSBztU9AAUDwp0BVO7dw
         wL34/zhwo1prJt8qS76z2mmB5JQGnG6F+m/SQZGY3EOwbx1g3knTXGqDvDfAtB9wLdT0
         tRVfkvzOQ6D50I+9D7xHMB/wdAOCJD8gKkf70gwMi4h+wgsqCc+xSAsgLNkKlwX6wHcm
         K0uCHYKHYBhd2kU0A7q5XiywBeRubbDNbOM15CHzAqHNEsnpnE8b0OeGtiLFh4sdxIWu
         FhMBTWDAkS7P2RL72C0ylxqC1umdpW/SRYmzyioHgN3iT/t00OIyzvDXAAY1NrwUcWnA
         WO5w==
X-Gm-Message-State: ABuFfog38Y+vTHl5zgcO7mK1A01J8nZ1BoDxSM+2aYWn8TVfehxDdOgN
        7Snpm0JyDwCsqVfuCefbL16jM+nn
X-Google-Smtp-Source: ACcGV60FyZJSRxgs7pOSTI4Vj0xtaiuvu3BqXaBLpL91HPyomgo9qSnjqy+NOx/i4WhcxhUFn/mL1ruM
X-Received: by 2002:a24:8306:: with SMTP id d6-v6mr3547242ite.24.1538521836077;
 Tue, 02 Oct 2018 16:10:36 -0700 (PDT)
Date:   Tue,  2 Oct 2018 16:10:24 -0700
In-Reply-To: <20181002231024.58408-1-rkir@google.com>
Message-Id: <20181002231024.58408-3-rkir@google.com>
Mime-Version: 1.0
References: <20181002231024.58408-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 03/15] platform: goldfish: pipe: Move the file-scope
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

