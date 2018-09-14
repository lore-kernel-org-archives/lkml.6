Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B35FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2438020866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MkyDxRlp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2438020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeINNkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:40:52 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36171 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbeINNkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:40:52 -0400
Received: by mail-pl1-f195.google.com with SMTP id p5-v6so3868655plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zMC8k40pj5pQI2mZhgUNgHT0ATkeiBUzIOSkhSJbf2Y=;
        b=MkyDxRlpTE1z+sXJl9oJhjBkIroORjHP0+gcHo25E0eNQy+Chisu66VCFmPJX6ozic
         MBrt+uFcIYdHRy0vr/6IMkApBO6zX/WM5gDslHsAYQcflGmpH9tpsb6YYrYWGfd5ysQS
         op09IT3pdUzvAk58KtyuYH1qix1EK7CJsDgVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zMC8k40pj5pQI2mZhgUNgHT0ATkeiBUzIOSkhSJbf2Y=;
        b=r6fn3R/fiE3ZATEvQFrF46SaSdCx7LMa5xnEhsVNbdnfsyvFy0fZtR7cHCF4xoAPR0
         PeoTkvkay14WA44cIDtJmxkAJDfvWf+NCK+z8hGk6tusSoO8uzU4b/UNI6zP0fkd3nxh
         qQ9K8nQo8HRcF4kpLsqnTr28GZNhsqofLcq65wQLdHNbeZ8YYdOw24Omd2tdxXzz2ZVj
         bX5yXYLAmrQS7cOPCN/ZIkN5O1DIDeMFtTbtSid2tqy01f71+a1SYJTDjytd5KA+8YNW
         jIGX7j2MWweptSquGwl0e6Xp0LPwKkguOkuQ45mzCwI6GPCyp0KTcfw/S6H+DkN56xQ7
         4f/g==
X-Gm-Message-State: APzg51BPKYdwo7Veay5P6+Xhh05905/6Encchzi7Fc4oNK2bjr09Zkce
        /7fXRxNUDkcGOfcZPtsWC+dvLg==
X-Google-Smtp-Source: ANB0VdYfPSoSSRwXLVKQlieRirLVJWQ24chmiRdciEzFlWslpnUx7evuTJ3Bm5q1tJNUI56DF28oQA==
X-Received: by 2002:a17:902:e088:: with SMTP id cb8-v6mr10976530plb.189.1536913649809;
        Fri, 14 Sep 2018 01:27:29 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.60.83])
        by smtp.gmail.com with ESMTPSA id q80-v6sm8919855pfd.15.2018.09.14.01.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 01:27:29 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Thibaut Varene <T-Bone@parisc-linux.org>,
        linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 2/4] parisc: Replace __NR_Linux_syscalls macro with __NR_syscalls
Date:   Fri, 14 Sep 2018 13:56:41 +0530
Message-Id: <1536913603-4584-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org>
References: <1536913603-4584-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_Linux_syscalls macro holds the number of system call exist in
PARISC architecture. This macro is currently the part of uapi/asm/
unistd.h file. We have to change the value of __NR_Linux_syscalls,
if we add or delete a system call.

One of the patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file contains
the number of system call information. So we have two option to update
__NR_Linux_syscalls value.

1. Update __NR_Linux_syscalls in uapi/asm/unistd.h manually by counting
   the no.of system calls. No need to update NR_syscalls until we
   either add a new system call or delete an existing system call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update __NR_Linux_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
__NR_Linux_syscalls macro from uapi/asm/unistd.h to asm/unistd.h. The
macro name also changed form __NR_Linux_syscalls to __NR_syscalls for
making the name convention same across all architecture. While __NR_
syscalls isn't strictly part of the uapi, having it as part of the
generated header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 2 ++
 arch/parisc/include/uapi/asm/unistd.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index fc71edf..71417c1 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -8,6 +8,8 @@
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
 
+#define __NR_Linux_syscalls __NR_syscalls
+
 #ifndef ASM_LINE_SEP
 # define ASM_LINE_SEP ;
 #endif
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index bb52e12..7532817 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -366,7 +366,7 @@
 #define __NR_statx		(__NR_Linux + 349)
 #define __NR_io_pgetevents	(__NR_Linux + 350)
 
-#define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
+#define __NR_syscalls           (__NR_Linux + 351)
 
 #define LINUX_GATEWAY_ADDR      0x100
 
-- 
1.9.1

