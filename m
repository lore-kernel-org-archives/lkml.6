Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0DAC64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AB0021470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hbdsl511"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AB0021470
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbeJDAHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:44 -0400
Received: from mail-it1-f202.google.com ([209.85.166.202]:42358 "EHLO
        mail-it1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:43 -0400
Received: by mail-it1-f202.google.com with SMTP id v125-v6so7600147ita.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oPChP9l9i8MBH2H+Y9t1MvQr9pTaos7oxN7Ke0Uax60=;
        b=Hbdsl511QQfMzVz9PJnZeyNZo8QWv6fcAhDQRuJGYaNSe+i9rxN4q6LGp7FRkY/LUt
         Wt1d3Q2hoOAoviFDicWcrM3MzAnZ5Pv/kgW5fuTsMSDnqZMfWu1VvfuCRnSYHriDAVz1
         lQOMcA2+C2jFEbzJ6bMAhXtaZ93rtACrskWZeORbcTqd9Xr+gwj97xJa1gSjpNtvf8GW
         KZFPmOjzqU5wdowCJF/qFUz8+Rammvf+1yQiXuDdkOngk0/wgSG6/eeH6EXQ3y6hWVSW
         DSfub1JFR1H0uZt/CcxqjjN7JdzuZIeEOJQmX1klPllXETMC3jKSTA6zwz+n7+dEyiqa
         BnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oPChP9l9i8MBH2H+Y9t1MvQr9pTaos7oxN7Ke0Uax60=;
        b=qNOIqxAcR8MqT+Y0T5JZmuc12N22WsZbYbzJlDebnjXKr3P4U/Ec2MsChpqgrljMQv
         +hiAhCsQTfkoM00NuuYapxZCeecUV2/efuM0TO5wG1mCQqTNv8i33AkQUbc9xItpwJCi
         +M4gDo71fe2rqYE5YqbRxxpLmsrNXW5bnihMA5Z0G/SsUO/pq9cmlGRW3xQK+xiOO8f6
         OdYnJam89mJFWICQUvB0P70DLoIQ0ixCyvdQJV6o2Qt5u51Uyj6yzseTpFPQVaJ1Gci/
         aD5kWRrAAc6hPmMCKZ6T2raTat8Q4FKWeezQ0gwQSa+94jdgBEx34cdM6j8fwocYNksi
         2a5g==
X-Gm-Message-State: ABuFfoizZKo1iLIVDxB6IX2A8Qzt0wTMiMif7BkxNXdGYvU6AtFvLR1k
        jZCgy+tlUFNaljKRdFPEudOavQkc
X-Google-Smtp-Source: ACcGV61BS5Oysmcq3FYLHlorm6oZwmQcGMamejikOSBlLnSDSnsQjEzWBAIWqFt7rOlAJZsiQ5xVDXIj
X-Received: by 2002:a24:d7:: with SMTP id 206-v6mr2107809ita.17.1538587104643;
 Wed, 03 Oct 2018 10:18:24 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:19 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-14-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 14/15] platform: goldfish: pipe: Rename PIPE_REG to PIPE_V2_REG
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

PIPE_V1_REG will be introduced later for v1 support.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/goldfish_pipe.c      |  4 ++--
 drivers/platform/goldfish/goldfish_pipe_qemu.h | 18 +++++++++---------
 drivers/platform/goldfish/goldfish_pipe_v2.c   | 16 ++++++++--------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 7b0920e962eb..353f7ce94aa7 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -81,8 +81,8 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	 *  reading device version back: this allows the host implementation to
 	 *  detect the old driver (if there was no version write before read).
 	 */
-	writel(PIPE_DRIVER_VERSION, base + PIPE_REG_VERSION);
-	version = readl(base + PIPE_REG_VERSION);
+	writel(PIPE_DRIVER_VERSION, base + PIPE_V2_REG_VERSION);
+	version = readl(base + PIPE_V2_REG_VERSION);
 
 	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
diff --git a/drivers/platform/goldfish/goldfish_pipe_qemu.h b/drivers/platform/goldfish/goldfish_pipe_qemu.h
index b4d78c108afd..24b02710769f 100644
--- a/drivers/platform/goldfish/goldfish_pipe_qemu.h
+++ b/drivers/platform/goldfish/goldfish_pipe_qemu.h
@@ -62,19 +62,19 @@ enum PipeFlagsBits {
 	BIT_WAKE_ON_READ   = 2,  /* want to be woken on reads */
 };
 
