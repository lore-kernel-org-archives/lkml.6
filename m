Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E946C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E69D21902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VzVvpheq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390620AbfBNCLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:11:41 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46208 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393937AbfBNCKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id i5so2680880qkd.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GrDWcqvz4w1IZM4bLnbt43ZL+fuuyvY4dihBlBpjGL0=;
        b=VzVvpheqp9hL5aBvqV+UN/IEz2gVnF1Cd2GNJPqgtpJxcEv0o4pOTs70+aKuKSm1tU
         4yuf6fy5j/ngR5niiCDuPZ1urSER5nY8Vu2VyLILOUjXsgbY6uP1q5Sfl2VmFELP1ZhP
         Ivu61ESd9zhK+pwXou8EBzthzF3fUsbcyyrv9obV29tsQhmk9N4xXNCnunAWNLutaHWA
         xlR6KTYV/46+gyXMLMErG2nHz841J5HP6jfeLuncyZ4cIWRlkjEpnPP4U7hMjnLqbSeE
         S3tmG2ohyBEE3oLDehlIhmtR0UcIVft2PQohanK3NDZkTuIcrVUuTn0eD+B/fwtJ8Jp/
         WjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GrDWcqvz4w1IZM4bLnbt43ZL+fuuyvY4dihBlBpjGL0=;
        b=dmisAWK2ow2hlyVhDxkDkl7j395VuPYrVF5LCSZR1h+HxlF6Pkzq0NbwcQX/YvL97g
         WjaczFUO9NDyTRy3QeSv3PXCdGvrPkU1Ty0Kfvd0sr/OuLxG2QBuVrSfWT4sg7YPO9Te
         w9HUZDtARVVN8/MuXEPHCne2ZacEjESq6kIG/pS0ZxDTwixjPwMpZQCN94nNBIrX3szN
         LATIk562FjG28gyiYNQ1fXWzIu9RO0119QwiGcme9s2ZktpCyRfsSiKorDvNIUBZjD6y
         XaXDy6DlvXtzAeqSy8aCfz1vn3qSrg/Gs/a9bvf6aU+PXlVattEoX9DvMZ1FMaoE319Y
         NAjA==
X-Gm-Message-State: AHQUAuY3njcNs+7UWCamwMJDNVcG0F+HSuiTwY1j81hi3v+3Q8zq0osT
        iHIRUsG0aXIvxajxkV191c1piQ==
X-Google-Smtp-Source: AHgI3IaYYyWqe9n1hfxRFdlH3JFi+4Eec1KQI0gP7QHpfay6mpCKQirj30l/dFG8TeXKP9DcSIgg5g==
X-Received: by 2002:a37:628a:: with SMTP id w132mr1008754qkb.60.1550110234410;
        Wed, 13 Feb 2019 18:10:34 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:33 -0800 (PST)
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
Subject: [PATCH 4.14 V2 07/17] ARM: 8795/1: spectre-v1.1: use put_user() for __put_user()
Date:   Wed, 13 Feb 2019 21:10:12 -0500
Message-Id: <20190214021022.5313-8-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
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
index 7d19584f5c39..cf50b030c62c 100644
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

