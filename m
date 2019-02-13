Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700E3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE83206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MzOyVW4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394898AbfBMVdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:33:39 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33112 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436747AbfBMVcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:36 -0500
Received: by mail-qt1-f196.google.com with SMTP id z39so4518731qtz.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Y9bjfpnIjOT82L5WN75hPg2gnG6Z+LcsZzLHUB1TZws=;
        b=MzOyVW4Ds6vkL8Y/zO0X8jD1DAb5GY6O3kQ39qkczIEmemCNKPrJYCWKTEGPZcvhLj
         oqbNB/eHgyKCShxs0F39T7zRkhQUgZxwb0LwiEMFgU2wfrAD2/wNGhxx2cF6mx66JJVi
         BGZyh6/XkwdlnKx2Shg/ISzfQDAZB840GPOPkg6ou95OAAVx++PnwWh49qx30F/3sAdQ
         9XqmvLIfMyZdmGcvVyM69WC+yo8aW+kskfuIZN7fNu+YzJ8ZmBI/7AsgP6b86ThTx7eu
         BpQZhNw5bNPUY8CKrwUySJ0duKB4X5YhLLvU9q/+eKJ7r2GqY2ZFIh1YfvKQoVPJ/OAK
         hkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Y9bjfpnIjOT82L5WN75hPg2gnG6Z+LcsZzLHUB1TZws=;
        b=GackY176lloiqFME6avoA8Cid9DiXCG1KbZL1PGUVR6KP1Mnq2X3tGcS52mSVhh1cF
         qmh0dan6aDDKYBxGI24MJ3aqHB00HMRt8fVQ/VifFj696wc1XcaPUUaYrIyCCwb5R2HC
         E164vqWrM30KNqS8dy+S2DAIiikm0w+dESaZElj1Gcv+sT9G989E0tmfO43kQqMhHW0X
         NElfbHGI2epbe8mAQMjaaQcC6GGoenswgDAQcEHjgwsDyccfnTlG9TVFVp69TxuXPjOR
         Xii748buJ3oW+3w+szblW/RJqzPK3EZFydOfKTJ/k6AD0plsSu+YmuAtb5bfpVmQrqOk
         94Mg==
X-Gm-Message-State: AHQUAuYuAzXNDK6w0UFgzCFgVQ5PjtPqjMJGfMDiW4KawCl0BWGcwaWq
        HMasCKGvC2psWjtoxc1VK9Zj0w==
X-Google-Smtp-Source: AHgI3IZpLedZO/Zy4OyyvE6dqteNaaVtgsW0nEdTvXN5uBvmTqhDJUVV0Djjr6W1HTQST2PeTfrwBg==
X-Received: by 2002:ac8:33d7:: with SMTP id d23mr206276qtb.243.1550093555522;
        Wed, 13 Feb 2019 13:32:35 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:34 -0800 (PST)
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
Subject: [PATCH 4.19 07/17] ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
Date:   Wed, 13 Feb 2019 16:32:13 -0500
Message-Id: <20190213213223.916-8-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit e3aa6243434fd9a82e84bb79ab1abd14f2d9a5a7 upstream.

When Spectre mitigation is required, __put_user() needs to include
check_uaccess. This is already the case for put_user(), so just make
__put_user() an alias of put_user().

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/uaccess.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index d65ef85fc617..1191e7da8fab 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -370,6 +370,14 @@ do {									\
 	__pu_err;							\
 })
 
+#ifdef CONFIG_CPU_SPECTRE
+/*
+ * When mitigating Spectre variant 1.1, all accessors need to include
+ * verification of the address space.
+ */
+#define __put_user(x, ptr) put_user(x, ptr)
+
+#else
 #define __put_user(x, ptr)						\
 ({									\
 	long __pu_err = 0;						\
@@ -377,12 +385,6 @@ do {									\
 	__pu_err;							\
 })
 
-#define __put_user_error(x, ptr, err)					\
-({									\
-	__put_user_switch((x), (ptr), (err), __put_user_nocheck);	\
-	(void) 0;							\
-})
-
 #define __put_user_nocheck(x, __pu_ptr, __err, __size)			\
 	do {								\
 		unsigned long __pu_addr = (unsigned long)__pu_ptr;	\
@@ -462,6 +464,7 @@ do {									\
 	: "r" (x), "i" (-EFAULT)				\
 	: "cc")
 
+#endif /* !CONFIG_CPU_SPECTRE */
 
 #ifdef CONFIG_MMU
 extern unsigned long __must_check
-- 
2.17.1

