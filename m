Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D763C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D043C2133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bqRxus8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbeLRIGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:06:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40307 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLRIGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:06:44 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so7752566pfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
        b=bqRxus8CEVj8x00GEJ6tPZFvSOeSdrZWpqKoGrOd+0VFFM7vST0FdEJg8tUILQR7sy
         xEw5UQsPhlbeZQPwBN6sYCJXLHrvPQ3Q9FhomxCBftgHOuunY/McWy3g1M59/W5ypScq
         tZzBeHz+n8n9mPud0gb81yWTanNJ3hO8J2tY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8+PRll/69hpVBI8tPhWaAoQEyS3IrjnhvvEZdMVHBc=;
        b=sPX2JZdHmQU01J8d3aisIEDPQdfYsJyi2a9mIuImpz4+xv26kJCgQRSVg9nGHkqtZQ
         V+249/MFLNbdnkVrTVzHWM/2mTs26pybTKkOHEkbJCiThS9G8wVkUuI/ueE4Vr8uCqb1
         ANQL0+AHfTSYYhqCpdq76Oh0hxXiY9Aslvizkl58n+fjXWkWnMvMLiTODlP2y6YEFGuL
         XJrHm95ihr29hDQXCXtTP1/xGxMP1tV5siGk9eEIbn8tguIfy/cM80JJ4IuzFrFnRZUg
         B8rExnI3mCdSaYctja0p1TDRD9Wij3R+s+z26PynX3DPFwxKV117AeMyGSSGSkXfo+4X
         BY4Q==
X-Gm-Message-State: AA+aEWZZQj2CzRlXzqTANsKRNWYZPxZ2FSJbdisOqN1fKQd5YrEtw5aW
        AFqmjjOR0pYrqNRB874p/1o6
X-Google-Smtp-Source: AFSGD/UtudcoBVycPlju1YFvp1c/6GqvVy4RLPUdo5T3hhOqyMghYv8PdFiTLmas8b2lU79LPnHrdQ==
X-Received: by 2002:a63:d547:: with SMTP id v7mr14713880pgi.339.1545120403546;
        Tue, 18 Dec 2018 00:06:43 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 00:06:43 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 08/11] dt-bindings: serial: Document RDA Micro UART
Date:   Tue, 18 Dec 2018 13:35:24 +0530
Message-Id: <20181218080527.10801-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
References: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
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
 .../bindings/serial/rda,8810pl-uart.txt         | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
new file mode 100644
index 000000000000..a08df97a69e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
@@ -0,0 +1,17 @@
+RDA Micro UART
+
+Required properties:
+- compatible :  "rda,8810pl-uart" for RDA8810PL SoCs.
+- reg        :  Offset and length of the register set for the device.
+- interrupts :  Should contain UART interrupt.
+- clocks     :  Phandle to the input clock.
+
+
+Example:
+
+		uart2: serial@20a90000 {
+			compatible = "rda,8810pl-uart";
+			reg = <0x20a90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&uart_clk>;
+		};
-- 
2.17.1

