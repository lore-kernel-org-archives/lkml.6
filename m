Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370CEC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D649220869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpQ5/XsS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D649220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbeIDJFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:05:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40426 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727523AbeIDJFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:05:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so1007895plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 21:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nYQduDF7NEsG6i8cWnr4XIXTQTH+GoEAWEHuj8R3h0w=;
        b=GpQ5/XsSU6VJBg+QWu0/UQEffBet7RCg31dofPkeOTO8CpOo3a4ln2Kpo5xhL4jIbZ
         zUqSxXfBBaTMXFlAvnjYershuVwmTUyswn4WbxCT1Ixme9j75BSzeJ6+UKzFqD3Ag8vK
         8YLm8rS/VpoqliP//M8kxkzV18fTL67gPLJYk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nYQduDF7NEsG6i8cWnr4XIXTQTH+GoEAWEHuj8R3h0w=;
        b=RvlAEfKUioLcoDf5cztBcifgi5dTp7XOIXlSJG0dP44ctEyrtJQ6rt0EGs2qQH4hD7
         IZRROI92Ze5KGj3MV048XU0mJEf3ZmPtAWzxV1Pd7JgqaN6QyTgIgsaKkMye07bO681Z
         o0j8RFwdzhdK8sIJOXXoLScniZEeiXvTTGMcwhK8k6uuAW0FOsJ2rY5rYc9vAOnjaRUK
         DENHqDT9r4ABDsmRIXQn8Eho6ZT5d6ZA0KhhuOj6ZC1PWufr/eiTlAB2fZkmblUQSu1r
         xPvGNMSQLTQZwicZfGROmWFZ2IB8nfTmqoYrYrVGPdNj9qTLKj9YrTLBeaxOhLPBBTII
         sKKg==
X-Gm-Message-State: APzg51AJe8n/HkyOGbVyoEJRxpU0YWKUnrZ3ZTH0pVcBBUIjhHqIQPpD
        X9UrwqoEyQxSPv0+6xQpa0tfcIEOxFY=
X-Google-Smtp-Source: ANB0VdYy//IkDSdYfAiCxa27cGXc++f7dmO2xTb/l/ZvzdH6Ub/OsC4AWgndbZ1Nc/dkzdg6eiEPrg==
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3-v6mr31857269plz.238.1536036139417;
        Mon, 03 Sep 2018 21:42:19 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id w12-v6sm10280372pfd.110.2018.09.03.21.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Sep 2018 21:42:19 -0700 (PDT)
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
Subject: [PATCH 2/4] sparc: Replace NR_SYSCALLS macro with __NR_SYSCALLS
Date:   Tue,  4 Sep 2018 10:11:25 +0530
Message-Id: <1536036087-15260-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist in SPARC
architecture. This macro is currently the part of uapi/asm/unistd.h
file. We have to change the value of NR_syscalls, if we add or
delete a system call.

One of the patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file contains
the number of system call information. So we have two option to update
NR_syscalls value.

1. Update NR_syscalls in uapi/asm/unistd.h manually by counting the
   no.of system calls. No need to update NR_syscalls until we either
   add a new system call or delete an existing system call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved the
NR_syscalls macro from uapi/asm/unistd.h to asm/unistd.h. The macro
name also changed form NR_syscalls to __NR_syscalls for making the
name convention same across all architecture. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sparc/include/asm/unistd.h      | 2 ++
 arch/sparc/include/uapi/asm/unistd.h | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index f120b6b..c8849b7 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -17,6 +17,8 @@
 
 #include <uapi/asm/unistd.h>
 
+#define NR_syscalls __NR_syscalls
+
 #ifndef __32bit_syscall_numbers__
 #ifndef __arch64__
 #define __32bit_syscall_numbers__
diff --git a/arch/sparc/include/uapi/asm/unistd.h b/arch/sparc/include/uapi/asm/unistd.h
index ccf4bea..e2407b4 100644
--- a/arch/sparc/include/uapi/asm/unistd.h
+++ b/arch/sparc/include/uapi/asm/unistd.h
@@ -422,6 +422,6 @@
 #define __NR_pwritev2		359
 #define __NR_statx		360
 
-#define NR_syscalls		361
+#define __NR_syscalls		361
 
 #endif /* _UAPI_SPARC_UNISTD_H */
-- 
1.9.1

