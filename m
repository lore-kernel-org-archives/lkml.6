Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD4DC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D559720823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E9JykKxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfBVIXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:23:46 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35951 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVIXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:23:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id k2so778350plt.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CWZpOa7KU5IoSG9K/3vLaR3fHpcin2VffNYLaVd5Roo=;
        b=E9JykKxLXU3+k4vQJjpERuNJgwqlLMYvxWPzlcoDPM4s+cbq4WMQ0swQVCbYdMDISL
         iJKV68RQ/EIyFU3hfa8393jPd6Aqbq6IBo2ph/gROiRMlHFGhQSyQ/UY/+HBwhDWK967
         Ayz64rJ09cxSRy1x06vCxiU9EaBJCnx8LMa5kzfj8e+zbJpKACzO4ixm2dw1JCJ5rwR6
         N4wHGXkLrKU50tsEGFyYyRrAG5kmj/J+HvSLF0lDGv570H6htjawDDrc5ZqhxrhU2IzK
         tI2juO2pHVCJY99UuLB+Y5mU13QgvatV2cyQWjrjfspX123dEnZifYcd8tNqxYU/DOj+
         I8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CWZpOa7KU5IoSG9K/3vLaR3fHpcin2VffNYLaVd5Roo=;
        b=aw83wWKAEPLzOtx8h76VFM0p1MjRbD5kaoo8+cgKm1yFOTrv+hbrmDrmaxj6AjL16X
         sJ9LWOF0wvxKpUyrtVC7UkkgrTohy6sC9pG+c3DlZxOp5aB61qssmOP6tOBDJybZ6Yuo
         8uiCzc9WX6aqBFZier7QURnRh2kgVbhiB+R+MJcOn9BTP7qM3+udoEGGUlmwULmLXB7Y
         rWzsvup7ZkQ8pyh7cGxzW1wGJU42D3kx92oUS+T6n0f2OTCccNT1Uc2EXEKNubHhr1TJ
         VbYNHoyw3os1XoeddZz05DLS3uSoo4OwJAr4ynFyGmHCqOhcidZ9Rau9a8ItsszsOZJg
         mjhA==
X-Gm-Message-State: AHQUAubSY8CxRd66uC9vHINdnDOLTKI0PRXyvbREoYmGg347dRWKvLYd
        ClqfIYfPeaFTyKe5foqa/XFXUA==
X-Google-Smtp-Source: AHgI3IZAlCgx+vdzMMXnYCfqie9DawIRzNKTXpKS+YqirqUzOYE8VP/uLh0i/02vD5sHe2HBX09mbg==
X-Received: by 2002:a17:902:45:: with SMTP id 63mr3010111pla.281.1550823824594;
        Fri, 22 Feb 2019 00:23:44 -0800 (PST)
Received: from localhost.localdomain (li1195-158.members.linode.com. [45.79.96.158])
        by smtp.gmail.com with ESMTPSA id y22sm133821pfn.136.2019.02.22.00.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 00:23:43 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/4] KVM: arm64: Use macro to replace hard number
Date:   Fri, 22 Feb 2019 16:23:23 +0800
Message-Id: <20190222082327.3312-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222082327.3312-1-leo.yan@linaro.org>
References: <20190222082327.3312-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macro for ID_AA64MMFR1_EL1.VH bits shift instead of 8 directly.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm64/kernel/head.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4471f570a295..3ac377e9fd28 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -490,7 +490,7 @@ ENTRY(el2_setup)
 	 * kernel is intended to run at EL2.
 	 */
 	mrs	x2, id_aa64mmfr1_el1
-	ubfx	x2, x2, #8, #4
+	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
 #else
 	mov	x2, xzr
 #endif
-- 
2.17.1

