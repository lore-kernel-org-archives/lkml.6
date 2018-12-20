Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD7C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29215217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9QlpD0k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387875AbeLTRUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:23 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35300 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733095AbeLTRUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id x30so2414407edx.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNOq9HM7IIA51VZQh4SQRXR3S46Yykx0FsGqyc+V3QU=;
        b=l9QlpD0kNQpR7aGvhnFsJNmFij0Yo4Xw04UDcj5ID+YlpscjYb6RO6/1PE8ikQA3Bb
         Ln+t4oMyvLYQ69N9KGFrdYVX9AEHQfyq6KQkUX7qyr5NK6TwcFiCSeklHNtZ5sCcPDqH
         ppSHjAS1oDhsoAfl/0LKOpYr7PFT6/adG/MXdvTz++ztAYPcnoZmWs0M6OFJiU5m/JYd
         yWk0hClNc6Jo/etr85Q/zHJBAP+4guB/jQeN83OE5GjNhrFWXFMQJqEoOyEqucUIi5xi
         cSUXReYzmuzMz3EYUtjn00UcNepv/UylL5b6UOh3xKuK4vSGFqW9RICGUMyS76STThIK
         uZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNOq9HM7IIA51VZQh4SQRXR3S46Yykx0FsGqyc+V3QU=;
        b=hb/w9FNmMS3r93RIjuSToi4EGL8w1bEg2p0c7M8a0EbawfL1BGIFSwj3c613dds5FH
         xfsdTl5vDkQq2+0nmNMEMrOeobIO9rVDbLFKpDg53ie5NWC6lJWt9gGKwZumeKE//l+C
         3IUYR/cTLb3PXePys6/5f48nqgxIA49Qbum2VROijTbbvdlYxAY3L94kbfrPqIgjNZeU
         2cNzHrcFrPSKk6CLKtO7HRvYC4mvGxLusA3HdHOWixdo0CXzQUCadaF4U0MOh/zPCqFU
         6H3eLlbttmMuEBmg6OkAqqUjzDYGaLdIP/gvJ6TqOD21LmfLgvE38cyCdww8r3pDWFmm
         eAUQ==
X-Gm-Message-State: AA+aEWZjkFjNRJeBqEQnHa+bVgZtswZXGcwd+WHMsV3uhenX4t14ybuV
        vY5Dpj5QjrYpVC6N+9lABV8=
X-Google-Smtp-Source: AFSGD/U1o2hGc9JPZWQsgkhg/fReE/iRKSRdElR9VVg6eday1u+7XdGI68id7K6ayliFmhzRzJhZsg==
X-Received: by 2002:a50:875d:: with SMTP id 29mr20106091edv.100.1545326418812;
        Thu, 20 Dec 2018 09:20:18 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id 24sm6326843eds.97.2018.12.20.09.20.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:18 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v3 09/19] mailbox: altera: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:52 +0100
Message-Id: <20181220172002.9016-10-thierry.reding@gmail.com>
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

Cc: Ley Foon Tan <lftan@altera.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/mailbox-altera.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/mailbox/mailbox-altera.c b/drivers/mailbox/mailbox-altera.c
index bcb29df9549e..397e25ddae29 100644
--- a/drivers/mailbox/mailbox-altera.c
+++ b/drivers/mailbox/mailbox-altera.c
@@ -341,7 +341,7 @@ static int altera_mbox_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = mbox_controller_register(&mbox->controller);
+	ret = devm_mbox_controller_register(&pdev->dev, &mbox->controller);
 	if (ret) {
 		dev_err(&pdev->dev, "Register mailbox failed\n");
 		goto err;
@@ -352,18 +352,6 @@ static int altera_mbox_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int altera_mbox_remove(struct platform_device *pdev)
-{
-	struct altera_mbox *mbox = platform_get_drvdata(pdev);
-
-	if (!mbox)
-		return -EINVAL;
-
-	mbox_controller_unregister(&mbox->controller);
-
-	return 0;
-}
-
 static const struct of_device_id altera_mbox_match[] = {
 	{ .compatible = "altr,mailbox-1.0" },
 	{ /* Sentinel */ }
@@ -373,7 +361,6 @@ MODULE_DEVICE_TABLE(of, altera_mbox_match);
 
 static struct platform_driver altera_mbox_driver = {
 	.probe	= altera_mbox_probe,
-	.remove	= altera_mbox_remove,
 	.driver	= {
 		.name	= DRIVER_NAME,
 		.of_match_table	= altera_mbox_match,
-- 
2.19.1

