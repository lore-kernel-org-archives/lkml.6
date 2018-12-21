Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8892C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 711BF218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="D1xAybEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbeLUCto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:49:44 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39662 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbeLUCto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:49:44 -0500
Received: by mail-pl1-f193.google.com with SMTP id 101so1786899pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 18:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=B/9WIP1doMudHgKric46ysCRndOOFeg6o6f8nrVxxgI=;
        b=D1xAybEu8p7N8PuPqjF9RAdMDR0Bxs2b5PnjITwq0Hv8klYCPRk5HCb2r0gkkYw4tJ
         prectoMcBStEgk41uB9tXZ5BTgPPns0eYj8pjD5aiJukGdE7yuHmeHCRdJL1k9VXtg3/
         Cj42Mp24u4VDRjMn+qViuJCPKrIAXED98fT0kSA4fFcKqNLleOn1s+q6ycHGfDekgGu4
         0+cbsY/YsF81VeoKax9c7k3gg4+sSN5kF4vRxsnexw6EmL56Atvd0OTL+wvhsWD5t5JI
         LajEhaZsWYwj2Hymca+T7Igqq41/gshMmHpXzbwkHLYQ+rVhN+XyYsrxE+1EOicsE+Cn
         AGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B/9WIP1doMudHgKric46ysCRndOOFeg6o6f8nrVxxgI=;
        b=TAW+it2AHoEqFNDaMHX51Of8ZKumc7aXiLxYYym+hPc0ZIbeWkroWzzvwFxuIH3GHV
         C74QpgUtnPj8QdaPjwSkzlJPLFZjTcOt24tqS2ud3mxQpqB4tn/2l692JyFBDuO57Po4
         7Soa0J33i5Mn6Js2R5/w/IbyIpEQHgmpE1i4MwZDs0McdwRpU1ZpGFFuBIjBLHAhpHP0
         yKO/oXWERx4ka3nZjdu4UtX6kMxyllh9HEJtOl/9EqUtQEMtFVAi2U2V8GkHlpl6dK+2
         ZHLifas3gMDFMTygsXyehRJvaC2VgNmz3iXdjTOECZyyNp1JNX7MkUEVhYlLW3v4AMcm
         yLCw==
X-Gm-Message-State: AJcUukcJUuOWhzRTLR+Nul2+cG53pV+/glg15bMhK9yVlYqBuuIvyw/L
        DWHqep3/FyP1ovqw/jqlfT29LQ==
X-Google-Smtp-Source: ALg8bN75ERoYWk6L2eVHmcf4dP940Lm8nwWCEAhTb25M1nCXVq8AXmnZtdcPs3MiveECqZd64mjvhA==
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr751670plj.116.1545360583784;
        Thu, 20 Dec 2018 18:49:43 -0800 (PST)
Received: from localhost.localdomain (36-239-205-170.dynamic-ip.hinet.net. [36.239.205.170])
        by smtp.gmail.com with ESMTPSA id c23sm27784184pfi.83.2018.12.20.18.49.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 18:49:42 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andrei Stefanescu <andrei.stefanescu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mcp16502: Select REGMAP_I2C to fix build error
Date:   Fri, 21 Dec 2018 10:49:29 +0800
Message-Id: <20181221024929.667-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix build error when CONFIG_REGMAP_I2C=m && CONFIG_REGULATOR_MCP16502=y.

drivers/regulator/mcp16502.o: In function `mcp16502_probe':
mcp16502.c:(.text+0xca): undefined reference to `__devm_regmap_init_i2c'

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 719d9d660e56..ee60a222f5eb 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -570,6 +570,7 @@ config REGULATOR_MC13892
 config REGULATOR_MCP16502
 	tristate "Microchip MCP16502 PMIC"
 	depends on I2C && OF
+	select REGMAP_I2C
 	help
 	  Say y here to support the MCP16502 PMIC. This driver supports
 	  basic operations (get/set voltage, get/set operating mode)
-- 
2.17.1

