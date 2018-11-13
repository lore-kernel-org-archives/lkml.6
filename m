Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735D6C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38B01223CB
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fT8ABgGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38B01223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbeKMP5k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 10:57:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32897 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbeKMP5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 10:57:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so2543802pgu.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 22:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L1MmGLhowMkEp3+3jZ4blj4L16FJ2J4LnmdalTZsoAw=;
        b=fT8ABgGgnE7dc7JKEqhztZc57y5uVfURFWAgXdtKvn3kHm/QTqSOgaPiY+jX5RHSou
         83V6izCtnmWGfl35c8G2GNSwS7cBSIxG61ELQXM8cyBzILyx7RBNvGsB7iHDMjviFVRo
         KGmPzP3dTfIl2tNV/NPv0VyFljbae95zQJWCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L1MmGLhowMkEp3+3jZ4blj4L16FJ2J4LnmdalTZsoAw=;
        b=pgfn8mWTN5yQDCMT59cJ5HpIx9RbzDsM7h+f+4vEHK+Pw7uzzX9p1hSFLwwAtOkLiS
         rVOjKlvMBJ68jxH7InMj+rhVGQ9ESIsLCIVrPrTgsKQ0lrbdbEr1WBDAd2CXCtgYzCDr
         xQ4S2+lX0T/FG3LRRDUVS1TJjfc6zNDV8QSLl8Jt/wz6sHfWwzv6ine4mqoK8CnBjjV5
         Hu63KuMoyTp56Z9nZgg8uzGwNzT8JnH6qc7LG65/ylmhu9/xgzyYpt0tqr/t1m0TJhfA
         LBJVcX8rGiNhS1QfvJSbZVQ30hbivH+rDaxfO9R3PwCdSt2tlR9rpgD/kCCPFYFeOAn8
         lysA==
X-Gm-Message-State: AGRZ1gKflBUnOsBilXWmYYlUobivWMzNuKLH9DyFkPMmdsewR+ax1qYQ
        /DD6ZIAtmBxWqUv5paw2uIhvCA==
X-Google-Smtp-Source: AJdET5clTOK/jXpHhxOV0mx8GqH3VeEEhDI9nn4QBhUDz8uuZt1vKieHTgCku2HC2CupyduO5VjlCA==
X-Received: by 2002:a63:193:: with SMTP id 141mr3580631pgb.136.1542088869009;
        Mon, 12 Nov 2018 22:01:09 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id r6-v6sm19150204pfk.157.2018.11.12.22.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 22:01:08 -0800 (PST)
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
Subject: [PATCH v5 1/3] m68k: add __NR_syscalls along with NR_syscalls
Date:   Tue, 13 Nov 2018 11:30:27 +0530
Message-Id: <1542088829-19790-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org>
References: <1542088829-19790-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call
exist in m68k architecture. We have to change the
value of NR_syscalls, if we add or delete a system
call.

One of the patch in this patch series has a script
which will generate a uapi header based on syscall-
.tbl file. The syscall.tbl file contains the total
number of system calls information. So we have two
option to update NR_syscalls value.

1. Update NR_syscalls in asm/unistd.h manually by
   counting the no.of system calls. No need to up-
   date NR_syscalls until we either add a new sys-
   tem call or delete existing system call.

2. We can keep this feature it above mentioned sc-
   ript, that will count the number of syscalls and
   keep it in a generated file. In this case we
   don't need to explicitly update NR_syscalls in
   asm/unistd.h file.

The 2nd option will be the recommended one. For that,
I added the __NR_syscalls macro in uapi/asm/unistd.h
along with NR_syscalls asm/unistd.h. The macro __NR-
_syscalls also added for making the name convention
same across all architecture. While __NR_syscalls
isn't strictly part of the uapi, having it as part
of the generated header to simplifies the implement-
ation. We also need to enclose this macro with #ifdef
__KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/include/asm/unistd.h      | 3 +--
 arch/m68k/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index e680031..49d5de1 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -4,8 +4,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-#define NR_syscalls		380
+#define NR_syscalls	__NR_syscalls
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
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

