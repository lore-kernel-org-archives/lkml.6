Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A24792229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XpWeH7lS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439369AbfBNOuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:50:00 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44879 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407275AbfBNOty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:49:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id n32so7046480qte.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 06:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OZ3w/jmfXs2wPitKzfdSFG0201b2pR2doaOOTk38mKc=;
        b=XpWeH7lS5H+3J1QFhvbSoyLLqklA1vROnnRDJ+ITFcNghqk16goR7jMGIqnWxYUYDq
         dWz3W6p4SH88in/qqqxTriIULi9n42o5qOcDnM0/MAVT/EXCOdqrYcqBZpsXhrhqoK5R
         i8HjtnTeuHQL/s4D8tihJJ/oJvH7Hy9o8c7KJIRhFXMhvAcAP5tfgPbWMevhTFoNN5TL
         1s+rpeBTOh0uJvabSCOQ3BSUtJliKCOFkip48o10bT0wH7ZeVDxZ1gAG3Llv2ysWPtVB
         Dd1bfJkaJBuha5Q/GT/vUG+UMxbKebFjaRpWr1nH8dXYO633/6rgeqb+AlFOW1YFKJy3
         Cpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OZ3w/jmfXs2wPitKzfdSFG0201b2pR2doaOOTk38mKc=;
        b=DhpA5wxDXvo69mc3+jIit51cgiQpINs55y928hQvZo3MT6VCs4WQRhiYNHbySgCFp4
         Fd8xvyJRLJxHQQEU5HX5MkrH1a7mO1Em0WDtKMA3x4DPVriDROYRvk6nsGJ1zASbOj69
         zV95BbEQX/YAWv6+Dx74/Pbmnim/mkJCYVMDo0PuFI291a1UvfwoHQ9Ulc46nBU5KrgS
         672yt4I996UaysqITQw+oESj2rPsUz3kQC1ONCgT8QLCaavMTogFGlCmexUEFWyOhZan
         ENrv1I/nb5nVAzw00YALKIz0jw+VKBpA+MkhFv28cFnVu3MozVS57gQ2luREm0ECkgGX
         EBzw==
X-Gm-Message-State: AHQUAubiVbB9v79+DPDFAVx2fQ2mmIZNc7QOSTBbRWUcj/nd5o/4EoZr
        LWFGNbyAF+TPO5gJ/LUlWyJhfA==
X-Google-Smtp-Source: AHgI3IYDvHYEt1JOmFbHDHNBdaYonXbEGuQH4Yfe08E2etAt8PWdzu/HrFH+WXBCCyJrBbjKfP2gyA==
X-Received: by 2002:ac8:1413:: with SMTP id k19mr786554qtj.134.1550155793586;
        Thu, 14 Feb 2019 06:49:53 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id k66sm1498919qkc.25.2019.02.14.06.49.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 06:49:53 -0800 (PST)
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
Subject: [PATCH 4.9 15/16] ARM: ensure that processor vtables is not lost after boot
Date:   Thu, 14 Feb 2019 09:49:29 -0500
Message-Id: <20190214144930.27539-16-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214144930.27539-1-dave.long@linaro.org>
References: <20190214144930.27539-1-dave.long@linaro.org>
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
index 7d9176c4a21d..7be1d7921342 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -275,6 +275,13 @@
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
@@ -310,6 +317,9 @@ ENTRY(\name\()_processor_functions)
 	.endif
 
 	.size	\name\()_processor_functions, . - \name\()_processor_functions
+#if 1 // defined(CONFIG_BIG_LITTLE) && defined(CONFIG_HARDEN_BRANCH_PREDICTOR)
+	.previous
+#endif
 .endm
 
 .macro define_cache_functions name:req
-- 
2.17.1

