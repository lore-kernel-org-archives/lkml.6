Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF76C282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9B320869
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 07:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="AwHqXUth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfA3HL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 02:11:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39245 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfA3HL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 02:11:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so10651934pld.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 23:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=9XBSQrgfNnpA+UjH9YzM/VX48LbBbUF72qT+7fBqNCA=;
        b=AwHqXUthzqKgCpq0yGQhs7bRldiFaJXup4DbSk0a8e5mYqN+wl00z2Wufr1cT1aELx
         zAdJoL0dtNmZ9rvHgaOFZFYBcghQfazxWUei6W1mL+W6BY9/WxzvdcrSeFbac0r37aAM
         IrqDLb9aqy1wMKZ0t3gBPXRWgrIjQo39QYNQ2tcWPHZ8jIjTw6c1stTMSycX5G3K0im1
         L3XyvxmDU6T4D6o13dk/01P+x30ACaUmd8Cjm9WlyG+WqD3uT4P0VafPdiC1TwG9bNYc
         /5EynFIHA85o2VLi5HYwYgCQGWaraJhuNHj93tzKi1fnKw7UskIGfqurJefGEi9yKPKW
         denA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9XBSQrgfNnpA+UjH9YzM/VX48LbBbUF72qT+7fBqNCA=;
        b=je7T4Ar1LuDDglwnJ0/lCtqTFHn+/STTpDZpQNjEs6aGNLm9DT7QyjLScb0G4R/+mm
         8CAyNGDOSVfkBlbz3UmbydmxIwjxqA7olDiflRghRjSaRqGA0B8ZdUEUQ8tSlLPKaH7K
         enGWXtCpIpYh4y+Hidz2S0+stRbGV2Hnsi4LAEWSnBdVII8ab11BDYjkTD9tpTWFEdrV
         LGDBgFOdS4VE8E9fFMw8LzsHSfLPY6aaPoNlPZb0LDT/h5Yz/HplnZIL0tphYBwpOPEk
         nMflrj4H5j46955jxjJMMIIMd0t0WkoCbt3rwsEwEEgZzSpXgaL919pmEM6yO69YyKQ8
         UPuw==
X-Gm-Message-State: AJcUukcuvRNWDg8oJ27dfkn7cq9glKMqYm/xcGh8uGAn9n0FcVN7kgA0
        8yRhHmxiw6Wd3tPGLn7j8+otdQ==
X-Google-Smtp-Source: ALg8bN5Xd8Kbbyeau9oKyqvAzOP7FqvCuHwMZjlaEeMmKY16mmhTzpsiUZsMJ3iHuqZLcpbBSQWF2Q==
X-Received: by 2002:a17:902:20c6:: with SMTP id v6mr29522047plg.156.1548832288044;
        Tue, 29 Jan 2019 23:11:28 -0800 (PST)
Received: from localhost.localdomain (36-239-242-165.dynamic-ip.hinet.net. [36.239.242.165])
        by smtp.gmail.com with ESMTPSA id z62sm1409056pfi.4.2019.01.29.23.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 23:11:27 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: uniphier: Fix probe error handling
Date:   Wed, 30 Jan 2019 15:11:09 +0800
Message-Id: <20190130071110.26050-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure unwind all resources if probe fails.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/uniphier-regulator.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/uniphier-regulator.c b/drivers/regulator/uniphier-regulator.c
index abf22acbd13e..6ba0ae405f2b 100644
--- a/drivers/regulator/uniphier-regulator.c
+++ b/drivers/regulator/uniphier-regulator.c
@@ -87,8 +87,10 @@ static int uniphier_regulator_probe(struct platform_device *pdev)
 	}
 
 	regmap = devm_regmap_init_mmio(dev, base, priv->data->regconf);
-	if (IS_ERR(regmap))
-		return PTR_ERR(regmap);
+	if (IS_ERR(regmap)) {
+		ret = PTR_ERR(regmap);
+		goto out_rst_assert;
+	}
 
 	config.dev = dev;
 	config.driver_data = priv;
-- 
2.17.1

