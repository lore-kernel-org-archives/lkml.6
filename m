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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7C2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D02C20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 15:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejsOU/UC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbeLQPCm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 10:02:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37142 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbeLQPCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 10:02:40 -0500
Received: by mail-ed1-f68.google.com with SMTP id h15so11016957edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JlB+rWpX2l7xq65j0HhkPvjisgzb4JWkRe/PmxcwxH8=;
        b=ejsOU/UCxJ4RqAxHo8BhRLsjRTvAV0sKIKIrb5saZRQgGddtBkj6XFJbMAWHK+sRYR
         VSSFrAQ8QIlm9IMen6vnFHWVws7/gKTIFaDeXdUdJ03LG9mISp+4cM++LumP0htKeXdq
         A2LKAalXkXDVmH80bPWb6lwNn/aIjuS5fFfOBi6Q4ckfGF9K2FNgQ9SLegmekLFqt5wM
         2MHC9AB74e+8C9zAX3RZOgvTSUmmv1qPes9mrKinQTWyygR/jhEdbrjLiNKslEtIAnTG
         0fGHlI+6O+l+kMRaNku0O5oJUjumXOCYt7bsWvY+/7quEgFlcncsaE7FUXFm6ymbkv2M
         yHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JlB+rWpX2l7xq65j0HhkPvjisgzb4JWkRe/PmxcwxH8=;
        b=PZHyYaa2oN56j6Z6sU9I1YjBl1S6f6IGctLi5aTBFiNqCkvWd+NcCkdUzelZsQ1kkQ
         E9ZlQbEpR+KGnwoWgsjdH+hR5XwqtCQNMUZBNDyh3xCsIwYVphtgdmkpZJnarLOMvI5U
         X9FnAH06CZZME1BEcJ9laCoNb+4AUxyJkq403gtqzSlMTqJc5vjCSWcTs1IbEGrp4qyp
         zLNC45hTmEtSOSDNY16w5CYdsrb5Wuso0/HhUt5jPMOkxnLdCFpQWflNHK/HlWSqQiWr
         mgUUWC5L3DzvHRFV33VOhzbFzV+zPu6Ig/gGwY8n3ssb28xZM3kdh8pgoTFdayq7gZA3
         MwHw==
X-Gm-Message-State: AA+aEWbxVCjgIuvx1mQ04ny+yfxlcLrLAwJOgEHgSimk32rjn/5+jtbu
        iBv00iNUF1I+8V0vyCGU3aA=
X-Google-Smtp-Source: AFSGD/V5mzyf6wU1fBJk6LaAdKpPKeQSmpiBmyJWVFrOF+D6n4sSTpQe5U6btZ+c4g7mjNwH5rV1tw==
X-Received: by 2002:a50:d94a:: with SMTP id u10mr13036917edj.214.1545058958422;
        Mon, 17 Dec 2018 07:02:38 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id n16-v6sm1861799eja.6.2018.12.17.07.02.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 07:02:37 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 07/19] mailbox: hi6220: Use device-managed registration API
Date:   Mon, 17 Dec 2018 16:02:05 +0100
Message-Id: <20181217150217.32435-8-thierry.reding@gmail.com>
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

Cc: Leo Yan <leo.yan@linaro.org>
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

