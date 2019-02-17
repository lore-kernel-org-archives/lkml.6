Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB63C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2014218AD
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lv7C30Ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfBQQXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:23:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41743 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfBQQXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:23:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so1926284plk.8;
        Sun, 17 Feb 2019 08:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TmLBhkcwf93Bo4/fPKHDPdkbWpR65IQ7m7Ea6pG7oSE=;
        b=lv7C30IaiATp0u5N16KjreOaS2GcPSSYdyWlSvAY+yYDY0gFvHcS9MSRU5W+7pbHaQ
         vOVpYgfkeMGo4n2WCfVAaqcMtYeSIiiykov4/aITxWy31kc0cvVTGl2VEE1+h1M71k72
         Gkajh+LDUbL/xpEB+gnghnTprn3v/ccxe4XIKhjpYYQJRPt0h8toyL11kKeA34+bDnum
         52wL4AibfdBlpgo+8jn/jDF8L6xQskiJywOsuuvJNIUs/5g6cA8eaXXFmRAA5BM8h1nW
         aco/sZ5zQYzdqh1o1pWqO/ZcMs29yGBy4hmzjXxzqQ0pD4Wt4TrtDtihcAtZPaVpc8mv
         T0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TmLBhkcwf93Bo4/fPKHDPdkbWpR65IQ7m7Ea6pG7oSE=;
        b=b3dNW/nKcyiU3wA5gNd0DwsyqVPLrKLPxh3YmhoGK/44Ak5XSVYPK1TUHKPgN23d8k
         Ef6zmbiany7AykRPyeXU2sZ4s6xRvIiDssYmiDNMvPmpGThB8HwPbGAi9Iz/oWaX9lyM
         zjGifOToauWlP814LEA3RtlEEMnaQ85bKmskhAzMzHw56MrXjOYEeiar3B8CKE7fR0SR
         JmGw1kC7XKZIxrWHjEWY5L/Zp0B4d+GoV6fm7oZXw47iUupDmSWcrFvPQs8B2B8tjk3m
         UuJ8cCrqgLeRHB96Q75AFcfRF4VQElPAdd0cIuUFrrA+vm+G3VJm5C/Sf/kydC3HUMpO
         RalQ==
X-Gm-Message-State: AHQUAublYMoWYwEaUZ8f/SsyY/4s20HZzecCb44KG8uSqj25WRvmpbSj
        w3A/1b0dN9lfqEFPHRGwQac=
X-Google-Smtp-Source: AHgI3Ibsn22Xygm1ibYW5QODahFc//NMQiQJ1c5JMNPNaSKAUDCDzxZXG3dWNqGc3/QgAlru5bkYvg==
X-Received: by 2002:a17:902:2468:: with SMTP id m37mr20776467plg.314.1550420630579;
        Sun, 17 Feb 2019 08:23:50 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id q21sm32884737pfq.138.2019.02.17.08.23.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 08:23:49 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 5/5] nvmem: sunxi-sid: convert to SPDX license tags
Date:   Sun, 17 Feb 2019 11:23:16 -0500
Message-Id: <20190217162316.14111-6-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190217162316.14111-1-tiny.windzz@gmail.com>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates license to use SPDX-License-Identifier.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 8692b58d76ce..f56c9f713cb4 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Allwinner sunXi SoCs Security ID support.
  *
  * Copyright (c) 2013 Oliver Schinagl <oliver@schinagl.nl>
  * Copyright (C) 2014 Maxime Ripard <maxime.ripard@free-electrons.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/device.h>
-- 
2.17.0

