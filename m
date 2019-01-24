Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45939C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08BBE207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 13:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VrW4JPf/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfAXNLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 08:11:47 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38319 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfAXNLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 08:11:47 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so5177604lja.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 05:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=M5kM16zyd/EiORNWuO/i8/IoR4fv7qnZKxV0scf9zO0=;
        b=VrW4JPf/trBoEUxZFLak6MnFQ8yOzjvXFGiMb9sx4ubbFBi75cuglw5eeLfxqPelMv
         YDQn+65yjQci49S3NHEXhk0euqnRBJOmnh4MkX8rwNcftqwRL6HMR8JioMqEn77rhbdB
         Usa/rr9JJXzLGo+AIYKstriVHWDkesqk60pIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M5kM16zyd/EiORNWuO/i8/IoR4fv7qnZKxV0scf9zO0=;
        b=XJJZYbQ+w5S/tA5yg1cKYBeKhPwxgcRxAZlG9o1qkfCHMWZMhKrWvCn2buIgCWyDOo
         ouQkIPkpQt1h8SAEUAg6kdsz90PIzrfywMk32+6k/ARfRY2MGKFx9xT6BMOxk+1BCXuC
         BNZZupFbpU9oHpcnJPPcEjIrwRxKdjSqwqwEt7uMdxkASSdEhoARQMLIqR+miM0u6hht
         3bad/R0aYyVQFtfvdtllmogz5uQVweTvnR2Zo6obOa4AmVOn+JLiZOeITqlBSY7vTTwQ
         hdrFc+wy7NRgDcwAWIhBZJI70yiu139HOcTdaJM5zfwbR+8N3SERDTloCq19ZUgTkUUr
         jmYA==
X-Gm-Message-State: AJcUukcEg/BNWdK2EJ0F4RE4pwE8gRw97oFfdYgLFVT9vvI2VWVYcOwT
        etdJuiAJrA1Xif7Zo5ueWm9LLr1987I=
X-Google-Smtp-Source: ALg8bN6/8ayVgXcnEBPQ8Fuz4g3lfP7Kq2EuzDauja88HlWUbwnFuy8qiW726xfHyP5pgA9VqBr7Gg==
X-Received: by 2002:a2e:a0d5:: with SMTP id f21-v6mr5576293ljm.98.1548335503991;
        Thu, 24 Jan 2019 05:11:43 -0800 (PST)
Received: from localhost ([195.238.92.223])
        by smtp.gmail.com with ESMTPSA id 18-v6sm982144ljg.83.2019.01.24.05.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 05:11:42 -0800 (PST)
From:   Igor Opaniuk <igor.opaniuk@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tee-dev@lists.linaro.org
Cc:     jerome.forissier@linaro.org, jens.wiklander@linaro.org,
        prime.zeng@hisilicon.com, sumit.garg@linaro.org
Subject: [PATCH 1/1] tee: add cancellation support to client interface
Date:   Thu, 24 Jan 2019 15:11:41 +0200
Message-Id: <1548335501-7868-1-git-send-email-igor.opaniuk@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of cancellation request to the TEE kernel internal
client interface. Can be used by software TPM drivers, that leverage
TEE under the hood (for instance in TPM2.0 mobile profile), for requesting
cancellation of time-consuming operations (RSA key-pair generation etc.).

Signed-off-by: Igor Opaniuk <igor.opaniuk@linaro.org>
---
 drivers/tee/tee_core.c  | 12 ++++++++++++
 include/linux/tee_drv.h | 14 ++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 7b2bb4c..aba71a8 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -1027,6 +1027,18 @@ int tee_client_invoke_func(struct tee_context *ctx,
 }
 EXPORT_SYMBOL_GPL(tee_client_invoke_func);
 
+int tee_client_cancel_req(struct tee_context *ctx,
+			  u32 cancel_id,
+			  u32 session)
+{
+
+	if (!ctx->teedev->desc->ops->cancel_req)
+		return -EINVAL;
+	return ctx->teedev->desc->ops->cancel_req(ctx, cancel_id,
+						  session);
+}
+EXPORT_SYMBOL_GPL(tee_client_cancel_req);
+
 static int __init tee_init(void)
 {
 	int rc;
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 6cfe058..62a0b56 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -526,6 +526,20 @@ int tee_client_invoke_func(struct tee_context *ctx,
 			   struct tee_ioctl_invoke_arg *arg,
 			   struct tee_param *param);
 
+/**
+ * tee_client_cancel_req() - Request cancellation of the previous open-session
+ * or invoke-command operations in a Trusted Application
+ * @ctx:       TEE Context
+ * @arg:       Unique cancel request id
+ * @param:     Session id
+ *
+ * Returns < 0 on error else see @arg->ret for result.
+ */
+int tee_client_cancel_req(struct tee_context *ctx,
+			  u32 cancel_id,
+			  u32 session);
+
+
 static inline bool tee_param_is_memref(struct tee_param *param)
 {
 	switch (param->attr & TEE_IOCTL_PARAM_ATTR_TYPE_MASK) {
-- 
2.7.4

