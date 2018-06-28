Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05210C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AA427776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 18:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9EW8cBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AA427776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967729AbeF1SM6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 14:12:58 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37106 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934003AbeF1SMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 14:12:55 -0400
Received: by mail-pf0-f196.google.com with SMTP id h20-v6so1042237pfn.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 11:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iV8dHRf+AgYsOrezJwGHzPe61QQcH4jdYWHAeIXuTcY=;
        b=C9EW8cBDXl4c2wthLw8ZK3Gkq2JuJk+zprVapCGvESR2qmNfqLzz2XOM+p8R/O4lJN
         p39T9QStOTbL8Lt5jltLOochqT2YVgvlB8tiOr+vu69gNbrZ6w6ujvsCbvphU6nUD6+5
         MIfdP6St0Z0Xd4defNDXB8GjpUQiMCRXY02Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iV8dHRf+AgYsOrezJwGHzPe61QQcH4jdYWHAeIXuTcY=;
        b=qa6No2cFlR5jP8TL+gI9sLY2JL1b4eQChC1IPuoTNEX+Dpb0gH9HgD6xXHj11Hn5Oh
         Okr24yK2jytLqqJmFs0BV9fzR2sHk9zLmmzSmLA18+ok5rRXhZCVu6f67xuClJi14KRC
         oZUUdsTIcQR+5ZptfkWHTe+SYaP8OoTWhLvzZdw7wKEa7VuSHfXDDuXVgkmmDgYyLSEM
         RlISfiJJ58RisldaVr6/96FIa/5zp5LwagiryWXVPHTkfYq80ZT1kYQx5t4kiNzdq6iJ
         MJx/mpZPTEYdy3m2++kblTmxIN6un4twdzychKhwq6pnFtYHOcuO75B7eZTSvhoS4Rbm
         2GnA==
X-Gm-Message-State: APt69E0KBxhobwa9P0nYJZT8a6zmR7j2b/iMbAscvvQSSREOSo7uCqfR
        /ayRnGkQ4EPFmynEDnEWoVJ/
X-Google-Smtp-Source: ADUXVKKqmpKHillipJuGfyvm1otSO0rfuDxTMbvvt5p/3beBv7pKgxnFsVVphcwd2glgi5Wv0rfvcw==
X-Received: by 2002:a63:8c10:: with SMTP id m16-v6mr9895269pgd.120.1530209575220;
        Thu, 28 Jun 2018 11:12:55 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:7141:9f8e:c1c3:7dd1:e694:9dc2])
        by smtp.gmail.com with ESMTPSA id o13-v6sm13293132pgn.93.2018.06.28.11.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 11:12:54 -0700 (PDT)
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
Subject: [PATCH v2 6/6] MAINTAINERS: Add entry for Actions Semi OWL I2C driver
Date:   Thu, 28 Jun 2018 23:40:42 +0530
Message-Id: <20180628181042.2239-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
References: <20180628181042.2239-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry for Actions Semi OWL I2C driver and its binding under ARM/ACTIONS

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

