Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E08C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BDA2083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBEeqMCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BDA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbeHATw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:52:58 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43589 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731967AbeHATw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:52:57 -0400
Received: by mail-pl0-f68.google.com with SMTP id x6-v6so9156688plv.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/b+N2DvOUUyA2A2wTJ+2C32b3lKHmvgv0TH8hNrLKeQ=;
        b=ZBEeqMCuqYkYK3Fgxl7+czSOyoffpI4T3hp2cDstd3VaPIHM88oglHVYmBDe1rJtE4
         jinpaZP3X3G6Ln3/VEGzm4omj3Vok4EvZDQYXMGwhepCV3i9Sl8vUdSogg0uAPO6hQca
         zWMrtYxv7aOYmN/9U2tnppAJcOJaQ0olTa3uQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/b+N2DvOUUyA2A2wTJ+2C32b3lKHmvgv0TH8hNrLKeQ=;
        b=a9553R2cmID/18j49by3DO2/XsStq/H4zlF8Yjc2AatCGhMYBi7Nev/gazOAhY0UD+
         bblsYRYTJWOqTkd8/echUsPbcR3N5GmsHcIHFOgJEb4elnsQ2oDCmzqMptNlgwqiJU1U
         cfewrNHhGEWr2iqy2fTATLgYqiwYQA71qw+lnGo0zUJEyQCqHFtZikNejyV1jGGXV6h/
         2+fQrDyM6V7DlvOGOU8yXLRPPEmix3ju5yN4u1huHr0+jnusZUXMqztEBeP4evBwXvsJ
         RaJWPJoLt61YyGnVdmGcinfSLzkWRCbTp+EDo8yZ+zteHP5guP6s3Di8VQxZLYC1BWfO
         FW8w==
X-Gm-Message-State: AOUpUlGu7Uf0c1IT0QWxQArCMAUtReiOj/LJf++BnEtuXfa7c4BepFvK
        cUiKflzP2AJhHlpx+AKpSZjX
X-Google-Smtp-Source: AAOMgpeyM9VtVhGG2TnAmU7eDCKaNId4JVLvj5M5IlVlYFlc4XzMnMeLW1WNkEntk52XNJQiDCQ7Dg==
X-Received: by 2002:a17:902:262:: with SMTP id 89-v6mr25400181plc.221.1533146762402;
        Wed, 01 Aug 2018 11:06:02 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73c1:5a70:e532:a47d:7290:5aa6])
        by smtp.gmail.com with ESMTPSA id x80-v6sm12961649pfe.129.2018.08.01.11.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 11:05:56 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 6/6] MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver
Date:   Wed,  1 Aug 2018 23:32:32 +0530
Message-Id: <20180801180232.23680-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
References: <20180801180232.23680-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for Actions Semiconductor Owl I2C driver under ARM/ACTIONS

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 09b54e9ebc6f..5084c62712fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1145,12 +1145,14 @@ F:	arch/arm/boot/dts/owl-*
 F:	arch/arm64/boot/dts/actions/
 F:	drivers/clk/actions/
 F:	drivers/clocksource/owl-*
+F:	drivers/i2c/busses/i2c-owl.c
 F:	drivers/pinctrl/actions/*
 F:	drivers/soc/actions/
 F:	include/dt-bindings/power/owl-*
 F:	include/linux/soc/actions/
 F:	Documentation/devicetree/bindings/arm/actions.txt
 F:	Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
+F:	Documentation/devicetree/bindings/i2c/i2c-owl.txt
 F:	Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
 F:	Documentation/devicetree/bindings/power/actions,owl-sps.txt
 F:	Documentation/devicetree/bindings/timer/actions,owl-timer.txt
-- 
2.17.1

