Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305EBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF40223C8
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 14:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fZAZvkMx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECF40223C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388073AbeKNAqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 19:46:51 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36631 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388027AbeKNAqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 19:46:50 -0500
Received: by mail-wm1-f66.google.com with SMTP id s11so2339099wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 06:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tViHdIAuLMf4y+erSnn2SN2Ls3FS2y77jwRN5WdfaDk=;
        b=fZAZvkMx3wU7m5M2KMTls8VACVBeRAWc3sBVt327+YQq0DlBvsIrPn81KURTfLjh81
         QzJV0isikNHil2mWzO1Eoz5F3JAdQWSg41VFCVJAm56yshEQUGensBvt0S3toJgpQOYA
         OANMO2AEK9ZEGJ/MlCMUNyZ0aZlA16tRmk3Nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tViHdIAuLMf4y+erSnn2SN2Ls3FS2y77jwRN5WdfaDk=;
        b=GuHI/nNxsCF644cwT6Fu1JRxMEC6KqHV7Z21RuIbLosDz+K2RsPz5Z4RZ6Qd0ShPRN
         NZpBaj0VnpCjmhLSrBXkWAUtpYGjsMbN4wiCKjQj4+Dhzzux8kXMrFJLs6ADtAYvIjsw
         xmQgcohnsUF85oir6bgmkgg835OVvYiC1AoufaoOIcGl072N92Z4uy/cd4t9ZNqUY+Xy
         8dYC1NzpDyZobyM7yyvh3w3wtUY2WohctPxVXI3DxWZU/xYxZ+HjDVk67VEIztC1vEQx
         EgVd4PKt9I2WGSB1z56uX75Ei3D2qEEOqNY8BSIm1UVCDuTmeQDRRx8TcW1kDWtYEFr+
         oc2A==
X-Gm-Message-State: AGRZ1gJK3nFswbgBC5VGaEgRDYhbF1unN0YRqc2M6czJlP3OXb3fhX8H
        pGnijd6oj3Qyencf89d6hJIKfg==
X-Google-Smtp-Source: AJdET5dXAOBBIuVq6yayP2ZfwuuGvpyTbj6YUhImr/A0+6C5QPTG8Qro3B2/JFQUxxKVBvQ1JCfpxg==
X-Received: by 2002:a1c:3b06:: with SMTP id i6-v6mr3399267wma.18.1542120500422;
        Tue, 13 Nov 2018 06:48:20 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:8cab:bca7:b2f2:d2bb])
        by smtp.gmail.com with ESMTPSA id s16sm3292020wrt.77.2018.11.13.06.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 06:48:19 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 3/3] ARM: dts: stm32: Add hwlock for irqchip on stm32mp157
Date:   Tue, 13 Nov 2018 15:48:05 +0100
Message-Id: <20181113144805.1054-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181113144805.1054-1-benjamin.gaignard@st.com>
References: <20181113144805.1054-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a hwspinlock to be used by irq controller

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 98f824d8b0f0..7c9ee32b775d 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -824,6 +824,7 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x5000d000 0x400>;
+			hwlocks = <&hsem 0>;
 		};
 
 		syscfg: syscon@50020000 {
-- 
2.15.0

