Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF04CC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 936C0208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hij93kMT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936C0208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbeHAFZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:25:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43197 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731182AbeHAFZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:25:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id j26-v6so7102691pfi.10
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pMtZkUiBZBqnYApmovi97PV8cm0Fy0bqoc/nFXRacRI=;
        b=hij93kMT5GeMSDfBuPnFlKTJS36dUKeGmXoOl95ekzU5LUOIV6V4MMYJfNZR/fq9kP
         UKkTm4JW1YEZDeIPLLLJ5/ZPWOz2NF0PCkJvhUYcKG9Bp7OTcHwEdruU+tE2XCVxpJgy
         qYIxPDZNT88bUZBKqOH0MXZHLmTPKl5T5a444=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pMtZkUiBZBqnYApmovi97PV8cm0Fy0bqoc/nFXRacRI=;
        b=ND+GRQ2BX0hupbXmgwYYskuiGST6PC0s5erLSAKW7k3dxWa9LI0S+ko/hkvD3gAzwx
         QV0Kk1ICkTinH1FoNRgyJYOB29+u0N21Sy3JOhgb6Paa8xk730bPo2xWy+lyLnbwishm
         NQp21LBdY8B51g7GigmSMChOV/URvQx9EHmX6a+8C6boQvwatEBJnszke5fF2TsJJiCo
         pb2++bvPOSUUJWYMM5jaLuOwFQdYCvVfFXV8O1twPGy/wJ4zF1hvRNg1c+ItVix+zApk
         Socy8+YXyRhAuc7MIN1s/fGTeTI7r2p+yik0i+CRYZUCvm7pEGRszRpFIQbbajlPodGY
         8H/A==
X-Gm-Message-State: AOUpUlEaphYrEaM3RVcGTPe8CLtGpbDrLIh625am04q7N17NNgMVExm/
        N39lo8o0xOs8GklLIxJDpTp0
X-Google-Smtp-Source: AAOMgpcDnVQMXAOT9271vToMMexSlEF7u+uKoxFEUVYZVM475lGEIggQPkB5UeODTcZEuKHkJ+AydA==
X-Received: by 2002:a63:c60:: with SMTP id 32-v6mr23092486pgm.155.1533094897467;
        Tue, 31 Jul 2018 20:41:37 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id d19-v6sm34879545pgi.50.2018.07.31.20.41.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 20:41:36 -0700 (PDT)
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
Subject: [PATCH v2 10/10] MAINTAINERS: Add entry for Actions Semi Owl SoCs Reset Management Unit
Date:   Wed,  1 Aug 2018 09:09:15 +0530
Message-Id: <20180801033915.15880-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for Actions Semi Reset Management Unit driver and its
bindings under ARCH_ACTIONS. Currently only S700 and S900 SoCs
of the Owl family are supported.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9c292ef3c210..25934ae77ba6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1146,13 +1146,17 @@ F:	arch/arm64/boot/dts/actions/
 F:	drivers/clk/actions/
 F:	drivers/clocksource/owl-*
 F:	drivers/pinctrl/actions/*
+F:	drivers/reset/reset-owl.c
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
+F:	include/dt-bindings/reset/actions,s700-rmu.h
+F:	include/dt-bindings/reset/actions,s900-rmu.h
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
 F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
+F:	Documentation/devicetree/bindings/reset/actions,owl-reset.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 
 ARM/ADS SPHERE MACHINE SUPPORT
-- 
2.17.1

