Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACA8C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5605A20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:28:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX9ae0zp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbfAaT0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:26:43 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41545 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728718AbfAaT0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:26:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id k15-v6so3689758ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5PQSBhuTUgZQFLTgqddr0CqBTUtKcav77T7bqZGTdgc=;
        b=EX9ae0zpeTnAMKyJ0iOAGzPanfPbaPkcHLWqusKio4o+X2ub+taupydmPXi8Ihr9bW
         XIg3reTLvDDSW37MpKfuZSXMPYKmD0UIwMpxUCJC4cVkpnwxoGfQUKiHxKZ7Ydhp4KqD
         i+BOPy+qjtt5czAAKpdYwQe1NV/sPtuiHpOMhCJPE7mgGYs+NEJHLFQUYgShnvu+OrkG
         N4LSITmv/DmJdNA87mNfwseqHkq/mGxmNHtc+Ysv9pvEk82Jq8l4OqrElYBpcKDdkyur
         XIeXIVQBlINYz2gh8z0kxbVH6UaVB2ihq/g/HLMI7scz+zgfD1YP4/krAhRV1w9+Owsr
         SalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=5PQSBhuTUgZQFLTgqddr0CqBTUtKcav77T7bqZGTdgc=;
        b=Vz/FHFYpukE4yjvAGOAAUJyLJDVWhkkzCwJSilRf5EocuUcmBM+QrHgYy8lLHw366s
         DqGrt/9PUdAALuEzRJ0uBu/EJr9SlMTJKbPGTCoRkpjrLC4XyRF7ERKLokoPTE/uIHjC
         k3QNxT1UbBsMto0rMMAzFuHYA+Q+WFP0NMWt2mVx91L9kqeMvIcDNZQbtMHuIAJzxT1a
         tQkR1NVp1hyAchchTL3ks9p2YHzRUGwqCunX37EXN6ImFH9jiHbZ/+1TrdX8UEbBP/7m
         jQ9nbM/0ghdaUoo1+zvN0hIi3j2imQCcrRwm9F13Lk8dsd+/RUnWn/G6N+vZsxWmjkgk
         gb1g==
X-Gm-Message-State: AHQUAuaWvjC1t1435+6goemR2bkdyXWpDsceSQSPQZUQOvEf7PvcnBcH
        ehaV+qSqpRy13zRz1wikmLQ=
X-Google-Smtp-Source: AHgI3IY2/xeYzgbzFBAHL6pL0ywmQP0xBKEy3QP3u+yZ0+8Tr9VFqmI7vqe11c8EMErsXQq9oEerAw==
X-Received: by 2002:a2e:8786:: with SMTP id n6-v6mr18389427lji.100.1548962799497;
        Thu, 31 Jan 2019 11:26:39 -0800 (PST)
Received: from jupiter.lan (18.158-248-194.customer.lyse.net. [158.248.194.18])
        by smtp.gmail.com with ESMTPSA id f1sm987363lfm.22.2019.01.31.11.26.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:26:39 -0800 (PST)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v1 05/19] drm/panel: truly: use DRM_DEV*
Date:   Thu, 31 Jan 2019 20:26:05 +0100
Message-Id: <20190131192619.9763-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190131192619.9763-1-sam@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce use of DRM_DEV* for logging.
This makes logging in the drm subsystem more consistent.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Stefan Mavrodiev <stefan@olimex.com>
---
 drivers/gpu/drm/panel/panel-truly-nt35597.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
index 6317b6b35341..162e8002c114 100644
--- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
+++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
@@ -581,7 +581,7 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
 	ctx->config = of_device_get_match_data(dev);
 
 	if (!ctx->config) {
-		dev_err(dev, "missing device configuration\n");
+		DRM_DEV_ERROR(dev, "missing device configuration\n");
 		return -ENODEV;
 	}
 
-- 
2.12.0

