Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399F0C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DB72081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SoQJQNLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DB72081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeKAW4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:56:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39487 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728743AbeKAW4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:56:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so9070233pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6ewO3RpocwTpvJiSbx8FaTIh/1XBx5ppmd7hictz/pU=;
        b=SoQJQNLNcCYZcLeBjJO1RVhm8X66+NAT09Fr5xCWALW4w2wxfp+x31Hgv1wuM+6oub
         +PKDQWVAaE1n6+ZHCzf7MkPzZTPwqC7Nndu1SFG8k4+4LfSvu2zmGxngOAVCZv0cPwvy
         FD13POuYawv9PA4EpVjJE3iZsPSfWE8hSH8CU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6ewO3RpocwTpvJiSbx8FaTIh/1XBx5ppmd7hictz/pU=;
        b=NvztdzzJPx/Ou1wKk9Euf+2e8lzOaqT3vt8Sn8kGqG310SW21QERbVUcvE8TolbrlP
         sF5gzsb6Jvh1XGhgtl4JzfT1ptgWZBMgK4R7j+Su0+gaz79EBaiivGs93I1lCY015YWg
         641jGQsTM0uzmX7RdehFw2YNW/R6IH7BHOplhsZq1YJNdvXE0ptp0vtSFFFOps/4tNZg
         ZDU29+lX0wSMxq1eSkOVBjNwisnrayVEpvN0wZk3nDpILGTIJpplg7EGyoX8l+9BnjTF
         0C3fUR753VpZUov/Vf2jPZOtpcBRSc6DbUtNMB6ColJc29xhr+xeqnm97z2+b5ro69Cz
         B2mQ==
X-Gm-Message-State: AGRZ1gJHV1apRKLHZoXMiOE+OmTLssFnTtiqfXfCFtlcFRtCKiB6tBK7
        2cd5KGlnoiDjcDLvJEOdygBSNQ==
X-Google-Smtp-Source: AJdET5dDwYMPvlK/7J7235JSfdohOerM0yIJS6kDBYBHVUa+aaN+pNfPVNCZ2SqXaVS9XoELzrtAUQ==
X-Received: by 2002:a65:4646:: with SMTP id k6mr7153241pgr.153.1541080430949;
        Thu, 01 Nov 2018 06:53:50 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id 131-v6sm2224716pfa.120.2018.11.01.06.53.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:53:50 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 2/4] sparc: add __NR_syscalls along with NR_syscalls
Date:   Thu,  1 Nov 2018 19:23:09 +0530
Message-Id: <1541080391-3890-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
References: <1541080391-3890-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist
in sparc architecture. We have to change the value of NR-
_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update NR_sy-
scalls value.

1. Update NR_syscalls in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_sys-
   calls until we either add a new system call or delete
   existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update NR_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with NR_syscalls asm/unistd.h. The macro __NR_syscalls
also added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/include/asm/unistd.h      | 2 ++
 arch/sparc/include/uapi/asm/unistd.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 6dfd752..171a6e5 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -17,6 +17,8 @@
 
 #include <uapi/asm/unistd.h>
 
+#define NR_syscalls	__NR_syscalls
+
 #ifdef __32bit_syscall_numbers__
 #else
 #define __NR_time		231 /* Linux sparc32                               */
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 6e59037..e11d86c 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -428,7 +428,9 @@
 #define __NR_pwritev2		359
 #define __NR_statx		360
 
-#define NR_syscalls		361
+#ifdef __KERNEL__
+#define __NR_syscalls		361
+#endif
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
-- 
1.9.1