-enum PipeRegs {
-	PIPE_REG_CMD = 0,
+enum PipeV2Regs {
+	PIPE_V2_REG_CMD = 0,
 
-	PIPE_REG_SIGNAL_BUFFER_HIGH = 4,
-	PIPE_REG_SIGNAL_BUFFER = 8,
-	PIPE_REG_SIGNAL_BUFFER_COUNT = 12,
+	PIPE_V2_REG_SIGNAL_BUFFER_HIGH = 4,
+	PIPE_V2_REG_SIGNAL_BUFFER = 8,
+	PIPE_V2_REG_SIGNAL_BUFFER_COUNT = 12,
 
-	PIPE_REG_OPEN_BUFFER_HIGH = 20,
-	PIPE_REG_OPEN_BUFFER = 24,
+	PIPE_V2_REG_OPEN_BUFFER_HIGH = 20,
+	PIPE_V2_REG_OPEN_BUFFER = 24,
 
-	PIPE_REG_VERSION = 36,
+	PIPE_V2_REG_VERSION = 36,
 
-	PIPE_REG_GET_SIGNALLED = 48,
+	PIPE_V2_REG_GET_SIGNALLED = 48,
 };
 
 enum PipeCmdCode {
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index 0e2a62322477..c99317548128 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -197,7 +197,7 @@ static int goldfish_pipe_cmd_locked(struct goldfish_pipe *pipe,
 	pipe->command_buffer->cmd = cmd;
 	/* failure by default */
 	pipe->command_buffer->status = PIPE_ERROR_INVAL;
-	writel(pipe->id, pipe->dev->base + PIPE_REG_CMD);
+	writel(pipe->id, pipe->dev->base + PIPE_V2_REG_CMD);
 	return pipe->command_buffer->status;
 }
 
@@ -214,7 +214,7 @@ static int goldfish_pipe_cmd(struct goldfish_pipe *pipe, enum PipeCmdCode cmd)
 
 /*
  * This function converts an error code returned by the emulator through
- * the PIPE_REG_STATUS i/o register into a valid negative errno value.
+ * the PIPE_V2_REG_STATUS i/o register into a valid negative errno value.
  */
 static int goldfish_pipe_error_convert(int status)
 {
@@ -611,7 +611,7 @@ static irqreturn_t goldfish_pipe_interrupt(int irq, void *dev_id)
 	/* Request the signalled pipes from the device */
 	spin_lock_irqsave(&dev->lock, flags);
 
-	count = readl(dev->base + PIPE_REG_GET_SIGNALLED);
+	count = readl(dev->base + PIPE_V2_REG_GET_SIGNALLED);
 	if (count == 0) {
 		spin_unlock_irqrestore(&dev->lock, flags);
 		return IRQ_NONE;
@@ -847,15 +847,15 @@ int goldfish_pipe_device_v2_init(struct platform_device *pdev,
 
 	/* Send the buffer addresses to the host */
 	write_pa_addr(&dev->buffers->signalled_pipe_buffers,
-		      dev->base + PIPE_REG_SIGNAL_BUFFER,
-		      dev->base + PIPE_REG_SIGNAL_BUFFER_HIGH);
+		      dev->base + PIPE_V2_REG_SIGNAL_BUFFER,
+		      dev->base + PIPE_V2_REG_SIGNAL_BUFFER_HIGH);
 
 	writel(MAX_SIGNALLED_PIPES,
-	       dev->base + PIPE_REG_SIGNAL_BUFFER_COUNT);
+	       dev->base + PIPE_V2_REG_SIGNAL_BUFFER_COUNT);
 
 	write_pa_addr(&dev->buffers->open_command_params,
-		      dev->base + PIPE_REG_OPEN_BUFFER,
-		      dev->base + PIPE_REG_OPEN_BUFFER_HIGH);
+		      dev->base + PIPE_V2_REG_OPEN_BUFFER,
+		      dev->base + PIPE_V2_REG_OPEN_BUFFER_HIGH);
 
 	platform_set_drvdata(pdev, dev);
 	return 0;
-- 
2.19.0.605.g01d371f741-goog

