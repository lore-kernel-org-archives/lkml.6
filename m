Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1540FC282CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13362186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 00:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KKU/5Rr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfBFALd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 19:11:33 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40224 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfBFALa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 19:11:30 -0500
Received: by mail-ed1-f68.google.com with SMTP id g22so4470735edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 16:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTWbi0cspDSUvTf1XFhVzvXrwfJNeSnlqsvl3s3OB4c=;
        b=KKU/5Rr7rVKPT4ptNFbtx4oyhm5xwH1a+Ylin6Ck4CjrYJrSFYXtY4LCFgVC3zO3C9
         xeXV6RQ7Lu8Ymvhbt0eF27tus9rAgiiFyWVdbjjN515Q3PpPHKqltJPzDtE4J9v//+Pa
         eqrt5a9Ew+DgUQLeSP1No7vpRBScV701yWxMgZNed/V0kNjNIvYdmkLPrmLLhoCPzGlK
         SGSqvp3Wosq5ktQuETNy/AcTv74UTzEdYa+oSF0h014b+J1sc9Ba2xtX8Yx1vkP9L8b6
         42T/XqJbS5pD99ZSqSDHm/ZgsuS/LHBlg+x7TDKaTSES46OHbzz7N7QgIcBU2V30WZyJ
         0LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTWbi0cspDSUvTf1XFhVzvXrwfJNeSnlqsvl3s3OB4c=;
        b=PdvsZobLlbr7BH4HYFOvFvuuVvD+FMzTxmuqJeIuxkQkfqbnCtndY8l9owBazmxrSk
         NJxqczGtekFF73j7wzW3XkGEZWE+fSrkfJ4ttKeXWzuhLa6WHUsmrh1ISTODpor4NfEt
         JrO+QGeiJLRubLai6c8MRkBFJElCGFjPeAxCfmNUAQG4gKeKbiOt3UnYwb7KjFMB5Y/L
         1zYcJJ2UPhgIqCES90YCoC4STJnrn98LBh6/MTZAyxANK5YcV8qkGe9tMtkn8Tp9cm8B
         jMgWOOgOlFfORfwZ3VUr6fXC/IYGT4Ukr2gZUynVKoxh2bmGmsHBJ5zxIwLfo0rdNC+e
         uKZg==
X-Gm-Message-State: AHQUAuYOe+iXCirVcUr+gAC1KGFwB7Ie6q4aDHNX5QYD+BP69u8IRczt
        HscoHnS9Pd+lT3tk7vfC6g0g2Zm9nvQ=
X-Google-Smtp-Source: AHgI3IY9FWTtBp94pBdw68SrowyoVee/9bkYcB5hytaG8rgIZMqMn/mhQV9PJK14D3lj1CM+RVu39w==
X-Received: by 2002:a50:b7d6:: with SMTP id i22mr5872133ede.27.1549411888456;
        Tue, 05 Feb 2019 16:11:28 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id p30sm5489594eda.68.2019.02.05.16.11.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 05 Feb 2019 16:11:27 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@openvz.org>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: [PATCH 14/32] x86/VDSO: Build VDSO with -ffunction-sections
Date:   Wed,  6 Feb 2019 00:10:48 +0000
Message-Id: <20190206001107.16488-15-dima@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206001107.16488-1-dima@arista.com>
References: <20190206001107.16488-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it has been discussed on timens RFC, adding a new conditional branch
`if (inside_time_ns)` on VDSO for all processes is undesirable.
It will add a penalty for everybody as branch predictor may mispredict
the jump. Also there are instruction cache lines wasted on cmp/jmp.

Those effects of introducing time namespace are very much unwanted
having in mind how much work have been spent on micro-optimisation
vdso code.

Addressing those problems, there are two versions of VDSO's .so:
for host tasks (without any penalty) and for processes inside of time
namespace with clk_to_ns() that subtracts offsets from host's time.

Unfortunately, to allow changing VDSO VMA on a running process,
the entry points to VDSO should have the same offsets (addresses).
That's needed as i.e. application that calls setns() may have already
resolved VDSO symbols in GOT/PLT.

Compile VDSO images with -ffunction-sections so that VDSO entries can be
aligned on the same addresses with linker script magic.
Put ia32 functions those are written in assembly into corresponding
sections.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/Makefile             | 2 +-
 arch/x86/entry/vdso/vdso32/sigreturn.S   | 2 ++
 arch/x86/entry/vdso/vdso32/system_call.S | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 2433ed9342fd..55ba81d4415c 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -3,7 +3,7 @@
 # Building vDSO images for x86.
 #
 
-KBUILD_CFLAGS += $(DISABLE_LTO)
+KBUILD_CFLAGS += $(DISABLE_LTO) -ffunction-sections
 KASAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
 OBJECT_FILES_NON_STANDARD	:= y
diff --git a/arch/x86/entry/vdso/vdso32/sigreturn.S b/arch/x86/entry/vdso/vdso32/sigreturn.S
index c3233ee98a6b..b641ccf8d664 100644
--- a/arch/x86/entry/vdso/vdso32/sigreturn.S
+++ b/arch/x86/entry/vdso/vdso32/sigreturn.S
@@ -11,6 +11,7 @@
 	.globl __kernel_sigreturn
 	.type __kernel_sigreturn,@function
 	nop /* this guy is needed for .LSTARTFDEDLSI1 below (watch for HACK) */
+	.section .text.__kernel_sigreturn, "ax"
 	ALIGN
 __kernel_sigreturn:
 .LSTART_sigreturn:
@@ -21,6 +22,7 @@ __kernel_sigreturn:
 	nop
 	.size __kernel_sigreturn,.-.LSTART_sigreturn
 
+	.section .text.__kernel_rt_sigreturn, "ax"
 	.globl __kernel_rt_sigreturn
 	.type __kernel_rt_sigreturn,@function
 	ALIGN
diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index 263d7433dea8..13ec05287f63 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -8,7 +8,7 @@
 #include <asm/cpufeatures.h>
 #include <asm/alternative-asm.h>
 
-	.text
+	.section .text.__kernel_vsyscall, "ax"
 	.globl __kernel_vsyscall
 	.type __kernel_vsyscall,@function
 	ALIGN
-- 
2.20.1

