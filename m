Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221A7C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD35820832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DzwtsZiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD35820832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeK2AzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:55:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33342 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728510AbeK2AzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:55:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so9507630pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKV6tkSPqX0yNGtFVz2wCvLN8kVE5+HDG9FY2wblCzs=;
        b=DzwtsZiWIiRy3wdTgR3sjnHfn1Yl1KKUHMTN/2Hz9yXtpuEnd1JdEBlrtUMYkMPR9K
         N8z5C3kp4C8M3veRMJaUw7fyhUr2Un4Q0oYoy6NfNngOyT4gczNeWTawcs8/oWYUl7Q0
         +s+cFxxHHn86fSyoItsEZwq8YkanrFsY5HdzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKV6tkSPqX0yNGtFVz2wCvLN8kVE5+HDG9FY2wblCzs=;
        b=Ajs3GXMRIfGcIyIsFqPNM51UJJM/uBDWRLfzrkjGej5bn6trTO71kEgAmE2+aalrzB
         +tSZIAVEHEZIPlu2NymL82819KkofMgu2xVrBUnRfpGPAImzy4I4ulQBuEGEcDKjhdMq
         B0OvwWMePi/mX7oxmeIKsh19U/Mn5L1IC+I7LOfXlgJElPSkSXiAsv6n2tcKpxcJnLTy
         Nga/nVL2QwJ9//xLm9hQZbWuJNrI4dX2kiscpgPI87zMLKw3lV6rC01mAPfuQM30XVjY
         URKwmaa1YygA4b9eM4gZdF/zIzXVoSZqEYsrbuZwZoiZyP3TPyAXt1k9gGMClQTfXDy0
         jveg==
X-Gm-Message-State: AA+aEWZ6ssrp2hUpSwAK6ObUw3gZumUUY1Zdn9zxQ8oZPxQeRfHThRcN
        an9HUZ+7qplt5iCZO7wX70jm
X-Google-Smtp-Source: AFSGD/XWFL5O/M0B0rxLmWwaYv0XNykMX+xv8YPfVGwrYj66cGaZHmlkbgfyTGTwrAvfTqIIzE4S5w==
X-Received: by 2002:a63:134f:: with SMTP id 15mr33028221pgt.19.1543413196423;
        Wed, 28 Nov 2018 05:53:16 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.53.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:53:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     afaerber@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        overseas.sales@unisoc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 12/15] dt-bindings: serial: Document RDA Micro UART
Date:   Wed, 28 Nov 2018 19:21:03 +0530
Message-Id: <20181128135106.9255-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
References: <20181128135106.9255-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Färber <afaerber@suse.de>

Add an initial binding for the UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/serial/rda,8810pl-uart.txt           | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
new file mode 100644
index 000000000000..ee03116d7415
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
@@ -0,0 +1,15 @@
+RDA Micro UART
+
+Required properties:
+- compatible :  "rda,8810pl-uart" for RDA8810PL SoCs.
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+
+
+Example:
+
+		uart2: serial@20a90000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x20a90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+		};
-- 
2.17.1

