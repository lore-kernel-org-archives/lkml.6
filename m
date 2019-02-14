Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8436C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72C84222CC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ScyAGhls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405515AbfBNDm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:42:26 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33817 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404944AbfBNDm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:42:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so2384182plz.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 19:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bfm3jWDvojxl4h/7pRChbGYtUVXLGrujYPfTa9LbC1o=;
        b=ScyAGhls3ng3RiLeocqJ++ZJDTtZW+XdofrphWUZXX32QC6O+as4z0ZuUIUunx5Ucv
         6SwtWaVe5jPToEhhiKC5s0Te/QNpDmxjRHmsuLa9l7tR/N7uXX+7PQ17dk4xLaTXp7k5
         Grv2UYcisYPMp5flo6ey4HFodHNPPqBV9jgTwVUcOMZhCHr+cFfd56RL6PIbgZXPsouF
         feWFjwSp1w7djc/XhnCGtcQtSSnRyhky7AiePM9cCKmP4FH4mz6QNMS02LPSVKhGOKai
         v9FA1iM+4oMUfd/IKN0FBmBe7hPAhUSnJ/5gEFcQ6qzCB8GtuKS3DqtoMA7ovy77gn0G
         gNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bfm3jWDvojxl4h/7pRChbGYtUVXLGrujYPfTa9LbC1o=;
        b=X3R38Q3jodeGESLmUcmqe7FqiP7thUtbwX55Y/Oegs5doxuufZOYWX81aWWK7ZT0dV
         mPC1Z0WvD3iZ5XbCwkC5jcLYyScCivtinRs554Y3TGZICvMIqB3UnhgbCa1Tq+BWBnMR
         xmiMdgt5t1sgJPc1gzmxC8BSTqxZCXMpzDqRrfAK2qLNTlvKPayNfIrbjlopf7Vj/KKE
         sEHajihpjCtib+nLq6P0uCTe2YD5nc2UYGSH45yQjVxywq3V8MPU33Odk29gk4jYnla2
         oQsk6CCMnMNTbYoKrNGGb2l1BVOpP20B+25QAiR3nzIqrPxbQaxrdRD/eB3JAlA1Kzhn
         ETeA==
X-Gm-Message-State: AHQUAuYLUgA9nN/HcfV2xOBS86lQe8c1mYDtCeb984LQaTb6xc0VCdHc
        f4in0zwSi7VVAzmHiUzsN8tYdQ==
X-Google-Smtp-Source: AHgI3IbwZ2BO5EBOZC+IOng6pObmOcUfXGkT1zJA7/YhRr6FINSPb1w8uGawZLlHqNVBbKfXwi1csw==
X-Received: by 2002:a17:902:509:: with SMTP id 9mr1272107plf.94.1550115745749;
        Wed, 13 Feb 2019 19:42:25 -0800 (PST)
Received: from localhost.localdomain ([103.240.171.178])
        by smtp.gmail.com with ESMTPSA id 66sm1324772pfq.17.2019.02.13.19.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 19:42:25 -0800 (PST)
From:   Vaishali Thakkar <vaishali.thakkar@linaro.org>
To:     andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org,
        Vaishali Thakkar <vaishali.thakkar@linaro.org>
Subject: [PATCH 5/5] base: soc: Export soc_device_register/unregister APIs
Date:   Thu, 14 Feb 2019 09:12:18 +0530
Message-Id: <2b8b869e418f72c21c4657793fd75828768fed3a.1550114271.git.vaishali.thakkar@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1550114271.git.vaishali.thakkar@linaro.org>
References: <cover.1550114271.git.vaishali.thakkar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Qcom Socinfo driver can be built as a module, so
export these two APIs.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Vaishali Thakkar <vaishali.thakkar@linaro.org>
---
 drivers/base/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index b0933b9fe67f..7c0c5ca5953d 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -164,6 +164,7 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 out1:
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(soc_device_register);
 
 /* Ensure soc_dev->attr is freed prior to calling soc_device_unregister. */
 void soc_device_unregister(struct soc_device *soc_dev)
@@ -173,6 +174,7 @@ void soc_device_unregister(struct soc_device *soc_dev)
 	device_unregister(&soc_dev->dev);
 	early_soc_dev_attr = NULL;
 }
+EXPORT_SYMBOL_GPL(soc_device_unregister);
 
 static int __init soc_bus_register(void)
 {
-- 
2.17.1

