Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA050C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC10A206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IvJ3USwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394887AbfBMVdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:33:32 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34981 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436761AbfBMVcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:39 -0500
Received: by mail-qt1-f194.google.com with SMTP id p48so4495936qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cmHxjX3QWGEzbd3gID8OLJBVtbh3tUIgNET1gXVqzGU=;
        b=IvJ3USwho3JZnRpyvMASZ3XvtoUm7qzuHhmNDwX8q6yHGzn9uAMmmIBUHhGLFwgQUU
         seEUJTS1jYdirWnlwMaWfZ1STNzjOeoWD2lr5w+Iq9kcmhXGiAv5AI0sS8kMGxK6fBhg
         NRTtPwWJmnhk5bK8Pi+x3iXRRprvqNhlAgtk+kET2zt0xiNUFcTzmJPYTvA61T9WuwvZ
         JqGXRJMA+6qUJZCFLsTTyrteplKjo0NxVun0F3UTJDo9mHz0Dg3jqHGr5EnXhxkJFMw9
         XSHcgxBW+FlSHpqGy4SNfysvdA/eznrYPWnr0jqnKmArPcU77qNUYn0Dbrp4k670vAAI
         pRgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cmHxjX3QWGEzbd3gID8OLJBVtbh3tUIgNET1gXVqzGU=;
        b=lOxCd9Ik8J4aM2xhGZJ8J3L0Oz1nLHfUBW9a0ueOWhrTmj07xz7u2oi8wpQnje2mAE
         RzDC6+o7A6WdQYrLkADKdX+sLSlXc3+cEFT8b6WNitn2wCFNczQTVppU1T/pbtfEhUsY
         Vu1ZhoLb0uPSs2glJ/3TXgoglnHdaHLkvfNSibl2qB0PGXTFKZYEzvpjN0SCMapwzn22
         PYN/rMJM19u4zcYTyHxAmmWzzGm5s/EctkMZIGAn0f+EBaTps2lOTWoxJOW1ll4xn2Ii
         YBeeHPoOY3rz5PvvWFlYPujShqqHjeBM4KZWeih/SnxWX2yLqS/AEvJSpWlhG8dG/IVZ
         GVFw==
X-Gm-Message-State: AHQUAuY4Jk1i/xl3qKfGib0V9r6RjR6876ErNdV40TOx1uY0eNBHzShu
        nblT2wzSC5lFFW2b5pjoJWeopw==
X-Google-Smtp-Source: AHgI3IYW8+K14QArKauUWkZ9ZtqpL7O14AvEk/eB69PdquX061fTxlr8ZKWVxytrXleRGtxapCzz/Q==
X-Received: by 2002:a0c:941b:: with SMTP id h27mr260105qvh.8.1550093558210;
        Wed, 13 Feb 2019 13:32:38 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:37 -0800 (PST)
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
Subject: [PATCH 4.19 09/17] ARM: 8797/1: spectre-v1.1: harden __copy_to_user
Date:   Wed, 13 Feb 2019 16:32:15 -0500
Message-Id: <20190213213223.916-10-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
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

