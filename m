Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E78C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C522229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CfCP86VN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437504AbfBNIb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:31:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46630 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731646AbfBNIbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:31:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so5408644wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tD91WMqXaqgalqYQc7fEccQT9a1D1s8fFsgbNnR5LZI=;
        b=CfCP86VNJP3saEW8dXsAgGRyMQ77IFzw2YxFhxp6j2BsNIqLwq9QD1MBeT5t+raGYe
         Lei1SuLaf2xEvUhJ+A41lp85+8WixEnaa/pbuU+U+xoZVa+tejh8Yr5CCm+SyJ44XzXX
         aerNrCQdu5wKiL7FSfyUsXDxanH1x1hZMz4Ca9I2fRnB04sLWyj40nVcWTXoDB87+Kgk
         vgG/kr9VVvvCdWHOz10tO5zQBD/ZI8uKdYg60aD+daI5DFcKiruTramEDewzC5S5QbTX
         +ad3pr7CFMfrWbnz6Kqt7XOZN3O6jc0Leb/hjzvCoLuyLq9Nmtzv1gEqVKD+vWdN2kk7
         x75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tD91WMqXaqgalqYQc7fEccQT9a1D1s8fFsgbNnR5LZI=;
        b=saZ/Jvz8VfoZNGfzpf7gLiktxoPkiUwIdapC5y6r0/glPeIbaMOLD9BeN5Uq6L4CCJ
         NrTBpsPtUSQT5gzhKFGinfNAlM39/FutM9iZTeLGarfhAffvSAYqg31vMsIr9j+KyoQO
         3B9+oWkTuzzpXYsstddKycyeXStFIp7zSfyy4CwOWSKUxj3dmYeHi37YN6JpJzqz+Bqj
         +yjX/H1yoTw5OZkmDB73C9InfCoaVIwnzbdYv6jGI4+va/QrSCjW3ZtUB9IPDH5XFkOi
         a3n0fCH5SAuVly3IEAgt3kQe+CU8kLlFoP1oJv02vYmC4iEbqt+s6WugBRazSjoIOHQ0
         XgbQ==
X-Gm-Message-State: AHQUAuamPV4L1KC+7RJbGkoXR9q/xwOWyJjkJonx16GinmfKl+z/qP2I
        eIrdh7rwZz0p80y0goVnrNOs5A==
X-Google-Smtp-Source: AHgI3IaI9HhYQJmJbOenn3Ox4CqhbhWHyAbXzyLYanlwbz04Bz2Dn0aY4MhXRu2LOGnrXyjzuYQWuA==
X-Received: by 2002:adf:e706:: with SMTP id c6mr1798741wrm.278.1550133110672;
        Thu, 14 Feb 2019 00:31:50 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:104b:51c7:1dcf:5141:50b9:8a8])
        by smtp.gmail.com with ESMTPSA id q6sm944673wmq.4.2019.02.14.00.31.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 00:31:50 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     linux@armlinux.org.uk, arnd@arndb.de, alexandre.torgue@st.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        benjamin.gaignard@linaro.org
Subject: [PATCH v2 2/2] ARM: stm32: select ARM errata 814220
Date:   Thu, 14 Feb 2019 09:31:45 +0100
Message-Id: <20190214083145.15148-3-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
References: <20190214083145.15148-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that ARM errata 814220 is selected by STM32MP157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-stm32/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-stm32/Kconfig b/arch/arm/mach-stm32/Kconfig
index 713c068b953f..be2403fa3deb 100644
--- a/arch/arm/mach-stm32/Kconfig
+++ b/arch/arm/mach-stm32/Kconfig
@@ -46,6 +46,7 @@ if ARCH_MULTI_V7
 
 config MACH_STM32MP157
 	bool "STMicroelectronics STM32MP157"
+	select ARM_ERRATA_814220
 	default y
 
 endif # ARMv7-A
-- 
2.15.0

