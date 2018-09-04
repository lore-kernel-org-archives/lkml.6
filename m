Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39956C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0A320869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D57Iekwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF0A320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeIDJFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:05:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37122 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbeIDJFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:05:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id h69-v6so1043894pfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 21:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nVMEY7kSg6pH6nKK4ILWh9DUB5HL9PrblssQxMhseHY=;
        b=D57Iekwd8aQmDTYqx01cIigyCRxJZPGhOhEDhWLZqaE9cx38yzjrputx14hwD0RfX6
         vt26jfK7fddhIOnYAdIv8kvzt5agKEZtDpJL+WbwZLI3pzG8VDb7eHJ+so70BcYg4j1z
         vQid/1HJdciSRCnDVDcjcLVFG9XYOc6REClU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nVMEY7kSg6pH6nKK4ILWh9DUB5HL9PrblssQxMhseHY=;
        b=CyowhhseaYiwWfWof0vBtgZbuCW/MUU0v7zDb99QUTsA5RpgeY0Svu4nKggSFROiLI
         VK5SAjN4flTc1drjQmTRWxafPS3jl6i3LtN4PHKbn0UIz/8Bi04vCMTBvndx2DSmvOLF
         KpAkbHJ/SfQAwNktc86M28gHRvcDS4sz4lpHS5SUXrYgcj55ywSGR3f+wSx2RG3KqipK
         iDSeLDGGO500Cbnxbo+YJXKUGT0OYjhLH9LKuKodcNfY5LwPFD+AZKxdL+gXj6ZoED3f
         Ol0+VmtvQQHxfS/0MF+wEMEZoGT/C+vAziwpURXtoZW7lEefHXfC40LKNv5fIbeZwgJF
         0/jA==
X-Gm-Message-State: APzg51Cgf1xGakhhf/t3FV9xNuJyiss/jwvH/goR8LUGTc/eEWI00zrs
        p0GFAdNftRS5rfz251GigQn0bA==
X-Google-Smtp-Source: ANB0VdbtzA7SnEYlu3cK5BGML7h7s3v8ty1q9mnf7iA3m1Qn4xZwo9q5LFb7aHK9xbB9hVLEljBoqg==
X-Received: by 2002:a63:1947:: with SMTP id 7-v6mr10032860pgz.192.1536036133950;
        Mon, 03 Sep 2018 21:42:13 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id w12-v6sm10280372pfd.110.2018.09.03.21.42.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 21:42:13 -0700 (PDT)
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
Subject: [PATCH 1/4] sparc: Move __IGNORE* entries to non uapi header
Date:   Tue,  4 Sep 2018 10:11:24 +0530
Message-Id: <1536036087-15260-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the  __IGNORE* entries are resides in the uapi header
file and it is not used by any user space applications.

One of the patch in this patch series will generate the
uapi header file and system call table file. So if we move
all the __IGNORE* entries to non uapi header, it will simplify
the uapi header and system call table file generation script.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/include/asm/unistd.h      | 25 +++++++++++++++++++++++++
 arch/sparc/include/uapi/asm/unistd.h | 25 -------------------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index b2a6a95..f120b6b 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -17,6 +17,12 @@
 
 #include <uapi/asm/unistd.h>
 
+#ifndef __32bit_syscall_numbers__
+#ifndef __arch64__
+#define __32bit_syscall_numbers__
+#endif
+#endif
+
 #ifdef __32bit_syscall_numbers__
 #else
 #define __NR_time		231 /* Linux sparc32                               */
@@ -45,4 +51,23 @@
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 
+/* Bitmask values returned from kern_features system call.  */
+#define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
+
+#ifdef __32bit_syscall_numbers__
+/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
+ * it never had the plain ones and there is no value to adding those
+ * old versions into the syscall table.
+ */
+#define __IGNORE_setresuid
+#define __IGNORE_getresuid
+#define __IGNORE_setresgid
+#define __IGNORE_getresgid
+#endif
+
+/* Sparc doesn't have protection keys. */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #endif /* _SPARC_UNISTD_H */
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index 09acf0d..ccf4bea 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -15,12 +15,6 @@
 #ifndef _UAPI_SPARC_UNISTD_H
 #define _UAPI_SPARC_UNISTD_H
 
-#ifndef __32bit_syscall_numbers__
-#ifndef __arch64__
-#define __32bit_syscall_numbers__
-#endif
-#endif
-
 #define __NR_restart_syscall      0 /* Linux Specific				   */
 #define __NR_exit                 1 /* Common                                      */
 #define __NR_fork                 2 /* Common                                      */
@@ -430,23 +424,4 @@
 
 #define NR_syscalls		361
 
-/* Bitmask values returned from kern_features system call.  */
-#define KERN_FEATURE_MIXED_MODE_STACK	0x00000001
-
-#ifdef __32bit_syscall_numbers__
-/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
- * it never had the plain ones and there is no value to adding those
- * old versions into the syscall table.
- */
-#define __IGNORE_setresuid
-#define __IGNORE_getresuid
-#define __IGNORE_setresgid
-#define __IGNORE_getresgid
-#endif
-
-/* Sparc doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _UAPI_SPARC_UNISTD_H */
-- 
1.9.1

