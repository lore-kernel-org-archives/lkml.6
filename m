Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CF3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27CB20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DuNvVWyY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27CB20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbeHAFYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:24:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33154 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeHAFYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:24:33 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so8096363plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Yo+LDLCDhPR78yjrPZOfTq5WVkY5aMuwoeScTScvKuk=;
        b=DuNvVWyYM2I0jhIGBxbnDXq0A0Gs0fFCYGxCEIBYhvCUviBTGpLMTm1eS3Oz0O7V/u
         jX0nJxufmdwf47TrFdXfAG2wHawc5jQR3trlvbG1rfm54vObbjSliLL1iywVu6Bvt9oY
         azCm+5mlEBeH3GXjJy7jPvFFzmpDU1Uzo3zt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Yo+LDLCDhPR78yjrPZOfTq5WVkY5aMuwoeScTScvKuk=;
        b=CCWnFVB1jDuffabkudxYJeumR/K0DD21xp8wG0mm/MYGDmlZFf5W0EnGIaPFeYoV/K
         bHYMIHsfnhTLd2sR7P4jDjiETYJH6HbIZKGHb/7jLU/nDm2LUXOlwLwlNYFNAJf3tgXq
         plyXdkH3XilRlEALsWDiVsgk4LE9UMuXxz1zj/PMPH6jm3pqywINdh+3I/ze1LXr9trS
         nGybhzUqsEa2IGwmiJUkkxxxXoiqFPW9Xlt8ldDFARlApM+YQmF4DbrIiT/StqXXVgK5
         kKzHjwEoqPPubWWIIqa0TqQgZJjuPyyT7ha2nzBuxxf+czdskBfqV1dQZQVSyIFW/UqJ
         78OQ==
X-Gm-Message-State: AOUpUlGjVR+Xr0fOU2jDgG5IT2zqtAjM5RcjdpPkvDdpzJJAS4V31WML
        bZbpjC4k4IfKzgBbLheITqyZ
X-Google-Smtp-Source: AAOMgpfnMYfHGrRngEZSriFdr6a5d6JSjznu1wV8Y99yxm/IL++6KqwyBDCxxO32Uw70xoKHsdH5nA==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4-v6mr23196504pls.84.1533094865650;
        Tue, 31 Jul 2018 20:41:05 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id d19-v6sm34879545pgi.50.2018.07.31.20.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 20:41:05 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org, lee.jones@linaro.org,
        arnd@arndb.de
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 07/10] arm64: dts: actions: Add RMU node for Actions Semi S700 SoC
Date:   Wed,  1 Aug 2018 09:09:12 +0530
Message-Id: <20180801033915.15880-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Controller Unit (RMU) node under the system-controller node
for Actions Semi S700 SoC. Also add the bindings constant header to
be used by clients.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s700.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
index a57f54587164..8498579504c7 100644
--- a/arch/arm64/boot/dts/actions/s700.dtsi
+++ b/arch/arm64/boot/dts/actions/s700.dtsi
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/actions,s700-cmu.h>
+#include <dt-bindings/reset/actions,s700-rmu.h>
 
 / {
 	compatible = "actions,s700";
@@ -169,6 +170,11 @@
 				clocks = <&hosc>, <&losc>;
 				#clock-cells = <1>;
 			};
+
+			rmu: reset-controller {
+				compatible = "actions,s700-rmu";
+				#reset-cells = <1>;
+			};
 		};
 
 		sps: power-controller@e01b0100 {
-- 
2.17.1

