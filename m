Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F85C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3357222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bT3kHfdd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405004AbfBNCK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:58 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35516 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404352AbfBNCKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:47 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so5213199qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JWWM0xAWumO0p3bY/5x9HLgVZOQ3s148CYkAGBmj6Ho=;
        b=bT3kHfddWoHjrWDizCUVqCfJci9GhpLD5WdiKcPx9Y6Xh6xad5lgywK8s1mOg27y02
         QotBuVnRS4fym+imfJ/3aIv9jA1z+WiYfT0k6Kw3FM0N16aQ1WlpQt0oIGr8fuo5ULh4
         K2/4vkB77v7jLnFQj4sxAanlpa5QVZ5Ih2NCq5hOXpODH61LocWaDRHRurs00Kf3RR8S
         aZxMGLJgD8OjczBDYplKPCfkAe0fsCSFNLV3MFfiY9+hjg+AxUNeDM0jZuj3QZD2vPm6
         Gh/P0w6VNVUH8s4ppUgnkZuKFSvLX66fiSdol/3PFrwvTeCyXB5aTTrjMmuwM/WOd8lu
         5elQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JWWM0xAWumO0p3bY/5x9HLgVZOQ3s148CYkAGBmj6Ho=;
        b=b3P29SrtIhNM6Sa8IvVN0RWofH/zZ6M8Lf4KX6QwVtXcLnNSxKgGw853cvi8nl7d0i
         2J1DIzOiR2pXE+cDMcf/CZGndHJvPFEzikD7Cpp/c4UdVDKbAHrVL8q20CkfFxtTftYg
         dEYsd8PtVY1HRrBgm+SxZX2DcZUgsdtxiYx5I7WjrcbRDn3swCBXpnsplFhdcrj0zfGm
         tXKUlvdjwfJ+Lpi2UkL1gu04zlH9NfGBCAas/aAWwlN78BVv5J7hG0/JyoyxP9fPYbot
         hhD2OLeVVKV4omub7OyEw2Ux5ZH9+Nm6VsWmEkRFzV/uZe6R2TSgcrthw+eYHa+yAnOd
         +w8g==
X-Gm-Message-State: AHQUAuYrLAQoTraiUZgglMy9grYAjnAt4kBOqWyY0d/Yj1cC6IwCWNC9
        qeXV8x1iIpWd3GYj8CM0hDfIcZ7NmEA=
X-Google-Smtp-Source: AHgI3IazptIldckFE+JpS4X8VLBIbLvw497vjBxkeyWoq09DUgmSPtkMKbQh84Uxc//yagtB+DHsxA==
X-Received: by 2002:ac8:814:: with SMTP id u20mr1011078qth.313.1550110246693;
        Wed, 13 Feb 2019 18:10:46 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:46 -0800 (PST)
From:   David Long <dave.long@linaro.org>
To:     stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Tony Lindgren <tony@atomide.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4.14 V2 16/17] ARM: ensure that processor vtables is not lost after boot
Date:   Wed, 13 Feb 2019 21:10:21 -0500
Message-Id: <20190214021022.5313-17-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

Commit 3a4d0c2172bcf15b7a3d9d498b2b355f9864286b upstream.

Marek Szyprowski reported problems with CPU hotplug in current kernels.
This was tracked down to the processor vtables being located in an
init section, and therefore discarded after kernel boot, despite being
required after boot to properly initialise the non-boot CPUs.

Arrange for these tables to end up in .rodata when required.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
Fixes: 383fb3ee8024 ("ARM: spectre-v2: per-CPU vtables to work around big.Little systems")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/mm/proc-macros.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 81d0efb055c6..19516fbc2c55 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -274,6 +274,13 @@
 	.endm
 
 .macro define_processor_functions name:req, dabort:req, pabort:req, nommu=0, suspend=0, bugs=0
+/*
+ * If we are building for big.Little with branch predictor hardening,
+ * we need the processor function tables to remain available after boot.
+ */
+#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+	.section ".rodata"
+#endif
 	.type	\name\()_processor_functions, #object
 	.align 2
 ENTRY(\name\()_processor_functions)
@@ -309,6 +316,9 @@ ENTRY(\name\()_processor_functions)
 	.endif
 
 	.size	\name\()_processor_functions, . - \name\()_processor_functions
+#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+	.previous
+#endif
 .endm
 
 .macro define_cache_functions name:req
-- 
2.17.1

