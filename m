Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F7FC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6712082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aiFQWEIj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6712082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeLJRhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:37:32 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43700 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbeLJRha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:37:30 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so5276394pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 09:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
        b=aiFQWEIjTJqW5cD7Yifwd/cRFPWpT7tiaTUq+kaUIWFy0HwQMtOX3GpS2TY6QncD83
         xIyp2/KlBjj2fU2RhRTaDkGyXH8y2luxRHobxBqsFr94fCG5abwR0KIzT6MfTa6dCUF4
         8qL0zmJxxdTS2bElMGhenfLNz1A8igc9c2RFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M9evsXiKq/f6/hJaxP4dc1I6TBIm55n2snnXtgBmQsE=;
        b=ADdlklNXWOnYyMUMGd85PcIJjWl6a9LZ0MAlrw0tLPTZLnoeqeZcg+xiUi1k5VijQV
         FcPJRaJHE0QvLevLseWve+g8bEm6+IOM4OI39cZXwXldy3/asOmocloQKyKKU6NifTUg
         Jq+PHAiIQDiFqD3jlx9YK+GPybr7+xjIe9fmVDxb0BaShCvBY3OLtZZV9BNpim1kEg17
         Fu0mGSyI55NR2D1aXW1506rNWyKOdXquP9vK8H9mvhxu5E0Ou/PDAkoIo9llyl0nGvwg
         X1mTm09UrE1rW/VYYUYWDvqj21SoVgbtcZ40J1hvp91Qqt8QV8O8c0DRJsO+c+LrcdvN
         8ywg==
X-Gm-Message-State: AA+aEWYmrzDe4+bDJRjVee8YbkC5TddetNUowcZ+fUh6tF8O+ZF1tADp
        1z5kKXKGmRwI8rNLdUXqXs3y
X-Google-Smtp-Source: AFSGD/UPhilp6RoQCxzrZ4fn66yfTtsY05W92EFkRCn1VJXgMwOc38i3haqhB0UUU/eE2THEbXf0dg==
X-Received: by 2002:a62:f907:: with SMTP id o7mr12906043pfh.244.1544463449240;
        Mon, 10 Dec 2018 09:37:29 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:91e:2c01:40e1:a028:b090:9e12])
        by smtp.gmail.com with ESMTPSA id q1sm15998396pfb.96.2018.12.10.09.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 09:37:28 -0800 (PST)
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
Subject: [PATCH v4 10/15] ARM: dts: rda8810pl: Add timer support
Date:   Mon, 10 Dec 2018 23:05:45 +0530
Message-Id: <20181210173550.29643-11-manivannan.sadhasivam@linaro.org>
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

