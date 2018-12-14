Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C9FC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6197E206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NNHHszyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbeLNPLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:11:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46218 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730251AbeLNPLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:11:40 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so5728683wrt.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 07:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=auUSZFGFdGybS+YYFDRiniv29seLWmCuXr51Wi5g/uk=;
        b=NNHHszyhil0vep2OuKhPJ4YXwMqVoivDPKelCo7LbHUvfswVhqEFu6nXtYYXaBUUPy
         ZaOWMVO33M9VfvtSZVaATUZfOgQ3XfoeDXDUPZ8TK1syCAQ8zkjMwE1AamAF4OzXjJE1
         dpZfPJxEb3vtx+Vlv0DABxGUC1SPJEFe5jQnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=auUSZFGFdGybS+YYFDRiniv29seLWmCuXr51Wi5g/uk=;
        b=DOMzCthjNyOt1GPldPoXIpRgPT1MELR7h2kzFKFVAG2FEe7YNHQz/278LSXwInGJSL
         IUXKr3k/3QKwcUoukUZUWSSiMiT+mVyRwfz9dfSTamKQzvnqpIYmMdxQur6mENLMw6d4
         2wnG6n5pnsD6U3nFro7ovTjmCv4PNdJdT2KPz0mj2NyiS42DytHJjdUCm1tQlotb/4Rd
         0hfYZCHb2dw6q8/nkD0SWUMKcDhk3cTk+T9XZTZLr4hpcy8NiLVLRterYAsXfkGmQJi4
         MnvJvXXMebpP90LVRpS5rfF7XjRctygxsaUuOkrztMBpD+Pr7xf+ubK0UtC1zYYakNr8
         l7hw==
X-Gm-Message-State: AA+aEWb8oTqGn4sAl3BGdqMXXqW+TkrBixhhcOxVAtJ0b2sOHVj/n1nB
        jorJyDdAv36pKTa9g/ytYpEndg==
X-Google-Smtp-Source: AFSGD/W3NGU0hC84t8J7pRTbdkLoTlCyVJb3MJzJnZC9MCb7KNuHslAz3T1WVNHyYfwjqDBo2UmTrA==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr3041021wrs.117.1544800298961;
        Fri, 14 Dec 2018 07:11:38 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:113f:f362:2090:a70c:c5c6:347e])
        by smtp.gmail.com with ESMTPSA id i13sm3381567wrw.32.2018.12.14.07.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 07:11:38 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2 2/2] ARM: dts: stm32: Add hwlock for irqchip on stm32mp157
Date:   Fri, 14 Dec 2018 16:11:28 +0100
Message-Id: <20181214151128.10005-3-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181214151128.10005-1-benjamin.gaignard@linaro.org>
References: <20181214151128.10005-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Define a hwspinlock to be used by irq controller

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index 8bf1c17f8cef..cac0af371082 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -815,6 +815,7 @@
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			reg = <0x5000d000 0x400>;
+			hwlocks = <&hsem 1>;
 		};
 
 		syscfg: syscon@50020000 {
-- 
2.15.0

