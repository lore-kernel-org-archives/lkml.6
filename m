Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B21C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097C82133F
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXJ3IW7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbeLRIGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:06:55 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44093 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbeLRIGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:06:53 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so7749151pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
        b=BXJ3IW7uYVqUSFHGn6zRnfhKmpfkZyk9RGGSU8gVMDkt6L1SUxV3i93NxB8DlWLJd+
         3Qs54lcPoImM9UuJ12mb252f4vEDdyhENsHSCl2sbEqRDEYAERrl4fTqVTqoqhn0q06z
         44BbHOaIDGhq1lyAePS4yjP0I5A4WG3EmzMDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3bKyeo3jAVxlIMumLLKO1Nw9oQMRPP9y6vXm+NkQhc=;
        b=Uw0oQSrBxdOxuV8ZwoIFvJhEBVsgLHqifiR/jzLQj2zIqnTbqZIJqppse5zLSO3ioU
         rISaavtidH6fgn14gpuBExXtjLm/3whu55uxNB9rjOY4hMO1T58hXR7wnJRnPQbvFehA
         03emOzhQToQmDfKzZxsp6zVyh15RHpXvU7R0HUFamAP/pocuB0NVloEaj2Od9RSROeYk
         9SRHLWoA1uOVbtFb0RXxvwE04Cj7miJflK19wOQphyG62yoVaSBXD1X5AvdxQ4Fb8oB/
         04nyRfcT5JXpF3py87FAL2Yhn8VRcWNkYSCd3cwv35BU+GhFkyKlRore3cD/ajrR07nA
         +Bsw==
X-Gm-Message-State: AA+aEWYEinxLnXRTMfqJOwAlD0etu9ye6gUzFfKlOmJ9lP1C1FyCI3hp
        NETFv66UPsnncCy9lSmOmqOZ
X-Google-Smtp-Source: AFSGD/ViSqwzomWYeiYBym8Z2HNI76a4fXi+BcPMIWXknJDVbFBJ5B5BzBFxFvSBn7vzU1uIDZj3zw==
X-Received: by 2002:a63:4d66:: with SMTP id n38mr2049614pgl.270.1545120412681;
        Tue, 18 Dec 2018 00:06:52 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.06.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 00:06:52 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 09/11] ARM: dts: rda8810pl: Add interrupt support for UART
Date:   Tue, 18 Dec 2018 13:35:25 +0530
Message-Id: <20181218080527.10801-10-manivannan.sadhasivam@linaro.org>
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

