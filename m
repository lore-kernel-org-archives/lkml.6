Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E393ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023532084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 05:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArkMinRx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023532084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbeJZNm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 09:42:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37145 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJZNm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 09:42:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id j23-v6so5320167pfi.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 22:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z+Px7sUPuRKapRa637BSknRaNKVUB6N1jn4kvI9gb9w=;
        b=ArkMinRxDe7YmFppkSMRSYWfGT+1uCuCigBc9vtGNB1rkeVbmzd9Fy11TnqJUiHXsN
         y2ql9z61wIJze5l7cP4NfuM5gOriMEvWp+WXVuaxp1r12aBXEtyNo78ffsJv3VV9pquV
         M00B8yIMbm9UwRld00guQygDw5o/mf9xpmjkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z+Px7sUPuRKapRa637BSknRaNKVUB6N1jn4kvI9gb9w=;
        b=YKE8Y4S9pH7L+G/1baYZmOJjyPBq1czSkkFEEnB7HfJICfa92GqkYs1c/Sh4YEJb5i
         guJoJBWfCatj1UZ8AZRzqr+p+S/Yp87v44EAP3qv1QdjMcuWJi6njw0OWIVrXzMGaYbs
         UPs47ROQFTVTfBXy76EGdyVrzvDW3B0uXvOJCXSzxLLN+jP375WlnlvYHs77mKgAnlDT
         yXOBkM8SyiuqqhCb6KMT0DCFjeR04b6mtal1n6eVDz7DpRdH5RMRPNZkzMrpvqgYND/D
         xY0jLD2g4RxZ6S8C7u2RTDrKrdIw5CSvLGcjavaNaKVwXivSvBttV7fVMAXTn1KfZF4Z
         8CXg==
X-Gm-Message-State: AGRZ1gIcju1QGPIAvUmNJMjH3eJsZsSmGLtKpe70ieWK9m+mQuDtRo6h
        c9ShT1QPBxLSccrQeq5tH1A+ig==
X-Google-Smtp-Source: AJdET5eWgyBjcgiwVkbYkpZ0iuPrcezmLxDq2WOn2eOCmJxnpjzEOfSl75XEyhHhPr/f1rFjZDNLJw==
X-Received: by 2002:a62:8910:: with SMTP id v16-v6mr2200909pfd.106.1540530418057;
        Thu, 25 Oct 2018 22:06:58 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.61.165])
        by smtp.gmail.com with ESMTPSA id m18-v6sm12800626pfk.149.2018.10.25.22.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 22:06:57 -0700 (PDT)
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
Subject: [PATCH v4 2/4] m68k: add __NR_syscalls along with NR_syscalls
Date:   Fri, 26 Oct 2018 10:36:15 +0530
Message-Id: <1540530377-3509-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540530377-3509-1-git-send-email-firoz.khan@linaro.org>
References: <1540530377-3509-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist
in m68k architecture. We have to change the value of NR-
_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update NR_sy-
scalls value.

1. Update NR_syscalls in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_sys-
   calls until we either add a new system call or delete
   existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update NR_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with NR_syscalls asm/unistd.h. The macro __NR_syscalls
also added for making the name convention same across all
architecture. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

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

