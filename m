Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAEFC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674B42064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BwQNTdSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674B42064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeKAWrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:47:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46188 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728657AbeKAWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:47:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id w7so388705pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/XsLB/mTm+LIF0r/5nrqJTJoWtRCz/bDdCwvPaNBjtY=;
        b=BwQNTdSfvlHi4WkoY+Xf/IzabNjZD861ktNNAOV90juP+P3x+fiBS52/GcPGKm8t7p
         3e4C4jtxCpqFl10VKGHCSNwIxTJEHv7adw6b04hamUWTODfCPMUOze31cCLuKGXzXBMs
         34QOQZ5uhfohK8RAvApuZ7pwvTTksSSJeAKZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/XsLB/mTm+LIF0r/5nrqJTJoWtRCz/bDdCwvPaNBjtY=;
        b=jGAw3vcG8JEaYx9Z0VsqtQ8G4oLhXjg5gwqBjGUYvSNiy9Fgk24y0Y5UzIWfTeJ5zF
         M48DtG69uSX6rBLDQiHQq1PXpWWZbgspFBmWTTaj4HQ8yogSnAHyDUw05WAlTsZ/Ip1m
         u3a9eY0pr6jw/uNtta4kDrXYte6JCYbSHTYjLui91Ui0TmoAyvzmlUfPTRKKhMthccEM
         XFASaC/NyMBfb87TDIg5jgjOS8zkR161UxJkR3nTZe1K7qtyNGXA8YtCMPVYi9ySvoRj
         KYR27zHyNhxcFctm+gja/MjlWsVIgsxi+YyhSkJbxCy1Bk6Y7Iar7Zh2FgzOPU/o0E36
         qTTw==
X-Gm-Message-State: AGRZ1gIlMKr/f++ySQzWphUunvOdH+pfBoFogPTLFUsFO+dSR3/byusg
        aXMeVaPTBqzalsJHisqpDdt3Lw==
X-Google-Smtp-Source: AJdET5dwkLNePVpFkw4MX21iw5IsyqqXNyj6KhOMh+kU9vIFv1x6TNlRCEWN6J2mS5h6c6Ttbe5ROw==
X-Received: by 2002:aa7:8252:: with SMTP id e18-v6mr7906548pfn.164.1541079869330;
        Thu, 01 Nov 2018 06:44:29 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id r23-v6sm36359299pgm.48.2018.11.01.06.44.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:44:28 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-alpha@vger.kernel.org, Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 3/5] alpha: add __NR_syscalls along with NR_SYSCALLS
Date:   Thu,  1 Nov 2018 19:13:35 +0530
Message-Id: <1541079817-3431-4-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
References: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_SYSCALLS macro holds the number of system call exist
in alpha architecture. We have to change the value of NR-
_SYSCALLS, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update NR_SY-
CALLS value.

1. Update NR_SYSCALLS in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_SYS-
   CALLS until we either add a new system call or delete
   existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update NR_SYSCALLS in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with NR_SYSCALLS asm/unistd.h. The macro __NR_syscalls
also added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/include/asm/unistd.h      | 2 +-
 arch/alpha/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index cbd04d3..65a5056 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/unistd.h>
 
-#define NR_SYSCALLS			523
+#define NR_SYSCALLS	__NR_syscalls
 
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index 47c65f1..ab40aa6 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -465,4 +465,8 @@
 #define __NR_pwritev2			521
 #define __NR_statx			522
 
+#ifdef __KERNEL__
+#define __NR_syscalls			523
+#endif
+
 #endif /* _UAPI_ALPHA_UNISTD_H */
-- 
1.9.1

