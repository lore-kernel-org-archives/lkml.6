Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2049C10F06
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B013D20643
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdyNqe7Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfBQQXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 11:23:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41737 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfBQQXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 11:23:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id y5so1926237plk.8;
        Sun, 17 Feb 2019 08:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bohSFX1l++RtGX/SzC4HgfDL1CVVoHjCGwPOHLnV08I=;
        b=FdyNqe7Zqiv7AeFHDpDUYcffaOGYduDvgb0wLI6n1R/tuQJy2GysI0crXRY7Gywwre
         yHguCo6IucwQTPIuTBFtew41UjCFZwgvoWyQtzZPeEM7eZYnloaHu4m1OaX2q9cTXKed
         xXLaDaZ7KPo2GenVRx4jlGw0ucQM7A/warcTvfl1eGrjWbmPqC7ds1kz4VvYy1Yvb4XA
         BZG8LkENFKm7VD4XpxjLnc2JLn/j08cQqj0JZXaTnPh+JvDhC1+TznBdlTtxupzFHaYU
         gpOSSV38EjmIWqDclIifY01MUTO8FNtWN6bl1jKNIEkkD3mRJRKxSJT7FPjWmLNrz1wn
         idIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bohSFX1l++RtGX/SzC4HgfDL1CVVoHjCGwPOHLnV08I=;
        b=RCYaVxOmQKh3QI4nAmUBih+IqU9f91bPl7LOa5yO+s5nkypQTIeNhpa9P8uZ9FrC3n
         McwBqiBt4NoYwbjjDD8XITpbSt+lkn+wWx99RlYvfijCX6iHO+lpm8wA7kvufaKHLwQ5
         NWTOUVce4UDW0XOddpqkb9Gr5NsrCn6z4RAuoH4UrBl8TDjcXiPqgZGVQH89kbTv08iV
         lyDcGIyHbthjdklksl+d859f7VRWj9K+ev+jhDYqnfBZoxPcTQ6zH1oZpcoiBqCWYlbg
         bCeTP7k4JG/wwLeQIGOFChGrzqAMLKZwdS23PAJqI4LP0OwRtGaAUnGSRUOeKWWLtWAS
         zt5g==
X-Gm-Message-State: AHQUAub/8BO0SiaSb6kHGcE3IagSflXpQ5Kq6GHggkLhm5ZG5wXoBSkW
        TYdPWkTKc3pg/vA7C1D3Mng=
X-Google-Smtp-Source: AHgI3IbvkHI8z7+rkzYw+0QcRf3Wx+2QccS2MFjpth5+eOo6amuKe3CqaP0bHv6NTmlJ/1j7JVjx5g==
X-Received: by 2002:a17:902:7b85:: with SMTP id w5mr16073456pll.288.1550420627046;
        Sun, 17 Feb 2019 08:23:47 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 27sm13317054pgn.56.2019.02.17.08.23.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Feb 2019 08:23:46 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, maxime.ripard@bootlin.com, wens@csie.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 4/5] nvmem: sunxi-sid: add support for H6's SID controller
Date:   Sun, 17 Feb 2019 11:23:15 -0500
Message-Id: <20190217162316.14111-5-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190217162316.14111-1-tiny.windzz@gmail.com>
References: <20190217162316.14111-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for H6's SID controller. It supports 4K-bit
EFUSE, bigger than before.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/nvmem/sunxi_sid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 036029e90921..8692b58d76ce 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -224,12 +224,18 @@ static const struct sunxi_sid_cfg sun50i_h5_cfg = {
 	.size = 0x100,
 };
 
+static const struct sunxi_sid_cfg sun50i_h6_cfg = {
+	.value_offset = 0x200,
+	.size = 0x200,
+};
+
 static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-sid", .data = &sun4i_a10_cfg },
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_h5_cfg },
+	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
 	{/* sentinel */},
 };
 MODULE_DEVICE_TABLE(of, sunxi_sid_of_match);
-- 
2.17.0

