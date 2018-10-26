Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC8EC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F8420854
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IiKyv8Fe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F8420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbeJZNtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:49:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38792 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbeJZNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:49:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id b11-v6so3675595pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gFcNXBX4l/6xItKhlgwTdqFlyHeCmRMGvdyUvQXs28g=;
        b=IiKyv8FeEAYyyW5ogH84j8mr5KrgMCL2k7oqKi7G8CsLL3y6G6zNO+ij0Mu8kNtdCN
         0X+8FQrwVqUBMwysTfrZaMDyaUJ7Nc1ZOmua8mB8Mt4jkCKrCB59ZfIRVyldoguJblOS
         ozFKhVmdFoNK/AvMbS7Ya5chx7P/+cpZhAmXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gFcNXBX4l/6xItKhlgwTdqFlyHeCmRMGvdyUvQXs28g=;
        b=FlWdMGmOxSDAUjy+2IEinhgYB7B8m+6pwyGJj19r6cxJ2tEfH69s/N8HHzthJL1s+V
         YYYWDkqqDciUZiiVetVtjMVO7rnnnHp1A9WvyuGUgFotcZT+LUfs1LBCBS4gdqVbj2ea
         QYfmNtXYWoSbw426J9g52W1hFAtcPzVOdkMCGCEOdZdOD4254K041QkFrro21AnVxCbm
         L/p+27//ldemUZmKJmEpK51wkqI291DdVdSZxYT3zrqN4VRALBMZ0DyKImThxYxeb7pM
         ugz6JSt0CmBUQ4vIrUI/z/mUoF3XvzowGhWXKtaFpX2zSIjFVr+0rWdI/a/lR072xPQB
         4g+w==
X-Gm-Message-State: AGRZ1gJWIRqlKe6dPsds7Txe/vaoQ1Ak0/K3axU8IviSImIFOhAoGzWa
        DiMPOAXSOIYmSgDbMdwVHj34Kg==
X-Google-Smtp-Source: AJdET5eaQerlqiKMXyUh4WfxfnaoRHsWuhRYCUddCVer2+HTmtuS1hur5Fgp1ctLyRQgm+iQzYw+VQ==
X-Received: by 2002:a63:f050:: with SMTP id s16-v6mr2054957pgj.403.1540530833916;
        Thu, 25 Oct 2018 22:13:53 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id m16-v6sm3329302pff.173.2018.10.25.22.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:13:53 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v6 2/5] parisc: add __NR_syscalls along with __NR_Linux_syscalls
Date:   Fri, 26 Oct 2018 10:43:08 +0530
Message-Id: <1540530791-3961-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540530791-3961-1-git-send-email-firoz.khan@linaro.org>
References: <1540530791-3961-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_Linux_syscalls macro holds the number of system call
exist in parisc architecture. We have to change the value
of __NR_Linux_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update __NR-
_Linux_syscalls value.

1. Update __NR_Linux_syscalls in asm/unistd.h manually by
   counting the no.of system calls. No need to update __NR-
   _Linux_syscalls until we either add a new system call or
   delete existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update __NR_Linux_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with __NR_Linux_syscalls asm/unistd.h. The macro __NR_sys-
calls also added for making the name convention same across
all architecture. While __NR_syscalls isn't strictly part
of the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 2 ++
 arch/parisc/include/uapi/asm/unistd.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 93fd9f6..d30fdbcb 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -4,6 +4,8 @@
 
 #include <uapi/asm/unistd.h>
 
+#define __NR_Linux_syscalls     __NR_syscalls
+
 #ifndef __ASSEMBLY__
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index bb52e12..f10d065 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -366,7 +366,9 @@
 #define __NR_statx		(__NR_Linux + 349)
 #define __NR_io_pgetevents	(__NR_Linux + 350)
 
-#define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
+#ifdef __KERNEL__
+#define __NR_syscalls           351
+#endif
 
 #define LINUX_GATEWAY_ADDR      0x100
 
-- 
1.9.1

