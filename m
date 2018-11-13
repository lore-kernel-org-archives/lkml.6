Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C98C0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE35D21780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijZEeocL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE35D21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbeKMQzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:55:06 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42604 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731059AbeKMQzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:55:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id 64so1088194pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 22:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNIl1XiLhRzKxCPbqGLZO4Ur4FhlYlJ4hj8ePU/zaS0=;
        b=ijZEeocLfZ0Tl1dWX3cc6NfwUPQ23N9SskfDTqjsInrXFi4EGZUAmumhHzw1ZQzyVW
         xTmMBGslo5/5OD2pBvM4QKu5sJOkGfiy236XKIk7F4hbDcCrIvDLT4jOzhih1wlUHus2
         DLGoevKQ3VnIDRgOTc/xxxkmF1EgQ/LWSONyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNIl1XiLhRzKxCPbqGLZO4Ur4FhlYlJ4hj8ePU/zaS0=;
        b=eCREZCbBfl5kitwKIYNrfbUa5u5t4fhOAF6z10b114Hcz+A55K1b22rfMmlptXISKn
         n1K/32l20wmZFwmCfEuLj/PZaKq1TsIR7AaOXCCshiAhkR8Iuu0r5OG9XmPbKy7SmSFd
         oP0kvWLolBf7IzL0a7ea7IemC+cz26N5NBF8GPjIV60hwkfuHj1Vhp75NXOE/alja5MW
         m+a5qaayuVxf2j0TuhKOEdjbGUdV62L2dR6QO0OMAIlr3USgLd7n0D1btZxkZSt6H97S
         sffpAk2ipnK8XHnR+5aJUFP2foEHvRV1+UPTHoPRSxVvIcnvfDK8AZcxGWpipjiHr0xA
         US0A==
X-Gm-Message-State: AGRZ1gIvjGvRvNAPzzp7xCpVdo6kdTQU8oPOept34UnX2dUA3sJSyPqs
        jQtMckculkdQHmDWNhZu7iJpcg==
X-Google-Smtp-Source: AJdET5fLJ9ry620VFDrLSGKlkFdqaQ4I4h2cU3xIh4hAje/DG0hONytydTJuK9vR+EcrcQzpWMDiUQ==
X-Received: by 2002:a63:8c2:: with SMTP id 185mr3703168pgi.26.1542092303061;
        Mon, 12 Nov 2018 22:58:23 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id s186-v6sm42437935pfs.164.2018.11.12.22.58.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 22:58:22 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v5 2/5] ia64: add __NR_syscalls along with NR_syscalls
Date:   Tue, 13 Nov 2018 12:27:42 +0530
Message-Id: <1542092265-20956-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542092265-20956-1-git-send-email-firoz.khan@linaro.org>
References: <1542092265-20956-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist
in ia64 architecture. We have to change the value of NR-
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
 arch/ia64/include/asm/unistd.h      | 4 +---
 arch/ia64/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/include/asm/unistd.h b/arch/ia64/include/asm/unistd.h
index 49e34db..0b08ebd 100644
--- a/arch/ia64/include/asm/unistd.h
+++ b/arch/ia64/include/asm/unistd.h
@@ -10,9 +10,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-
-#define NR_syscalls			326 /* length of syscall table */
+#define NR_syscalls		__NR_syscalls /* length of syscall table */
 
 /*
  * The following defines stop scripts/checksyscalls.sh from complaining about
diff --git a/arch/ia64/include/uapi/asm/unistd.h b/arch/ia64/include/uapi/asm/unistd.h
index 94b835c..388ab4e 100644
--- a/arch/ia64/include/uapi/asm/unistd.h
+++ b/arch/ia64/include/uapi/asm/unistd.h
@@ -341,4 +341,8 @@
 #define __NR_preadv2			1348
 #define __NR_pwritev2			1349
 
+#ifdef __KERNEL__
+#define __NR_syscalls			326
+#endif
+
 #endif /* _UAPI_ASM_IA64_UNISTD_H */
-- 
1.9.1

