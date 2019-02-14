Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DAFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6CA222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dwwaIIhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404331AbfBNCKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:10:42 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:41683 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393989AbfBNCKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:10:38 -0500
Received: by mail-qt1-f171.google.com with SMTP id v10so5174256qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 18:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cmHxjX3QWGEzbd3gID8OLJBVtbh3tUIgNET1gXVqzGU=;
        b=dwwaIIhGhe/W4fv0WLGZipxrqaTJg/oyBGMzOQ5IfacD3zPcmv4vwj2uiHmFq9QWNy
         5JPvOiad9GUL8bC6P7oGHiMR4AOxVlE+P6E39igFBrB3pv2Pczr92iGqyI4PjKPJUPpA
         x65m/MqQN62IhgWMpwGrc9yaparmdeII9TdnaREM2oxlvLC2b9otDSgIFbda/Ss1RQWi
         ebi9XIa3aNFeKyYxRH2zfPQxZUpgGd+Pz1OXmex5llrU44lvLBCSqofmN5iNmaEYIg6L
         iBtT7a28KDuwKj9c1a/8a6UXU1IWpGSth6KdlcLG72/qpZhy5u6q2WiPowFbqTfihKYe
         qMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cmHxjX3QWGEzbd3gID8OLJBVtbh3tUIgNET1gXVqzGU=;
        b=ZVOys//ZnMDwVR3afGWcNVEmITaII50q5MWj6Ea0+0+hf1Y2ovsr2LGdzYZKPuTz5n
         f7TKr6L+FTJFDoMWEG4JVPJhEGKznP3RI+AXjBmo3r/3lcjO2XqlaptIksDvr9+z0dIC
         pwSliZreUnpZtvs/dMhMfIwPhM/eh4Ly+/vv4n/zRJTyfw5RgyQmiJRVo2055ZSAsD+i
         lNnPvbgsKm1fRiYqYmtXC87u2qb3DGKYRwciVGHQPa1yvqzWbOf1nivDNCMc79hcGoVl
         1UtIP3XhtuwTcI/w7dpqbMIhb+uIlx55RcNgUG16VRAp0Gj3PGC0SjU3ZQXhlXw+Kj0E
         /kuA==
X-Gm-Message-State: AHQUAuYLoHhvXY3MB8UNBWozQA17cU9TY04x2vskuSBf/gbw4iFAN8v2
        Jbtrpf+no0793Qj051IZIBKlyQ==
X-Google-Smtp-Source: AHgI3IbOJ0G/C9jKSa9gSfu5KY19PNsZDByWcebqN0yAJbWGCFZfEZvLsjhYnORACPzBc8i4S0rGeA==
X-Received: by 2002:ac8:34ed:: with SMTP id x42mr1062788qtb.173.1550110237197;
        Wed, 13 Feb 2019 18:10:37 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id d63sm1091575qka.22.2019.02.13.18.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 18:10:36 -0800 (PST)
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
Subject: [PATCH 4.14 V2 09/17] ARM: 8797/1: spectre-v1.1: harden __copy_to_user
Date:   Wed, 13 Feb 2019 21:10:14 -0500
Message-Id: <20190214021022.5313-10-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190214021022.5313-1-dave.long@linaro.org>
References: <20190214021022.5313-1-dave.long@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

Commit a1d09e074250fad24f1b993f327b18cc6812eb7a upstream.

Sanitize user pointer given to __copy_to_user, both for standard version
and memcopy version of the user accessor.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: David A. Long <dave.long@linaro.org>
---
 arch/arm/lib/copy_to_user.S        | 6 +++++-
 arch/arm/lib/uaccess_with_memcpy.c | 3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/copy_to_user.S b/arch/arm/lib/copy_to_user.S
index caf5019d8161..970abe521197 100644
--- a/arch/arm/lib/copy_to_user.S
+++ b/arch/arm/lib/copy_to_user.S
@@ -94,6 +94,11 @@
 
 ENTRY(__copy_to_user_std)
 WEAK(arm_copy_to_user)
+#ifdef CONFIG_CPU_SPECTRE
+	get_thread_info r3
+	ldr	r3, [r3, #TI_ADDR_LIMIT]
+	uaccess_mask_range_ptr r0, r2, r3, ip
+#endif
 
 #include "copy_template.S"
 
@@ -108,4 +113,3 @@ ENDPROC(__copy_to_user_std)
 	rsb	r0, r0, r2
 	copy_abort_end
 	.popsection
-
diff --git a/arch/arm/lib/uaccess_with_memcpy.c b/arch/arm/lib/uaccess_with_memcpy.c
index 9b4ed1728616..73dc7360cbdd 100644
--- a/arch/arm/lib/uaccess_with_memcpy.c
+++ b/arch/arm/lib/uaccess_with_memcpy.c
@@ -152,7 +152,8 @@ arm_copy_to_user(void __user *to, const void *from, unsigned long n)
 		n = __copy_to_user_std(to, from, n);
 		uaccess_restore(ua_flags);
 	} else {
-		n = __copy_to_user_memcpy(to, from, n);
+		n = __copy_to_user_memcpy(uaccess_mask_range_ptr(to, n),
+					  from, n);
 	}
 	return n;
 }
-- 
2.17.1

