Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2ECC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 06:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF270204EC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 06:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="shrB3pN/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfBXGlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 01:41:22 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33249 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfBXGlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 01:41:22 -0500
Received: by mail-pg1-f195.google.com with SMTP id h11so3031397pgl.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 22:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Mhx7WSc2Boc++wZrS8Wqg/jKi9Evc4gOJln3rTNCf+Y=;
        b=shrB3pN/DcmQCAi+lu++uv2TGefessthPFtq/HbeCut6pxCtBGhfSQQwHcQ0yXoTuj
         WQv5bAq9y5t1epSQy1tn5LzcES108IGM5AHVCT/V0YnCMJcGOidL94x9q/GnHS3pA9z+
         icFxYbOZn8vzSXq9771ebOTPZatMY5VluygKuihktchnGPd+zNbGf31TG+o478AOLF2s
         U6PoLydy+K+Pz5LK1cB0WVISQFO0Xw2asqhpz/M+1Io0LVH2Q9uyCS0HBfDSLOqOkR47
         mhXFqrEhE9mwbVKswo8X+WhyKjONGKL9RaqobjuLZCDqYXQxVZ4VzKZV7/zc0v3PyBAp
         VuyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Mhx7WSc2Boc++wZrS8Wqg/jKi9Evc4gOJln3rTNCf+Y=;
        b=CD+Qp97f0kFfgcZ2mf9mZ783nmpbkxNNId32fZ4wBCh/NX5apYyp6F5YIQH5y2sC9T
         wwrHwJpdPBGBrPrdl/H/TKAkLISJfmQiOOR8HDmVNJnqQJms0vTp7cAN9tZC0SkkiRdJ
         Az2OUrxUHQgHwQ3z54ocknqRdeD17x4vSGBnn8epbOlvdU/U1lr5TqAG6aV6lLRj/Yuu
         pQqCFFMfqFE2QhmHsWzySj/gY7u6pTafOvrU5zauAaY+spOzjS4LajEJgh4Wh4EpLrlj
         FHEwmREQCA9VHU+ASDq+A/bXNFX0m1ZKXLcEPf0V7OJR7JQpGJy2m3SrY+Qy50qjJDMK
         ClmQ==
X-Gm-Message-State: AHQUAuYOzn4fZ87d0x/fuNxneWawH6vwiMUbKcj86NCz2sP7JzHwKf/m
        Q2Yz2DNnMlD5p/UIXetGwVLWaA==
X-Google-Smtp-Source: AHgI3IapndehzdSwDjXBCp7gJg0eTOgD37MnXOgaE1O9vn2zBsoZi5UZuPpRzGYODwRspD9PWWQU6w==
X-Received: by 2002:a65:508b:: with SMTP id r11mr9725199pgp.242.1550990481176;
        Sat, 23 Feb 2019 22:41:21 -0800 (PST)
Received: from localhost.localdomain (118-171-128-111.dynamic-ip.hinet.net. [118.171.128.111])
        by smtp.gmail.com with ESMTPSA id g136sm14106070pfb.154.2019.02.23.22.41.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 22:41:20 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mcp16502: Remove module version
Date:   Sun, 24 Feb 2019 14:41:10 +0800
Message-Id: <20190224064110.27181-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module version is unlikely to be updated, use kernel version should be
enough.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mcp16502.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 0fc4963bd5b0..3a8004abe044 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -547,7 +547,6 @@ static struct i2c_driver mcp16502_drv = {
 
 module_i2c_driver(mcp16502_drv);
 
-MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MCP16502 PMIC driver");
 MODULE_AUTHOR("Andrei Stefanescu andrei.stefanescu@microchip.com");
-- 
2.17.1

