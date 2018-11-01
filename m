Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58527C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2021A2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvU6w/hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2021A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeKAXAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 19:00:00 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44410 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728810AbeKAW77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:59:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id w3-v6so9059541pgs.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pnxeipCiPkb8vJ+Pd7jS4kFRDZjLiyf2+Z/z+WNftIQ=;
        b=CvU6w/hchzFBPMwlBNJDUScAJ5JIA1i/H+3P5nNbi1G8grVKBMHb2DiEKtkJ7tCm5v
         xMAoA71fAhwIdWVd66Jm8lBv3EBajJdkkk1bHPKkgqPSDNhm3sA4qTnHnlRry3L3PQNj
         lUsFa7TUNkRTqwiL2TXk9jR1VPS+TOHYd6AoY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pnxeipCiPkb8vJ+Pd7jS4kFRDZjLiyf2+Z/z+WNftIQ=;
        b=SP4JMzu8E4pYphSewHPOF9SQyF9B8PQwoF2y1eJySfHBhlWJqY8uHq1SDL/HYcSvMd
         MGVgyZVkOncqED7s1upo+7qadpG1p9+HxXCZo/A3D5E64BfRHh/gYwRZaK942Zg7UizO
         RKOSmYXGYRKKXgtSO18n7eGvX0x6TkoPUTGvjV5X8jWKqazp1uU/7+PcmnRE6C4oNNWn
         90g+Gwms9TZvxFviDJ5qc/QUewTXJmmc54YY1NdIqhGdZabe18JZl7KyQlcs16jLfbQM
         JHzP1dypbDTqoKBijc3OOwCprunxuA5Fo5XphJF7k6X8mwhSQ2rWp9C3+C8eFKUHcPe0
         o5hA==
X-Gm-Message-State: AGRZ1gIYU82ECW7TrQTWifhHRsi/E5jRujrwgwFnPLEF5/I07E09LqbC
        UXzNhGCWx135wra1++zyUmMPww==
X-Google-Smtp-Source: AJdET5d5Z4sImdQnauBf1zBqsmiCNQUBZ1qDT6yBmFqt1mCGJ3l++sN2hOsc8azpAitanKyGPS5qsw==
X-Received: by 2002:a63:2356:: with SMTP id u22-v6mr7238665pgm.122.1541080614948;
        Thu, 01 Nov 2018 06:56:54 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id m18-v6sm39076169pfk.149.2018.11.01.06.56.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:56:54 -0700 (PDT)
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
Subject: [PATCH v1 1/4] xtensa: move SYS_XTENSA_* macros to non uapi header
Date:   Thu,  1 Nov 2018 19:26:18 +0530
Message-Id: <1541080581-4072-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
References: <1541080581-4072-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the SYS_XTENSA_* macros used by sysxtensa syscall
handlers are resides in the uapi header file move to
non uapi header asm/unistd.h as it is not used by any
user space applications.

It is correct to keep these macros in non uapi header
file asm/unistd.h while uapi/asm/unistd.h must hold
information only useful for user space applications.

One of the patch in this patch series will generate
uapi header file. The information which directly used
by the user space application must be present in uapi
file.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/xtensa/include/asm/unistd.h      | 18 ++++++++++++++++++
 arch/xtensa/include/uapi/asm/unistd.h | 18 ------------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/include/asm/unistd.h b/arch/xtensa/include/asm/unistd.h
index ed66db3..c73eca83 100644
--- a/arch/xtensa/include/asm/unistd.h
+++ b/arch/xtensa/include/asm/unistd.h
@@ -22,4 +22,22 @@
 #define __IGNORE_vfork				/* use clone */
 #define __IGNORE_fadvise64			/* use fadvise64_64 */
 
+/*
+ * sysxtensa syscall handler
+ *
+ * int sysxtensa (SYS_XTENSA_ATOMIC_SET,     ptr, val,    unused);
+ * int sysxtensa (SYS_XTENSA_ATOMIC_ADD,     ptr, val,    unused);
+ * int sysxtensa (SYS_XTENSA_ATOMIC_EXG_ADD, ptr, val,    unused);
+ * int sysxtensa (SYS_XTENSA_ATOMIC_CMP_SWP, ptr, oldval, newval);
+ *        a2            a6                   a3    a4      a5
+ */
+
+#define SYS_XTENSA_RESERVED               0     /* don't use this */
+#define SYS_XTENSA_ATOMIC_SET             1     /* set variable */
+#define SYS_XTENSA_ATOMIC_EXG_ADD         2     /* exchange memory and add */
+#define SYS_XTENSA_ATOMIC_ADD             3     /* add to memory */
+#define SYS_XTENSA_ATOMIC_CMP_SWP         4     /* compare and swap */
+
+#define SYS_XTENSA_COUNT                  5     /* count */
+
 #endif /* _XTENSA_UNISTD_H */
diff --git a/arch/xtensa/include/uapi/asm/unistd.h b/arch/xtensa/include/uapi/asm/unistd.h
index bc3f62d..c8ac79a 100644
--- a/arch/xtensa/include/uapi/asm/unistd.h
+++ b/arch/xtensa/include/uapi/asm/unistd.h
@@ -780,24 +780,6 @@
 
 #define __NR_syscall_count			352
 
-/*
- * sysxtensa syscall handler
- *
- * int sysxtensa (SYS_XTENSA_ATOMIC_SET,     ptr, val,    unused);
- * int sysxtensa (SYS_XTENSA_ATOMIC_ADD,     ptr, val,    unused);
- * int sysxtensa (SYS_XTENSA_ATOMIC_EXG_ADD, ptr, val,    unused);
- * int sysxtensa (SYS_XTENSA_ATOMIC_CMP_SWP, ptr, oldval, newval);
- *        a2            a6                   a3    a4      a5
- */
-
-#define SYS_XTENSA_RESERVED               0     /* don't use this */
-#define SYS_XTENSA_ATOMIC_SET             1     /* set variable */
-#define SYS_XTENSA_ATOMIC_EXG_ADD         2     /* exchange memory and add */
-#define SYS_XTENSA_ATOMIC_ADD             3     /* add to memory */
-#define SYS_XTENSA_ATOMIC_CMP_SWP         4     /* compare and swap */
-
-#define SYS_XTENSA_COUNT                  5     /* count */
-
 #undef __SYSCALL
 
 #endif /* _UAPI_XTENSA_UNISTD_H */
-- 
1.9.1

