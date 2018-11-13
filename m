Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E37C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2CB2245E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 10:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="V/TOESN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2CB2245E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbeKMUR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 15:17:28 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39092 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732090AbeKMUR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 15:17:27 -0500
Received: by mail-pg1-f194.google.com with SMTP id r9-v6so5478355pgv.6
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 02:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iAxfK6mJJTXjojV0s0X/f7oWUHPo/2/Qtwcy0lQmsO0=;
        b=V/TOESN1rmhipP+yrrPcnozAiqFifBxqXhwr4OG9wTSAcSyX5MO9az/FEMpScsxpHk
         Q+UBrjw6lFJALPjXn2HyvDXFtQCKi1JKJuw8fCiLY9h7mrr9fUcS0lWXQTiNB/gxh156
         JRObWrA7luxjKm2zaX1iJY2SeWSiUe6fDLJDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iAxfK6mJJTXjojV0s0X/f7oWUHPo/2/Qtwcy0lQmsO0=;
        b=pyqiqL4DQoNBkT5+AMbMf5Vu7Xs9ND/BC5MkEl9FStcZBnLgiSswCaC59i7uqbGwnZ
         RKIzCWTF3cIzyY0gzZYXwkijJjHFiBEDMSaHwBov/pApqtk0nUDUQEFvFutfCWjIwUqM
         BB65LRzefYBeTJ5iqyjG6N9NgEtK2RxDVKZr3VXsxXgpA5UbUu+ycDPypjLkVeY9Blyn
         tf4XTeTFbjLN50lo4VA5rgk2GH9I9Z3/8nMRwMN+9d1GEAkqLS3RP4AqEMtfEZX+hOQB
         02RT9Iiaf5G8n6A0aSHjkWSvL45bYbqHVFZAkBLmoRIdfdbPXQZ/RErAue2ZKKGP5ati
         AGYg==
X-Gm-Message-State: AGRZ1gL7k+zXN+NotqoVUpu+RMUkx+yjw0KB8YuUZB9lM0GPKkZDNYZs
        NJUkdZF9ffdgzitewnp/hTrnrg==
X-Google-Smtp-Source: AJdET5fldL3T1rR2CLw1BShZNOXtKcDRqelZLCgYGOVbSWBdsR+1QeGLI2iWDvatUC9AiT4ebcRC2Q==
X-Received: by 2002:a62:fb14:: with SMTP id x20-v6mr4494432pfm.71.1542104402055;
        Tue, 13 Nov 2018 02:20:02 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id f10-v6sm13363364pfa.188.2018.11.13.02.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 02:20:01 -0800 (PST)
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
Subject: [PATCH v2 1/3] xtensa: add __NR_syscalls along with __NR_syscall_count
Date:   Tue, 13 Nov 2018 15:49:28 +0530
Message-Id: <1542104370-22831-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
References: <1542104370-22831-1-git-send-email-firoz.khan@linaro.org>
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
index 574e552..787987a 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -5,6 +5,8 @@
 #define __ARCH_WANT_SYS_CLONE
 #include <uapi/asm/unistd.h>
 
+#define __NR_syscall_count	__NR_syscalls
+
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_UTIME
diff --git a/arch/xtensa/include/uapi/asm/unistd.h b/arch/xtensa/include/uapi/asm/unistd.h
index bc3f62d..332d67a 100644
--- a/arch/xtensa/include/uapi/asm/unistd.h
+++ b/arch/xtensa/include/uapi/asm/unistd.h
@@ -778,7 +778,9 @@
 #define __NR_statx				351
 __SYSCALL(351, sys_statx, 5)
 
-#define __NR_syscall_count			352
+#ifdef __KERNEL__
+#define __NR_syscalls				352
+#endif
 
 /*
  * sysxtensa syscall handler
-- 
1.9.1

