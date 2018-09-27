Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F9DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C2B216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hp04tXel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C2B216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbeI0Unk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:43:40 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41174 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbeI0Unk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:43:40 -0400
Received: by mail-pf1-f195.google.com with SMTP id m77-v6so2036370pfi.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p45a/e2du0K3VOKtsUCRlFfXZHC5nty49NugILWrhhY=;
        b=Hp04tXelDoxjmpjnvGyk1hbmHmr+mthqWJ0pcvHjEV1MfQ4YeGeZ6ZmDA3qms6BAdJ
         3uHH4DaIb80ZpI/cy4V+562r6yG7jpGW38yQaiKnVEpP+2dvFsYQoPSOEHcFVNSGBHMq
         p3LVcf4DbI7D6VwtT1GuWIwNnDy2ajWis10OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p45a/e2du0K3VOKtsUCRlFfXZHC5nty49NugILWrhhY=;
        b=FjD5OOPY+q4ZV+3J1+peOb49KeQKqfyOLLAPP+ICXcz8eVx8sARwFRWFJT5DpXZQrC
         l6qfRL9iRqgPRDT4nao6Gp1gBSJQN4UUqEwvzFJJmttTf8iaIRewahxqyfzRRUevKdRi
         fKdRevAkMGLb+CdYsqVsnHwBOZkqY2Q9pFy7WPfIXVu2UfQoRRpH2H7sEHMfi7GWH3xx
         6fUKvIyBBw8mWBn3t3fvCaFibMEsabLAKRHF/SJVE4CETgZLVHVAubxqwMGPihArFFtf
         F8EEAC7R+K0p4LO2VXJhZgwWlOyy6D8CwKAohpyDYrZxAM97AAX+7ntqZ9u/3q2gOEDU
         4FuA==
X-Gm-Message-State: ABuFfogzLPtAcuSy3eneTlRk1V26/7n6NxEmKWO7kpSgGHnLjHdhWEWG
        JQ+pSkDVRYu2XInuRVpgdy3fhg==
X-Google-Smtp-Source: ACcGV61+Shi0tUodVNrcHq1kqqZ7BVtB5nSbOH3nBXhNZZusVSMlPSrsmE8sFi6FCYsheg6EZzwfQQ==
X-Received: by 2002:a62:ee06:: with SMTP id e6-v6mr11979421pfi.2.1538058308607;
        Thu, 27 Sep 2018 07:25:08 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.105.186])
        by smtp.gmail.com with ESMTPSA id f81-v6sm9717421pfh.46.2018.09.27.07.25.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 07:25:08 -0700 (PDT)
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
Subject: [PATCH v2 1/5] parisc: move __IGNORE* entries to non uapi header
Date:   Thu, 27 Sep 2018 19:54:23 +0530
Message-Id: <1538058267-3765-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the  __IGNORE* entries are resides in the uapi header
file moved to non uapi header. Basically it is not used by
any user space applications.

One of the patch in this patch series will generate the
uapi header file and system call table file. So if we move
all the __IGNORE* entries to non uapi header, it will help
to simplify the uapi header and system call table file
generation script.

It is correct to keep __IGNORE* entry in non uapi header
asm/unistd.h while uapi/asm/unistd.h must hold information
only useful for user space applications.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 6 ++++++
 arch/parisc/include/uapi/asm/unistd.h | 7 -------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 3d507d0..93fd9f6 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -8,6 +8,12 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
+#define __IGNORE_select                /* newselect */
+#define __IGNORE_fadvise64             /* fadvise64_64 */
+#define __IGNORE_pkey_mprotect
+#define __IGNORE_pkey_alloc
+#define __IGNORE_pkey_free
+
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
 #endif
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index dc77c5a..bb52e12 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -368,13 +368,6 @@
 
 #define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
 
-
-#define __IGNORE_select		/* newselect */
-#define __IGNORE_fadvise64	/* fadvise64_64 */
-#define __IGNORE_pkey_mprotect
-#define __IGNORE_pkey_alloc
-#define __IGNORE_pkey_free
-
 #define LINUX_GATEWAY_ADDR      0x100
 
 #endif /* _UAPI_ASM_PARISC_UNISTD_H_ */
-- 
1.9.1

