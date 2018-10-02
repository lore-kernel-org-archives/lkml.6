Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E895AC64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A721F20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JuXNfmXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A721F20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbeJCFGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:06:23 -0400
Received: from mail-vk1-f202.google.com ([209.85.221.202]:43517 "EHLO
        mail-vk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:06:22 -0400
Received: by mail-vk1-f202.google.com with SMTP id r11-v6so842486vke.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x4wSw6xf1XRnq0lS/nECfCGfJyirDBwNxRG/QeNClV8=;
        b=JuXNfmXfsiO2jTdtpw/+6ukxSIDiPIl5hSDCMSjx8uXkwwiYhxbnXkCA3DdbIrN6nr
         f50TBUpfsR6UON1gdWQDd6JsOuau0Ul7r/blwryed/PXbw03MoUeibX3CbPM38cSaLjT
         JnG/Llh9mYIaSGgiVrtJ/uclXl4/evs9JYiCOfaBNfCn2on4CUzzWizH0+YigCRZseDx
         yh2QUpYY4PD23e6UAEc5rM03eIYuPD6+wiDjgcfiEFYyc+VTtlrtNC6f0LKU1lP9U/5/
         Zom2LPMDzrI+AlKxY/OUfyHK/BXBLxX8v7rQC7okwkXdTmoZqNnqwRuJT1mK++dEFf7T
         MS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x4wSw6xf1XRnq0lS/nECfCGfJyirDBwNxRG/QeNClV8=;
        b=dgM+WjjoFsuh5fd8tpZKEIdC/dKU/XPZNJPs78W7GRjoN8ecyqJ+IV5Rx2A8bzXfG2
         1Pqac1yEVUgBThTIN2Mf5Gj1jxUItYHnFEBo4PwRv/XPYF0mBKD4EFlkKkuoHIRmYRLW
         S4l8F7STZAUgq1FBhNt/9UAI9iNQP5W48nFKx7gDgItEqOTRC8H+Rw2wqLTFbZ4cgHkx
         s1bZmU1iSZmnopOp1ybrO7gQ06ycuO5zUp3JzeiXLcQ+HX4yX9JoBcapMA6jqb0ngQqN
         iAFqEoVab/sEEa1DGqAzAeU2zX7jukm/HGN2HHWzvp1ldQa8MQsl6IP7lleeCwqEzKzl
         UEPw==
X-Gm-Message-State: ABuFfoi3hrouuAEl7wVNyPWo8Kw1nR7Q7vm/fTZwitHe4jBh5nLZ/Dbt
        y4Xi9BhI/Tq7n07S5ravrqSycLwY
X-Google-Smtp-Source: ACcGV63XsT8s6slcbDBhaQ/h/R5APqQ8m4L7hSM1276PBA8CeHA6WDL7mLUj29JkVA5jaztFuWe51aG4
X-Received: by 2002:ab0:2102:: with SMTP id d2-v6mr17506777ual.6.1538518847237;
 Tue, 02 Oct 2018 15:20:47 -0700 (PDT)
Date:   Tue,  2 Oct 2018 15:19:00 -0700
In-Reply-To: <20181002221903.19476-1-rkir@google.com>
Message-Id: <20181002221903.19476-12-rkir@google.com>
Mime-Version: 1.0
References: <20181002221903.19476-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH 12/15] platform: goldfish: pipe: Rename the init function (add "v2")
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

This is the v2 driver. v1 will be added later.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/platform/goldfish/goldfish_pipe.c    | 2 +-
 drivers/platform/goldfish/goldfish_pipe_v2.c | 6 +++---
 drivers/platform/goldfish/goldfish_pipe_v2.h | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 792b20bdf76c..7b0920e962eb 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -87,7 +87,7 @@ static int goldfish_pipe_probe(struct platform_device *pdev)
 	if (WARN_ON(version < PIPE_CURRENT_DEVICE_VERSION))
 		return -EINVAL;
 
-	return goldfish_pipe_device_init(pdev, base, irq);
+	return goldfish_pipe_device_v2_init(pdev, base, irq);
 }
 
 static int goldfish_pipe_remove(struct platform_device *pdev)
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.c b/drivers/platform/goldfish/goldfish_pipe_v2.c
index 641dfdcc3ffd..9857ce07d0e6 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.c
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.c
@@ -787,9 +787,9 @@ static void write_pa_addr(void *addr, void __iomem *portl, void __iomem *porth)
 	writel(lower_32_bits(paddr), portl);
 }
 
-int goldfish_pipe_device_init(struct platform_device *pdev,
-			      char __iomem *base,
-			      int irq)
+int goldfish_pipe_device_v2_init(struct platform_device *pdev,
+				 char __iomem *base,
+				 int irq)
 {
 	struct goldfish_pipe_dev *dev;
 	int err;
diff --git a/drivers/platform/goldfish/goldfish_pipe_v2.h b/drivers/platform/goldfish/goldfish_pipe_v2.h
index 03b476fb9978..70bf4ec1fd66 100644
--- a/drivers/platform/goldfish/goldfish_pipe_v2.h
+++ b/drivers/platform/goldfish/goldfish_pipe_v2.h
@@ -3,8 +3,8 @@
 #define GOLDFISH_PIPE_V2_H
 
 /* The entry point to the pipe v2 driver */
-int goldfish_pipe_device_init(struct platform_device *pdev,
-			      char __iomem *base,
-			      int irq);
+int goldfish_pipe_device_v2_init(struct platform_device *pdev,
+				 char __iomem *base,
+				 int irq);
 
 #endif /* #define GOLDFISH_PIPE_V2_H */
-- 
2.19.0.605.g01d371f741-goog

