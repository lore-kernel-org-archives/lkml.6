Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BACC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBDC21902
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jG9k1VfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394028AbfBNCLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:11:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39328 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393918AbfBNCKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id x6so2706295qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hBL7Wb0KdnmLsxeoxyLW0Tbkce8RSkol6PC9Ygx296g=;
        b=jG9k1VfQvhqa9stEBXoUgTnHpRsxJKHOyYG1WWAXTdx1CMzgOPJoBBGUK3dDuJh7Jt
         InBZGJo4lOLCvI5fafIqykZup//rOWKm1rhQbXJI6Cgp0A6/3aWXP39Wln9mMvJ9Rmj5
         CzZIFCn1jm0BLYVKl0ftmtfkThwrB67I7iaifVBZG9noOu3KrdPiKNUIqQGHodhc3emd
         BzthAd+xwHF/wbv+FojoZDOaJHpKD+uLtVrcZFAJkNxjV4KdU5P4H040Mt0tR7UMl4wI
         3wCjfWy0XONYeVhoqKFxSKt5W8XA69GqUoUNvM00LDjQZPvUvKQcNPVV+g+E8CU8Pp6y
         lGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hBL7Wb0KdnmLsxeoxyLW0Tbkce8RSkol6PC9Ygx296g=;
        b=cKLgQeFarJ8YNs7fLi0BWaz4BfvMwWJI998X7VaUE3uM1JPSbCqwPhCcIUhP5NRKrV
         oOSflaDSMI8HC3PU5quemrDsvoGDk8gVbrv9gBLIDHbj/lSRPL7GG2oS2fF4lt5MAyWH
         5s1NNfgPlZ7AfmEMA5kuEo2JA1xBllJAsCOj3xPIfZiYDmxmezrszp/KDbokmJD0rPkW
         zPS+zHVOViC1jKTrWnZ2Cr91l2LMHbO/mJaIOwq9XjUoJuJLZBhgqARh1E1snUBdnQ4b
         pMPFUfmj+UMckG8lb3U+PDEjKJibiqllc56EkcQHUr4/MAW0wIFQwqoGL8Z26PwBDpt9
         36kw==
X-Gm-Message-State: AHQUAuaWDTjiDhi2q3YDtJRd5lmvChj+q3kE7P1/TxRXF298QHr7ozOE
        EyJPqgwxoVFwWAeEqecxvoZpUg==
X-Google-Smtp-Source: AHgI3IZcpwfSnjhLIPi5nDo695ajgpwp3u6zeBChihrC0pKX9ABdZSdAuhmul8NHt/UhyoAjdzHMqQ==
X-Received: by 2002:a37:4145:: with SMTP id o66mr920551qka.129.1550110233070;
        Wed, 13 Feb 2019 18:10:33 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:32 -0800 (PST)
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
Subject: [PATCH 4.14 V2 06/17] ARM: 8794/1: uaccess: Prevent speculative use of the current addr_limit
Date:   Wed, 13 Feb 2019 21:10:11 -0500
Message-Id: <20190214021022.5313-7-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit 621afc677465db231662ed126ae1f355bf8eac47 upstream.

A mispredicted conditional call to set_fs could result in the wrong
addr_limit being forwarded under speculation to a subsequent access_ok
check, potentially forming part of a spectre-v1 attack using uaccess
routines.

This patch prevents this forwarding from taking place, but putting heavy
barriers in set_fs after writing the addr_limit.

Porting commit c2f0ad4fc089cff8 ("arm64: uaccess: Prevent speculative use
of the current addr_limit").

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/include/asm/uaccess.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 4140be431087..7d19584f5c39 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -69,6 +69,14 @@ extern int __put_user_bad(void);
 static inline void set_fs(mm_segment_t fs)
 {
 	current_thread_info()->addr_limit = fs;
+
+	/*
+	 * Prevent a mispredicted conditional call to set_fs from forwarding
+	 * the wrong address limit to access_ok under speculation.
+	 */
+	dsb(nsh);
+	isb();
+
 	modify_domain(DOMAIN_KERNEL, fs ? DOMAIN_CLIENT : DOMAIN_MANAGER);
 }
 
-- 
2.17.1

