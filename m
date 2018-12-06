Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09976C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C287A20850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y3BlfhLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C287A20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbeLFJ6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:58:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38895 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbeLFJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:58:07 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so350638wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 01:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kmeN4J5R9xs3mYXoP7Fp+Ey5CgaHJ7uOHwX9towS34Y=;
        b=Y3BlfhLgbisVYA/HIV/+Rab9fIIJD5TdZ8zHzsHH59V5T3VzZyqsiX8HjT3kG0TH8m
         T5U3jkD2uTSuFHxXKdFUFXitFt+8YK2r4HITacvlb4v16fW1JfXkvbRo1pJbFgYez0mV
         ip+dn+duTRTb/Ww/sm41Nwkvv5DDe4LLl1D8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kmeN4J5R9xs3mYXoP7Fp+Ey5CgaHJ7uOHwX9towS34Y=;
        b=qwcNJT3TLUcvUqQ4PVHV7+K1FvQ5uI4IN4cMXDmuw8RKOd72rFXshm5/KBNGUDaw/O
         c0tGcpDgMjxzUWtB0IEJYh5aCP+idDu2GRnjwqkTOVNHfGpOVoz16Joi6X5S1BJkmYax
         2ei78Q7DF30sdBpWSrE8wCjQ61A49Bxycv0kZImAevuG8fx5L+1oCtpFnDgVPBe+JYVx
         51oFcKvIrDiAA8fk8WX8HZ9Dby0eg8EAjMvrgZAcW5E3Z2crQiv+Kfvsjuxm6VF0uWiY
         8c2O/4uV/a90Z8VlPkqHQhs2ifAYxjfZ19Axb2tUbvJRbJd6XM1EyO2kWnPxKNVBd7bU
         VzAQ==
X-Gm-Message-State: AA+aEWZN9eARwh6pYlxXEREqIiM22k39Tjl7mhiWhC8wP7Litq/w/iNz
        UCChw+u7DouXP1Et4IkyCb5Y0g==
X-Google-Smtp-Source: AFSGD/UAS+ctTUuZ5fzn8SLLW5HTTPbxllBO1zOY8iCFJsTGXrsmCvCs6V+4YBhd5SkwX5aNhS3Unw==
X-Received: by 2002:a1c:8fc2:: with SMTP id r185mr18702221wmd.54.1544090285865;
        Thu, 06 Dec 2018 01:58:05 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:100a:b939:11c3:94f9:a500:590])
        by smtp.gmail.com with ESMTPSA id i13sm16527677wrw.32.2018.12.06.01.58.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 06 Dec 2018 01:58:05 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     alexandre.torgue@st.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH] ARM: dts: stm32: Add hwspinlock node for stm32mp157 SoC
Date:   Thu,  6 Dec 2018 10:57:57 +0100
Message-Id: <20181206095757.16363-1-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@st.com>

Declare hwspinlock device for stm32mp157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
---
 arch/arm/boot/dts/stm32mp157c.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c.dtsi b/arch/arm/boot/dts/stm32mp157c.dtsi
index f8bbfff5950b..2bd4394fd791 100644
--- a/arch/arm/boot/dts/stm32mp157c.dtsi
+++ b/arch/arm/boot/dts/stm32mp157c.dtsi
@@ -886,6 +886,14 @@
 			status = "disabled";
 		};
 
+		hsem: hwspinlock@4c000000 {
+			compatible = "st,stm32-hwspinlock";
+			#hwlock-cells = <1>;
+			reg = <0x4c000000 0x400>;
+			clocks = <&rcc HSEM>;
+			clock-names = "hwsem";
+		};
+
 		rcc: rcc@50000000 {
 			compatible = "st,stm32mp1-rcc", "syscon";
 			reg = <0x50000000 0x1000>;
-- 
2.15.0

