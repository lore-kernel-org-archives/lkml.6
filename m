Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C18C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A59213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 17:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olIY4SGy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3A59213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbeJDAHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 20:07:24 -0400
Received: from mail-io1-f74.google.com ([209.85.166.74]:43993 "EHLO
        mail-io1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeJDAHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 20:07:23 -0400
Received: by mail-io1-f74.google.com with SMTP id w19-v6so6122482ioa.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kCzQhdQumjnoOCHQSFSh0FZe4DkfX7jadMesum4jW4A=;
        b=olIY4SGyXFC6hU28p7eVciyws6sHK22rLNNyrOH9D41XjsaIP1W57WbC2wLiFp1D1D
         /6+ySnMfY+jHBbuV4bOKYf6m8ak9reOsHCvdYeyv0ptoKowp/ORkdsCEUtI4yXJ8ZnLM
         RfMMBs4GsuIdBk6/Gqhv5Zhcbu1IcH/++wKPgBnfpoobAeq2hPsyZzmQjXMzuun8fdCN
         QH6YfbPOC/77zcXmUFN7/u0lMheuMr18wL0kzYDrfuxdInhFs07Cn6Au0IKXwYqo9bSV
         /sZey32zc3zlAWfO80f1x9zmFq82PEGlf4yYM5SBBv3MLz8BlvEiSLMOgSDGz66AF0Kt
         3v1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kCzQhdQumjnoOCHQSFSh0FZe4DkfX7jadMesum4jW4A=;
        b=lpflw7zb4BFDW7y2GrKIcVBRCuI87vnr4YvRxL10GZBexk7pTa1GwM19QyjSMlxT0b
         3epRy+GH6Ekb/bDlEkSEkPeoj9VbcfiCP8eCsT/BysAsCW7wAzkLjcmTSd/D9OGN9D4R
         OQ31LlslrEYbGBH7sYwm+0ZSDom6YWLXzixjoLfmxPj6KXao0+2AVN6PpB190LbNLgG6
         GkjlgilVyn9tmbO9wXvwDVjztZUjfFoTz9kobKtbx0W26JzJgEcfOZ/5Va/yPwOd89hn
         uqCSpTLOeptmDDIA8uDhsgRNzeyjNu8IKO3n6tqH3Yrav+XlDF146SVwWM5pB1TpOva7
         o1GQ==
X-Gm-Message-State: ABuFfojR7yQWyaQxYA8GYKwti95fsDP7LXT6wO/8YPqpX8qqNTErfrlh
        l7Vcq29qKANmwgMPwgcl/4PnB4V8
X-Google-Smtp-Source: ACcGV63vjCR/F7OT9wCRQHj+f18duWlmhQD2etK8MsFE5Xz9ZMq6HQyiSIwGc/9ZwHGMrjnk4tERvTiB
X-Received: by 2002:a24:8082:: with SMTP id g124-v6mr2030174itd.12.1538587085241;
 Wed, 03 Oct 2018 10:18:05 -0700 (PDT)
Date:   Wed,  3 Oct 2018 10:17:12 -0700
In-Reply-To: <20181003171720.169953-1-rkir@google.com>
Message-Id: <20181003171720.169953-7-rkir@google.com>
Mime-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
Subject: [PATCH v3 07/15] platform: goldfish: pipe: Return status from
 "deinit" since "remove" does not do much
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

This way deinit will have a chance to report an error.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
Changes in v3:
 - No change.
Changes in v2:
 - No change.

 drivers/platform/goldfish/goldfish_pipe.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/goldfish/goldfish_pipe.c b/drivers/platform/goldfish/goldfish_pipe.c
index 445c0c0c66c4..1822d4146778 100644
--- a/drivers/platform/goldfish/goldfish_pipe.c
+++ b/drivers/platform/goldfish/goldfish_pipe.c
@@ -888,13 +888,15 @@ static int goldfish_pipe_device_init(struct platform_device *pdev,
 	return 0;
 }
 
-static void goldfish_pipe_device_deinit(struct platform_device *pdev,
-					struct goldfish_pipe_dev *dev)
+static int goldfish_pipe_device_deinit(struct platform_device *pdev,
+				       struct goldfish_pipe_dev *dev)
 {
 	misc_deregister(&dev->miscdev);
 	tasklet_kill(&dev->irq_tasklet);
 	kfree(dev->pipes);
 	free_page((unsigned long)dev->buffers);
+
+	return 0;
 }
 
 static int goldfish_pipe_probe(struct platform_device *pdev)
@@ -941,8 +943,7 @@ static int goldfish_pipe_remove(struct platform_device *pdev)
 {
 	struct goldfish_pipe_dev *dev = platform_get_drvdata(pdev);
 
-	goldfish_pipe_device_deinit(pdev, dev);
-	return 0;
+	return goldfish_pipe_device_deinit(pdev, dev);
 }
 
 static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
-- 
2.19.0.605.g01d371f741-goog

