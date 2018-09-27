Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F83C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0953206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rc8t9lme"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0953206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbeI0Unp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:43:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40536 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeI0Uno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:43:44 -0400
Received: by mail-pg1-f193.google.com with SMTP id n31-v6so2087587pgm.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p9t4d2U76M7pVedCN85mCQCPYHIVwNmeA4otNDy9pl4=;
        b=Rc8t9lmekcb9TYf9AhJ2vtFn+IsrkMaqDsPXR+06TM2j9yTko9LvoIAhPG3b6rSaIn
         KyHzSkcq6IO4LpEvBfc9YKYnXkzJ/bG6vl9pZ14w+HD3HEipgSPUaaoLrSN0RwI9ukrf
         +nb5Uj0wFiPe6bo9FGJ23cPWpVpq49Ha/ASh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p9t4d2U76M7pVedCN85mCQCPYHIVwNmeA4otNDy9pl4=;
        b=AAUCD3vPnGELI2o0IjERTowPgPqOb/JBavwB8B/SQ9gnE7SkpYvTre3zsd23SNdcbW
         pw5yNZpWdv4Sbi5b3+LTNRp9E87lvDv9Oe+YYk38E/8V6Y3AvvRnK93bqzfb7zbGRyyd
         YqJnvfSxFBscMQqemao3v+C4L7xbrCAi90ohjyQFUA0Za18ATDrSF62za2ZEqLFy2g5l
         eTcPgt7rhtbZdVrQbOnlDEE4Bbx0IL/G+GIasOY0IIlKgoWWcJELCB2+Ptq/0gYQgLfs
         gIxX0cm0AbhamopbAa2cl9bHAMYSn/1/E5Wo6PaiDRllzQO6ioQjlOej6WNjSUdlA52A
         j8CA==
X-Gm-Message-State: ABuFfohfECXKyJBjjZCVT16jIt1vNXMAM3YyorrS6tqn+DLyiULQK5jg
        tfhZXCg7BsRJbJP0scOiHYofhw==
X-Google-Smtp-Source: ACcGV63o0Irg1MEEYdDF2pv3zSCv0ITgnqy+ZrvMq4cPWscqKEVtzVjYPBJTMkTJCaj8MYYvjGyYaA==
X-Received: by 2002:a63:6746:: with SMTP id b67-v6mr10616283pgc.310.1538058313394;
        Thu, 27 Sep 2018 07:25:13 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([106.51.105.186])
        by smtp.gmail.com with ESMTPSA id f81-v6sm9717421pfh.46.2018.09.27.07.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 27 Sep 2018 07:25:12 -0700 (PDT)
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
Subject: [PATCH v2 2/5] parisc: add __NR_Linux_syscalls macro with __NR_syscalls
Date:   Thu, 27 Sep 2018 19:54:24 +0530
Message-Id: <1538058267-3765-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
References: <1538058267-3765-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__NR_Linux_syscalls macro holds the number of system call
exist in PARISC architecture. This macro is currently the
part of uapi/asm/unistd.h file. We have to change the value
of __NR_Linux_syscalls, if we add or delete a system call.

One of the patch in this patch series has a script which
will generate a uapi header based on syscall.tbl file. The
syscall.tbl file contains the number of system call inform-
ation. So we have two option to update __NR_Linux_syscalls
value.

1. Update __NR_Linux_syscalls in uapi/asm/unistd.h manually
   by counting the no.of system calls. No need to update
   __NR_Linux_syscalls until we either add a new system call
   or delete an existing system call.

2. We can keep this feature it above mentioned script, that
   will count the number of syscalls and keep it in a gener-
   ated file. In this case we don't need to explicitly update
   __NR_Linux_syscalls in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I moved
the __NR_Linux_syscalls macro from uapi/asm/unistd.h to asm/
unistd.h. The macro __NR_syscalls also added for making the
name convention same across all architecture. While __NR_sys-
calls isn't strictly part of the uapi, having it as part of
the generated header to simplifies the implementation. We also
need to enclose this macro with #ifdef __KERNEL__ to avoid side
effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/uapi/asm/unistd.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index bb52e12..255c62a 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -366,7 +366,11 @@
 #define __NR_statx		(__NR_Linux + 349)
 #define __NR_io_pgetevents	(__NR_Linux + 350)
 
-#define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
+#ifdef __KERNEL__
+#define __NR_syscalls           351
+#endif
+
+#define __NR_Linux_syscalls     __NR_syscalls
 
 #define LINUX_GATEWAY_ADDR      0x100
 
-- 
1.9.1

