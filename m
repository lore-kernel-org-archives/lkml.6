Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945E0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6A520854
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 06:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vq1BPqor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B6A520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbeKNQh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 11:37:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43228 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbeKNQh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 11:37:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id g7-v6so7380988pfo.10
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 22:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SF+X+az1/kVFQM1iw9o2jTMCcFF+r13iQ4gP5wHuuG4=;
        b=Vq1BPqorbLAVa63fbxxbO0Oi6ZhUEMTwsNd4RheFVsbqKpxfOo4VTcLGgtE8Ap5M8e
         bdZe+gNCRRcvK0ZNVM8fzDSxDk2+xS6CEjHqivCH9OBkIwCr8NFdz4c6brReYMdIFxfS
         xY7Wp03AFfPMsLSqVSU89JY6SYctZ6l+D+sTg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SF+X+az1/kVFQM1iw9o2jTMCcFF+r13iQ4gP5wHuuG4=;
        b=BD1p9/uYXAoAdnKdxOjn/fW0QgmONb0TKLDnD3ParAUbKVugPlK7zQ4Lt508RzJCdI
         yDSs2hpKT5aANERms1TbdDTbITT+vsRjTn4JkIQL8Pkbsn8ejcM/SrKkK/kXettLjZaH
         j0lwa+oSPaG7woSaLKCdCKXSr7DLckVxtnUWPnesfTL0alKHt712JH4RpgiHEGgMnS2W
         OG5vX4PPPZc26neuqmmkto4QD3hIY+5YLpI0geQroGAXmputJZx28EJVWN7pcy2+UmXj
         XTjjzFIxzidg7Cln2Z6BPIrf2AmDV3iVA+8Hr0dVFwpAQCPLrmVLnJ9lUVRa/PDAAWUY
         Oymg==
X-Gm-Message-State: AGRZ1gKRgM0f1yV97UC1z+w8LCo/1dtrp3zUQuShPYvQoHAMiSWe9Urq
        3mDZLKuiJCThxgUhqppryyEzmQ==
X-Google-Smtp-Source: AJdET5fn555AHQufCPTi0sryaH0OKHZsEJptG6UHhOO+ZNF+MtYo58QUR0wEBujOF4LUqneQcxkFJQ==
X-Received: by 2002:a63:5a08:: with SMTP id o8mr605499pgb.185.1542177336684;
        Tue, 13 Nov 2018 22:35:36 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id l26-v6sm39097318pfg.161.2018.11.13.22.35.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 22:35:36 -0800 (PST)
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
Subject: [PATCH v7 2/5] parisc: add __NR_syscalls along with __NR_Linux_syscalls
Date:   Wed, 14 Nov 2018 12:04:58 +0530
Message-Id: <1542177301-25844-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
References: <1542177301-25844-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_Linux_syscalls macro holds the number of system call
exist in parisc architecture. We have to change the value
of __NR_Linux_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update __NR-
_Linux_syscalls value.

1. Update __NR_Linux_syscalls in asm/unistd.h manually by
   counting the no.of system calls. No need to update __NR-
   _Linux_syscalls until we either add a new system call or
   delete existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update __NR_Linux_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
added the __NR_syscalls macro in uapi/asm/unistd.h along
with __NR_Linux_syscalls asm/unistd.h. The macro __NR_sys-
calls also added for making the name convention same across
all architecture. While __NR_syscalls isn't strictly part
of the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 2 ++
 arch/parisc/include/uapi/asm/unistd.h | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index fd1013f..c2c2afb 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -4,6 +4,8 @@
 
 #include <uapi/asm/unistd.h>
 
+#define __NR_Linux_syscalls	__NR_syscalls
+
 #ifndef __ASSEMBLY__
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index bb52e12..53cc748 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -366,8 +366,10 @@
 #define __NR_statx		(__NR_Linux + 349)
 #define __NR_io_pgetevents	(__NR_Linux + 350)
 
-#define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
+#ifdef __KERNEL__
+#define __NR_syscalls		351
+#endif
 
-#define LINUX_GATEWAY_ADDR      0x100
+#define LINUX_GATEWAY_ADDR	0x100
 
 #endif /* _UAPI_ASM_PARISC_UNISTD_H_ */
-- 
1.9.1

