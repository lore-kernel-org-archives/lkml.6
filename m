Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1F0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA87B217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4QxjNC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbeLTRVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:21:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44728 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbeLTRUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:09 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so2373935edd.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DvIlnbOfmNRaaSFhv0dATMqXe/B3z0+hPYy8eaSe4VM=;
        b=Y4QxjNC7MBMenbN0zUeBmAnQ5BwNpJNxHewya03/qRY6LG/isdmc7sX0MR+JrHRYkI
         KPnBTgAjB4Pe05uNesESAH4oot7m0uUKDZdjcCjeJEUorHxqj6V7EHePGSSszHKXMYSk
         c7Xec2ZSRNvlbxH+yrV6BCYRjddp0zqlyvlrCb+Dl1rbtvF5jxUMSIjVVBHFYxrgMhUk
         XPJZAPRCOqbiCFCdOxgZgy42RmAEN4c0UpyfJe8xRKQD8OQcaIf7VDw6MiP5u1w/Q7DU
         doi8cPL9doL9hCJiQRTW7TA4ZMWmJwiioitPgSR2GoNyI6z6BNNCQKm9ta2fI6IHfVWs
         Vtig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DvIlnbOfmNRaaSFhv0dATMqXe/B3z0+hPYy8eaSe4VM=;
        b=G7iHrevI+0Kt/xCtLmVElZFKAn4xTRe199mCWqpJw/BdyEgDbZuarPIdStvmc6kIbj
         MZCkLVwNwJr5LDLB0TLdW1/5WZJLJjEfyLRRyCvLhF8YrdCywijfd73A+P6eQnXWY6aJ
         HMYvOfGzyH13FBV90pcqkpMhDucPVPuiLSDvfuFN9EtnFYX5zIT95zW2eHSBcaQ5bwm1
         vQ/TaIt/9bzx7PsOffUTKJ49+MXkcUYNuY+C8diXy9EspXfj/QZYfhKTLS0liBtTsn72
         yR3zkwhKrqb3MNkvb91cpfReCoTIxnihTsawOHugn4g1wkffXQ3b0A7MF6a+oaxcE2uQ
         ATvA==
X-Gm-Message-State: AA+aEWZje9bD2NKZy91eACCTCro4cE6PHunPxwtfcdyQ+ktycAnYh9Rn
        Yd0OV218kDlwAB02mVbaG2I=
X-Google-Smtp-Source: AFSGD/VLt842lB9XNzntXkM9CyalnE4C5aMRbc2GHuW7fR1QfXxEaM3V2x5i+T0++nMmy4+9crbnuQ==
X-Received: by 2002:a17:906:3b11:: with SMTP id g17-v6mr20005564ejf.210.1545326407873;
        Thu, 20 Dec 2018 09:20:07 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id c30sm6272717edc.70.2018.12.20.09.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:07 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v3 02/19] mailbox: arm-mhu: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:45 +0100
Message-Id: <20181220172002.9016-3-thierry.reding@gmail.com>
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

Cc: Sudeep Holla <sudeep.holla@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/arm_mhu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/mailbox/arm_mhu.c b/drivers/mailbox/arm_mhu.c
index 99befa76e37c..64d85c6a2bdf 100644
--- a/drivers/mailbox/arm_mhu.c
+++ b/drivers/mailbox/arm_mhu.c
@@ -152,7 +152,7 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 
 	amba_set_drvdata(adev, mhu);
 
-	err = mbox_controller_register(&mhu->mbox);
+	err = devm_mbox_controller_register(dev, &mhu->mbox);
 	if (err) {
 		dev_err(dev, "Failed to register mailboxes %d\n", err);
 		return err;
@@ -162,15 +162,6 @@ static int mhu_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 }
 
-static int mhu_remove(struct amba_device *adev)
-{
-	struct arm_mhu *mhu = amba_get_drvdata(adev);
-
-	mbox_controller_unregister(&mhu->mbox);
-
-	return 0;
-}
-
 static struct amba_id mhu_ids[] = {
 	{
 		.id	= 0x1bb098,
@@ -186,7 +177,6 @@ static struct amba_driver arm_mhu_driver = {
 	},
 	.id_table	= mhu_ids,
 	.probe		= mhu_probe,
-	.remove		= mhu_remove,
 };
 module_amba_driver(arm_mhu_driver);
 
-- 
2.19.1

