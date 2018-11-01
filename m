Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD870C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F8F20820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XzUb3U9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5F8F20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbeKAWrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:47:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43148 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbeKAWrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:47:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id g59-v6so4972959plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hrIc/09hG2Rjx2gxHsto6VmZaTQU+F7AknA7S+s7234=;
        b=XzUb3U9GlS5JnUygI02ciugK291+KqeUWtH8GxITzw46BLpeq1B0E2D7yFKWibv9+s
         lVQ85elZZLczsoPWxk0EGfMa13I/fU6Nv5hwnEngEumepLGuNBiyZdN4NqgfXwSJVsGh
         5hyOW6k4a4SAKPqz5idoo5MmcnFk+yzYxWWSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hrIc/09hG2Rjx2gxHsto6VmZaTQU+F7AknA7S+s7234=;
        b=lj9+O9Ba9eYfLQZSz6k8guo8voW9SBw1uhARw1hwu72nDb6B3nTEUmWpRc9949gpty
         LSi68q4KcmQKYYtWLhbg38QymF7FBA/aY38DDCWRyO6Z6Xkru+Wyb0XBwgJoneyqvpOp
         rqan+MFbm/7GeV9dzAxC1lefEisd1KUTllXGUoh/SkmYnCXy/j+Tn5I7kKrJCcd1/6u1
         Bs2YXbpvdBwOUlkY2EPbhwhljmHdgvrIE1PSYHNdNBL2HQvJTE5uL8BvZ2DtYfzJjq9o
         VAdN5RpLmjp3dcht6MqUMuMFFFC2efcRcjjZMIMi/YxqzSYd24JF1MvgiabCSla0m0u9
         1OBg==
X-Gm-Message-State: AGRZ1gIbGkTru3GYb72oL7Rx1VwPtcNyS8IlEa9l9i1VhAXeIlk4M3eH
        FiGbttE0L5U9i8pjgC5WV4M27w==
X-Google-Smtp-Source: AJdET5eEJ8oLGZAaXmPNwf+YUWGevi0Nnpg/fQsy8Z8cFOH83+EIJtJHBg9Vs/f2o4DLn8COxIqX0g==
X-Received: by 2002:a17:902:8b8c:: with SMTP id ay12-v6mr7407124plb.69.1541079857341;
        Thu, 01 Nov 2018 06:44:17 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id r23-v6sm36359299pgm.48.2018.11.01.06.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:44:16 -0700 (PDT)
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
Subject: [PATCH v2 1/5] alpha: move __IGNORE* entries to non uapi header
Date:   Thu,  1 Nov 2018 19:13:33 +0530
Message-Id: <1541079817-3431-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
References: <1541079817-3431-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the __IGNORE* entries are resides in the uapi header
file move to non uapi header asm/unistd.h as it is not
used by any user space applications.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

One of the patch in this patch series will generate uapi
header file. The information which directly used by the
user space application must be present in uapi file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/alpha/include/asm/unistd.h      | 21 +++++++++++++++++++++
 arch/alpha/include/uapi/asm/unistd.h | 21 ---------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index d6e29a1..cbd04d3 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -17,4 +17,25 @@
 #define __ARCH_WANT_SYS_VFORK
 #define __ARCH_WANT_SYS_CLONE
 
+/*
+ * Ignore legacy syscalls that we don't use.
+ */
+#define __IGNORE_alarm
+#define __IGNORE_creat
+#define __IGNORE_getegid
+#define __IGNORE_geteuid
+#define __IGNORE_getgid
+#define __IGNORE_getpid
+#define __IGNORE_getppid
+#define __IGNORE_getuid
+#define __IGNORE_pause
+#define __IGNORE_time
+#define __IGNORE_utime
+#define __IGNORE_umount2
+
+/* Alpha doesn't have protection keys. */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #endif /* _ALPHA_UNISTD_H */
diff --git a/arch/alpha/include/uapi/asm/unistd.h b/arch/alpha/include/uapi/asm/unistd.h
index e153ca6..47c65f1 100644
--- a/arch/alpha/include/uapi/asm/unistd.h
+++ b/arch/alpha/include/uapi/asm/unistd.h
@@ -241,22 +241,6 @@
 #define __NR_osf_fdatasync	261	/* not implemented */
 
 /*
- * Ignore legacy syscalls that we don't use.
- */
-#define __IGNORE_alarm
-#define __IGNORE_creat
-#define __IGNORE_getegid
-#define __IGNORE_geteuid
-#define __IGNORE_getgid
-#define __IGNORE_getpid
-#define __IGNORE_getppid
-#define __IGNORE_getuid
-#define __IGNORE_pause
-#define __IGNORE_time
-#define __IGNORE_utime
-#define __IGNORE_umount2
-
-/*
  * Linux-specific system calls begin at 300
  */
 #define __NR_bdflush		300
@@ -481,9 +465,4 @@
 #define __NR_pwritev2			521
 #define __NR_statx			522
 
-/* Alpha doesn't have protection keys. */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #endif /* _UAPI_ALPHA_UNISTD_H */
-- 
1.9.1

