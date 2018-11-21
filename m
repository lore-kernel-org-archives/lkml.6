Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C80EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C86213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 03:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LEjFpsOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C86213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeKUOLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:11:49 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36886 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbeKUOLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:11:49 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so3389392plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 19:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKV6tkSPqX0yNGtFVz2wCvLN8kVE5+HDG9FY2wblCzs=;
        b=LEjFpsOgz+0OPLB1VA0nGOoMSkQ2hGJNouKoLv6S26+cax3TGZRUiLYaGoN4ywnhAN
         jKg9HPE03PIwZIH+E5+gZf5s/QIEbmK+mOu+zRyI/KIr7uFxrUejXy8ou9pYNEyVCNb+
         5VRCWtCO/PSvyipvFwXZoxGZ2Q0VwBGSP8eFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKV6tkSPqX0yNGtFVz2wCvLN8kVE5+HDG9FY2wblCzs=;
        b=Atpp6s5ctscwd6l7sObSKLwjPtAa/y3Pk1MF8hlYl8kOUEwlUxul0FYC0iwsAvGPsF
         o56jTA4Ynj7Drt1f+CKogHXp3RZNOeDoV5QmNA1rb+sFhdSYVcrAs3FAGCJkLvVC2LCJ
         EiO9rcCRcAMMZCdhPaWbx43WUks9nenv7WUlrAQn3poIHeRhinGI0uwQ45nYWKt1uXHt
         YKOBvYaZki+hRXvd/za2UoSo6Q3aVNatnpHN3q9fVjhE1z0eHAzDEnzaCdWcJca+/u3e
         UF9Ec7t3svalmbt5LSwZOqaCNHQHDeNNdjcz6fQK7DEFoaEBUpJR1qZt1/WC2sudzEBg
         ybeg==
X-Gm-Message-State: AA+aEWbABehtPQhA+R3SzuMX+KJU/VQu+SFZgK4suXnamkkEeDC5QK3C
        f0KP4UFkTtzNfuhlcBvmbxrf
X-Google-Smtp-Source: AFSGD/WH6kcnRgiWee3vPoeC+X5fz9BHsjfblauBdhGsbTlw19x+oEoMg1RLNgnSNYfzu4K7ENOeTA==
X-Received: by 2002:a63:5026:: with SMTP id e38mr4441685pgb.123.1542771554867;
        Tue, 20 Nov 2018 19:39:14 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:98b:9501:106a:f751:df0d:9e68])
        by smtp.gmail.com with ESMTPSA id z8sm72025095pgz.53.2018.11.20.19.39.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 19:39:14 -0800 (PST)
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
Subject: [PATCH v2 12/15] dt-bindings: serial: Document RDA Micro UART
Date:   Wed, 21 Nov 2018 09:06:49 +0530
Message-Id: <20181121033652.12247-13-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
References: <20181121033652.12247-1-manivannan.sadhasivam@linaro.org>
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

