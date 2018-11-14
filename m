Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709F3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2572C214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="E6IlCKgo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2572C214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbeKNP2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:28:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36406 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726927AbeKNP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:28:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id w24-v6so7213504plq.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 21:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B3ds7rWHkGzK5qCHEibhgyG4TVo4EuBJkWgfwHOFgYM=;
        b=E6IlCKgoPK9G+itbofuXiUJ7AIRx8lieLRsXMdI9HuxuNZqwPE8tQNwA2zbl/CzE30
         PHslebYaHB5DUHKmDIx4mpZ5dEeT3zVVjAbEyP06vtiyDrW7ShSlEZefU19fAezu2yG5
         drO21dteT4GmRqxq8vnd+gIWHBjDJJUZbSDZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B3ds7rWHkGzK5qCHEibhgyG4TVo4EuBJkWgfwHOFgYM=;
        b=AUs+FLTGNsdvxVlBj9KWM/EIWpHQN33WckmH/VSAmFR78qqckC+vP+Fipqm2m7kbCj
         aTHII3WtD/uHIrdmezmbv3nGm37GTy0qF2LAo6SUTjVlcEUOClkRdymV/P/hdvSSDA/S
         42LPz1CjHLU7I1FMtHTD35sagbkUab6yLB87aLwR0JquH6x3vw2JNvzJFSYM6Yq0d0Dt
         21m9KeeCnB3/hmkS30x6sVPbnQhGmwv7t2HoUQcDfbQWmUnmRBxCkBIGR4bVKdTZ0nPJ
         d2timFoclXWO57nmIelrlIlDm15ldHnGHDtnDIBaINbNpxe+bZAAxttYKSReYVtMCYR2
         EKfA==
X-Gm-Message-State: AGRZ1gIbdazHuQR9G8ljE/a8MpnAD+1IG3NJTbkN5k08rtYrudW6L3Th
        gx2So9ZVHnWXkhSBMZhzIATTdw==
X-Google-Smtp-Source: AJdET5c0Ef9XFV5bFeOgsL8rgl/UrLwO0SU6yZp2J77XqjVg6gdzRHOWTphHfEDzoDRs2w3TDiiLIQ==
X-Received: by 2002:a17:902:3084:: with SMTP id v4-v6mr506490plb.326.1542173229004;
        Tue, 13 Nov 2018 21:27:09 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 34sm36331746pgp.90.2018.11.13.21.27.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 21:27:08 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 2/4] sparc: add __NR_syscalls along with NR_syscalls
Date:   Wed, 14 Nov 2018 10:56:29 +0530
Message-Id: <1542173191-24981-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
References: <1542173191-24981-1-git-send-email-firoz.khan@linaro.org>
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
index 73d2454..5194d86 100644
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
index d37a136..4ae11c4 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -429,7 +429,9 @@
 #define __NR_statx		360
 #define __NR_io_pgetevents	361
 
-#define NR_syscalls		362
+#ifdef __KERNEL__
+#define __NR_syscalls		362
+#endif
 
 /* Bitmask values returned from kern_features system call.  */
 #define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
-- 
1.9.1

