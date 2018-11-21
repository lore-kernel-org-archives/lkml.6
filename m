Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE8C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A4421104
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 04:15:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hm+ioeOE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71A4421104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeKUOrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 09:47:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35688 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbeKUOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 09:47:49 -0500
Received: by mail-pl1-f194.google.com with SMTP id v1-v6so3510532plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 20:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZE1AyeTPRRnquAdnDl25l1LOkW//go+oKzyIjbXwF4=;
        b=hm+ioeOEZqzXAkSAoJMLslosWiNM54cQ6z/99LjRB6gDyt3LOjzktYLZO5RXxSKL/v
         r9KZIEtuZUWks7oCnw7K+G7z+eC/uPgrKjWw4BAQeQxLvc1l88sNWMS03SektvPUNF5I
         bSFBmA+j56zv/dEJYw0u4BFLi9Sxo03mZZoDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YZE1AyeTPRRnquAdnDl25l1LOkW//go+oKzyIjbXwF4=;
        b=C9UPeTYQkI05/VU0Vo1WVMjCNnq2aq6U/QCSlhSP/JZnt3VaIJfx3gNyiNzUxLRMxI
         VKAeuabWmftwKY2xy+q/t8+VclLv5eaQTstJHIcNu8RgRpUsUY7S3Mke0DnfUvcpnkzF
         WCR2i65B9onTROtEzfepOxb4r/Du3Xl6Uc3SW5GvpagiyUI3uKcqUvQPHVwlU6H4oKA2
         dB+COzeB32P7BAbkxehtspH6Ke7QkpjEMECE1q/PISA6YjTiESgEvoEJecTBkxhKLdH3
         tjMQs23xu4YWW/K6hRmoWjKm9ppkXehSiTRC9ikt3QKucq/NJ2fGhyicdmRsfsVZ34xs
         8s2A==
X-Gm-Message-State: AGRZ1gJOwAOBsFgPj8nvLrPJBvXz4eD7TqQ06L3/k/WKRQVF/YNTSfUL
        ulAAHZB8qQ46Fzs7j2vIo9nTjQ==
X-Google-Smtp-Source: AJdET5dVb8X62s4n2Of0dNjIXVvZt69JZlLBjESDQj0cT336h375mvGc74M3jq9iPgBSmzWGswnpfQ==
X-Received: by 2002:a62:a511:: with SMTP id v17-v6mr5143960pfm.18.1542773707402;
        Tue, 20 Nov 2018 20:15:07 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id v124-v6sm10818712pfb.182.2018.11.20.20.15.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Nov 2018 20:15:06 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v8 2/6] parisc: add __NR_syscalls along with __NR_Linux_syscalls
Date:   Wed, 21 Nov 2018 09:44:26 +0530
Message-Id: <1542773670-25460-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542773670-25460-1-git-send-email-firoz.khan@linaro.org>
References: <1542773670-25460-1-git-send-email-firoz.khan@linaro.org>
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
Acked-by: Helge Deller <deller@gmx.de>
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

