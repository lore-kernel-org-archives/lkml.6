Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A108C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA69A208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="i/RbAs4i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA69A208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbeJBAnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 20:43:05 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37168 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeJBAnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 20:43:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id j23-v6so455355pfi.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 11:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a082AL/4Oj65cVJFcdJAwbuKyRvNhbo+1Hg117kQxIY=;
        b=i/RbAs4izAdc8l6xtU2dFlH7VxCmErKV/xX/K1VzpZVyWk9JWxuGM0W40qGHVufztV
         SrKvBz49Ps+yH4ERe38Tzoy+6czv+p16TEUGlR8nEHBiECbcyvWsofsPHOnxOb97DrON
         1t06AWfcy08CuFXSioU1S0pmUNjdYMZeS2xYvcmTvqKJ/6c2NHVpeyls2klSVX7+CZOl
         tU/TquASqsX2EyTjJKi8RrgtgPT253ad79p0O9HiQkoDuylMZf1OH2bZFttVbyUTvsk3
         KKXTPZ4TYv9VtYdPf9WKd5STOTJCOpTvsNhbCOAYRORYvUqdu7hdNf01VuZoYRL2YqtI
         SzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a082AL/4Oj65cVJFcdJAwbuKyRvNhbo+1Hg117kQxIY=;
        b=WqKL9tjFL48p0aA1vSqxeBvIU62mZ52zuehhOA3Al/p+re7KbNfZLA9jfXLTj9Mnzj
         p8bct/Lni41SNjWqFPDM35fsdA8ZWrhifkvHBGKFUOAEWq35e+GWx0Y81SW2dZoGysSM
         fBXwKCt2UpcY6Cgv3JO2TAhEy7/qYp8va+eOEtyQ4eCpSSWC/kk9SgzBjeVcPqML1Hdj
         xhW79h2cRiSqwJLXF8smt2UZs4MlGj9KEEvknJWa6zm5pR9tiRc3epgmVcGfWY7l9mb1
         p1E0+kXMIBEetBOTJsmjupVlGFWk9fMSbNNAgY6Ej37VC0n7+oiFX1Yj7fFAJFrCOUjU
         Aj3Q==
X-Gm-Message-State: ABuFfoiPbNzbZfnxfgAjtIx6b9+L2Ptd3huLTi4l8NuS3YRw76X/CnzL
        pJFu9Z6khajdMvD1Wq8158T0FwVeH64=
X-Google-Smtp-Source: ACcGV61cLdG7DWQiudJJIj+s/q2sNeMqzZ9N0MvqOmIuRztv9JsFZ08pWU7HSiH3MsKmL19dWYicKQ==
X-Received: by 2002:a63:3747:: with SMTP id g7-v6mr11311032pgn.59.1538417046158;
        Mon, 01 Oct 2018 11:04:06 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1612:b4fb:6752:f21f:3502])
        by smtp.gmail.com with ESMTPSA id d186-v6sm24469261pfg.173.2018.10.01.11.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 11:04:05 -0700 (PDT)
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
        android-kernel@android.com, Ben Hutchings <ben@decadent.org.uk>,
        Dave Martin <Dave.Martin@arm.com>
Subject: RESEND [PATCH 2/6] arm64: elf: Set AT_SYSINFO_EHDR in compat processes
Date:   Mon,  1 Oct 2018 10:58:39 -0700
Message-Id: <20181001175845.168430-20-salyzyn@android.com>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20181001175845.168430-1-salyzyn@android.com>
References: <20181001175845.168430-1-salyzyn@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

If the compat vDSO is enabled, we need to set AT_SYSINFO_EHDR in the
auxiliary vector of compat processes to the address of the vDSO code
page, so that the dynamic linker can find it (just like the regular vDSO).

Note that we cast context.vdso to Elf64_Off, instead of elf_addr_t,
because elf_addr_t is Elf32_Off in compat_binfmt_elf.c, and casting
context.vdso to u32 would trigger a pointer narrowing warning.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Tested-by: Mark Salyzyn <salyzyn@android.com>
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
Cc: android-kernel@android.com
---
 arch/arm64/include/asm/elf.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 433b9554c6a1..bf4672a0491b 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -147,10 +147,10 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 })
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-#define ARCH_DLINFO							\
+#define _SET_AUX_ENT_VDSO						\
 do {									\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
-		    (elf_addr_t)current->mm->context.vdso);		\
+		    (Elf64_Off)current->mm->context.vdso);		\
 									\
 	/*								\
 	 * Should always be nonzero unless there's a kernel bug.	\
@@ -162,6 +162,7 @@ do {									\
 	else								\
 		NEW_AUX_ENT(AT_IGNORE, 0);				\
 } while (0)
+#define ARCH_DLINFO _SET_AUX_ENT_VDSO
 
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
@@ -209,7 +210,11 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 ({									\
 	set_thread_flag(TIF_32BIT);					\
  })
+#ifdef CONFIG_VDSO32
+#define COMPAT_ARCH_DLINFO	_SET_AUX_ENT_VDSO
+#else
 #define COMPAT_ARCH_DLINFO
+#endif
 extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
 				      int uses_interp);
 #define compat_arch_setup_additional_pages \
-- 
2.19.0.605.g01d371f741-goog

