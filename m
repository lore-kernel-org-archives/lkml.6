Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FD4C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7069B20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JnK364Fg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7069B20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbeGZRFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:05:00 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44531 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732034AbeGZRFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:05:00 -0400
Received: by mail-pl0-f68.google.com with SMTP id m16-v6so1000975pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/b+N2DvOUUyA2A2wTJ+2C32b3lKHmvgv0TH8hNrLKeQ=;
        b=JnK364FgCcvwl1hRoUw22bKaVzouoAVfQkln9dZo+3L7/CGrynFIZ9t06FSi6p2MBG
         7Z0ZjxSKmaweMpB87jx2J6qDT4XDWSumFzpzciNKMsFuLU+p/JtQz+I5O6EvJ9SAipT8
         gPnt2b2/B9vcW8/G/PPc1VK3brEDimfXG0xhQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/b+N2DvOUUyA2A2wTJ+2C32b3lKHmvgv0TH8hNrLKeQ=;
        b=AqQw2EPjyDBk+cBbKwYJGYJEe+WZkFta76WMYSkYpl7II/LJ+UUXna1ihoxO3zPRp6
         LPplbcXiRzrPb2zMjOnNmPN3rzXkiu6WGn2KBzHSZpGhhD4ZCn89w2DNfGcglK0msH77
         PU3Uj7D9s5pRBlYMufkFmslBPuh6snYPiRs6t6Gcpc1kmGPYdjGZFVgcbIbxoujUz5iA
         nWhldDzlKvy5PrfdWqaFcFtRGdcz63gjLHwfOa6hERefkZjQJ5CUX2wZa47BUK3XGsup
         UWx4g4t9jPeFgNtmwEb8MJH+4DwUv2PFexfkpz0yowwrMTbQELW86RRwCvCBoU/AVyO6
         Suow==
X-Gm-Message-State: AOUpUlFGhaTkXe7QTBcu8Mlr0IVo1SUEoa3mwCWEI3HW9XKAhbKy6yOB
        /oUViBf6t3ecpTikh8NgD1gD
X-Google-Smtp-Source: AAOMgpfZv40dlK4etd+JvCxAOy81N78nJkWXP3q6Em+oFRPFLzgMHt3rbqCtstI5+AmgmNHSMOS/Lw==
X-Received: by 2002:a17:902:1566:: with SMTP id b35-v6mr2437438plh.135.1532620055163;
        Thu, 26 Jul 2018 08:47:35 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:628e:aef6:6d51:3501:dada:e06d])
        by smtp.gmail.com with ESMTPSA id z11-v6sm3755322pff.162.2018.07.26.08.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 08:47:34 -0700 (PDT)
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
Subject: [PATCH v7 6/6] MAINTAINERS: Add entry for Actions Semiconductor Owl I2C driver
Date:   Thu, 26 Jul 2018 21:16:03 +0530
Message-Id: <20180726154603.5089-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
References: <20180726154603.5089-1-manivannan.sadhasivam@linaro.org>
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

