Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D53EC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2115720882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:33:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I0LxI7IO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2115720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeINNrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:47:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36583 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbeINNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:47:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so3977403pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V1pLobhWUOK3+AIkMnLWzrODShe4KPeHpTFV/R+9qIY=;
        b=I0LxI7IOMZWk8Bb6lesmDel8BzNj9snHxgU6ADz3VBp4qmlZgaKfQ3bjErzfzy7mcK
         owX5QhGfX9gmu5ajCFWyuz1BDVkvgmRFuEFxJiwRaMOn5HCdWRKe9RRAVuL2lwtvDIzc
         8CnrGmgXTJnv7FwyyJFJU5utJ0IMCzas5ES7g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V1pLobhWUOK3+AIkMnLWzrODShe4KPeHpTFV/R+9qIY=;
        b=o0mj1xEaq4kigtFwPVdu4uB+9/g8XGDMpkQIpYtlHAGD93dTn3xEVtYr2dg1XoGzMf
         B+hy5irrWWljx+G8TZRwSknjQum2lRnN7GKhdqLuAiiEFOq1hD90Zr8sJzjiF6eUndUF
         h5EVW+zLEm1cNOe1srR3ELR6lJawrPFpBCPyTgT4Ci5B3JzMkL2cZZGVB8LpjXQX+NcF
         uKceVLoS6lEZQPshWAIyTlEA4X3mNud4mnhTgle7/zOWLAs2/VZtTIwbrZCps6RzCLy8
         molkCkYU9vO6sxDJ0NWGFaoBoPgO8hims95J3ZbhB7Noma+FzcUUD3xdIhvGmRlqaM6v
         3IDA==
X-Gm-Message-State: APzg51DAb452uuvvtPUqWfoYGipr5pQ/gzUOAJz+uIj5Pp00VxoUE3ES
        TebbwJLWukb5rPT6W8buzWOXhA==
X-Google-Smtp-Source: ANB0VdZfL6bobWOgPakdI5//IoicNvgb6huwgMgadpEbVMCZgcnSCASbZV5t4JLxwSgEWgnXpIrRHw==
X-Received: by 2002:a62:1089:: with SMTP id 9-v6mr11358878pfq.30.1536914019275;
        Fri, 14 Sep 2018 01:33:39 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.60.83])
        by smtp.gmail.com with ESMTPSA id d6-v6sm12427070pgt.66.2018.09.14.01.33.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Sep 2018 01:33:38 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH 1/3] powerpc: Replace NR_syscalls macro from asm/unistd.h
Date:   Fri, 14 Sep 2018 14:02:58 +0530
Message-Id: <1536913980-4811-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_syscalls macro holds the number of system call exist in POWERPC
architecture. This macro is currently the part of asm/unistd.h file.
We have to change the value of __NR_syscalls, if we add or delete a
system call.

One of the patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file contains
the number of system call information. So we have two option to update
__NR_syscalls value.

1. Update __NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update __NR_syscalls untill
   we either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update __NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
NR_syscalls macro from asm/unistd.h to uapi/asm/unistd.h. The macro
name also changed form NR_syscalls to __NR_syscalls for making the
name convention same across all architecture. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/powerpc/include/asm/unistd.h      | 3 +--
 arch/powerpc/include/uapi/asm/unistd.h | 2 ++
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index c19379f..54732f9 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -11,8 +11,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-#define NR_syscalls		389
+#define NR_syscalls  __NR_syscalls
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 985534d..f999df2 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -401,4 +401,6 @@
 #define __NR_rseq		387
 #define __NR_io_pgetevents	388
 
+#define __NR_syscalls           389
+
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.9.1

