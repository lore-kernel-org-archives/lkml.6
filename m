Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC054C64EB8
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81BC82089C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGlNJsOw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BC82089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeJHM1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 08:27:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35246 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbeJHM1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 08:27:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id l17-v6so3413355pff.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 22:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FAowNU2Le7w5YJvjpIycOrYvvQJDBUjpEbsXPhhb+kM=;
        b=hGlNJsOwHYESLLQiLtBWEm5vORLZrkyzqmoz/cGiVOeLg1DNwx46CFd6KApULQEuYT
         nu7G/gDJ4LdbvInsR+iZ5EfIhyFFpCske3ClTjbLVVNfKK3Jr+NN9Gx0NEEs+rIPQlOE
         ZuR91PPPzS+yalnvfjEHolhqTQ+9Cu4Q0MZ5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FAowNU2Le7w5YJvjpIycOrYvvQJDBUjpEbsXPhhb+kM=;
        b=VV2VcbU8EQ87yNLjmAZOnlG2msLjMr8Ff5mYTUnD0n36TjshNaR54CV+oxFQiY2NkP
         Qva65JC9yktXR7dfADSWHe5A4mCkuFrCDCjYPaS0OpWLcPRRAnfvJELEEAJaOaM2/3cV
         /5/n5Na96oWMJCZKnBjFSYz1PHgmLH7vPMhcb/Ajzwk5n/hDDMaI9Ub6oQ3e2Z9lBBuy
         APZAkLCMbpKRz1pKuOPy2pXAk2FHlnxWCG26gaWDhCzri7BzIsnNNF4XThyHL5x0FOrZ
         JOjZjNILz/4ZDjuuqwCnvGIlJfsHVcHvU6sW7MOeNDpEZbtriPVOMwZ3k+kDaXa2qknm
         RYUQ==
X-Gm-Message-State: ABuFfojqmmPT3GjF+zpNGRwftkMO7jeyp6A48ja2/Kfrp9kntJBBfujv
        RMMIp87Ia53/UFPe0r1SentbrQ==
X-Google-Smtp-Source: ACcGV63h92On9iSxabx6KD1l5bfzvq9yxie8gdrxcV6US30NtyMS24i7hbL/8x8V+ByPsdDNoGm/Vw==
X-Received: by 2002:a62:dd01:: with SMTP id w1-v6mr23280159pff.129.1538975848545;
        Sun, 07 Oct 2018 22:17:28 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.qualcomm.com (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id j19-v6sm1875919pfi.137.2018.10.07.22.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 07 Oct 2018 22:17:28 -0700 (PDT)
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
Subject: [PATCH v3 2/6] parisc: add __NR_Linux_syscalls along with __NR_syscalls
Date:   Mon,  8 Oct 2018 10:46:37 +0530
Message-Id: <1538975801-13735-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
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
need to enclose this macro with #ifdef __KERNEL__ to avoid
side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/parisc/include/asm/unistd.h      | 2 ++
 arch/parisc/include/uapi/asm/unistd.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index 93fd9f6..d30fdbcb 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -4,6 +4,8 @@
 
 #include <uapi/asm/unistd.h>
 
+#define __NR_Linux_syscalls     __NR_syscalls
+
 #ifndef __ASSEMBLY__
 
 #define SYS_ify(syscall_name)   __NR_##syscall_name
diff --git a/arch/parisc/include/uapi/asm/unistd.h b/arch/parisc/include/uapi/asm/unistd.h
index bb52e12..f10d065 100644
--- a/arch/parisc/include/uapi/asm/unistd.h
+++ b/arch/parisc/include/uapi/asm/unistd.h
@@ -366,7 +366,9 @@
 #define __NR_statx		(__NR_Linux + 349)
 #define __NR_io_pgetevents	(__NR_Linux + 350)
 
-#define __NR_Linux_syscalls	(__NR_io_pgetevents + 1)
+#ifdef __KERNEL__
+#define __NR_syscalls           351
+#endif
 
 #define LINUX_GATEWAY_ADDR      0x100
 
-- 
1.9.1

