Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10C1C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74E0208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XmBpqSNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A74E0208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407096AbeKTDgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:36:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44317 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406280AbeKTDgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:36:54 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so14864196plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XKV6tkSPqX0yNGtFVz2wCvLN8kVE5+HDG9FY2wblCzs=;
        b=XmBpqSNhX67XnZAI8V4YG6QRxsnY98Qz1gMvD249R+PDOr0/Ol3LjekRawkgO4hjSY
         G6/f5L5cO6PoTf9kmMDd91uqAGGDfF/pqm9/hbeupQAEOsI1ne2A2oI28F22hm4T+Ay/
         r471d7yvsUdijDAvjryUrznpm2tYtLeAR7vxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XKV6tkSPqX0yNGtFVz2wCvLN8kVE5+HDG9FY2wblCzs=;
        b=Oatfdw10ci1W/LQHQ3EHwuwN67aW/i6MKTUYFUETNpZesaI/1T0IiOFu2usZ04FsDj
         LmNZ/sVC4F0snMXDmOQA3ggqjQ1uN72G86L86SMFZd1zF/dkBYFBXJ27TYdPrUudwYIy
         nBRspQnbIqSrsLCn4/6tnzWC19bAysG3yxRUEbEdIY3DG7Y7VCvWjeO3I+RSoUFhpy3Z
         C5p7HS2dRzQDb6kGQghuUMl9qaFGUCYFLV7Pf3eGA9kdSlWVl7vSqfIIr/KvvVWUS1i4
         nAl//xA87bhD86UXfvMV9/sCnXmHkomIl9aO9JJrdP0BQ+a8Sz4jB+RpKvvuEEpI4CWY
         I5DA==
X-Gm-Message-State: AGRZ1gLmjskTEr0wtdiS6ZbyI3e+2exRKYBoNaRTTyqMKkIBegHjugXU
        mSqn+gdgCXfUl63DJTjlHiHl
X-Google-Smtp-Source: AJdET5flriC4gY8ziKyEvsBBxbb4yRpyfzs+Z1CfYpVQPhFcQFqOn2AMTefplmZfzL0p8ugFTPxt4w==
X-Received: by 2002:a17:902:8648:: with SMTP id y8-v6mr23239933plt.159.1542647554488;
        Mon, 19 Nov 2018 09:12:34 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.12.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:12:33 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 13/16] dt-bindings: serial: Document RDA Micro UART
Date:   Mon, 19 Nov 2018 22:39:36 +0530
Message-Id: <20181119170939.19153-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
References: <20181119170939.19153-1-manivannan.sadhasivam@linaro.org>
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

