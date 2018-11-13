Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E35C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DEA922507
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XNTHJBvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DEA922507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbeKMTtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:49:21 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37801 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731876AbeKMTtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:49:20 -0500
Received: by mail-wm1-f65.google.com with SMTP id p2-v6so10716401wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5FLtnV+wQIcNUrNrHkM6Ut8LWj8aU2ocfMFyomIotT4=;
        b=XNTHJBvJR7vTHxamm+10/rQwlHl+lCQChVUq7XhhWIZv5VzofJ4v/Cks61vFvzAkrj
         JSnAgBerb+2dkykxd55Hxq5zoGPFwUmOMwQQ7+4SC2hITG+0NhusC6s9voQ+eDYnRx6e
         WKnc8zCO9PBIlhIW4//6y/+DLO/aSdzDtrTS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5FLtnV+wQIcNUrNrHkM6Ut8LWj8aU2ocfMFyomIotT4=;
        b=q3wlBhVs/6W648d4vpAuQxB5pTaQe1LOJOlXX2+VUN7DRzaLREHAMerUATU2u0wYJh
         Oe6U16CocK0npUuPlqpTR//erFjPxs9N9AaG6va60Vc6cDNtI4OkBhmISMcUv2kUy9qy
         xYccZi8Zprl/0ddTmO7NdQ6qSys4Rj3hdcxrCu9c28Z7gc5iVntAJRlmgxEGvM5/UbzB
         nXpTaOyKBCrC1huvSplw8umzxaWfJWL4yOeJjh88r+HY6nE/zlCZRLaSseVGxb2FpIwc
         88T5tPzainbtitggMYKzxS3Lr54oAHGTXOU6YHt/o8syG17FNaZbDu5uDnlt8hu2XRbL
         oc+g==
X-Gm-Message-State: AGRZ1gJJA2PDufbxrR9LQq/vSGOItH6+P0GTsF3G+xedH5N1Pns80V9a
        Ay4UMwJ0dIwtNYePKAJ4ozWtPA==
X-Google-Smtp-Source: AJdET5dPUhi4uro2/QGE51QkU/Nhi0ZKMAwzYNQoncmtj/ls/wRWoQGP8AITcZQxR5AVgZh6MluVYQ==
X-Received: by 2002:a1c:7ec9:: with SMTP id z192-v6mr2782098wmc.43.1542102721132;
        Tue, 13 Nov 2018 01:52:01 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1088:2b4c:8cab:bca7:b2f2:d2bb])
        by smtp.gmail.com with ESMTPSA id d4sm6044279wrp.89.2018.11.13.01.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 01:52:00 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
X-Google-Original-From: Benjamin Gaignard <benjamin.gaignard@st.com>
To:     linus.walleij@linaro.org, robh+dt@kernel.org,
        alexandre.torgue@st.com
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 3/3] ARM: dts: stm32: Add hwlock for pinctrl
Date:   Tue, 13 Nov 2018 10:51:42 +0100
Message-Id: <20181113095142.32015-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181113095142.32015-1-benjamin.gaignard@st.com>
References: <20181113095142.32015-1-benjamin.gaignard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a hwspinlock to be used by pin-controller

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
index c4851271e810..2886e5a6ac27 100644
--- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
@@ -14,6 +14,7 @@
 			ranges = <0 0x50002000 0xa400>;
 			interrupt-parent = <&exti>;
 			st,syscfg = <&exti 0x60 0xff>;
+			hwlocks = <&hsem 0>;
 			pins-are-numbered;
 
 			gpioa: gpio@50002000 {
-- 
2.15.0

