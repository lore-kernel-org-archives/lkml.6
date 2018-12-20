Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11963C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6EFB218C3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4fA7I9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387942AbeLTRUd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:33 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44774 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387923AbeLTRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id y56so2374881edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WsSnVBo8KJVkRT0Qz1vH8hLCjFF5IQ8192hboW8X5ek=;
        b=O4fA7I9B179pyeiNfNUBKyTW8gCMnYj/HEMrAVcafBrxWnGQpcLpj1y0GT8xiDfKY8
         iF+UHGPZbA0ESGPAapaRJBsUqGT+Zq1Y3RmFOPuctIMrPtwG7ymLdduWhGA8bfgCPORo
         ENEQBPs3xOe+pz5rdVt3OrdrGG5B0vTaqzEPkVbhTKFxTpIM0VxVY4wpqEP/uiTFdYC8
         qluef84jCN1Hbg66U52jB092LJtqtaGCVSomxW9AmBn6XA/POb9Dk+De8kICHQjdsRR8
         EZQL8SDmPW8tB47w7CbocJhCuxY7K1C+jzbLgcHFcnima1Fga/unG6cYiwci1prkujme
         xrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WsSnVBo8KJVkRT0Qz1vH8hLCjFF5IQ8192hboW8X5ek=;
        b=E09MVspWq3AojqA21ULhYVXoLF9A0IzfATKgCRmGOcagoJY8I41iS45FRSEDDZ0m9b
         DshcCSX3t5J2Li/SR3R2wmNUNCy8bUbOhZPZs/KLveRki8dPM+4GxC+VBaf+gm7vj7kj
         GOeJvP6eQl+6dGmutSEQe0/EPh4vj/LYY8kgyx1FWg3qCvYwsFAGURfwiLfNpONqrb9c
         QYpS9wHmXrB76RS400A104+0/2SSqxz2yW/TXg/Sl2dkkhWc6QT5H8+EfpSec2McHwt/
         jO6M4CSjUpvdnR+zuMUzxa3W0aa8K4FpkUadliKXyvRqQUewMsS2A+5Iuzd+oXlUNR9n
         vydw==
X-Gm-Message-State: AA+aEWaegZKs87jez7Aze9lAbTns8fElNzxV3SVn4zZA3PgmLfZ/DsZH
        6RKAj5MjNgmn6zDGDJmBMAU=
X-Google-Smtp-Source: AFSGD/WlDFiiUldvXSok29M4elNVJ+zqzXOLOeyiPiGCa0uYEiwu+D1GFu+VIL6ugo5PxCjDjrgzqA==
X-Received: by 2002:a50:c408:: with SMTP id v8mr17312134edf.144.1545326429761;
        Thu, 20 Dec 2018 09:20:29 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id o37sm6207778edc.32.2018.12.20.09.20.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:28 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v3 16/19] mailbox: qcom-apcs: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:59 +0100
Message-Id: <20181220172002.9016-17-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220172002.9016-1-thierry.reding@gmail.com>
References: <20181220172002.9016-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Get rid of some boilerplate driver removal code by using the newly added
device-managed registration API.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/qcom-apcs-ipc-mailbox.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
index aed23ac9550d..3cf2937be149 100644
--- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
+++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
@@ -91,7 +91,7 @@ static int qcom_apcs_ipc_probe(struct platform_device *pdev)
 	apcs->mbox.chans = apcs->mbox_chans;
 	apcs->mbox.num_chans = ARRAY_SIZE(apcs->mbox_chans);
 
-	ret = mbox_controller_register(&apcs->mbox);
+	ret = devm_mbox_controller_register(&pdev->dev, &apcs->mbox);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register APCS IPC controller\n");
 		return ret;
@@ -115,7 +115,6 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
 	struct qcom_apcs_ipc *apcs = platform_get_drvdata(pdev);
 	struct platform_device *clk = apcs->clk;
 
-	mbox_controller_unregister(&apcs->mbox);
 	platform_device_unregister(clk);
 
 	return 0;
-- 
2.19.1

