Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC9CC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E93F20671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SeW6GUeI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E93F20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389172AbeG0UKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:10:13 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35262 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388871AbeG0UKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:10:13 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6-v6so3724480pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 11:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TanQD+d7LdIbw0io1BUgGGGTWN/HLNDHztrgp/3rkq8=;
        b=SeW6GUeIspTSirkI+shn2iYVZxeU271X4a2EhoAMSeY372ivtWiBKX+LvPsi3+sklx
         Oya4ziotCU6SVTc6wbiU3+7CGjD2zOdRUY8sKTRhGJmGmmg6NqUOxeJcHuujgogzUzGv
         FPFILeZwLCtelFnN2pizkX345SIvcp+m0f4ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TanQD+d7LdIbw0io1BUgGGGTWN/HLNDHztrgp/3rkq8=;
        b=BnK3tMawE5xVDJ6jPR9hxxacUAOPJzU5SmzNqBccHienC8GpzZ2p7Rb2hwW7Gjrisw
         LHZzCA+udiMBnSGMEr84ZImdX8nIWuM1+A4V4fuVkhWQVrI5Fd5+2BcMxUhvg7phNx8c
         vp46c/l9W0ZbFp2wES9V1Lcj8novrbQ2C0YdNr+8jQWM1ndMdOHDHwLM1YwES/674AO7
         Uq+kBdyurAUYH0qaHp+awv/ub9xO6bs0R3O/LYpLuWcMhrDfpk1YO8qHg1jc6ZiUVGNH
         qumr0+Sfng+Qgh1YNqNnyo3rJP9o6O/XJiOdZNl4WMW9gX2jHhallfw1ky7KAdcTA8WR
         SHqg==
X-Gm-Message-State: AOUpUlG2xZbARUnwiwRI18fsIT6crwYg/fLMo3eujaKxG0a1BqaLH09j
        y1PgUJxgT9+RteH6hX8pxnx4
X-Google-Smtp-Source: AAOMgpdWw1UGVko+dJA3M6kYTG8A5Lfj39Ahgs3GSkzGuLNxlQgEHCwzQgEQIzWhXysOGuOciC7CtQ==
X-Received: by 2002:a65:4541:: with SMTP id x1-v6mr7054348pgr.26.1532717223938;
        Fri, 27 Jul 2018 11:47:03 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7308:c330:41b:cc59:b463:ec7b])
        by smtp.gmail.com with ESMTPSA id t69-v6sm13817959pfj.7.2018.07.27.11.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 11:47:03 -0700 (PDT)
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
Subject: [PATCH 2/9] dt-bindings: clock: Add reset controller bindings for Actions Semi Owl SoCs
Date:   Sat, 28 Jul 2018 00:15:20 +0530
Message-Id: <20180727184527.13287-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
References: <20180727184527.13287-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Controller bindings to clock bindings for Actions Semi Owl
SoCs, S700 and S900.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

