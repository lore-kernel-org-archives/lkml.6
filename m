Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65654C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEE620832
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 13:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RvXNXcRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BEE620832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbeK2Aym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 19:54:42 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39130 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728348AbeK2Aym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 19:54:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so11135335pld.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 05:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
        b=RvXNXcRHZHMo+xE//oZmLxHt09geXet/i4djGs8nsnYgU0TnGrTLwIe22yMLEZPD6b
         pr44ZlN7dWIS3mwsxScfui2i/euRbNUNdbEJIYGiat1cABGiNyIaSxewoTOAtTq5LPei
         +2nbSpyjWQBlBdBiIvWVMJjcSgMByMJpjVv1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
        b=Jb56zw7We5rHT4W2FKlRtgG9jRQ+elhSkXAqQonQ8EvKsT+7Na8UPR8Gu3pkQrJ0Ty
         1Dzr7AsDpCix2FtQZ1D5C9LeUXKTv1yDsNGWcXQeOOWv8iRbnpx8oznbbnIavgbN6PhU
         Cd+Eb+a2eX7SZYyvrJ4a7OYiYD/h8EJCqc+G0bm9BmsUXagzUSk3WRlUN6jYj+Ep3N8W
         HCJ7Ng7ORXm11AhlmzLF0YVORBHuYJEgLw7krXJuePXlHG1O6Iv8yKuU7Z0AxMpXs2Rx
         nKteeU1NA3iVpO9inmqAGhb12V/P4ZC0nK/1w5palNOjoiBq3lRQPjsQJb8tJ0WEGYyi
         KVlg==
X-Gm-Message-State: AA+aEWak7VNp7ifCFuy7BgXAYU+XCsqg9uEOSSwydNzDns5F4NJqeXfu
        2THhhvy93UVFXhCMIOq6Pvpl
X-Google-Smtp-Source: AFSGD/X4qU9FeZG0/DvatsZXiVE5uX1w8JvpnUMvt8j8/w2oD00oBd/HRB0aCUPF+OshUbMCPrzCUg==
X-Received: by 2002:a17:902:8a95:: with SMTP id p21mr32550680plo.183.1543413178149;
        Wed, 28 Nov 2018 05:52:58 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:90a:a93f:b481:6fae:6692:c3ee])
        by smtp.gmail.com with ESMTPSA id c4sm22049854pfm.151.2018.11.28.05.52.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 05:52:57 -0800 (PST)
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
Subject: [PATCH v3 10/15] arm: dts: rda8810pl: Add timer support
Date:   Wed, 28 Nov 2018 19:21:01 +0530
Message-Id: <20181128135106.9255-11-manivannan.sadhasivam@linaro.org>
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

