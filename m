Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27412C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D457321526
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 15:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AfB0g5Pd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D457321526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbeITUus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 16:50:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38804 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387728AbeITUus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 16:50:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id t84-v6so4571392pgb.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CX41ki2kczu1qAQ/hv2i6mgWeOgVj6gPhu2iwSGbJw4=;
        b=AfB0g5Pd4Qqi0cygwYQX6lH8seBTd1v1q8Q4xES7uATertP3is7ZpDCmnXOrLMz5OA
         M3iBWFSm3UWMAVHvXg5McpMu/JrZL2hOlOSFOpM2Uoh6FzW7kn2Dw7I46NK7I3ncRQRG
         Gc9IR6NGvHvN+7l3EgLFQ9fd9A8opyd90zyQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CX41ki2kczu1qAQ/hv2i6mgWeOgVj6gPhu2iwSGbJw4=;
        b=oU5hsCztiOtr6rTKhNwU0AK4vnuiqVPqp2KkLqXE9W856gKphZNaQiQfVY7LeVbG3T
         0eEA1ICMI14MnS187UShfcHG7QzjPQ5qAUA+NFdTcussRplySxkKk+j2YKk+8HNXsI4H
         7j5LjAnAweALW+0M6qTt0fNYfe5WMnx3SZqgY9wIS6d12PjsDyXr+iE743nRw9UrjsCD
         TS35xdpZ4lp88XA6I8wqXjiUst/rNJSbsQOTcm9kFJB+aqoZYvHksMFxKJIojrVi5+Vd
         cTKsgtyWE+kevngnMa1cJIQDZDIeheK9vPjtpG8MO7/RaDzIwj0nF0G5sqEUw2s+V+e6
         OuxQ==
X-Gm-Message-State: APzg51Cu5cVO+uWUYjw1VdJgzt8wtJceRVS09FCNbwCpU8AoIKBlBfFq
        jsoKi5GXwQdbXsa7l3g3+1q+Pg==
X-Google-Smtp-Source: ANB0VdZb7MpiuECzUxPu4Wcn9Ey/ERSaiH4cnouXUrckC8Pebb6TxeXQJmFTwdaiQTt4gYgkh+76jw==
X-Received: by 2002:a63:7f06:: with SMTP id a6-v6mr37524094pgd.296.1537456013788;
        Thu, 20 Sep 2018 08:06:53 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.107.142])
        by smtp.gmail.com with ESMTPSA id k64-v6sm36222991pfg.141.2018.09.20.08.06.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Sep 2018 08:06:53 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 2/5] m68k: Replace NR_syscalls macro from asm/unistd.h
Date:   Thu, 20 Sep 2018 20:36:10 +0530
Message-Id: <1537455973-12468-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
References: <1537455973-12468-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist in m68k
architecture. This macro is currently the part of asm/unistd.h file.
We have to change the value of NR_syscalls, if we add or delete a
system call.

One of patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file
contains the number of system call information. So we have two
option to update NR_syscalls value.

1. Update NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update NR_syscalls untill
   we either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I come up
with another macro - __NR_syscalls which will be updated by the
script and it will be present in api/asm/unistd.h. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation. So we need to enclose this
macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/include/asm/unistd.h      | 3 +--
 arch/m68k/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 30d0d3f..5072e94 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -4,8 +4,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-#define NR_syscalls		380
+#define NR_syscalls __NR_syscalls
 
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT
diff --git a/arch/m68k/include/uapi/asm/unistd.h b/arch/m68k/include/uapi/asm/unistd.h
index de3054f..ba4176aa 100644
--- a/arch/m68k/include/uapi/asm/unistd.h
+++ b/arch/m68k/include/uapi/asm/unistd.h
@@ -387,4 +387,8 @@
 #define __NR_pwritev2		378
 #define __NR_statx		379
 
+#ifdef __KERNEL__
+#define __NR_syscalls		380
+#endif
+
 #endif /* _UAPI_ASM_M68K_UNISTD_H_ */
-- 
1.9.1

