Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E3BECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09AD62086E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f+YC378O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09AD62086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390235AbeIUT3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:29:43 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:40168 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389463AbeIUT3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:42 -0400
Received: by mail-it1-f195.google.com with SMTP id h23-v6so1930376ita.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=08TSpeJeZkfX8ro4yZ1U1ymVD6C3Yb4G89YnYCiuJos=;
        b=f+YC378ORDYvGRfze+FXjdkUWYuShnzubMklTFJhPg4e3fVrFhN/YBf/B1rqS8FrHJ
         UixqT1kXoJIC7MF5UFh+IMAzMHjj2uz8/B4kQ+hxE/olVepwE1RZo0m4CMU3Z/vt1bdN
         pUQKHUV3/+lyoJ+EOoEoZvWkBcuZBur8lzFR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=08TSpeJeZkfX8ro4yZ1U1ymVD6C3Yb4G89YnYCiuJos=;
        b=cpx/MmK/8sv9jJm1kOUioGDs5d4XFFTk6n2wsI47qvuvOEymPkZv/vMmP3DK3GBIWJ
         MH6SBJy8rfZES0qPut+VAXHD5M191cGyHjCjBWdD5NjxUL4bacoOsHRsTqx2CK9e2EMP
         zx2NmCu4Lv2snBoTk8CqhjrcoOYm0NWYyFyIwqpFPuUPqrjJwCr20mG8EuideOw9aNjG
         42GmOjTHKPJfye8YvlGszHHRJ1ttEFm1Ou2e0WOOwAfYiPgj2Wye/aQvbCGw4mrC1ASI
         tZaLux9xLEHQRaSD8tsQBZNYiTH64Gu+pFg7XmLqbyjL+apWpAEFdPzrN6n4X84ogdrB
         sd1Q==
X-Gm-Message-State: APzg51AlIJMfHnim/X+7MJ4FuXCqmjOLwTrPcvw/ZXwlf30Ion3epNNc
        rgkkaRUcpb1Nf/rI2UO+bzj4LA==
X-Google-Smtp-Source: ANB0VdZtkrdpwaCby9dWaG9lv+j08qXLhMYdb8Sxayrje5NZEqZxV3a1u48rzD7IpXZ+ZO5x5DMKkA==
X-Received: by 2002:a24:e4ca:: with SMTP id o193-v6mr5999958ith.132.1537537247155;
        Fri, 21 Sep 2018 06:40:47 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:40:46 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 11/26] nvmem: lpc18xx_eeprom: use devm_nvmem_register()
Date:   Fri, 21 Sep 2018 06:40:11 -0700
Message-Id: <20180921134026.4596-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Use the managed version of nvmem_register().

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/lpc18xx_eeprom.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_eeprom.c b/drivers/nvmem/lpc18xx_eeprom.c
index a9534a6e8636..b42dbaddb419 100644
--- a/drivers/nvmem/lpc18xx_eeprom.c
+++ b/drivers/nvmem/lpc18xx_eeprom.c
@@ -236,7 +236,7 @@ static int lpc18xx_eeprom_probe(struct platform_device *pdev)
 	lpc18xx_nvmem_config.dev = dev;
 	lpc18xx_nvmem_config.priv = eeprom;
 
-	eeprom->nvmem = nvmem_register(&lpc18xx_nvmem_config);
+	eeprom->nvmem = devm_nvmem_register(dev, &lpc18xx_nvmem_config);
 	if (IS_ERR(eeprom->nvmem)) {
 		ret = PTR_ERR(eeprom->nvmem);
 		goto err_clk;
@@ -257,10 +257,6 @@ static int lpc18xx_eeprom_remove(struct platform_device *pdev)
 	struct lpc18xx_eeprom_dev *eeprom = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = nvmem_unregister(eeprom->nvmem);
-	if (ret < 0)
-		return ret;
-
 	clk_disable_unprepare(eeprom->clk);
 
 	return 0;
-- 
2.19.0

