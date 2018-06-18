Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177B4C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBFA5208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 15:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="OiZw9g3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBFA5208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=android.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935755AbeFRPJa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 11:09:30 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46519 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935442AbeFRPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 11:09:27 -0400
Received: by mail-pf0-f193.google.com with SMTP id q1-v6so8320686pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 08:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OaELTQw2RDxK69EIJRpzEZSOniPvvy6Q+QK1TVFJ+EY=;
        b=OiZw9g3+gWGlWDJFmVNvIqbTcSN0ZpeNFl7264qjDE9OIo6w8eBJXfRq7YQ0l9QP9e
         HAkPU8PRMtWRMlTXsgrF28ffcnX+Na7qo4a6Y6gEtSVxp29TEshKWEG5mR0N9v9E22Ux
         UqJwfnhjNKyWi3fpOM+yAmIWwwRBIeNplGD4CunOyrugGOf2irjThgSOlCYubLPcgon6
         8XDrfsQlDwi0BaeApVh3xSbsnftASqVv9Vtji8GCeIafdtElVv9jPYXxCw41fQtRvbkC
         1g3DLGQk1V9yrSGQqieu1HWmU93OPSvwPbRXQJ8PcvlSTMuIsApQ4aAfJ18Xol8oozHe
         Qxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OaELTQw2RDxK69EIJRpzEZSOniPvvy6Q+QK1TVFJ+EY=;
        b=LX/DwL5Kj2h2C9/cfrGvyND+qIPpyVDcAaqYmGqwrqL6MpVKZLNiJHtPY9kOVJuvqE
         k6yY4IMqIiFrJcnS28Zrb2cwPhtf/psF6vYqeaw2iR8XJeMuKTrZFviEtcbYm2P7NFAW
         mgd68fwXyc/VHtDeuHIyD7GBy23kVIuYC2ylYn4g4Xxw2FgHE/4n90z8KLAYrzkUbyjL
         q3LqURrMoemyDi+PUM1/NzFyFSUWvJ1vxHB3RWzdvOWc81btMs/3KShYD1bSf3M2RdiT
         YqMrMXrpqVFCib7lyjQwpKJRDECRlhNebe/HbTQdLYzkIeRNr61zrWGxfeAgdmpsGQ6E
         +FXw==
X-Gm-Message-State: APt69E0ZCQyVzySbtzUmzOIhzjZRsav9lnxIJQRQPfAqE+69LJ9yRu+n
        YGqr9MOgsWnNk15URr2PuVg1FXxIkxw=
X-Google-Smtp-Source: ADUXVKJHQJt5S+doddx2ep+Djnwc64EARW73qaPTgd2qgrai/8kt1rOojWfXd95PTRUI628NhEjKSQ==
X-Received: by 2002:a62:4a0c:: with SMTP id x12-v6mr14029123pfa.142.1529334566300;
        Mon, 18 Jun 2018 08:09:26 -0700 (PDT)
Received: from nebulus.mtv.corp.google.com ([2620:0:1000:1611:6077:8eec:bc7e:d0f4])
        by smtp.gmail.com with ESMTPSA id i7-v6sm54830660pfa.34.2018.06.18.08.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jun 2018 08:09:25 -0700 (PDT)
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
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: RESEND [PATCH v2 3/3] arm64: compat: Add CONFIG_KUSER_HELPERS
Date:   Mon, 18 Jun 2018 08:06:02 -0700
Message-Id: <20180618150613.10322-17-salyzyn@android.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180618150613.10322-1-salyzyn@android.com>
References: <20180618150613.10322-1-salyzyn@android.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kevin Brodsky <kevin.brodsky@arm.com>

Make it possible to disable the kuser helpers by adding a KUSER_HELPERS
config option (enabled by default). When disabled, all kuser
helpers-related code is removed from the kernel and no mapping is done
at the fixed high address (0xffff0000); any attempt to use a kuser
helper from a 32-bit process will result in a segfault.

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

v2:
- split off assembler changes to a new previous patch in series to reduce churn
- modify slightly the feature documentation to reduce its reach
- modify slightly the feature documentation to rationalize the yes default.
- There are more ifdefs as a result of the rebase.

