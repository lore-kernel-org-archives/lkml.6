Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49764C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED2D22419
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 09:32:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DIzVLkvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED2D22419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbeKMT3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 14:29:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33340 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731669AbeKMT3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 14:29:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id v68-v6so5764416pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 01:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PmD+PCg2rARw5PC4eCUFbOCoKLS/cwCHLXhaCYfoDTI=;
        b=DIzVLkvMpWnQJ3kKr9HOUeTGZj7sXd+aSOpRXLwYJvxFvZzg/Qu0quURmgD7pqaRFE
         geakGxB8vJBi16/zugGJVNUNzb/1+kimLKvgQvx7so+ZJMS8lHR6x8bbFgcd+GvDBXks
         q6FDwqK8aYRDbYtZ/RXXV4CHFYse7UCuWQY9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PmD+PCg2rARw5PC4eCUFbOCoKLS/cwCHLXhaCYfoDTI=;
        b=HlIfxTUwg9klPwh72D1cQ9DfmH7yjvTW3/g5Bk1OHB5ddB0udJ8uxZvJPDkJsXlakc
         7MzNsN41BfIoWl/tEDEPvXZ7LVWwtZnzmM4vaIbk6eUJP13jHthfHhs4VIkSfWInNHa8
         XXD34mbMnR5X/c1oawkfkkA5bKWvnUZDnFhjkvPGhjXHzrpOjgMmLyXRn0uXgdRc/VVz
         3xpKILNRqyvz+I94jboa9KVHl3iEeYdp+MeWEu9WfJwf7Hyv2M6QNpHkfSYxiZtrkCXy
         GhzljwHxlsfWsMlDrP93PyclF/mYAYIC7JZ8rDU9lUfPFbwg+yHffdcHBno3lY5AVN6H
         +png==
X-Gm-Message-State: AGRZ1gLegRkrs3rAWlnnmT8aBs95EDdGkcLHXKl6+CVHutLDbCjCqXP2
        +u1NNgjNZhyNPLQA49mvvcnBSw==
X-Google-Smtp-Source: AJdET5e3sb7FEKjW8PpG1PihZBbDFCO0PQ0c0sOlTcuVb3/5EsolnspbmlJfOAJkl5cDh+lRFu/+Pw==
X-Received: by 2002:a62:5504:: with SMTP id j4-v6mr4391445pfb.166.1542101547420;
        Tue, 13 Nov 2018 01:32:27 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id u6sm19902462pgr.79.2018.11.13.01.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 01:32:26 -0800 (PST)
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
Subject: [PATCH v3 1/5] alpha: move __IGNORE* entries to non uapi header
Date:   Tue, 13 Nov 2018 15:01:49 +0530
Message-Id: <1542101513-22010-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
References: <1542101513-22010-1-git-send-email-firoz.khan@linaro.org>
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
index 9ff37aa..4f0ceb3 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -19,4 +19,25 @@
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

