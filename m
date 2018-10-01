Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADAAC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA6D20684
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6RFV98Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA6D20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbeJATV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:21:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41427 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbeJATV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:21:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id 23-v6so495115pgc.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s8hI874nr1svKsPuQ+4jj2+9yIBbAE+XlrRpXowMo1U=;
        b=N6RFV98Y65kCWeczCKHFm2nY7Fqjuh7lQa887pmiWJX4z72dez5LyEmFk/kpP9aZlW
         VwRBn1B+ahG1MAT+jWJ7DIrmw3zhEby+hyWjT9FeQy+tbVfcbwtFDOARBXo0e3KubJRZ
         +xVXR2PS5ZIsh0zqsVYVP2Icny/hgOg/xxJJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s8hI874nr1svKsPuQ+4jj2+9yIBbAE+XlrRpXowMo1U=;
        b=rmzJjzwh3JY5I1sMoewjgfWYx9P7ydsPZIc8BSlkqhogtLERazZTsfV0cJJ82jYwj+
         Nco0Lcoh4N2X2Pn7Uv0n0uqVA7hXawmL3xpxfYGodbCYq8DS0+FrGlV01cIsT+oIKSc8
         mq6noyH1/zc1TKQU+nwNVp/PLzcQ5ulCaG8pIEJqyP3hlkfx1twI8cZFEjZtefmtSxGQ
         /8iAWqGTGEpx4FlfojhHdr0DaPVVSA3ahCmA/hJPUfLePkRt6maGRIbRxgZyC24UaTmW
         5HP941zYNWwNuiIoXHKe7hWVixxIf7ktyGGondXBV1LXRveNrarQQckUzRKrWbb3gKdu
         58mw==
X-Gm-Message-State: ABuFfogEDXxL5HZrwVa1mApdnNcATbqY7T18rCacvo9U+n4aqGt4LSop
        vYPYSTLG53q4zW35FLs9KnsCSw==
X-Google-Smtp-Source: ACcGV61nHIcQOTqKLoWbKw/ZLh8m9tJ55DdzTcUwn+TO5DoIC0zVlIgWJUeha1ItjH3NTC/012tlDQ==
X-Received: by 2002:a62:56c1:: with SMTP id h62-v6mr9301694pfj.107.1538397830469;
        Mon, 01 Oct 2018 05:43:50 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.59.231])
        by smtp.gmail.com with ESMTPSA id x17-v6sm5522450pfn.59.2018.10.01.05.43.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 05:43:50 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 1/3] microblaze: replace __NR_syscalls macro from asm/unistd.h
Date:   Mon,  1 Oct 2018 18:13:02 +0530
Message-Id: <1538397784-4214-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
References: <1538397784-4214-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_syscalls macro holds the number of system call exist in this
architecture. This macro is currently the part of asm/unistd.h file.
We have change the value of __NR_syscalls, if we add or delete a
system call.

One of the patch in this patch series has a script which will
generate a uapi header based on syscall.tbl file. The syscall.tbl
file contains the number of system call information. So we have
two option to update __NR_syscalls value.

1. Update __NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update __NR_syscalls until
   we either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update __NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
__NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. While
__NR_syscalls isn't strictly part of the uapi, having it as part
of the generated header to simplifies the implementation. We also
need to enclose this macro with #ifdef __KERNEL__ to avoid side
effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/microblaze/include/asm/unistd.h      | 2 --
 arch/microblaze/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index a62d094..e19550f 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -38,6 +38,4 @@
 
 #endif /* __ASSEMBLY__ */
 
-#define __NR_syscalls         401
-
 #endif /* _ASM_MICROBLAZE_UNISTD_H */
diff --git a/arch/microblaze/include/uapi/asm/unistd.h b/arch/microblaze/include/uapi/asm/unistd.h
index 7a9f16a..ed9c6f5 100644
--- a/arch/microblaze/include/uapi/asm/unistd.h
+++ b/arch/microblaze/include/uapi/asm/unistd.h
@@ -418,4 +418,8 @@
 #define __NR_io_pgetevents	399
 #define __NR_rseq		400
 
+#ifdef __KERNEL__
+#define __NR_syscalls         401
+#endif
+
 #endif /* _UAPI_ASM_MICROBLAZE_UNISTD_H */
-- 
1.9.1

