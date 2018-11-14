Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00389C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7712145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 04:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgMxE6cq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF7712145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbeKNOeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 09:34:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40483 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeKNOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 09:34:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id b22-v6so1687969pls.7
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 20:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gLAK6+1KFP1G0YnE093JSOG5lPwuwqduZFcklqBU+hM=;
        b=ZgMxE6cquMAE0KkViQx397cH5O45NqQHULeJ62YymxLAPXXyYrcnsWqKTKWXtExza0
         2eUhyKTLlq///3RJWorIfQ7tNRklH5meeriqJ/wl1k4isCRlwKlDjg0L8CQZCYWlHPHX
         fh3gqdi/vQ2p8WBdl5r10JE5JttqTJw1/1LMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gLAK6+1KFP1G0YnE093JSOG5lPwuwqduZFcklqBU+hM=;
        b=mX5XiHEN5DHjnZbvDKRDEgMEDl/L54fDfSZ7sMRBveLSWTe6MRLjmJqfOduNDBkZyK
         3wniiBDZezF3D00pBZZyBJ8ON1GhzW9mDAzCfN61ygwsylB4FIJymdHFrGSgSpHg9fIJ
         2NQVhQ6pisMMW6F7DhMQvwP890WijGUIA2/Jzl8KW/bAPZEwl/TWUH9rFbZDne4FctYn
         i+NA76DDhY3PyvYwk5TnVgxBdlKllj2odvAVzER7/xAYYArK1fA+pUCuDrr+BoJaJ2vA
         VdAztSMmYB81nLggVgXCVdRlB/eveAuI7fit3Ngbui15PxDTEEb3SdgAlBXHEROsffZa
         8vyg==
X-Gm-Message-State: AGRZ1gKp07pYMJCh+GH3kIpAbyMYv+DEYrZywCPUpMMnprpKwU0wNmE5
        C/tQW63wUuUjFvBU9rKFO8Bzwg==
X-Google-Smtp-Source: AJdET5chj5vHUqU2pxRYb8Ud5PayUB2YbHRoEP4W0OLEsOT35PNpwZekq8gEvW1cuYWNuP6MhG+E+w==
X-Received: by 2002:a17:902:2943:: with SMTP id g61-v6mr421151plb.82.1542169963532;
        Tue, 13 Nov 2018 20:32:43 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a17sm26382842pgm.26.2018.11.13.20.32.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 13 Nov 2018 20:32:43 -0800 (PST)
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
Subject: [PATCH v3 1/3] sh: add __NR_syscalls along with NR_syscalls
Date:   Wed, 14 Nov 2018 10:02:08 +0530
Message-Id: <1542169930-24118-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
References: <1542169930-24118-1-git-send-email-firoz.khan@linaro.org>
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
index a99234b..a97f93c 100644
--- a/arch/sh/include/asm/unistd.h
+++ b/arch/sh/include/asm/unistd.h
@@ -5,6 +5,8 @@
 #  include <asm/unistd_64.h>
 # endif
 
+#define NR_syscalls	__NR_syscalls
+
 # define __ARCH_WANT_NEW_STAT
 # define __ARCH_WANT_OLD_READDIR
 # define __ARCH_WANT_OLD_STAT
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

