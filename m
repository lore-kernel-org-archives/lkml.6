Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7012DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9022190C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 15:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emxoL1Kz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390118AbfBOPyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 10:54:09 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41057 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389661AbfBOPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 10:54:07 -0500
Received: by mail-pl1-f196.google.com with SMTP id k15so5139280pls.8;
        Fri, 15 Feb 2019 07:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uccmsO0qVZau17wPhnmEOlY4fogBW79/IYa238V6d90=;
        b=emxoL1KzvzBcIgE2xzDLh7qQzKB5SPIhFRdU/nNbfCtvQ3N2E0XxdLeXWEw5rtjIqM
         kRk6rj0ofsbvEBSyjwXDDG8RdvsAZp/t8rRWT0E95HrJuh5q6Vm0SeVxWHqDM0WD7Jn+
         uVBum94XxNDtNnfv8ap3JWNhdkbSBivgcE7W0fPGLEyZWXEtT6CZSa2+VM0uJlsvVWMz
         2rBn2+BMW3XzTmmS5JUUrlPnK/FTmXjhcGnmeXBvuA+42WEDvUAzGXRDTw8zg1U1ZTPC
         gZY69Q7rtlfVa1gotmkEpvX++r82UIVP94lp53OA+oqI69XmjdmR6oPFSm3yjYZfkU2l
         FHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uccmsO0qVZau17wPhnmEOlY4fogBW79/IYa238V6d90=;
        b=f4Pukv5c/3VnlIqRdhtqP87KYL/3LhDAMjqIBAyqA8cFWl/GZdEGbh3g3iE8u1dfZl
         dggQPk2cpxj/Y7ghhofoat+CqLjfi8V91NmxeKQUBU0x1uhZXB+LIRZ2v1IwjCw11aHn
         MDZHzPswiq7AXhjHbEqMjaKlRZ9vDGe7hM+SV84Ra7a9onTGFtWAzpChIVR9WU2WAq3J
         WcDQNVjdtkeVUoj/2DeORyQqIPAu//O45CdaV8vUfhJSrSpHYp1OXClqD7Y4/CJhaw41
         tQjeczSSiqU9pDQZZULmym1BnOGrU5rd2DkbyyJpks4AEUd5kNq1jOopzaBk8k3Ftpe8
         OczQ==
X-Gm-Message-State: AHQUAub1SspLT5PoQeVQoaockX5V2W97fdipII3BhakXaZgfHaQghd5c
        qFRDF7GReBaG03rzh8Q1BA4=
X-Google-Smtp-Source: AHgI3IbrDAhQRuLksuCQbodqFBztTLP/msRY10qRi8FyOrURXineipyQrjlm6aaywNpMUCb9I3dFLQ==
X-Received: by 2002:a17:902:8346:: with SMTP id z6mr6310437pln.74.1550246047408;
        Fri, 15 Feb 2019 07:54:07 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id f2sm6217792pgp.32.2019.02.15.07.54.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 07:54:06 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     maxime.ripard@bootlin.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v3 3/4] arm64: dts: allwinner: h6: Add clock to CPU cores
Date:   Fri, 15 Feb 2019 10:53:37 -0500
Message-Id: <20190215155338.10564-4-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190215155338.10564-1-tiny.windzz@gmail.com>
References: <20190215155338.10564-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM CPU cores are fed by the CPU clock from the CCU. Add a
reference to the clock for each CPU core, along with the clock
transition latency.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d93a7add67e7..723f5d991a74 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -26,6 +26,8 @@
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu1: cpu@1 {
@@ -33,6 +35,8 @@
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu2: cpu@2 {
@@ -40,6 +44,8 @@
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 
 		cpu3: cpu@3 {
@@ -47,6 +53,8 @@
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
+			clocks = <&ccu CLK_CPUX>;
+			clock-latency-ns = <244144>; /* 8 32k periods */
 		};
 	};
 
-- 
2.17.0

