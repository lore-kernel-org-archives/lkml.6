Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BB3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4199D20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz+JOj4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387679AbeLQPCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:02:39 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42231 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387645AbeLQPCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:37 -0500
Received: by mail-ed1-f67.google.com with SMTP id y20so4864302edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cE/VU6XiDgj53KRbAhtRMxwm+oX4ZAWJ5I/1EbrIbbk=;
        b=Bz+JOj4W89CR1XTrCIlp8a+Z0SLsIY9t34OUwwPx6erURWAjErf1gMoqNh2yWr4TZw
         Bf04hI7eRKLDBOtKRPlKxs0U0xn782f/fcbZT7Pif+8WcTo+aeAjubn9NSA4H4ehUnbx
         1hpUsX3lJN/TxZt1hu//9SeltAX1Y8roLDwS7otoWe979JOdA3TvgYqMuPG3asbQnsjP
         EMNpyhy9BhY6p+yH+AGgceUdEtOECLwfNWrSgpxgX9eI/Hre4DfX8C2d47aSwTM8dzx/
         oNtju0cus6Ls7wxw8nSkLCFGCKAF1xNizxq065sk2LCg9OarRROkPqrk6OKcM3ZHoJFY
         9GPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cE/VU6XiDgj53KRbAhtRMxwm+oX4ZAWJ5I/1EbrIbbk=;
        b=cupIGHNzoCxmwaxOuieV/Y5K3ugE7oF0OU29Xj1b7n861syZ9bqtbWQfX+pRuB8EXa
         iDZr5vXnEJqdbnkQEPx3/zMV4X5nA4P5I2jHPAy06RJmYtaYhI7vxFUwbEDIyl3h6eYM
         rFJdp9hP6zh/tQih9/uiWOCOLt6GtAVZj+pbkyyuJZg8er2lHUk+HpntrUcdu+RYbOXM
         frG2WKpVfyFrsZtazNrNT375V8GeJ42sSVmDRtN/pIl57l7LuEiWyUyFYZ18bDIPWH7e
         KxErajqUmsD3p88/p+tgklIJ9Y7uvk/UwWgl3xVULNNY99VUjUVFfKCNdkTogJb4cjv7
         Uzug==
X-Gm-Message-State: AA+aEWZ2IQ9LiWuU7GB95ehQGZbICoPf1VI0HsQhy3T59+jlp7SAEdbO
        DOQdduRZk2vDEymv2s50lYo=
X-Google-Smtp-Source: AFSGD/V1ZQvPlhqjmcdKt1QY6hc5ZS3x2O4u0F1uMSNn2h+7TY/PMRz4+HFUvV9uSisBL+baq0IRmA==
X-Received: by 2002:a17:906:3712:: with SMTP id d18-v6mr10382149ejc.126.1545058955788;
        Mon, 17 Dec 2018 07:02:35 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id l51sm3785705edb.36.2018.12.17.07.02.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:33 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>,
        Kaihua Zhong <zhongkaihua@huawei.com>,
        Ruyi Wang <wangruyi@huawei.com>, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 06/19] mailbox: hi3660: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:04 +0100
Message-Id: <20181217150217.32435-7-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181217150217.32435-1-thierry.reding@gmail.com>
References: <20181217150217.32435-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Kevin Wangtao <kevin.wangtao@hisilicon.com>
Cc: Kaihua Zhong <zhongkaihua@huawei.com>
Cc: Ruyi Wang <wangruyi@huawei.com>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/hi3660-mailbox.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index f9aed5d8f9f1..53f4bc2488c5 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -265,7 +265,7 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
 	for (ch = 0; ch < MBOX_CHAN_MAX; ch++)
 		chan[ch].con_priv = (void *)ch;
 
-	err = mbox_controller_register(&mbox->controller);
+	err = devm_mbox_controller_register(dev, &mbox->controller);
 	if (err) {
 		dev_err(dev, "Failed to register mailbox %d\n", err);
 		return err;
@@ -276,17 +276,8 @@ static int hi3660_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi3660_mbox_remove(struct platform_device *pdev)
-{
-	struct hi3660_mbox *mbox = platform_get_drvdata(pdev);
-
-	mbox_controller_unregister(&mbox->controller);
-	return 0;
-}
-
 static struct platform_driver hi3660_mbox_driver = {
 	.probe  = hi3660_mbox_probe,
-	.remove = hi3660_mbox_remove,
 	.driver = {
 		.name = "hi3660-mbox",
 		.of_match_table = hi3660_mbox_of_match,
-- 
2.19.1

