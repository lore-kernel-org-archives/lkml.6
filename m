Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A60BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCFB82133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MffBEizv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbeLRIGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:06:39 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38899 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbeLRIGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:06:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id g189so7446676pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
        b=MffBEizv6QiHPXKM+e83ZEZYoA1KC9gItgx0iSi6G9oDgRiYQnnfjrzgN318hsMC6Q
         IAT/Dh47Ks5pu8Svd/hK5ftpbrerRHcw0Yx0c+gkDdMnFaaC+zlFJhVyyYxmS+pLFsFS
         C0G6pDISGRxdKXI33oemt2XsNEqhF2assGZ5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
        b=sQBH0N8x3jILk5IijGhjsIp6tJItF19/Pzd2imF3l3Xx/irV1Ib60Q9aOfO+SWZfI3
         J6J87XJwhzdboa10tquLeIKtyIG0pz3vvLwkejg3DJbmfs7b+H2xtU7IfJ7V0thQMovS
         0mLX/EmXgRjJ79WzI8odfTU/qfEThQ/nps+awby1/VdIOSKoSx9lPQjnnF+IMKxa3ABl
         173M8Fnd51JNdg3aieXjOY24U8rFDZB8/c0ra1jFSv1HchfWLnKC9yJqfS8Rb+vDWOyF
         3IxxwtLbNHIEleeogL26QWV6nDJTaEK0zYCRHZV+Y3wEwlFULHHBBast+sDru7k0d4ai
         9qqQ==
X-Gm-Message-State: AA+aEWaX13F91yDmes/C4paBrV8MM+bKAf57LpWE0JLZJRpQmi1IwFHt
        FOuFJFZdOD0EB8tfO/QhwDfF
X-Google-Smtp-Source: AFSGD/V6n1jxQwzQiBjKKv+Wv2LUsskRd42kelksznlZGgsorN8iYDlrqQsF1sr29BaKb2nkjlvvMw==
X-Received: by 2002:a62:1e45:: with SMTP id e66mr15627883pfe.152.1545120395371;
        Tue, 18 Dec 2018 00:06:35 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.06.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 00:06:34 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 07/11] ARM: dts: rda8810pl: Add timer support
Date:   Tue, 18 Dec 2018 13:35:23 +0530
Message-Id: <20181218080527.10801-8-manivannan.sadhasivam@linaro.org>
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

Add timer support for RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 15547b138977..84baa4c0a14c 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -6,6 +6,8 @@
  * Copyright (c) 2018 Manivannan Sadhasivam
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 	compatible = "rda,8810pl";
 	interrupt-parent = <&intc>;
@@ -50,6 +52,14 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges = <0x0 0x20900000 0x100000>;
+
+		timer@10000 {
+			compatible = "rda,8810pl-timer";
+			reg = <0x10000 0x1000>;
+			interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+				     <17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "hwtimer", "ostimer";
+		};
 	};
 
 	apb@20a00000 {
-- 
2.17.1

