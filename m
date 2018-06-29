Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B501CC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588DE24F71
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEtP/bK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588DE24F71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936644AbeF2PpB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:45:01 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33425 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932658AbeF2PpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:45:00 -0400
Received: by mail-lf0-f65.google.com with SMTP id u14-v6so2089861lfu.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ukUiJ2rUXwVX3Go8FDMuJHjQu61MHyNVrpg0bCo8+rI=;
        b=WEtP/bK4mtcKospOlYG8NJA8I6B8FEb1LQEt0TVTsA1HXtFH8gRxx3zy7ARPIQpny5
         CJ3BV7JQfMyehNie2aJ2M+CPoVkfAbcHABUCZ5wuMF6l/ymnruC6FUTU2ykd6vzRyx6e
         CLs5a6H7c9+pjlVHAcYxAV2khU9ItmirTBQMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ukUiJ2rUXwVX3Go8FDMuJHjQu61MHyNVrpg0bCo8+rI=;
        b=g4bnC8Gs9AO5xE0PQUAgC0MVU26li/lSaJNOBVWpP9YwMZFPGxI9Etskh6Q5oem+f5
         H7u0qAxRj8/sh3/dIp/yzjOJj5G9O28WJ+/1xEhSawIHigE/jx2T8kdq5/F1SRz+4sos
         hPp6Ra8dWP6Ze29y1m5uwDyvHPL91ctFXxrWo6nV1ay59lKzol/KF8jkDRkB0/bmds2I
         RoIm13XbdZlee7lMDe/p6A2HwkZIZWgYD1D2nnkxn+Fi3NraO0PVLwiFdXTGoqPKVdvi
         ITIVnoEI5bDxtLqlunb6Mn7ivuAKjuKNNZkERGZEE4zxc9Tuo6IYBcNSnxg4LadBq/IL
         R2UA==
X-Gm-Message-State: APt69E3Ys+IRoBwQVDaCZy45IlBKYAHq6zkzuafpE3uBM+7HJ6AyAo76
        8kJQfUV/8gp1byfVgYb9cUAbAw==
X-Google-Smtp-Source: AAOMgpc4xaZQ6WViy7h6IKa808G2CYnGa3AlgcOAYNqnCoNBLkTnvuHxUUmTgmM0j0kOMrILp+J0/Q==
X-Received: by 2002:a19:a685:: with SMTP id p127-v6mr9668535lfe.4.1530287098651;
        Fri, 29 Jun 2018 08:44:58 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id n79-v6sm1592348lfi.51.2018.06.29.08.44.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 08:44:58 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Niklas Cassel <niklas.cassel@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: llc-slice: Add missing MODULE_LICENSE()
Date:   Fri, 29 Jun 2018 17:44:47 +0200
Message-Id: <20180629154447.2272-1-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing MODULE_LICENSE().
According to the SPDX-License-Identifier, the license is GPL v2.

Fixes the following warning:
WARNING: modpost: missing MODULE_LICENSE() in drivers/soc/qcom/llcc-slice.o

Fixes: c5c7385f89bf ("drivers: soc: Add LLCC driver")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/soc/qcom/llcc-slice.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/qcom/llcc-slice.c b/drivers/soc/qcom/llcc-slice.c
index fcaad1a4b41d..54063a31132f 100644
--- a/drivers/soc/qcom/llcc-slice.c
+++ b/drivers/soc/qcom/llcc-slice.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
@@ -333,3 +334,5 @@ int qcom_llcc_probe(struct platform_device *pdev,
 	return qcom_llcc_cfg_program(pdev);
 }
 EXPORT_SYMBOL_GPL(qcom_llcc_probe);
+
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

