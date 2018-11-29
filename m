Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67438C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF132081B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 04:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dw4w+jTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CF132081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeK2Pb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 10:31:56 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40504 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbeK2Pb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 10:31:56 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so373732pfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 20:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XJq1AFUaGxDCB6jFqaj05hzzcUKv19kg30xJpzrgoLo=;
        b=Dw4w+jTE4sHeLHbFY3h8XVpKi3OIVSznCkWDKwpiGYHlzkJKreDJLYtgPydbnATQQv
         qydXXL/H54a76SOH8inBTEx/gd9WTTbN9wU6j1mnRERrsYXrudmaoLihg9uxvYk2Pn5f
         P2928+HzbuFTZvfoT/BuV2wGXyzTRGf6QXVAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XJq1AFUaGxDCB6jFqaj05hzzcUKv19kg30xJpzrgoLo=;
        b=VAB1YWcvLKz5uy0+P+C6sdXeTvLHkTq3Cg4TpNs0Aib0IJIN94jp9kXPJw6eGWT4DV
         atTgVRuHaPctfV2Xh72ycwDVzouNRLd7jzP6QMC71Q1cu1dooDrCJ3nzswct0ryVpGaD
         1UPjRDPwvOGpHsfmOHzRtQkFISGLKU7sEC3usQIuV4CCIvxIim7nyAuVIL6bTAD1z52C
         c80+QW2fqrtlGEzF2L05OTZTTWPJwnhheJ0AXJag3Ucszm4G38Wt5ayTTY2MPZhOZBL/
         1szk9a/2AV2RkA/bTotsIwoahI6+gJ6qCIl1VTbUavz7Yjk87YE0+Ep+Tlk1D+fhM4e9
         vjGw==
X-Gm-Message-State: AA+aEWYOPMFKAkuMA2fYYg8PuGDMBvdzsv+T35VtDpacjteUiHf1hu5Y
        Dy9zB7paGk+4svwF0v4zkRfw8w==
X-Google-Smtp-Source: AFSGD/V6PrHvIlRkpyvYrzQAsI9nx5xntQSkPNk8i3Qz8o777z9I3AiQiy39tAbTNh1b3TgWMRdlMA==
X-Received: by 2002:a63:955a:: with SMTP id t26mr36023391pgn.449.1543465676346;
        Wed, 28 Nov 2018 20:27:56 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id p2sm770473pfb.28.2018.11.28.20.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 20:27:55 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ram Pai <linuxram@us.ibm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Breno Leitao <leitao@debian.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v3 1/4] powerpc: add __NR_syscalls along with NR_syscalls
Date:   Thu, 29 Nov 2018 09:56:48 +0530
Message-Id: <1543465611-17122-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
References: <1543465611-17122-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist
in powerpc architecture. We have to change the value of
NR_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the number of system call
information. So we have two option to update NR_syscalls
value.

1. Update NR_syscalls in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_sys-
   calls until we either add a new system call or delete
   existing system call.

2. We can keep this feature in above mentioned script,
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
 arch/powerpc/include/asm/unistd.h      | 3 +--
 arch/powerpc/include/uapi/asm/unistd.h | 5 ++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index b0de85b..a3c35e6 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -11,8 +11,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-#define NR_syscalls		389
+#define NR_syscalls	__NR_syscalls
 
 #define __NR__exit __NR_exit
 
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 985534d..7195868 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -10,7 +10,6 @@
 #ifndef _UAPI_ASM_POWERPC_UNISTD_H_
 #define _UAPI_ASM_POWERPC_UNISTD_H_
 
-
 #define __NR_restart_syscall	  0
 #define __NR_exit		  1
 #define __NR_fork		  2
@@ -401,4 +400,8 @@
 #define __NR_rseq		387
 #define __NR_io_pgetevents	388
 
+#ifdef __KERNEL__
+#define __NR_syscalls		389
+#endif
+
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
-- 
1.9.1

