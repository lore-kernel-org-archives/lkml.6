Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BDDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E608206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 17:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmcUeCnP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E608206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407221AbeKTDgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:36:38 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43666 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406861AbeKTDgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:36:38 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so111500plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 09:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jBqjbleOR1XYLcLHKcw7C9MGOuQDlogmmYBwF0l/45o=;
        b=HmcUeCnPjGv3rKO0oslKqohVVIOwHxX54dueSObI1priLH+c1AhIdViI0RuN8Lc/2Q
         cAo596iXqK2aFT51VnSMoOIOEXefF4+TVz5HJ+o1ux1J4Vt+T/0iQ65XlD0PnigiwYir
         nk5XiqFCSV0ArSqbwK0MPIKG9dWtTVTINXQM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jBqjbleOR1XYLcLHKcw7C9MGOuQDlogmmYBwF0l/45o=;
        b=Cy7roorp+bAjzPyY26MlbRn3ZbHO64SPkVavYvtX9WUWFuvSVEhaQurJWY/ppJ2sun
         CNQI1mqa9ynVuPi7TmuVJZ/fIKbs+WJfaKZQl5uadgk0DDHu2h0ygxYhui7Yk5EAVXxJ
         Ddgqk5zXGbPpZQ2eXq9oglGzP+9Y+8WibjAIgJ7hX/dWMuUHLYHfU5cbVGdzKtMBdZMZ
         7jGL/b9ODw2k0B2kg7dopWRO3CUGBufULVu/vD5chbEQYwl/IDuKtBBbgS8l5FpOwqEQ
         /Gv2t2Q2wOma7SQrq7EwcFVc5gzobMtEitsqankYO3tAqfBd580hAJHLVblMKR2He6m0
         MODA==
X-Gm-Message-State: AGRZ1gL09zmY2NVxqpgNN8iXJaNufY7d3Gs2XGOlTuEZ9L9ecnYDlgD+
        wyc3+S9+otrWnk17ta7v2prQ
X-Google-Smtp-Source: AJdET5f5ZFJeJ8M4A42eK5gIdpNSsV/fL4NIXwNP47kda2ohDxhTKyWoH7KDGMNrpXHNt6xuPxaOhQ==
X-Received: by 2002:a17:902:6801:: with SMTP id h1-v6mr23061128plk.177.1542647538329;
        Mon, 19 Nov 2018 09:12:18 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:631b:44eb:3905:6402:e2fb:2d7])
        by smtp.gmail.com with ESMTPSA id 186-v6sm46175458pfe.39.2018.11.19.09.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 09:12:17 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        service@rdamicro.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Subject: [PATCH 11/16] arm: dts: rda8810pl: Add timer support
Date:   Mon, 19 Nov 2018 22:39:34 +0530
Message-Id: <20181119170939.19153-12-manivannan.sadhasivam@linaro.org>
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

Add timer support for RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 093d6980bfbd..470a18585deb 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -7,6 +7,8 @@
  * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
  */
 
+#include <dt-bindings/interrupt-controller/irq.h>
+
 / {
 	compatible = "rda,8810pl";
 	interrupt-parent = <&intc>;
@@ -65,6 +67,14 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0x0 0x20900000 0x100000>;
+
+			timer@10000 {
+				compatible = "rda,8810pl-timer";
+				reg = <0x10000 0x1000>;
+				interrupts = <16 IRQ_TYPE_LEVEL_HIGH>,
+					     <17 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-names = "hwtimer", "ostimer";
+			};
 		};
 
 		apb@20a00000 {
-- 
2.17.1

