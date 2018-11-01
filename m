Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C94C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F0282081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fkHJs6jd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0282081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbeKAXAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:00:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34120 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728744AbeKAXAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 19:00:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id k1-v6so7653926pgq.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4qIal7fdLs8KMix5Hy3TLm8h5tkN+4OXLwyC3Lu8zUc=;
        b=fkHJs6jdDHpZ07dzMy5V+xr1uZsPwoRtbbXFacPdc2ZuxJmSkWw5hXIW1ct/vxpxuO
         wtaIyAwDEuHYPy0bzYGSnU7cXALzLZjoa14wUJkQDlDBGQwt+JxLkLYYNOym6i4cQyY6
         tc6xdGSko2D9RfCx9rOh7aEO19a8FVUU0Y4AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4qIal7fdLs8KMix5Hy3TLm8h5tkN+4OXLwyC3Lu8zUc=;
        b=U39zdYrlx1lEYZ5qiMGoi2E2hUMKZH6BzvZy6FEbewW0mj6iXENQgODFoJUqVv5dbO
         /YKTymukeqLKUiwLNxLQwXkYjGZX7FZVtQxWJLeTG/Tg/yBMbuMRvZvJx22hDsKJiIWA
         HbHLIqbDfWzKqVS21qc+nm3rjuTMoj8iRRuxqt6yt5avDHJ4OCyEoJPuk7f6Kf4PiK/4
         qa3B6dn0GxU84BOFGWwxifdFKlYJiI0UoVYg64EAUUZs3PofDjdxfyW72v4OQWtDjo34
         FUFT/OFM1PQfs4KHRYF5/inGkcvSR2aWzm3JtGX+E65OcZh6Rj7ZyA2QRbXeVpEVHQjP
         evGQ==
X-Gm-Message-State: AGRZ1gKSa5o3mjZu/y4nWWC+uCGJxFmfHTb4wnteQ3WPQGKBxCtgA4L6
        aDnC0fDg4a4G1pUxvLkLvTvdXw==
X-Google-Smtp-Source: AJdET5ceEqkUpbGQ4F42wQgA/KBcikq8TS2TsPTj1xsnVpFLHJalIomymQHD81W2w65iwhlAmnZapQ==
X-Received: by 2002:a62:1552:: with SMTP id 79-v6mr7743757pfv.120.1541080619511;
        Thu, 01 Nov 2018 06:56:59 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id m18-v6sm39076169pfk.149.2018.11.01.06.56.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:56:59 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v1 2/4] xtensa: add __NR_syscalls along with __NR_syscall_count
Date:   Thu,  1 Nov 2018 19:26:19 +0530
Message-Id: <1541080581-4072-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_syscall_count macro holds the number of system call
exist in xtensa architecture. We have to change the value
of __NR_syscall_count, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update __NR-
_syscall_count value.

1. Update __NR_syscall_count in asm/unistd.h manually by
   counting the no.of system calls. No need to update __NR-
   _syscall_count until we either add a new system call or
   delete existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update __NR_syscall_count in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with __NR_syscall_count asm/unistd.h. The macro __NR_sys-
calls also added for making the name convention same across
all architecture. While __NR_syscalls isn't strictly part
of the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/xtensa/include/asm/unistd.h      | 2 ++
 arch/xtensa/include/uapi/asm/unistd.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index c73eca83..b844081 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -5,6 +5,8 @@
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 
+#define __NR_syscall_count 	__NR_syscalls
+
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_LLSEEK
diff --git a/arch/xtensa/include/uapi/asm/unistd.h b/arch/xtensa/include/uapi/asm/unistd.h
index c8ac79a..fa26aa2 100644
--- a/arch/xtensa/include/uapi/asm/unistd.h
+++ b/arch/xtensa/include/uapi/asm/unistd.h
@@ -778,7 +778,9 @@
 #define __NR_statx				351
 __SYSCALL(351, sys_statx, 5)
 
-#define __NR_syscall_count			352
+#ifdef __KERNEL__
+#define __NR_syscalls				352
+#endif
 
 #undef __SYSCALL
 
-- 
1.9.1

