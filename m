Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E785C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB0F2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ktz7qqlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAB0F2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbeJATQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:16:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37951 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbeJATQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:16:26 -0400
Received: by mail-pg1-f196.google.com with SMTP id r77-v6so9400409pgr.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C9OBy+U1NW8in6jPZ1eqMRPpUZk14fgu1Kgje70cQpo=;
        b=Ktz7qqlSeqbvhayLW4R9we1ZkpVT1cEBnCutO+7B7nEAXw0akgn1wUaWjg7Z6QGcOc
         Uw67HQpq+YV8XFxp1rTvGum1fkMs/SVeeXRRKXoRKOQyytCl9HxZS1YLleM5/OPwcBsv
         maSih6z+E5kWODaIHqaxBkctc6j5AXRqnTGN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C9OBy+U1NW8in6jPZ1eqMRPpUZk14fgu1Kgje70cQpo=;
        b=W989RVggTrgHJw2oQw/FEtAs1ey/2wSaXTO3fOQCCf0yVr8Ad8ItrM96gFDTA9I8Yb
         LezMLd0GSfPRZKJaO/0odxeKYUGonNmv+qN4e2wV7tiaEJuOtI56ZxT3SvDZ4G+KsfMX
         JtPxGKy+2G7znC1auNXeNjtOxa1LYg8ylqoR7rdjXi97t2gHsM6l33So4I/j7E4jUgRK
         5orWOmBx+GbKWWf+N5Yu0Ni2ryhkt+H+UkuikLnV2T7LIccm0AcF4gWpsadBx1mEPIxa
         cFcXyby6ygRYpElrAS9GlGeINOXqLDmfI8oUO+GH+D9B/nJIWbijw7su6sBx6/DpE0ii
         Z/7g==
X-Gm-Message-State: ABuFfohlSZBVFRHx5bW0ManAAPyRUbb8MCQEZ8sPDun6sc/mqe0LlG1k
        4FztqBxWnPBv+8HH+0JpYCzq+A==
X-Google-Smtp-Source: ACcGV62E9uJdWGoGrTUoZTxLy1w3Ql4sg8ViBQ/R9dxTQ1cchz3lxkG27x7ogyswAAsZ7I/dOBTEhQ==
X-Received: by 2002:a17:902:1ab:: with SMTP id b40-v6mr11799943plb.82.1538397528898;
        Mon, 01 Oct 2018 05:38:48 -0700 (PDT)
Received: from qualcomm-HP-ZBook-14-G2.domain.name ([49.207.59.231])
        by smtp.gmail.com with ESMTPSA id o12-v6sm21329345pfh.20.2018.10.01.05.38.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Oct 2018 05:38:48 -0700 (PDT)
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
Subject: [PATCH v3 2/5] m68k: replace NR_syscalls macro from asm/unistd.h
Date:   Mon,  1 Oct 2018 18:07:54 +0530
Message-Id: <1538397477-4003-3-git-send-email-firoz.khan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
References: <1538397477-4003-1-git-send-email-firoz.khan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NR_syscalls macro holds the number of system call exist in m68k
architecture. This macro is currently the part of asm/unistd.h file.
We have to change the value of NR_syscalls, if we add or delete a
system call.

One of patch in this patch series has a script which will generate
a uapi header based on syscall.tbl file. The syscall.tbl file
contains the number of system call information. So we have two
option to update NR_syscalls value.

1. Update NR_syscalls in asm/unistd.h manually by counting the
   no.of system calls. No need to update NR_syscalls until
   we either add a new system call or delete an existing system
   call.

2. We can keep this feature it above mentioned script, that'll
   count the number of syscalls and keep it in a generated file.
   In this case we don't need to explicitly update NR_syscalls
   in asm/unistd.h file.

The 2nd option will be the recommended one. For that, I come up
with another macro - __NR_syscalls which will be updated by the
script and it will be present in api/asm/unistd.h. While __NR_syscalls
isn't strictly part of the uapi, having it as part of the generated
header to simplifies the implementation. So we need to enclose this
macro with #ifdef __KERNEL__ to avoid side effects.

Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
---
 arch/m68k/include/asm/unistd.h      | 3 +--
 arch/m68k/include/uapi/asm/unistd.h | 4 ++++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/unistd.h b/arch/m68k/include/asm/unistd.h
index 30d0d3f..5072e94 100644
--- a/arch/m68k/include/asm/unistd.h
+++ b/arch/m68k/include/asm/unistd.h
@@ -4,8 +4,7 @@
 
 #include <uapi/asm/unistd.h>
 
-
-#define NR_syscalls		380
+#define NR_syscalls __NR_syscalls
 
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT
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

