Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50448C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1961E2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4aE/9tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1961E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbeLJRh7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:37:59 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42834 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbeLJRh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:37:58 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so5723044pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
        b=T4aE/9tVdvdKbD1qV6t56JGFjbK5DnIBBewRd1FAVKSLl2ircbuiqvbq4IujPowJfJ
         0fQ1S9frWf49eaZhnA1iyCFA7xEOoCM0btUoKccwz2VUcV79S+rmzC7HxL94H7nBnhms
         KdRPO1VXtaFvvevtbn7ISihZ1+2TimQPTPz7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
        b=A9CMFLEfHCLGYO7XjEhc9+hJAhVkr2gCC6a5tZGOYwkRloFg7e7R9JS6Y/G5VE/KEO
         eKmqZYtZhwt7uHHxywktN/FxUBThhWviaf0zxPUM5ztbhz8pPMwQ0API9HJgZ4da/5qv
         3C+TUusnq0ZDo2yhBUE8Mx2M4kLmloMt9x+SQroE+SUOn8ellBMH/ModnFfqrerxz1lD
         Zv6kvFIfTmG5cZlM4pgiPLzeltZH1+MTdJ4L7acj+i+4p7ywKyHppn+o029mVmoNd5YA
         7LYDz0B5aVfyYQpGLQHEcLdo5pkaVSYKAdLTJ/ux+e3gVrkqXJecaAusPJuPAYFGJnw1
         iR+Q==
X-Gm-Message-State: AA+aEWapR1tYCQZntzTslEAdwZOXbrvG/tPa8w3atAY47NlDsEvFJ9/M
        B/L6FyvfQDBPYx2M5ugOEOa+
X-Google-Smtp-Source: AFSGD/U+Io0p59DhFow06bx9KYAM+nPTTmsP/eKC8VLs20FZttEOnHkV9lu/f6Z/PSYevW/7qi9PYg==
X-Received: by 2002:a62:cf84:: with SMTP id b126mr13041885pfg.98.1544463477719;
        Mon, 10 Dec 2018 09:37:57 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:37:57 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        daniel.lezcano@linaro.org, gregkh@linuxfoundation.org,
        jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 13/15] ARM: dts: rda8810pl: Add interrupt support for UART
Date:   Mon, 10 Dec 2018 23:05:48 +0530
Message-Id: <20181210173550.29643-14-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add interrupt support for UART in RDA Micro RDA8810PL SoC.

Signed-off-by: Andreas Färber <afaerber@suse.de>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/rda8810pl.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/rda8810pl.dtsi b/arch/arm/boot/dts/rda8810pl.dtsi
index 84baa4c0a14c..19cde895bf65 100644
--- a/arch/arm/boot/dts/rda8810pl.dtsi
+++ b/arch/arm/boot/dts/rda8810pl.dtsi
@@ -71,18 +71,21 @@
 		uart1: serial@0 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x0 0x1000>;
+			interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		uart2: serial@10000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x10000 0x1000>;
+			interrupts = <10 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 
 		uart3: serial@90000 {
 			compatible = "rda,8810pl-uart";
 			reg = <0x90000 0x1000>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
 	};
-- 
2.17.1

