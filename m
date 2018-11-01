Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D227C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E38A620820
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 13:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOZdKtRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E38A620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbeKAWw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 18:52:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42833 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbeKAWw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 18:52:27 -0400
Received: by mail-pf1-f196.google.com with SMTP id f26-v6so9366366pfn.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nVzadkm3B8vZT4Re5btIMSdYYClObm2dBafrqh2nn0E=;
        b=IOZdKtRdSHOcHXtMjmIVEb21TnWhRzpFX4c4eSKMzaGla8oSzHS3qVOtQIjzvX07m+
         NfScitucIIRyueCh5MMgNCzHwxJW/bJdc8crnd2wPV4QBpVWVVY/Piwv8v424MnhMC4x
         xseAkehsyZ9zCX+I9x/kyj10kGC6xoBrJtS5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nVzadkm3B8vZT4Re5btIMSdYYClObm2dBafrqh2nn0E=;
        b=fXPMk8DRjluHs8/JlXXYEj2O8e49pb29ZOhhb3IWahuJlQ/Gi6UI+7gPsvR5xMii3f
         1F0/dl6iivkDAz1Pb1+S1MACuYb4jhBX3rTqwEZxM15BzR+JQn5+1Wxx4QaKmPZQAxao
         nDGmoysdHQTxmB2F2IQ4WqOauO9E6rBgd+gkutBsCHaCnr3FnNRR38e8jZslo+uRbgu5
         7n+Su/QX36HIVxTm9snqJnA8xALTHOAGCwnFUFqzsrofZ/M1x1pFaFEMvdTU2PL44Lbv
         OSCie01t0JK0H1n1OHuwD7Usxpnx39+nEHwOoq9Iw+Y6m1RICgZCgm/zC6pYmp27Cr5X
         K9NA==
X-Gm-Message-State: AGRZ1gLWVkfpDhC/vfbFG2n7yvWSyc4ZuGm2LtKL4Am49kHAvkeS49QV
        HWhaqLqDOgz//RATGo5Pl56xQA==
X-Google-Smtp-Source: AJdET5cbghwj1/16/qWbECX7Mn1+LZ2RYlUC1sOKQEC26VHoAAvjqE2jI8vdC8mgDEGTcVR7ROIPzQ==
X-Received: by 2002:a63:e00d:: with SMTP id e13-v6mr7185680pgh.114.1541080164492;
        Thu, 01 Nov 2018 06:49:24 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.104.211])
        by smtp.gmail.com with ESMTPSA id p11-v6sm16567307pfn.53.2018.11.01.06.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 06:49:23 -0700 (PDT)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     linux-sh@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v2 1/3] sh: add __NR_syscalls along with NR_syscalls
Date:   Thu,  1 Nov 2018 19:18:48 +0530
Message-Id: <1541080130-3678-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541080130-3678-1-git-send-email-firoz.khan@linaro.org>
References: <1541080130-3678-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist
in sh architecture. We have to change the value of NR-
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
added the __NR_syscalls macro in uapi/asm/unistd_32/64.h
along with NR_syscalls which is moved to asm/unistd.h.
The macro __NR_syscalls also added for making the name
convention same across all architecture. While __NR_sys-
calls isn't strictly part of the uapi, having it as part
of the generated header to simplifies the implementation.
We also need to enclose this macro with #ifdef __KERNEL__
to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/sh/include/asm/unistd.h         | 2 ++
 arch/sh/include/uapi/asm/unistd_32.h | 4 +++-
 arch/sh/include/uapi/asm/unistd_64.h | 4 +++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/unistd.h b/arch/sh/include/asm/unistd.h
index b36200a..66fd71c 100644
--- a/arch/sh/include/asm/unistd.h
+++ b/arch/sh/include/asm/unistd.h
@@ -5,6 +5,8 @@
 #  include <asm/unistd_64.h>
 # endif
 
+#define NR_syscalls __NR_syscalls
+
 # define __ARCH_WANT_OLD_READDIR
 # define __ARCH_WANT_OLD_STAT
 # define __ARCH_WANT_STAT64
diff --git a/arch/sh/include/uapi/asm/unistd_32.h b/arch/sh/include/uapi/asm/unistd_32.h
index 58f04cf..31c85aa 100644
--- a/arch/sh/include/uapi/asm/unistd_32.h
+++ b/arch/sh/include/uapi/asm/unistd_32.h
@@ -396,6 +396,8 @@
 #define __NR_preadv2		381
 #define __NR_pwritev2		382
 
-#define NR_syscalls 383
+#ifdef __KERNEL__
+#define __NR_syscalls		383
+#endif
 
 #endif /* __ASM_SH_UNISTD_32_H */
diff --git a/arch/sh/include/uapi/asm/unistd_64.h b/arch/sh/include/uapi/asm/unistd_64.h
index 6f809a5..75da548 100644
--- a/arch/sh/include/uapi/asm/unistd_64.h
+++ b/arch/sh/include/uapi/asm/unistd_64.h
@@ -416,6 +416,8 @@
 #define __NR_preadv2		392
 #define __NR_pwritev2		393
 
-#define NR_syscalls 394
+#ifdef __KERNEL__
+#define __NR_syscalls		394
+#endif
 
 #endif /* __ASM_SH_UNISTD_64_H */
-- 
1.9.1

