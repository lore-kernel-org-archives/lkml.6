Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34943C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02F22217D9
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 17:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn7x64jd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbeLTRUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:20:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36987 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387929AbeLTRUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 12:20:33 -0500
Received: by mail-ed1-f66.google.com with SMTP id h15so2410975edb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 09:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+gOo8zs+s92KTAUX6s3+jz0o4ECXMvdcL4c1sWAOPE=;
        b=cn7x64jd6AZDodQbyiGmA1FkBYQoJs5W22kMmiEt59VlCeAEJ4yuYc1WPko10f0Fjg
         COfdzU9+DYVngEIErsxQ/8JLCpdvYmh0Iq8aTjCmVmEV3RyZfyeSLAbw7dtvwCm7uoYP
         eS0qmbgiQbL4X2NGqvOQIltO/EnT/gOJmdF8kdiNYUk3VcEZ9crYoXKv1dipz64b6KUU
         3fqsVPBXPAAjTs+bccP99hUO1jA52vBXkE7mBnxf65O9C0yvC22wy8MEJjf9eLIRiD35
         CVN7P8mr3tQ0kKhXeac16yD+LvwCgTvO2ZXss6vSfSnk46xg0QWILvTss9pxsOMXjqZt
         7oTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+gOo8zs+s92KTAUX6s3+jz0o4ECXMvdcL4c1sWAOPE=;
        b=BMmZeQstwSy5fO/qDYipUX7vqItUE78lj8RdHGeUfL5udj68zU5rbblCqqQQPR7bWM
         LQJPLHeobhoXVbd4psGuDx/V2bbl1vJnr7JdFOgcyqVf0cRHMq6+kqTd8rBwVm4WOXE7
         4V/jTIlbt7cnAzf79a9Cz/FagYWxGte8ThJJKvuT9Si/R8bp9PpWojPnz+VwcJNshCd7
         3EKaZ3eeDHZ9gvvCmLD5M2WxJsARwgXhSriZ2I0twTzUImPsNZoryJ+EX95nslQ14Gq+
         oi8d98rimPzZ43T6isDCM+u+IJkHmJyViQzbWOIAbvWYeaCbCg2a4Lv5VGfyvR///iUa
         yugA==
X-Gm-Message-State: AA+aEWZLaRdCPspoGmG5bDahSilQYe55WL8SSFo/8LR3QI+g3xg6LbGE
        oUoZ9WoTARWf9kd3F4PxP8Y=
X-Google-Smtp-Source: AFSGD/W0F/C//JlDiuc3iinDD6VyPuINByFrPpX3L/Duq4NPQ/Jm0RQ1pi1KM8DRexz39peD1vf9kQ==
X-Received: by 2002:a17:906:51d4:: with SMTP id v20-v6mr13994272ejk.184.1545326431347;
        Thu, 20 Dec 2018 09:20:31 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id dc5-v6sm3298140ejb.53.2018.12.20.09.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 09:20:30 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Caesar Wang <wxt@rock-chips.com>
Subject: [PATCH v3 17/19] mailbox: rockchip: Use device-managed registration API
Date:   Thu, 20 Dec 2018 18:20:00 +0100
Message-Id: <20181220172002.9016-18-thierry.reding@gmail.com>
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

Cc: Caesar Wang <wxt@rock-chips.com>
Reviewed-by: Caesar Wang <wxt@rock-chips.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/rockchip-mailbox.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/mailbox/rockchip-mailbox.c b/drivers/mailbox/rockchip-mailbox.c
index d702a204f5c1..f24a77b1a0ff 100644
--- a/drivers/mailbox/rockchip-mailbox.c
+++ b/drivers/mailbox/rockchip-mailbox.c
@@ -247,28 +247,15 @@ static int rockchip_mbox_probe(struct platform_device *pdev)
 		mb->chans[i].msg = NULL;
 	}
 
-	ret = mbox_controller_register(&mb->mbox);
+	ret = devm_mbox_controller_register(&pdev->dev, &mb->mbox);
 	if (ret < 0)
 		dev_err(&pdev->dev, "Failed to register mailbox: %d\n", ret);
 
 	return ret;
 }
 
-static int rockchip_mbox_remove(struct platform_device *pdev)
-{
-	struct rockchip_mbox *mb = platform_get_drvdata(pdev);
-
-	if (!mb)
-		return -EINVAL;
-
-	mbox_controller_unregister(&mb->mbox);
-
-	return 0;
-}
-
 static struct platform_driver rockchip_mbox_driver = {
 	.probe	= rockchip_mbox_probe,
-	.remove	= rockchip_mbox_remove,
 	.driver = {
 		.name = "rockchip-mailbox",
 		.of_match_table = of_match_ptr(rockchip_mbox_of_match),
-- 
2.19.1

