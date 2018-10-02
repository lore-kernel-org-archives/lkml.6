Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0301C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A129C20645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 23:10:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iRTfzzZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A129C20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeJCF4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:56:13 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:42264 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCF4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:56:13 -0400
Received: by mail-ot1-f74.google.com with SMTP id c21-v6so2556879otf.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 16:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/4s/uGgYRRDfIeiEH/wwc+WLllVoxTTEZLt3OAwHaYQ=;
        b=iRTfzzZhLJySyCiVpxnlOQ1q0L582tsA1ZgiVeqvQhWGC6xkf+ZX5MEsxWfN7C+DKt
         0xm/D65XF2yrCkucH7SQKBsDBF+uL99DdW9dV55DB81LKZ78DZTYiR0JbMR9d50wEcN+
         GL8a5UV2cgNm4FFVH49rorNmlNW07Ldq8S7G8MjxY3xh8pXS/L4sJgJzs/ATnj9YohYO
         bFXtKY71XSFC/iMvEmH7YItqGMcAWLKNXtJfo0c4wUTeDpmXRLzhhvScmnSV8Vur6YGG
         mI9C8lHFixuS9j59+2dZgmh4n8wftnqDLf3LM0RaZmeeu8SbXb3HLFtNPsZLS0uVreYt
         V96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/4s/uGgYRRDfIeiEH/wwc+WLllVoxTTEZLt3OAwHaYQ=;
        b=aeSb4+6i2DfwAgUCUK+7TYNY3HobhLEnW3DtcKM7crvlZyiQYH+ctnkEjwlEvRZEek
         hmDqXFamOlQFskG7HBUpMGeiBINa9PcQeKXt1NhJ6MPCGpTQXhanKZ6VLnANJjMS/vZS
         cWwflz4SToijAwTwANye1CMh2DMMasBabW5IBoIRWaz9fqNwgJPwGATwC560zxmFeUtn
         8fsIzTnY4nOUtY+/S75hamXtw8K6Q4m9aiOwL+TdaeXIjczUGTyHOAE1ZdFUMVSE7+MR
         ItO355kBC5txSuKPc4z16F3bSAG5Isd4o6CChMxpL7anNi8+e4XDihzCG7BpWXO6S2ke
         gulw==
X-Gm-Message-State: ABuFfohdxXQzUWssr4tS3stfhXIMOjnhwkOw2/u2eh8B+ap8RyNAeceQ
        R8XSK08+qtmuEujFWrKUwSR/l/Oc
X-Google-Smtp-Source: ACcGV62DERduSVLs7n51rroi1x+xysYWU/vIrru1hkfm5C5pp4v19mt4Sy6YfXO2ZIiJvK++ojWTGfWf
X-Received: by 2002:a9d:339b:: with SMTP id u27-v6mr13724531otc.55.1538521828556;
 Tue, 02 Oct 2018 16:10:28 -0700 (PDT)
Date:   Tue,  2 Oct 2018 16:10:22 -0700
Message-Id: <20181002231024.58408-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v2 01/15] platform: goldfish: pipe: Move the file-scope
 goldfish_interrupt_tasklet variable into the driver state
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

This is a series of patches to move mutable file-scope variables
into the driver state. This change will help to introduce another
version of the pipe driver (with different state) for the older
host interface or having several instances of this device.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v2:
 - Updated the commit message.

 drivers/platform/goldfish/goldfish_pipe.c | 24 +++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 56665e879e5a..ba9aede17d57 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -208,6 +208,9 @@ struct goldfish_pipe_dev {
 	int irq;
 	int version;
 	unsigned char __iomem *base;
+
+	/* an irq tasklet to run goldfish_interrupt_task */
+	struct tasklet_struct irq_tasklet;
 };
 
 static struct goldfish_pipe_dev goldfish_pipe_dev;
@@ -582,14 +585,14 @@ static struct goldfish_pipe *signalled_pipes_pop_front(
 	return pipe;
 }
 
-static void goldfish_interrupt_task(unsigned long unused)
+static void goldfish_interrupt_task(unsigned long dev_addr)
 {
 	/* Iterate over the signalled pipes and wake them one by one */
+	struct goldfish_pipe_dev *dev = (struct goldfish_pipe_dev *)dev_addr;
 	struct goldfish_pipe *pipe;
 	int wakes;
 
-	while ((pipe = signalled_pipes_pop_front(&goldfish_pipe_dev, &wakes)) !=
-			NULL) {
+	while ((pipe = signalled_pipes_pop_front(dev, &wakes)) != NULL) {
 		if (wakes & PIPE_WAKE_CLOSED) {
 			pipe->flags = 1 << BIT_CLOSED_ON_HOST;
 		} else {
@@ -605,7 +608,6 @@ static void goldfish_interrupt_task(unsigned long unused)
 		wake_up_interruptible(&pipe->wake_queue);
 	}
 }
-static DECLARE_TASKLET(goldfish_interrupt_tasklet, goldfish_interrupt_task, 0);
 
 /*
  * The general idea of the interrupt handling:
@@ -648,7 +650,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	tasklet_schedule(&goldfish_interrupt_tasklet);
+	tasklet_schedule(&dev->irq_tasklet);
 	return IRQ_HANDLED;
 }
 
@@ -800,9 +802,14 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 static int goldfish_pipe_device_init(struct platform_device *pdev)
 {
 	struct goldfish_pipe_dev *dev = &goldfish_pipe_dev;
-	int err = devm_request_irq(&pdev->dev, dev->irq,
-				goldfish_pipe_interrupt,
-				IRQF_SHARED, "goldfish_pipe", dev);
+	int err;
+
+	tasklet_init(&dev->irq_tasklet, &goldfish_interrupt_task,
+		     (unsigned long)dev);
+
+	err = devm_request_irq(&pdev->dev, dev->irq,
+			       goldfish_pipe_interrupt,
+			       IRQF_SHARED, "goldfish_pipe", dev);
 	if (err) {
 		dev_err(&pdev->dev, "unable to allocate IRQ for v2\n");
 		return err;
@@ -854,6 +861,7 @@ static int goldfish_pipe_device_init(struct platform_device *pdev)
 static void goldfish_pipe_device_deinit(struct platform_device *pdev)
 {
 	misc_deregister(&goldfish_pipe_miscdev);
+	tasklet_kill(&goldfish_pipe_dev.irq_tasklet);
 	kfree(goldfish_pipe_dev.pipes);
 	free_page((unsigned long)goldfish_pipe_dev.buffers);
 }
-- 
2.19.0.605.g01d371f741-goog

