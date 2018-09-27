Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3BBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23AF7215E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkH6yCwz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23AF7215E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbeI0Uei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:34:38 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39002 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbeI0Uei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:34:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so2028204pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uCe8GDuDIsW/oywTVVyhSQ6yR7tNM4OEAIIVzFvTQ8s=;
        b=MkH6yCwza8WPqQKk9MDz+wHEGdJd9E0YPhcH8+viIL2isMP9wPACn48taRmloxCev7
         U1hEr7/yIIO7K8WNuyyimHGEzUx+69sHXQI6Np8pOPp1vDy7c1FKkmnz1KGLwURefUip
         27pQIZ56ceza6+ZQIqoZMjhVUHqLC5znHq00k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uCe8GDuDIsW/oywTVVyhSQ6yR7tNM4OEAIIVzFvTQ8s=;
        b=n4YYLVM1wLJLj+N82I16egM5QbegGsKmRwh1msToQcoLiQ/5O5CYM/QTUhhZJzRi28
         oFYYCFI7cpi1lnwSNVrkGnCJnduUc7If6ULWEHl/ljHV/MFTxHidOEjAUu2GlQFarlDA
         BvFXXwhsMRVKVvuXCIOu0NbJhKK7A9O1MNuJ+dQ/T+++LJzhQxS+IuVqlQHVQY1giO/V
         UP9zJYusdNgY4qmy87MPOucs71ZxjBep2sxTSGrCQ2ADQtKD19aTix8HrQ7govddP9t3
         YoLyoHfCdgaG6cS+0K8nJBWy0xYDUvv9nOL7jr6iBOq5GqRMxuYfaXwj5zE2M3Lh+8Xt
         lDtQ==
X-Gm-Message-State: ABuFfoh7Lp3QU4bKkXEPwEOKnat3zT1NG/GTJg6MQfxiy7nMp7MkpC4J
        oimwzMxRDOEyjplIra6D03Jeig==
X-Google-Smtp-Source: ACcGV6161SGFCvdEP1G+2VRuRoSzysQjJDoT23ZtYD1W8LVtCtKS6DdZet2LN0NjrSe/j61WsEnWEw==
X-Received: by 2002:a17:902:1681:: with SMTP id h1-v6mr11257754plh.262.1538057769552;
        Thu, 27 Sep 2018 07:16:09 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.105.186])
        by smtp.gmail.com with ESMTPSA id m20-v6sm110399pfj.171.2018.09.27.07.16.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 07:16:09 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 2/7] ia64: replace NR_syscalls macro from asm/unistd.h
Date:   Thu, 27 Sep 2018 19:45:15 +0530
Message-Id: <1538057720-3392-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist in IA64
architecture. This macro is currently the part of asm/unistd.h
file. We have to change the value of NR_syscalls, if we add or
delete a system call.

One of the patch in this patch series has a script which will
generate a uapi header based on syscall.tbl file. The syscall.tbl
file contains the number of system call information. So we have
two option to update NR_syscalls value.

1. Update NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update NR_syscalls until we
   either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I come up
with another macro - __NR_syscalls which will be updated by the
script and it will be present in uapi/asm/unistd.h. The macro
name changed form NR_syscalls to __NR_syscalls for making the
name convention same across all architecture. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/ia64/include/asm/unistd.h      | 4 +---
 arch/ia64/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index ffb705d..397b143 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -10,9 +10,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-
-#define NR_syscalls			326 /* length of syscall table */
+#define NR_syscalls		__NR_syscalls /* length of syscall table */
 
 /*
  * The following defines stop scripts/checksyscalls.sh from complaining about
diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index 4d590c9..4186dc2 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -341,4 +341,8 @@
 #define __NR_preadv2			1348
 #define __NR_pwritev2			1349
 
+#ifdef __KERNEL__
+#define __NR_syscalls			326
+#endif
+
 #endif /* _UAPI_ASM_IA64_UNISTD_H */
-- 
1.9.1

