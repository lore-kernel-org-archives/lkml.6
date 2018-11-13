Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AFAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B67772251D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JqNQHLaH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67772251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbeKMQBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:01:34 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46967 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731813AbeKMQBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:01:33 -0500
Received: by mail-pf1-f194.google.com with SMTP id s9-v6so5482376pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 22:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W7CVG+DoBP6obniYHuUnZ5aTvOCR4v184AzcmvXg/bQ=;
        b=JqNQHLaHratdbGFQeDkUOOtmOKTA4pbV+HplF0fbRqANZmti8V3mE6jwWfJ5Fltgx8
         joVrpYQRzEKng/v0qyDrGAlwebT4tIii+q2OEXmEF9678+Jy2iEmhAQUPTpsqo7Oj8Yk
         xZWCKY9WHUb7GWy4grApW1iovq/s0nxR99s2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W7CVG+DoBP6obniYHuUnZ5aTvOCR4v184AzcmvXg/bQ=;
        b=pTwan+EJC9yw/SbDgQmzdB7gFBYrBStr8tTDno5/DwWQqGON1PHKVzjJhEpW5GEblU
         3e5tuexGPZM0ckzVOU4fIahkshHR+ma/MjpzzAP/GUOEjAcTYlstPlgKQ7LNwULYRzXi
         DKgMfSt8EQRJ3GLoUJDea9yZUo4dzaE+a1vvVh398/aTmjznuNno+BJprLldTjYxlHXR
         +qVHpvebEmFdBkn052ni3+BazTeg25xHDoiZbNPwwnlnR9LuCtm50BaipUmc1g2k2Xec
         r4C159Z86H79P5NQtFkRpnsuVBti07rCP8UXK4Xs16ksYt3GecGtf8cLW6cEov7DlXg6
         zelg==
X-Gm-Message-State: AGRZ1gLM6eu5j/nNGqC5ZCWj/DmGkkmvNyq2WqB8qIN9zWNwCrMGV/3e
        ZiL253oam6ixVSJ0jlXwYOcv97/oD0Q=
X-Google-Smtp-Source: AJdET5fgCTb85XZRxhM11WzVkjMDvzkep0aNrHsp2XMYMUPeTlaXsOFdZ6Zd74Lobo3+2fWo1UAyig==
X-Received: by 2002:a63:151f:: with SMTP id v31mr3513279pgl.34.1542089102347;
        Mon, 12 Nov 2018 22:05:02 -0800 (PST)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id e23sm11429892pfh.68.2018.11.12.22.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 22:05:01 -0800 (PST)
From:   Firoz Khan <firoz.khan@linaro.org>
To:     Michal Simek <monstr@monstr.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, arnd@arndb.de, deepa.kernel@gmail.com,
        marcin.juszkiewicz@linaro.org, firoz.khan@linaro.org
Subject: [PATCH v4 1/3] microblaze: move __NR_syscalls macro from asm/unistd.h
Date:   Tue, 13 Nov 2018 11:34:32 +0530
Message-Id: <1542089074-20027-2-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>
References: <1542089074-20027-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_syscalls holds the number of system call exist in
microblaze architecture. We have to change the value of
__NR_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file.
The syscall.tbl file contains the total number of system
calls information. So we have two option to update __NR-
_syscalls value.

1. Update __NR_syscalls in asm/unistd.h manually by count-
   ing the no.of system calls. No need to update NR_sys-
   calls until we either add a new system call or delete
   existing system call.

2. We can keep this feature it above mentioned script,
   that will count the number of syscalls and keep it in
   a generated file. In this case we don't need to expli-
   citly update __NR_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I
moved the __NR_syscalls macro from asm/unistd.h to uapi-
/asm/unistd.h. While __NR_syscalls isn't strictly part of
the uapi, having it as part of the generated header to
simplifies the implementation. We also need to enclose
this macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/microblaze/include/asm/unistd.h      | 2 --
 arch/microblaze/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/asm/unistd.h b/arch/microblaze/include/asm/unistd.h
index f42c40f..9b7c2c4 100644
--- a/arch/microblaze/include/asm/unistd.h
+++ b/arch/microblaze/include/asm/unistd.h
@@ -38,6 +38,4 @@
 
 #endif /* __ASSEMBLY__ */
 
-#define __NR_syscalls         401
-
 #endif /* _ASM_MICROBLAZE_UNISTD_H */
diff --git a/arch/microblaze/include/uapi/asm/unistd.h b/arch/microblaze/include/uapi/asm/unistd.h
index 7a9f16a..1c3f867 100644
--- a/arch/microblaze/include/uapi/asm/unistd.h
+++ b/arch/microblaze/include/uapi/asm/unistd.h
@@ -418,4 +418,8 @@
 #define __NR_io_pgetevents	399
 #define __NR_rseq		400
 
+#ifdef __KERNEL__
+#define __NR_syscalls		401
+#endif
+
 #endif /* _UAPI_ASM_MICROBLAZE_UNISTD_H */
-- 
1.9.1

