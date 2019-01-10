Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C8EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7AD20665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="J7SKdesZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbfAJM0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:26:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46029 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfAJM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:26:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so5220904pfd.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 04:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xmkcyMZKGPzMvMKxjtfmwiWNsAxxqPR66jDHmZbAgx0=;
        b=J7SKdesZLm6Y9+X6F2SsUmlo3xJzXD6shk9TFdntFYJZFwu+eCwEhAFHjhc5wmSEsm
         jbvAthFaklKJC+Z3Y78vA8b03Vv60Kcm8Txwoz4qjERSviQU1YXSC0o4tBfXDm96vYHp
         aemXD3QAeJnkKuq3CUrnnvJNosMSE1XFh2Yic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xmkcyMZKGPzMvMKxjtfmwiWNsAxxqPR66jDHmZbAgx0=;
        b=IjXdvFiKBZypCSEhO1SmUjXHAvwnnbRSsYbvBcp8NZJcnq0V6rAwJAHbnUr4XuStup
         TbX67BBfuJZMn5Nz9i0vHi59TfsiByWgWBV6qVbRE9DiBuoRyImrOHJnRAYmmL/bxv2F
         /gNTrH1xjRZdubnMLtKdKArt3amgFoXO80icewtgKUXUUito3H7Ph80TI0c8xM6ZWH1f
         0KZ9hdPZnankIibU7kmcfkBnWUbIgUIYRVqK37oV7+TVnObn5DUH8AQjDJhm4qEQmnBL
         DVmSinw6DGvMK09UoM5FUe4x1KvGGajK18RlcUnSi5WEw/cSKNgiqvdM/z6vTiWFCJga
         S/eg==
X-Gm-Message-State: AJcUukcA1yNyY48f0ISixzlK+peP95pRuEB0TO18vT3sCyUQcGnLYwxy
        +Tr1YiMyAlBBIAD1rc/c+U+BVw==
X-Google-Smtp-Source: ALg8bN6ioSM9jYGnCYQdKNpJXazspwjwMQTGCEdrWP6BYVLiUtGDe/IxVnpJkVVOu7MfHw5wn7hgOg==
X-Received: by 2002:a63:ea4f:: with SMTP id l15mr9028354pgk.102.1547123161238;
        Thu, 10 Jan 2019 04:26:01 -0800 (PST)
Received: from localhost.localdomain ([117.196.233.251])
        by smtp.gmail.com with ESMTPSA id m67sm142985541pfb.25.2019.01.10.04.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Jan 2019 04:26:00 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jens.wiklander@linaro.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        daniel.thompson@linaro.org, ard.biesheuvel@linaro.org,
        bhsharma@redhat.com, tee-dev@lists.linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 3/4] tee: add supp_nowait flag in tee_context struct
Date:   Thu, 10 Jan 2019 17:54:56 +0530
Message-Id: <1547123097-16431-4-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
References: <1547123097-16431-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag indicates that requests in this context should not wait for
tee-supplicant daemon to be started if not present and just return
with an error code. It is needed for requests which should be
non-blocking in nature like ones arising from TEE based kernel drivers
or any in kernel api that uses TEE internal client interface.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/supp.c | 10 +++++++++-
 drivers/tee/tee_core.c   |  2 ++
 include/linux/tee_drv.h  |  6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/supp.c b/drivers/tee/optee/supp.c
index 43626e1..92f56b8 100644
--- a/drivers/tee/optee/supp.c
+++ b/drivers/tee/optee/supp.c
@@ -88,10 +88,18 @@ u32 optee_supp_thrd_req(struct tee_context *ctx, u32 func, size_t num_params,
 {
 	struct optee *optee = tee_get_drvdata(ctx->teedev);
 	struct optee_supp *supp = &optee->supp;
-	struct optee_supp_req *req = kzalloc(sizeof(*req), GFP_KERNEL);
+	struct optee_supp_req *req;
 	bool interruptable;
 	u32 ret;
 
+	/*
+	 * Return in case there is no supplicant available and
+	 * non-blocking request.
+	 */
+	if (!supp->ctx && ctx->supp_nowait)
+		return TEEC_ERROR_COMMUNICATION;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
 		return TEEC_ERROR_OUT_OF_MEMORY;
 
diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 9ddb89e..5d6c317 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -105,6 +105,7 @@ static int tee_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
+	ctx->supp_nowait = false;
 	filp->private_data = ctx;
 	return 0;
 }
@@ -981,6 +982,7 @@ tee_client_open_context(struct tee_context *start,
 	} while (IS_ERR(ctx) && PTR_ERR(ctx) != -ENOMEM);
 
 	put_device(put_dev);
+	ctx->supp_nowait = true;
 	return ctx;
 }
 EXPORT_SYMBOL_GPL(tee_client_open_context);
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index ed16bf1..fe1a920 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -49,6 +49,11 @@ struct tee_shm_pool;
  * @releasing:  flag that indicates if context is being released right now.
  *		It is needed to break circular dependency on context during
  *              shared memory release.
+ * @supp_nowait: flag that indicates that requests in this context should not
+ *              wait for tee-supplicant daemon to be started if not present
+ *              and just return with an error code. It is needed for requests
+ *              that arises from TEE based kernel drivers that should be
+ *              non-blocking in nature.
  */
 struct tee_context {
 	struct tee_device *teedev;
@@ -56,6 +61,7 @@ struct tee_context {
 	void *data;
 	struct kref refcount;
 	bool releasing;
+	bool supp_nowait;
 };
 
 struct tee_param_memref {
-- 
2.7.4

