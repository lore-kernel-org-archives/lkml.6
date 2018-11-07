Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49701C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0630A21019
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PsB/ogyt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0630A21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbeKHDUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:20:24 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41433 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbeKHDUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:20:23 -0500
Received: by mail-pf1-f195.google.com with SMTP id e22-v6so8002121pfn.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=PlgXOOwrJHJJiKxje6zgPJnsxvzU0hJfT3GJPdyu57s=;
        b=PsB/ogytMFtjBI1hwRaBYrKNWTJCAxT1zYJCLwWbOiOUBRl0Ny5Zn+YYPx7E0fcLmu
         U9msr5uVSn3xwBUaCFTAo925ow9CB8KaZi6sZL69NYxQ5glxtOBYlcgxBTVxqWdEf1ji
         uFqV/4wie7uxXsstS7h4rkaXu3SjFFNNROPTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PlgXOOwrJHJJiKxje6zgPJnsxvzU0hJfT3GJPdyu57s=;
        b=BxuKQBmvrbPt4hxnq1pOrNeFvU/oQZ5Q2OPymRdY+6cYIl1mYGWWsyeMR2DwSA2Xca
         FKS8KNkoPTlbEeYSRGCXXZUSLEYD/+Ic1t7ql4zGRdS2LXETHQ0vRL21ET0WbfBJONn7
         V6YCLyiL1+GrKqD5GHiNOUvbuOxyPvr/PAyGsMX9+0KazzgGZRUgk4DzYoEq/SCxwX6s
         Nir6M0hg1ER28O8hCKFqYFpN7j47zySE2nT55dy20XQjvRzdeA7FkvdtubXs3EbjMCki
         2zjRbKDUPUKaIxiZWm6B/h5v5+fTISqNRMg9mXdXacOMWhne6M6EQctDbfz617oLmrUx
         C4Lg==
X-Gm-Message-State: AGRZ1gKkHgvBvcorY+QHczCLI1is90NWHfWq+7IE+1cKyt24Jn+GBqTj
        0JXCHmjf+wEAZC52fXBWqXvG
X-Google-Smtp-Source: AJdET5f0EDE4y5HsosPfnVw7UlavGxGFj8Z6AqqITs2QJ9e3pJnQVvEdI3DoalPIA1Jim6Zs8kbUOw==
X-Received: by 2002:a63:f960:: with SMTP id q32-v6mr935759pgk.213.1541612937152;
        Wed, 07 Nov 2018 09:48:57 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:6282:6ca8:a0d9:6a81:97fe:992e])
        by smtp.gmail.com with ESMTPSA id e70-v6sm1232645pfb.113.2018.11.07.09.48.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 09:48:56 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, amit.kucheria@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/4] Add initial pinctrl support for MT6797 SoC
Date:   Wed,  7 Nov 2018 23:18:40 +0530
Message-Id: <20181107174844.5381-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds initial pinctrl support for Mediatek MT6797 SoC.
The pinctrl driver is based on the vendor binding as like MT6765 and
implements only GPIO and pinmux functionalities.

The devicetree binding document consists of pinmux, pinconf and
interrupt functionalities documented since the binding should describe
what the hardware is capable of rather than what the driver offers.

This patchset has been tested on 96Boards MediatekX20 development board.

Thanks,
Mani

Changes in v3:

* Modified bindings doc according to Sean's suggestion.

Changes in v2:

* Added devicetree bindings for Pin Controller
* Dropped the applied warning fix patch
* Added Tested-by tag from Matthias Brugger
* Added Acked-by tag from Sean Wang

Manivannan Sadhasivam (4):
  dt-bindings: pinctrl: Add devicetree bindings for MT6797 SoC Pinctrl
  arm64: dts: mediatek: mt6797: Add pinctrl support
  arm64: dts: mediatek: x20: Add pinmux support for UART1
  pinctrl: mediatek: Add initial pinctrl driver for MT6797 SoC

 .../bindings/pinctrl/pinctrl-mt6797.txt       |   83 +
 .../boot/dts/mediatek/mt6797-x20-dev.dts      |    2 +
 arch/arm64/boot/dts/mediatek/mt6797.dtsi      |   21 +
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6797.c     |   82 +
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h | 2430 +++++++++++++++++
 include/dt-bindings/pinctrl/mt6797-pinfunc.h  | 1368 ++++++++++
 8 files changed, 3994 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-mt6797.txt
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6797.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6797.h
 create mode 100644 include/dt-bindings/pinctrl/mt6797-pinfunc.h

-- 
2.17.1

