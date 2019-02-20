Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C89C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C32F72147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 06:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCfZdzVf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbfBTGCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 01:02:54 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:37779 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbfBTGCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 01:02:54 -0500
Received: by mail-pg1-f178.google.com with SMTP id q206so11318765pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 22:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=d6A0igDOsc3jNLySuAErsWHOJjhNYwodP/Hd1Anf35E=;
        b=lCfZdzVfUjOoBZ+L8AhBPSXnJxoCCXiZL2BEUhM0u/EDD5wRHimQtqgOVKdwAGdkAQ
         Q/oXwg6XKdb5HBpqN1JMFfKNQe3Aci1BcQO8YnMU+CDAnSNCTUyamtg7rPp/1wqvWbsI
         P0sW1zttfI77GPUv8JNKqWo6ssEN3oT8rGc+Px7yzx9311+98ohUXhTG0GSXvulA3B/g
         lRy4Vl7wfN6DdNoxzKljPaUgS3r7r2Zpyre01RJ7KAeNgfMXp+/zerRWN+knm+QbPHDJ
         uNLbESWIvEEsxf+c/la+zTkeLUQexa4kEL6gjivyE9Tj/wh7zQ4HEwT0XZ1W1Y29dwT6
         wcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=d6A0igDOsc3jNLySuAErsWHOJjhNYwodP/Hd1Anf35E=;
        b=Y/eeGKqndHtUZsooLVZzIPSLyCy1YjetN/Li+zh/hhAWvMz+H0yeeZSefAG+DmOHto
         0zoWmRIREQYVntyVYG7PcJTCTE/fobHwrP+2qv85pL4BF4erQbqkI5tXI6+94N9KkEjv
         Stb9E+jXFqZGa3IG7jlpVdj+OTCASlpcv0tDNLI+4PXdGs63AxGALf1CtDaUi1Fj42iP
         8XBtNORGoT9cxZ7bXyQH9rYPgMnIFn9iJ+mXVkIzdYxy6jKDzAAFDXiPi2GtdUJGCYnX
         J/0OELGsvZfj+ln5TKGb6Qcyvt7v1awY0jcaV/49tAFtIoGPAnL6D95Ec0/2u6/79tjk
         Bwlw==
X-Gm-Message-State: AHQUAuYr7dvKb3XW4bE0F+9UP2JfF7PwxmVNPhDVQjBqVd2i2PJKt8y+
        XjH+R/5iFQRIunUpSf3SCps4R2c3et8KHA==
X-Google-Smtp-Source: AHgI3Ibb7+OEMMx+PAtTLBwWXLV97iKaVhnzkebAn/EsMfiF5pX9uBo7SLQ3+kYLg/Npf9UoKhQNWg==
X-Received: by 2002:a63:5b1c:: with SMTP id p28mr27045620pgb.73.1550642573331;
        Tue, 19 Feb 2019 22:02:53 -0800 (PST)
Received: from localhost.localdomain ([117.252.69.94])
        by smtp.gmail.com with ESMTPSA id z1sm27945835pfi.155.2019.02.19.22.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Feb 2019 22:02:52 -0800 (PST)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     dan.carpenter@oracle.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH -next] tee: fix possible error pointer ctx dereferencing
Date:   Wed, 20 Feb 2019 11:32:27 +0530
Message-Id: <1550642547-21968-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add check for valid ctx pointer and then only dereference ctx to
configure supp_nowait flag.

Fixes: 42bf4152d8a7 ("tee: add supp_nowait flag in tee_context struct")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 25f3b9c..06fbfc0 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -993,7 +993,9 @@ tee_client_open_context(struct tee_context *start,
 	 * tee_client_open_session() if any in kernel client requires
 	 * different behaviour.
 	 */
-	ctx->supp_nowait = true;
+	if (!IS_ERR(ctx))
+		ctx->supp_nowait = true;
+
 	return ctx;
 }
 EXPORT_SYMBOL_GPL(tee_client_open_context);
-- 
2.7.4

