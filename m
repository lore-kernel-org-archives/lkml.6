Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D38C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56ED222D4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPsLdv9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388791AbfBMJ40 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:56:26 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35451 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388917AbfBMJ4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:56:21 -0500
Received: by mail-wr1-f68.google.com with SMTP id t18so1759375wrx.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c+xpQ8Cv9S1rQLFgHBKpoTDBY527By8Ao8JL0Wyb+h4=;
        b=SPsLdv9/2+cGVKRHeOMBZ4eo31XIm8OAw1Y41wWWkOhU+aMle8fRs6CTn9BD/1YM1s
         VMs/v78ereqECZ/4pomBUxpprLZ1+d8KsFBJX3JZ2pVpQ4THXwvdMwIpwz3p7ISTXSx0
         4yFDVtGwfx2tCNm3oaSdMSBHfKAmVwRVQQFykWztlUtMrx5FZ9ckWt2GMvZvjhbcsJVj
         RQa1kZDBuWoN+UUFtwsEbIEBH0liNmSFny9F6+DdM6BzExUgHadT3libtRnyViEy8yQW
         4WSJedEbO2VQFG/AvBXz/ufQpZbfWASrl0IT4k3NrELxcBMhFKxP9K9LavK+JAS+LMJ2
         4SOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c+xpQ8Cv9S1rQLFgHBKpoTDBY527By8Ao8JL0Wyb+h4=;
        b=BQW0ccRNG1ButA7k0sy0+hj2cH/F1fRcFoa/WaMfrjm5AdRRvwkfbpyfrR4n4PsECq
         7snicyovHmuKnM/HN3GVx5zyI2kW8SVWGRLwa+nsXMZM1WD75tOLzpITCKyyylzgPnf9
         k3YtH1m2XtUmxWA/nbGGAQj1xgliULcqH/VJyxYjs7+0wRT8EX5zU/O/kuYwnJZJEwHg
         cCjaguZs//mHHV8LmrMuDge6HT/vny4VIRx0Zh8LKr0pdulcWojUP9/A6pfPQR2zNDpV
         C87O3gZQrMba0BQ/MPFeXVA9hc5510ZPMJUerag/AKFEIMgOcVCYpVQO7yaBEvxVn2Ry
         7U8g==
X-Gm-Message-State: AHQUAuZaWtxwt3IOGhn+n3ywPQtykliY+mu5MZrua5TmbZ42QkKq9KEv
        VsNmoLZroDihuj11pQsZhCjvFg==
X-Google-Smtp-Source: AHgI3IazIKAI99RnShuqfTxtkm4vLlbUGgnYpB7NvypPH0hNFAdvQ0o8esLZkU+ymvIs+nsJK+hVlQ==
X-Received: by 2002:a5d:4a89:: with SMTP id o9mr6181198wrq.323.1550051779598;
        Wed, 13 Feb 2019 01:56:19 -0800 (PST)
Received: from lmecxl0911.lme.st.com ([2a04:cec0:1008:7bdd:48fa:e18e:8893:ae85])
        by smtp.gmail.com with ESMTPSA id 2sm41244909wrj.27.2019.02.13.01.56.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 01:56:18 -0800 (PST)
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
To:     linux@armlinux.org.uk, arnd@arndb.de, alexandre.torgue@st.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: [PATCH 2/2] ARM: stm32: select ARM errata 814220
Date:   Wed, 13 Feb 2019 10:56:13 +0100
Message-Id: <20190213095613.31045-3-benjamin.gaignard@linaro.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
References: <20190213095613.31045-1-benjamin.gaignard@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that ARM errata 814220 is selected by STM32MP157 SoC

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
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

