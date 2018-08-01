Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6A3C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AEC208A2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 03:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4dhPdgK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56AEC208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733021AbeHAFYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 01:24:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37859 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732998AbeHAFYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 01:24:22 -0400
Received: by mail-pl0-f68.google.com with SMTP id d5-v6so2561205pll.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 20:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=87ctvXnEfYlfyPeonG8uMOze3/fxbszxeHlLbAhYYFw=;
        b=g4dhPdgKrVIDWcT2rr0rlzk9On0nFtMI4xE5GMSnCThE0Iq8pljshwpm3eyB8CSJR3
         yD7F8VA+J5BsoeusUUKdkf45NqO0CMjzguxYnYhrJ9wC6owqemBsnJs1Zvxn58R0GEHC
         TRkN5dhllk616WTjf6TBW9QmxBaq/h/gcSxW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=87ctvXnEfYlfyPeonG8uMOze3/fxbszxeHlLbAhYYFw=;
        b=aIiGnDwcPbIAOmqWOGEPCvXR2PKx1Z1RMoe9JSoSJQ7IoUAO5slaZP5qVJfjcHR9ag
         HUcan+d5iy3C4/Br3LtwtXE3NU/O64HHozoxTOdiqIo+PfVYuDCuZ1+nZqbI5R7ZHRGP
         aSN2n0l2y3V+guSApBHdYfYPOc/WCbb+0CbKnTzIvknUTtmzYsjkg38ptezZqPV9dd8X
         wyX8EDbhBg4Sl5hrd16dnFiohXNDBvnCygTHYMxdtMq7EX091V0vnDglDsHbF/9O0TAF
         15LgbTbDgOqHcOobOl+pew88jSQ81dm40xi8DQ4Qg5iiPI1hkE9fizwQ+P5FnKY+6fXY
         615w==
X-Gm-Message-State: AOUpUlHwfz5pICBuOHZcqTbcWJKeNHXvIcdyjqrBvaS7HPZUM7G6jJmo
        1YoRSxdi6+a+fe4XvyshK+uFiVliWQ==
X-Google-Smtp-Source: AAOMgpcfjTzvaiN6ctH0ZEtZXjZtB1DVSkrMudxRkoAXlK5MMB3DAeSkdtvc36srdp9qUgw8uC7v6Q==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14-v6mr22709509plo.139.1533094854810;
        Tue, 31 Jul 2018 20:40:54 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:730e:f0ae:ac4e:9cdd:28a2:4bf9])
        by smtp.gmail.com with ESMTPSA id d19-v6sm34879545pgi.50.2018.07.31.20.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 20:40:54 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        afaerber@suse.de, robh+dt@kernel.org, lee.jones@linaro.org,
        arnd@arndb.de
Cc:     linux-clk@vger.kernel.org, liuwei@actions-semi.com,
        mp-cs@actions-semi.com, 96boards@ucrobotics.com,
        devicetree@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com,
        thomas.liau@actions-semi.com, jeff.chen@actions-semi.com,
        pn@denx.de, edgar.righi@lsitec.org.br, sravanhome@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 06/10] arm64: dts: actions: Add RMU node for Actions Semi S900 SoC
Date:   Wed,  1 Aug 2018 09:09:11 +0530
Message-Id: <20180801033915.15880-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
References: <20180801033915.15880-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Reset Controller Unit (RMU) node under the system-controller node
for Actions Semi S900 SoC. Also add the bindings constant header to
be used by clients.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/actions/s900.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
index d239033f9599..a242d3193a6a 100644
--- a/arch/arm64/boot/dts/actions/s900.dtsi
+++ b/arch/arm64/boot/dts/actions/s900.dtsi
@@ -6,6 +6,7 @@
 
 #include <dt-bindings/clock/actions,s900-cmu.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/actions,s900-rmu.h>
 
 / {
 	compatible = "actions,s900";
@@ -176,6 +177,11 @@
 				clocks = <&hosc>, <&losc>;
 				#clock-cells = <1>;
 			};
+
+			rmu: reset-controller {
+				compatible = "actions,s900-rmu";
+				#reset-cells = <1>;
+			};
 		};
 
 		pinctrl: pinctrl@e01b0000 {
-- 
2.17.1

