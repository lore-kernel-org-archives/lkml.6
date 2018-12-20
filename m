Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F1CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13FE2217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkEp9jBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387901AbeLTRU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:28 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34149 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387816AbeLTRUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so2418299ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W3DbdO8i8UCFTKJbfMwISGp/pjGqC8y7EdutvkAVqMA=;
        b=nkEp9jBztFO/Az3B+X3xLwwji17qxILByMPfFkvTYSn5Lpx+cgIgzN3o5kprK2NmC3
         JIbOY7O4z0O130gVtZO1s8E2adSFZ50CZukONkeXRMJKYs/fjiqyoVoYBhn6zSvMnqJy
         tKi9Rjlmd2SYbdKd/EalJq6pvLCKQG8w5ndreAj+ImprFxLP2KA4LYMEoZMmYOnXKn5k
         umnnqFyjz5+bZC6FVISENuTPTH/9mRPBJqKFkMqNZTrT4fmCgBzHtqqrr7DsIvxjUf4O
         x9swe1YqUxlc7Tj9erRxyOl+LaPqVGCNnw80m0h3TFTZIBZtGdl9AsMT7cAw0mIMGyUN
         zCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W3DbdO8i8UCFTKJbfMwISGp/pjGqC8y7EdutvkAVqMA=;
        b=F0amBjdTh02TmZt4tcoN7de3YMEHYLxTlT4m7AdtDDqr0t1zYYzspOnDAZvIfUEerJ
         V38c8Yzab2PTcBo/ZrVBm251SOdChWPGV+DdFdREXth7b8D3+WQpyRxFFMp00hSzfX6g
         6vJ/W/7TLKPmobKP/dgJQY1SpxLGPV+vzyUcc6SYGVOyAdOS/6K3YXbgc1Vgu3DSsSy+
         dMPeKuNuf0s2W9XmRMs9R/h+jxsgdlzK/+QWW8H73g5vUiguvMM8NUOA+uepQzvBFZap
         K8Kk3pUPy4mEUGixFmoIlBvxWgnXV+cSdJcWkVu+A0igSZI4QhX/+0lq3UpV25y2x8Zi
         JWbA==
X-Gm-Message-State: AA+aEWYKCOu/49SfV7xNLDVK8n2VXc44RdEfOTiJ0YGsqb5VAIg68U3r
        ant8XHNoOWBtn6QRZy/zkI6PIoWG
X-Google-Smtp-Source: AFSGD/WFeLc7vyqD9EHg30v6GMtQl4Rwr1LNHsvX7qS4AhkR70VXXSHf3mVWaxEIS07qT4rfJrPdBA==
X-Received: by 2002:a50:d085:: with SMTP id v5mr24205377edd.61.1545326420212;
        Thu, 20 Dec 2018 09:20:20 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id s46sm6525873edd.9.2018.12.20.09.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:19 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v3 10/19] mailbox: sti: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:19:53 +0100
Message-Id: <20181220172002.9016-11-thierry.reding@gmail.com>
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

Cc: Lee Jones <lee.jones@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/mailbox-sti.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mailbox/mailbox-sti.c b/drivers/mailbox/mailbox-sti.c
index 779d41262ef0..adf82b85dbb2 100644
--- a/drivers/mailbox/mailbox-sti.c
+++ b/drivers/mailbox/mailbox-sti.c
@@ -462,7 +462,7 @@ static int sti_mbox_probe(struct platform_device *pdev)
 	mbox->chans		= chans;
 	mbox->num_chans		= STI_MBOX_CHAN_MAX;
 
-	ret = mbox_controller_register(mbox);
+	ret = devm_mbox_controller_register(&pdev->dev, mbox);
 	if (ret)
 		return ret;
 
@@ -480,7 +480,6 @@ static int sti_mbox_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, mdev->name, mdev);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't claim IRQ %d\n", irq);
-		mbox_controller_unregister(mbox);
 		return -EINVAL;
 	}
 
@@ -489,18 +488,8 @@ static int sti_mbox_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sti_mbox_remove(struct platform_device *pdev)
-{
-	struct sti_mbox_device *mdev = platform_get_drvdata(pdev);
-
-	mbox_controller_unregister(mdev->mbox);
-
-	return 0;
-}
-
 static struct platform_driver sti_mbox_driver = {
 	.probe = sti_mbox_probe,
-	.remove = sti_mbox_remove,
 	.driver = {
 		.name = "sti-mailbox",
 		.of_match_table = sti_mailbox_match,
-- 
2.19.1

