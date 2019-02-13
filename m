Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFDCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E983206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gQABb81M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436775AbfBMVck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:32:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34969 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436736AbfBMVcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:32:35 -0500
Received: by mail-qt1-f193.google.com with SMTP id p48so4495707qtk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 13:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dQLK2/rrLChjZCacrkpff81URBJeOtphw+yxRdVdzZ4=;
        b=gQABb81MbKQBlmSXhqJWQfg/1AxyC7N9oosWf++hMdAGIruAgpqJYldwUqM1bmB6Jr
         dulsq1OpTXHG1i2jGcQeuZyZIpjlKNdKfSMyrS0u+NAnjSlxqj7zZ3qkDJYNjUsmUrJF
         zigsHfdtmvf3MT0gwEA2vuSBKY4RwNgfY025WHBxSsYe2wuncmOQ88OE0GyPQcL58ysd
         4e65OoRDhrMM69gcPZUaLEQEaHinHgZEFhvilAAmkSckKd5/7GedCqUALyP0aiq2Fvxn
         HNIc7JEQhrKke9sonMbxjJlaZ3nPYoqJqcssm1/sMCPDAFExEk7IVkLGZUSwo359avMR
         lWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dQLK2/rrLChjZCacrkpff81URBJeOtphw+yxRdVdzZ4=;
        b=bi2w7uZEG7k6hNM2rU29fdy/ClZbdMwqiiwY+lUMlooZT5PejDZv9l1y6fWwDqHemq
         T2AiHNC3jGsaC8f3rFdOvbYU9eOCvWWckkBTaA/2+UvdRdrCiIjhKBAEmvpFNJGXFfxz
         i8WXhJ59Qbtiel3pLTLq428enl5z2zHrAzLYW59+D3HMnW9qKsuOwgS8wL2e8Hz6I2Xy
         T+ATRc05OX6u/OXa0JMh2beE5hhSgh8KZSAUofu0C1AnZ1wjvid3hktEeGUc1G+1SYt2
         1lZaMFia1J1Sn5kjGhr5LQpu1yxAxUOHfKT4OCqgeUKKRQk5asl4NcfEt8yHjSgrr5bB
         /r4g==
X-Gm-Message-State: AHQUAua6m67NEe3sFtRaVNQFkr8R8tVyiPycN+bbAkF5Odm1VggmnKGl
        flhUtw3QSJjQkLCn7LZWvTOK2g==
X-Google-Smtp-Source: AHgI3Ia4pComQ8ctgxQDJ1CcQxaos+nBxL2y9DAGiemotoOFbJLoJ3KztZyURL89wAh+dQrfdS0EKQ==
X-Received: by 2002:ac8:341a:: with SMTP id u26mr205865qtb.211.1550093554162;
        Wed, 13 Feb 2019 13:32:34 -0800 (PST)
Received: from localhost.localdomain (pool-72-71-243-63.cncdnh.fast00.myfairpoint.net. [72.71.243.63])
        by smtp.googlemail.com with ESMTPSA id 8sm382675qtr.7.2019.02.13.13.32.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 13:32:33 -0800 (PST)
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
Subject: [PATCH 4.19 06/17] ARM: 8794/1: uaccess: Prevent speculative use of the current addr_limit
Date:   Wed, 13 Feb 2019 16:32:12 -0500
Message-Id: <20190213213223.916-7-dave.long@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213213223.916-1-dave.long@linaro.org>
References: <20190213213223.916-1-dave.long@linaro.org>
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
index 5451e1f05a19..d65ef85fc617 100644
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

