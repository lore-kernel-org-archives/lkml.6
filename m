Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54976C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A6F12509F
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 13:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8NGQkkb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A6F12509F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751925AbeF3Ne6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 09:34:58 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34862 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751838AbeF3Net (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 09:34:49 -0400
Received: by mail-pg0-f65.google.com with SMTP id i7-v6so5179417pgp.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jun 2018 06:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/b+N2DvOUUyA2A2wTJ+2C32b3lKHmvgv0TH8hNrLKeQ=;
        b=B8NGQkkb3O9z1Ad/bk2zXFbcrvVcHZBxlXOMSUF71WeQplj5vl7ctP+34eX5FDIUur
         UebRaEBWBb7LYZ8tBaI/xzCZ70TZDssrnf12ZNYxCP4HVNi8GBbbP1MtCdGB0t972YOE
         bwUWDEaW1U80UvZa90cWzUtzYc/uJO+gcX3hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/b+N2DvOUUyA2A2wTJ+2C32b3lKHmvgv0TH8hNrLKeQ=;
        b=nLDcg+/xrEU+oVWqNI/UeovmOCV9m7EkuKveh4jhZkRWb1Fqak7PLQ0We4Q38esbZa
         +YA7QcenS2CwAHy/eP0TDm6a5ubmKdOSsQIehvAvvaJ4b9i7cU3o9acF5nwTh2D1TCGD
         kh5N6+hB4dhayL5+o/1I5bz1jbNr63LmwVhIiBeicXMSY5MaM4+FRtrSH2wI8fT1I8Ci
         ENZn3x+Rz1h2Yqp3Jiaxbpd3lEcGk4BCm77ZtVyn8aLXpV0ba9YfEQeo+uVbwD7tKxOs
         sgIUH7PRzy2FO13U9raPCuB6Fw+6JGl9iCxMoaIj2i7ZSTZAEgD232ABugECTfUnn+xT
         t8Vg==
X-Gm-Message-State: APt69E07QY4wT/hTniJhD2zzAuwq4NnKOk2uqoi9KvBNN+4bj450lxbH
        Zeh+WKgDABo09v/cgAvhhzFq
X-Google-Smtp-Source: ADUXVKLO0j+o1NF7K+W+TrDK8/ATApV9QIOSK6NQlJiKVuou97VZcrShtfd9Av452j4ih4nDv7fwCg==
X-Received: by 2002:a63:7c5c:: with SMTP id l28-v6mr16063697pgn.352.1530365687977;
        Sat, 30 Jun 2018 06:34:47 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:73ca:b257:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id m10-v6sm18738778pgq.89.2018.06.30.06.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Jun 2018 06:34:47 -0700 (PDT)
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
Subject: [PATCH v3 6/6] MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver
Date:   Sat, 30 Jun 2018 19:03:30 +0530
Message-Id: <20180630133330.23858-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
References: <20180630133330.23858-1-manivannan.sadhasivam@linaro.org>
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