v3:
- rebase
---
 arch/arm64/Kconfig         | 30 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/Makefile |  2 +-
 arch/arm64/kernel/vdso.c   | 10 ++++++++++
 3 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 42c090cf0292..11b4c6aef7d7 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1296,6 +1296,36 @@ config COMPAT
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config KUSER_HELPERS
+	bool "Enable the kuser helpers page in 32-bit processes"
+	depends on COMPAT
+	default y
+	help
+	  Warning: disabling this option may break 32-bit applications.
+
+	  Provide kuser helpers in a special purpose fixed-address page. The
+	  kernel provides helper code to userspace in read-only form at a fixed
+	  location to allow userspace to be independent of the CPU type fitted
+	  to the system. This permits 32-bit binaries to be run on ARMv6 through
+	  to ARMv8 without modification.
+
+	  See Documentation/arm/kernel_user_helpers.txt for details.
+
+	  However, the fixed-address nature of these helpers can be used by ROP
+	  (return-orientated programming) authors when creating exploits.
+
+	  If all of the 32-bit binaries and libraries that run on your platform
+	  are built specifically for your platform, and make no use of these
+	  helpers, then you can turn this option off to hinder such exploits.
+	  However, in that case, if a binary or library relying on those helpers
+	  is run, it will receive a SIGSEGV signal, which will terminate the
+	  program. Typically, binaries compiled for ARMv7 or later do not use
+	  the kuser helpers.
+
+	  Say N here only if you are absolutely certain that you do not need
+	  these helpers; otherwise, the safe option is to say Y (the default
+	  for now)
+
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 9851be3ef932..c16be3cf39bf 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -29,7 +29,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
 arm64-obj-$(CONFIG_COMPAT)		+= sys32.o signal32.o	\
 					   sys_compat.o entry32.o
 arm64-obj-$(CONFIG_COMPAT)		+= sigreturn32.o
-arm64-obj-$(CONFIG_COMPAT)		+= kuser32.o
+arm64-obj-$(CONFIG_KUSER_HELPERS)	+= kuser32.o
 arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
 arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
 arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 5398f6454ce1..76a94bed4bd5 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -62,18 +62,22 @@ static const struct vm_special_mapping compat_vdso_spec[] = {
 		.name	= "[sigpage]",
 		.pages	= &vectors_page[0],
 	},
+#ifdef CONFIG_KUSER_HELPERS
 	{
 		.name	= "[kuserhelpers]",
 		.pages	= &vectors_page[1],
 	},
+#endif
 };
 static struct page *vectors_page[ARRAY_SIZE(compat_vdso_spec)] __ro_after_init;
 
 static int __init alloc_vectors_page(void)
 {
+#ifdef CONFIG_KUSER_HELPERS
 	extern char __kuser_helper_start[], __kuser_helper_end[];
 	size_t kuser_sz = __kuser_helper_end - __kuser_helper_start;
 	unsigned long kuser_vpage;
+#endif
 
 	extern char __aarch32_sigret_code_start[], __aarch32_sigret_code_end[];
 	size_t sigret_sz =
@@ -84,22 +88,26 @@ static int __init alloc_vectors_page(void)
 	if (!sigret_vpage)
 		return -ENOMEM;
 
+#ifdef CONFIG_KUSER_HELPERS
 	kuser_vpage = get_zeroed_page(GFP_ATOMIC);
 	if (!kuser_vpage) {
 		free_page(sigret_vpage);
 		return -ENOMEM;
 	}
+#endif
 
 	/* sigreturn code */
 	memcpy((void *)sigret_vpage, __aarch32_sigret_code_start, sigret_sz);
 	flush_icache_range(sigret_vpage, sigret_vpage + PAGE_SIZE);
 	vectors_page[0] = virt_to_page(sigret_vpage);
 
+#ifdef CONFIG_KUSER_HELPERS
 	/* kuser helpers */
 	memcpy((void *)kuser_vpage + 0x1000 - kuser_sz, __kuser_helper_start,
 		kuser_sz);
 	flush_icache_range(kuser_vpage, kuser_vpage + PAGE_SIZE);
 	vectors_page[1] = virt_to_page(kuser_vpage);
+#endif
 
 	return 0;
 }
@@ -128,11 +136,13 @@ int aarch32_setup_vectors_page(struct linux_binprm *bprm, int uses_interp)
 
 	current->mm->context.vdso = (void *)addr;
 
+#ifdef CONFIG_KUSER_HELPERS
 	/* Map the kuser helpers at the ABI-defined high address. */
 	ret = _install_special_mapping(mm, AARCH32_KUSER_HELPERS_BASE,
 				       PAGE_SIZE,
 				       VM_READ|VM_EXEC|VM_MAYREAD|VM_MAYEXEC,
 				       &compat_vdso_spec[1]);
+#endif
 out:
 	up_write(&mm->mmap_sem);
 
-- 
2.18.0.rc1.244.gcf134e6275-goog

