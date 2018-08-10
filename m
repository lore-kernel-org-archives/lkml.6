Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD2DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B5A223EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f70Zh6db"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B5A223EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeHJMVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:21:46 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33200 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727738AbeHJMVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:21:46 -0400
Received: by mail-pf1-f194.google.com with SMTP id d4-v6so4302527pfn.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/2SNt9Nhz3v7D4RvDwtle5+O7jcsvrVGidUkEkSh/JQ=;
        b=f70Zh6dbHcJj90PYsdsGnMbY4EklUDwq31RUxdBDRvdLHnsfNPdiQuqQjL1saJ2TWg
         v06/aefq2lkqE+n7QIrBGRhGKLtEo5TJHrLKsqALtAVoirhs6YJG1kvgpSdd8vEWYPt8
         4XLZoO7Sd9SLUQwfW4yYL2+NIkxTyqrCk3tG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/2SNt9Nhz3v7D4RvDwtle5+O7jcsvrVGidUkEkSh/JQ=;
        b=OkXm9mYCFBufSNVo63u1ob4jmyX78mxaQRsZru71Uc3fn7Yir+8iS8HtzZPyP1QANP
         eER4KGfQIYWsxpGrUVmQpmrEqbq8JAAPtriNGI6aVJPyqhiHybzDMtKXbpgTGnvXggNM
         WWgJe3ZtG0nNmCa08vWC1junyr+2RjeoSaMQGGxqTkeSBNjFspLpRD6zsGYIJypRiRkq
         b+Hn4ihTdczPi84LYALnPD2JG95zOhaeTC/fXnFE+2dvKGxVgn2qeoAzasNgMZgXeuIs
         +oMT86DKsybYfMvZB/ZgAVGQ+yUN+Q7+Si0VjKAQyLHbGRQlwM0JZQLPZ8MxaB39Zehk
         jUaA==
X-Gm-Message-State: AOUpUlHDO+GJhR9+NHbIsluTRycaur23Utz8Gm3g5pos/BWmuCCs1uMs
        +4C01QFA0Dj/8GC8yo7Rhda/b8eNLg==
X-Google-Smtp-Source: AA+uWPwE3fKIyHwfgnYaawH11c5tMSWbQ/GGtYX3T2LY/XcWwsos3ykmxhvP7/D1zIFuL2DTtBP3iw==
X-Received: by 2002:a63:ce43:: with SMTP id r3-v6mr5704786pgi.439.1533894757291;
        Fri, 10 Aug 2018 02:52:37 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6391:e983:9562:f5f7:1a60:4363])
        by smtp.gmail.com with ESMTPSA id n83-v6sm25315120pfk.19.2018.08.10.02.52.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 02:52:36 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/9] dt-bindings: clock: Add reset controller bindings for Actions Semi Owl SoCs
Date:   Fri, 10 Aug 2018 15:21:06 +0530
Message-Id: <20180810095113.25292-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
References: <20180810095113.25292-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Controller bindings to clock bindings for Actions Semi Owl
SoCs, S700 and S900.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/clock/actions,owl-cmu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
index d1e60d297387..2ef86ae96df8 100644
--- a/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
+++ b/Documentation/devicetree/bindings/clock/actions,owl-cmu.txt
@@ -13,6 +13,7 @@ Required Properties:
   region.
 - clocks: Reference to the parent clocks ("hosc", "losc")
 - #clock-cells: should be 1.
+- #reset-cells: should be 1.
 
 Each clock is assigned an identifier, and client nodes can use this identifier
 to specify the clock which they consume.
@@ -36,6 +37,7 @@ Example: Clock Management Unit node:
                 reg = <0x0 0xe0160000 0x0 0x1000>;
                 clocks = <&hosc>, <&losc>;
                 #clock-cells = <1>;
+                #reset-cells = <1>;
         };
 
 Example: UART controller node that consumes clock generated by the clock
-- 
2.17.1

