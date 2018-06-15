Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DC79FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91973208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 07:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDBvU4rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91973208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755997AbeFOH4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 03:56:49 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38658 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755925AbeFOH4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 03:56:46 -0400
Received: by mail-pl0-f66.google.com with SMTP id b14-v6so4941502pls.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kpMEU3sh1IN0/bxn4qA0OTMbmXCEF6TENF+YzCU+lOw=;
        b=DDBvU4rzCp9e+l19e+pORcW+cEFywfs3fb1wjwtB8DcbVZiIj/KWS2WMhIhSSDm9Me
         ti+Jj+TCb7ZdaLMoEx0z4oA0I+WJD19fKOV3JNOEiNDyh0/fxx3rBVO7iaWDeYyiqmpy
         r0zFGt6g/zJ6D14WTbXzhgA6ggN9IjbAvowqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kpMEU3sh1IN0/bxn4qA0OTMbmXCEF6TENF+YzCU+lOw=;
        b=j3KCcr0OT3mUrx6HgXbuhv8ktRvLOV585k2vkTrPlyUIMWbTT49vobc4f6dqhQmN1I
         ALF4qd4lcqFRtz6hMtqoR4r+EVyRxJVK+oS4wq/l8F6/iFt5JMdJ51Y588let+9zrqmG
         pUtdL86l3PGaSgO/TTefsN0w37Vg3fsOCV/58AE8Owqdo/BBzfwkVI14atRcrhmXoNme
         CkwHOfqSQY5p5Hnb0O5+unv+sK7oWcnn5Ck6oB2pKT5TZEVubpzvcm2Jv+TIDhf5Aq4d
         /wOM4VbtqmHKxufso90ATR3Kaxd1HTyg5mv6dDid1Y2wRkhkagfql2RLkTop60tirKw8
         Qi9w==
X-Gm-Message-State: APt69E2SH7Lu1wip7IziMwwRQm5GO8j04lh6R0pQ8oPb56oYTfGU6Uv2
        EklhywxMh3qlnaiM0YnHNNsm6w==
X-Google-Smtp-Source: ADUXVKKFvcK55T+MYYv1z6RJT20I8uSXol/ZFTy7CGC6g+ThoSH7Vgy6oSz5mTXqssZbQyy8CBS2sg==
X-Received: by 2002:a17:902:9048:: with SMTP id w8-v6mr788087plz.34.1529049405314;
        Fri, 15 Jun 2018 00:56:45 -0700 (PDT)
Received: from linaro.org ([121.95.100.191])
        by smtp.googlemail.com with ESMTPSA id s2-v6sm12872638pfb.127.2018.06.15.00.56.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 00:56:44 -0700 (PDT)
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, ard.biesheuvel@linaro.org
Cc:     tbaicar@codeaurora.org, bhsharma@redhat.com, dyoung@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, al.stone@linaro.org,
        graeme.gregory@linaro.org, hanjun.guo@linaro.org,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH 3/3] init: map UEFI memory map early if on arm or arm64
Date:   Fri, 15 Jun 2018 16:56:23 +0900
Message-Id: <20180615075623.13454-4-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180615075623.13454-1-takahiro.akashi@linaro.org>
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As ACPI tables may not always be properly aligned, those regions should
be mapped cacheable in order to allow the kernel safe access to them.
UEFI memory map contains necessary information for mappings, and we want
to make sure that it should get accessible before any acpi_os_ioremap()'s.

So, in this patch, efi_enter_virtual_mode(), which was previously named
efi_enable_runtime_services() and invoked via early_initcall on arm/arm64,
is now moved early enough as the first access will occur in
acpi_load_tables() of acpi_early_init().

See a relevant commit:
    arm64: acpi,efi: fix alignment fault in accessing ACPI tables at kdump

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 init/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/main.c b/init/main.c
index 3b4ada11ed52..532fc0d02353 100644
--- a/init/main.c
+++ b/init/main.c
@@ -694,6 +694,9 @@ asmlinkage __visible void __init start_kernel(void)
 	debug_objects_mem_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
+	if (IS_ENABLED(CONFIG_EFI) &&
+	    (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)))
+		efi_enter_virtual_mode();
 	acpi_early_init();
 	if (late_time_init)
 		late_time_init();
-- 
2.17.0

