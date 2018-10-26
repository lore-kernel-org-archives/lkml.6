Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6E7C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D54207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:11:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJf5oDcX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3D54207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbeJZNrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:47:22 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42514 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeJZNrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:47:22 -0400
Received: by mail-pl1-f194.google.com with SMTP id t6-v6so4890192plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kmPQRtCg67Rb8OhlxUSRTL6Ko6ikHgAeICx3msAVfdc=;
        b=QJf5oDcXUzCVxKvMG0uoX7wnvG+rLw0VD/8slqssFz/i2hXZB8urzu9stYYuPhhfE/
         H46ZHwbz8E54LzpWAce5ZYcyTj1KTjpPtgo2A2bmg9v1QjO4GRio8avvMsCCoBg0XPmq
         tRYjfcciwwGNWpEXodzba/ucHn/nWyt33iOP4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kmPQRtCg67Rb8OhlxUSRTL6Ko6ikHgAeICx3msAVfdc=;
        b=lYUS5A7Fvm7cJzdjl9xLKemjG59PbwEjaxcrxEt2eOdM4LQCMJWFDdlsEa5jdocPYH
         sWFzb4shl9w4jVpZH2PrHaPQNxPWkpQ5dw8QsC92tqjSD420uyUepdjOTN74D0YHsjBO
         wD3c6PL9CyYibDXt425/nj2j7tINb9tyliN2AfwnS0Xby82eJlXp05VULOCjQpEbwk6n
         2R62ZZDLvfq8g4FwHvNhS6QVZ4YAMVQY1lFrzH3QmrkXCDolqaGonER/gTm8MTZ3aDl1
         JoasMYX5Mbgn8Xj3ogQT2OkPC56y0cPrDy9e2CYdcQ/xzofAbxRF64pkUtK45ev9aT/y
         Xq7w==
X-Gm-Message-State: AGRZ1gIlPiPqS74OvBUwPrqyhXhHyo+6Lk4IHR9iWH0OVoS9uKwIuC+J
        NLESQb2y0t97Wj2W/kaIs4bd6A==
X-Google-Smtp-Source: AJdET5fzA5nxOAConk2j0yX/EINjNTM4ElbfxKcN74xTiqixRJK2Wfo9dllUJN1u0fdX8AcCXjVZYA==
X-Received: by 2002:a17:902:a618:: with SMTP id u24-v6mr2076116plq.77.1540530712796;
        Thu, 25 Oct 2018 22:11:52 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id u13-v6sm9608912pgp.18.2018.10.25.22.11.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:11:52 -0700 (PDT)
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
Subject: [PATCH v4 2/5] ia64: add __NR_syscalls along with NR_syscalls
Date:   Fri, 26 Oct 2018 10:41:11 +0530
Message-Id: <1540530674-3824-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540530674-3824-1-git-send-email-firoz.khan@linaro.org>
References: <1540530674-3824-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist
in ia64 architecture. We have to change the value of NR-
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

