Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C895AC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745FF219EA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bg/9qx9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 745FF219EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753345AbeGDR3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:29:12 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39473 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753015AbeGDR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:29:10 -0400
Received: by mail-pf0-f194.google.com with SMTP id s21-v6so3151689pfm.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 10:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ysxcBNHmBG5DiupaDa6tjlXfj4Dbv7xDYOP/Gcynov4=;
        b=bg/9qx9npOgLQwqwJm/GhbfgnEGzRtvwf4QswGfQ8XhWZ8Ml6jdcdcdmIOfCeOeNMv
         TuzlTvnzZcJm2Js4zguGNXyQ8MhO8Z2gazkOedXbUG5jPeQQImYpjQEqdBrStJ4Pt1VK
         elDkCDpvkgP2s4rFHuEU5hoSkEfIOtFnFosQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ysxcBNHmBG5DiupaDa6tjlXfj4Dbv7xDYOP/Gcynov4=;
        b=CcVD6QSIWSasrPTUhlUloNVpjg7XC2PYYi2UqsrbvV+HlDxTnpaxpw6nblIvYgZqnY
         ptUCUV7Xk+JiOwdNI9JaaJya4giycn3ih5/Uq9Tmai0GyITd/r+CSESYGg0p+7Yp5yq3
         XZxlvHK6rjdoPvk4xbAYQ+CH8Cb1uZDqR6hwd6a92dbjr7+/wqqOYdHzCXgVxVPJAPJI
         c2DOeX2lvGedGxjmg8wr9vPqM77DPX629+Zz86r5JIyZTe587MHMRNqv+JlO8aHi9Vxz
         2SVbIXW+AxF+ZRS8y3xGoBjxf22eLFh+B/IvMjRJYHuJgS207bvZVKA1pvxj1vUvKzns
         Girw==
X-Gm-Message-State: APt69E27MB4WE+LhXE8l+K0W7luMpHZ5fGrjURlF8clJ3Fl3GJETgvXC
        8mqE2cNqmwqdZUmTW9/s9ELJDg==
X-Google-Smtp-Source: AAOMgpdQyzGyyeSK2qpPy2uZyv6kc0i20PGaa0iylheGHT1gRYoDsbs6DaVksO8JtSJqu/+g5kgIkw==
X-Received: by 2002:a62:5d18:: with SMTP id r24-v6mr3110039pfb.87.1530725350316;
        Wed, 04 Jul 2018 10:29:10 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 14-v6sm8834881pft.10.2018.07.04.10.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 10:29:09 -0700 (PDT)
Date:   Wed, 4 Jul 2018 10:29:08 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Darren Hart <dvhart@infradead.org>
Cc:     Vadim Pasternak <vadimp@mellanox.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/mellanox: Use 2-factor allocator calls
Message-ID: <20180704172908.GA33650@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As already done treewide, switch from open-coded multiplication to using
2-factor allocation helpers.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/platform/mellanox/mlxreg-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-io.c b/drivers/platform/mellanox/mlxreg-io.c
index c192dfe6bd65..acfaf64ffde6 100644
--- a/drivers/platform/mellanox/mlxreg-io.c
+++ b/drivers/platform/mellanox/mlxreg-io.c
@@ -152,8 +152,8 @@ static int mlxreg_io_attr_init(struct mlxreg_io_priv_data *priv)
 {
 	int i;
 
-	priv->group.attrs = devm_kzalloc(&priv->pdev->dev,
-					 priv->pdata->counter *
+	priv->group.attrs = devm_kcalloc(&priv->pdev->dev,
+					 priv->pdata->counter,
 					 sizeof(struct attribute *),
 					 GFP_KERNEL);
 	if (!priv->group.attrs)
-- 
2.17.1


-- 
Kees Cook
Pixel Security
