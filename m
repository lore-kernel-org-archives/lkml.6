Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE0DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3BB217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZC3K39gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388046AbeLTRVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:21:36 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45566 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387824AbeLTRUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:17 -0500
Received: by mail-ed1-f68.google.com with SMTP id d39so2371584edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fobWK4n17T67GMuE/BvlycKahsSdAvw/9nNI3xEAREQ=;
        b=ZC3K39grRdu0iDfSKR/QjuaW+L/muz5vPV2g/Eg9hdq6S5c/r6LyMqj3LFc22qmAns
         SsxVC3L/bJjA40U+Fy6zP/8PZ4hgwG5Aa2/bpdGjsBsYAA/FUw323Ju1Pa4MFuKMSQb5
         aBjWOSqIu6J1v0TVezVdtSWLHgCi5BiK9xpEyLXb5CZlXbDTNsOYOsyG3hUjnq2skT2O
         GA/bg4FaJEyB+guiYF+tlq+eWjaac4v/ll+8WS9r5vo9SV4m7ux3BtE4UxPIaCOmurOO
         BK2Kq4COro8EC+e9UFApoDIiu1EOEMOsaDKJOX2qRXODL1MjFk9y+GyknBY6nXi+WrBR
         kYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fobWK4n17T67GMuE/BvlycKahsSdAvw/9nNI3xEAREQ=;
        b=FNQhOmEVuuqK37v16FL2hjHYQQD0QX7ctdr1pl4aOaRrwSN8ZL5yQPR6ZLvti/y8Ko
         WrOs6QJUv6j+2tGPauJ8YHObx4LPHUvrzSFk3hm53FOc6lJjtnY/F9YGvdOEr7vzZb0g
         WYei0IfjVQMFxNByczmL2YwkarPbVLhE2mCWt6bILlpzy3FEd0aUqULf/voBjSXN8fLB
         m46l4Gooe6htG/qlyVhp6TZjhnRgM2hsZz/tCCN2XetFRuHhh7nyJW4bafJ2VZdgVtVl
         69PFXGC/TOxX+rYd6+aFMkTrKR/rytTKKPBD54HdweTrxMcT1aU+o/2IHkI1Ku2avhK9
         xDRg==
X-Gm-Message-State: AA+aEWZ7jIiF7fzoN2AF4/R+A9sKJ6eRTB7DeR18pbXVnitWbqVrhJg/
        f+YlTNy52H083+ZiGjOcgHE=
X-Google-Smtp-Source: AFSGD/XTMc8ZlVu2Movu/VjrpnhPJxaeX9g721ZOQF1KZNGAkSgStJw90Ex3TdcGuxkUCjx42MMnPw==
X-Received: by 2002:a17:906:d41:: with SMTP id r1-v6mr19753413ejh.186.1545326415690;
        Thu, 20 Dec 2018 09:20:15 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id h11-v6sm3267102ejc.3.2018.12.20.09.20.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:15 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 07/19] mailbox: hi6220: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:50 +0100
Message-Id: <20181220172002.9016-8-thierry.reding@gmail.com>
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

Cc: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/hi6220-mailbox.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/mailbox/hi6220-mailbox.c b/drivers/mailbox/hi6220-mailbox.c
index 4fa9803cd204..c32cbfaf223a 100644
--- a/drivers/mailbox/hi6220-mailbox.c
+++ b/drivers/mailbox/hi6220-mailbox.c
@@ -349,7 +349,7 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
 		mbox->controller.txpoll_period = 5;
 	}
 
-	err = mbox_controller_register(&mbox->controller);
+	err = devm_mbox_controller_register(dev, &mbox->controller);
 	if (err) {
 		dev_err(dev, "Failed to register mailbox %d\n", err);
 		return err;
@@ -360,14 +360,6 @@ static int hi6220_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int hi6220_mbox_remove(struct platform_device *pdev)
-{
-	struct hi6220_mbox *mbox = platform_get_drvdata(pdev);
-
-	mbox_controller_unregister(&mbox->controller);
-	return 0;
-}
-
 static struct platform_driver hi6220_mbox_driver = {
 	.driver = {
 		.name = "hi6220-mbox",
@@ -375,7 +367,6 @@ static struct platform_driver hi6220_mbox_driver = {
 		.of_match_table = hi6220_mbox_of_match,
 	},
 	.probe	= hi6220_mbox_probe,
-	.remove	= hi6220_mbox_remove,
 };
 
 static int __init hi6220_mbox_init(void)
-- 
2.19.1

