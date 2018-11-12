Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DFBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0BA20685
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 15:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KFlVX/Wv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0BA20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbeKMBRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 20:17:40 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45313 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeKMBRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 20:17:39 -0500
Received: by mail-wr1-f65.google.com with SMTP id k15-v6so9777310wre.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZZI6wSh5pBPJOFFIecGp1d55HkRDAwN8pNlGpBqhGKw=;
        b=KFlVX/WvZWh0RyvkOLNMSKoL7A36jKg8fG/u01HAb7u6qWkO5UAmA8p0XZ44fn/X6z
         i8j2RDHRwIOyqJaDJfK2rKxcIt4Gmk04/OMS2OixvaEN6chyRmWNwV1MtTk+yys1jTXE
         F6WsmlljpN37edOmiBYCypLIlrgaNQ0dJZnbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZZI6wSh5pBPJOFFIecGp1d55HkRDAwN8pNlGpBqhGKw=;
        b=Gr861nNwxjFChjrPU/eWe2AOboPcegx+vvhsDlEqJXiwcTOEDRJDSCbzLXKRrkYT4u
         j160QSM7E/A1PxUra9tOhaWTgVJxEyVpoEn8vgR9zEgAz1Xrzb8SB2EuhDPSw/KEiBqu
         3HyyZDHLc8hsfusLE94ksyCbSVbpneDG5LLfqpUTiFp3HnWq3rpCR3Rmrh/V6VCRQeuY
         natmtxSH1I20ZsGLoyaqnWgPfQY0IglgpsIlilk92FwktiZg/Wa9gSoGzYv5olPNWecz
         o21tcL24gdIgdkxBP+/c7p1WVmpkIX4MAz0DiETi8nh2SCyXIuLcz032XCqyKuxpY3Ph
         8Vfg==
X-Gm-Message-State: AGRZ1gK4WsEgaIHmXjHtU++KKRZP7UIkkd+3ygojQa1RBJwqv21TVt4U
        nIu6oVJBO4YIHSEJvWJFtkLR3A==
X-Google-Smtp-Source: AJdET5cjTcrn5Mw2RMk1opMiUKI3Y/OxS1br/jE6G3dZ2v16tZUPR0o8ah+z65E2P6ix3bJGuCJR4A==
X-Received: by 2002:a5d:4b8b:: with SMTP id b11-v6mr1470899wrt.72.1542036236137;
        Mon, 12 Nov 2018 07:23:56 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:105e:a8d5:7c2c:2737:d373:11ee])
        by smtp.gmail.com with ESMTPSA id t82-v6sm11192849wme.30.2018.11.12.07.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 07:23:55 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v3 3/4] ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
Date:   Mon, 12 Nov 2018 16:23:41 +0100
Message-Id: <20181112152342.6561-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181112152342.6561-1-benjamin.gaignard@st.com>
References: <20181112152342.6561-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declare hwspinlock device for stm32mp157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 185541a5b69f..98f824d8b0f0 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -803,6 +803,15 @@
 			status = "disabled";
 		};
 
+		hsem: hwspinlock@4c000000 {
+			compatible = "st,stm32-hwspinlock";
+			#hwlock-cells = <1>;
+			reg = <0x4c000000 0x400>;
+			clocks = <&rcc HSEM>;
+			clock-names = "hwsem";
+			status = "disabled";
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
2.15.0

