Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61171C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B85D208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="DsDlZHYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B85D208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935798AbeFRPJr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:09:47 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34800 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935310AbeFRPJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:09:42 -0400
Received: by mail-pg0-f68.google.com with SMTP id q4-v6so7674371pgr.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4NAG7hzXUC7y7frdcTzxZYfU3GpX9HZN0SD1UZIE0Yk=;
        b=DsDlZHYArPoA1Pb7vK4oDE4O7fCqck8USieAMKDXuZ19a5AiHBpRRokXov9D2cQY6z
         EcOZAMuCDSPekBGWcUEntS/kny7qHg6BYTWxTF/pB0k25uMktOiD1886pGFl/h/i00Ti
         UqnG8RvAomok/SObRLDslxGFRHmPb0hODWdpNkOVHCoK9m7XO9ZiKj2lwjTXtqB7P6Wg
         q9AUFOm3W6eEk1IQA1/jonD8EG+LOu9R6pHWgR/QArhPg4r568ldvIS5CfWyYYziZwBX
         JIF/wb/hs7e2wCyS93eLhDcns8dJyjjTHGqjCc3LxVPRXkKhwiQ7U5X0TlkSVm7UUTsr
         B3Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4NAG7hzXUC7y7frdcTzxZYfU3GpX9HZN0SD1UZIE0Yk=;
        b=QWmqGunke81lT9MdAOmAgAbNJhfy9sCwCy4MrHr4FwRf1/01L3bn+5kh7gWcBpIVgz
         8GWbJnLElIvGdcteoRrjb0gmQrM5/v1BJCRPWPT/X875zq64y/QYvDg9k7AqTDRoPGcE
         nvBZF98QQa1r3uQBzDOxcckogL09ANszyjzL3iM/DATcKGTM/VU9FPlJIiUw/4gGw2lV
         mkL+TqhDfRKSFf+Qbr354rnddqqwPprsdFNaU1ygPn2PhivAi0snBRgsePZ48kbehFDk
         Q0Cqt1x5IkC5h2JeqZ0ZGB/Z9k+FRh+d+labQyHxkkZRXOlusPMekYXDh8cRfQJy2qWQ
         wxMA==
X-Gm-Message-State: APt69E1A59GiV8+gJdn+bzfe37N2TinKZLCtX0pS24/d6Tv0LYJ63kEE
        MRYujtkSNc6IWnJ8B4+ZSSJAmDhy6tk=
X-Google-Smtp-Source: ADUXVKKRJDjK89MbmamOu74nYl/qgHpF3Qorlhiak7ulOtfbBA3N3hX6d7P5n6SjHWawSGWjjVmsmg==
X-Received: by 2002:a62:484d:: with SMTP id v74-v6mr14091182pfa.256.1529334581231;
        Mon, 18 Jun 2018 08:09:41 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.09.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:09:40 -0700 (PDT)
From:   Mark Salyzyn <salyzyn@android.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kevin Brodsky <kevin.brodsky@arm.com>,
        Mark Salyzyn <salyzyn@android.com>,
        James Morse <james.morse@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dmitry Safonov <dsafonov@virtuozzo.com>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Andrew Pinski <apinski@cavium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: RESEND [PATCH 1/6] arm64: compat: Use vDSO sigreturn trampolines if available
Date:   Mon, 18 Jun 2018 08:06:04 -0700
Message-Id: <20180618150613.10322-19-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618150613.10322-1-salyzyn@android.com>
References: <20180618150613.10322-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

If the compat vDSO is enabled, it replaces the sigreturn page.
Therefore, we use the sigreturn trampolines the vDSO provides instead.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Cc: James Morse <james.morse@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Andrew Pinski <apinski@cavium.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Jeremy Linton <Jeremy.Linton@arm.com>
---
 arch/arm64/include/asm/vdso.h |  3 +++
 arch/arm64/kernel/signal32.c  | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 839ce0031bd5..f2a952338f1e 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -28,6 +28,9 @@
 #ifndef __ASSEMBLY__
 
 #include <generated/vdso-offsets.h>
+#ifdef CONFIG_VDSO32
+#include <generated/vdso32-offsets.h>
+#endif
 
 #define VDSO_SYMBOL(base, name)						   \
 ({									   \
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index 096c88731c56..5ee07da53fd1 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -29,6 +29,7 @@
 #include <asm/traps.h>
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
+#include <asm/vdso.h>
 
 struct compat_vfp_sigframe {
 	compat_ulong_t	magic;
@@ -347,6 +348,19 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		retcode = ptr_to_compat(ka->sa.sa_restorer);
 	} else {
 		/* Set up sigreturn pointer */
+#ifdef CONFIG_VDSO32
+		void *vdso_base = current->mm->context.vdso;
+		void *trampoline =
+			(ka->sa.sa_flags & SA_SIGINFO
+			 ? (thumb
+			    ? VDSO_SYMBOL(vdso_base, compat_rt_sigreturn_thumb)
+			    : VDSO_SYMBOL(vdso_base, compat_rt_sigreturn_arm))
+			 : (thumb
+			    ? VDSO_SYMBOL(vdso_base, compat_sigreturn_thumb)
+			    : VDSO_SYMBOL(vdso_base, compat_sigreturn_arm)));
+
+		retcode = ptr_to_compat(trampoline) + thumb;
+#else
 		void *sigreturn_base = current->mm->context.vdso;
 		unsigned int idx = thumb << 1;
 
@@ -354,6 +368,7 @@ static void compat_setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 			idx += 3;
 
 		retcode = ptr_to_compat(sigreturn_base) + (idx << 2) + thumb;
+#endif
 	}
 
 	regs->regs[0]	= usig;
-- 
2.18.0.rc1.244.gcf134e6275-goog

