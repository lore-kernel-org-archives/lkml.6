Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00846C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF0D206C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 15:23:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbeLNPX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 10:23:26 -0500
Received: from foss.arm.com ([217.140.101.70]:53880 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbeLNPX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 10:23:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7290780D;
        Fri, 14 Dec 2018 07:23:25 -0800 (PST)
Received: from [10.1.197.36] (e112298-lin.cambridge.arm.com [10.1.197.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 693823F59C;
        Fri, 14 Dec 2018 07:23:23 -0800 (PST)
Subject: Re: [PATCH v7 11/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
From:   Julien Thierry <julien.thierry@arm.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        joel@joelfernandes.org, Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, oleg@redhat.com
References: <1544633245-6036-1-git-send-email-julien.thierry@arm.com>
 <1544633245-6036-12-git-send-email-julien.thierry@arm.com>
 <CAKv+Gu8E9g=J78a-2HAdcijaHyVFL1KA3civwfoVHQ=mp7yJJA@mail.gmail.com>
 <19500d6b-62a3-21cb-9ac0-a4e5d4714a63@arm.com>
 <CAKv+Gu8+1JNzM4AUujiEfkYujpgakLXcUwTDG4eHwvQ7pKAzFA@mail.gmail.com>
 <31e41461-763f-aa7d-91ea-b493ede81eed@arm.com>
 <CAKv+Gu9PaeGbfB-9r0Gv1oYn+jORJDk9ozajEwKbse3KjkSmbQ@mail.gmail.com>
 <bc27fb6d-1adf-d7e9-ded2-2cbed81b6e03@arm.com>
 <e0ecdb24-ef52-2c31-565d-66f7a2770f4a@arm.com>
Message-ID: <7d42f570-541a-59a3-79fc-f00dc0b51689@arm.com>
Date:   Fri, 14 Dec 2018 15:23:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <e0ecdb24-ef52-2c31-565d-66f7a2770f4a@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/12/2018 15:03, Julien Thierry wrote:
> 
> Argh, not as simple as I had expected.
> 
> Turns out include/linux/efi.h does not include asm/efi.h (including it
> at the beginning of the file breaks the build because asm/efi.h misses
> the efi type definitions.
> 
> So a thing like:
> 
> #ifndef efi_get_irqflags
> #define efi_get_irqflags(flags) local_save_flags(flags)
> #endif
> 
> in include/linux/efi.h cannot be overridden.
> 
> Either I would need to introduce the definitions arm, arm64 and x86 (I
> don't think there are other arch supporting EFI right now) or I'll need
> to come up with another solution.
> 

Would the following patch be acceptable for the EFI generic side?

If it is, I'll add it to the next iteration of this series.

Thanks,

Julien

-->

From 7acaa8e17142263addafb18ae10bd5d2d49cfb39 Mon Sep 17 00:00:00 2001
From: Julien Thierry <julien.thierry@arm.com>
Date: Fri, 14 Dec 2018 14:20:13 +0000
Subject: [RFC] efi: Let architectures decide the flags that should be
 saved/restored

Currently, irqflags are saved before calling runtime services and
checked for mismatch on return.

Add a config option to let architectures define a set of flags to be
checked and (if needed) restored when coming back from runtime services.
This allows to use check flags that are not necesarly related to
irqflags.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
---
 arch/Kconfig                            |  8 ++++++++
 drivers/firmware/efi/runtime-wrappers.c |  4 ++--
 include/linux/efi.h                     | 12 ++++++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e1e540f..cbec325 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -695,6 +695,14 @@ config HAVE_ARCH_HASH
 	  file which provides platform-specific implementations of some
 	  functions in <linux/hash.h> or fs/namei.c.
 
+config HAVE_GENERIC_EFI_FLAGS
+	bool
+	default n
+	help
+	  Architecture defines a set of flags that EFI runtime services
+	  should take care to restore when returning to the OS.
+	  If this is not set, the set of flags defaults to the arch irqflags.
+
 config ISA_BUS_API
 	def_bool ISA
 
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index 8903b9c..6dafa04 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -93,7 +93,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
 {
 	unsigned long cur_flags, mismatch;
 
-	local_save_flags(cur_flags);
+	efi_save_flags(cur_flags);
 
 	mismatch = flags ^ cur_flags;
 	if (!WARN_ON_ONCE(mismatch & ARCH_EFI_IRQ_FLAGS_MASK))
@@ -102,7 +102,7 @@ void efi_call_virt_check_flags(unsigned long flags, const char *call)
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_NOW_UNRELIABLE);
 	pr_err_ratelimited(FW_BUG "IRQ flags corrupted (0x%08lx=>0x%08lx) by EFI %s\n",
 			   flags, cur_flags, call);
-	local_irq_restore(flags);
+	efi_restore_flags(flags);
 }
 
 /*
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 100ce4a..41c110a 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1594,6 +1594,14 @@ enum efi_secureboot_mode {
 
 void efi_retrieve_tpm2_eventlog(efi_system_table_t *sys_table);
 
+#ifdef CONFIG_HAVE_GENERIC_EFI_FLAGS
+#define efi_save_flags(state_flags)	arch_efi_save_flags(state_flags)
+#define efi_restore_flags(state_flags)	arch_efi_restore_flags(state_flags)
+#else
+#define efi_save_flags(state_flags)	local_save_flags(state_flags)
+#define efi_restore_flags(state_flags)	local_irq_restore(state_flags)
+#endif
+
 /*
  * Arch code can implement the following three template macros, avoiding
  * reptition for the void/non-void return cases of {__,}efi_call_virt():
@@ -1621,7 +1629,7 @@ enum efi_secureboot_mode {
 									\
 	arch_efi_call_virt_setup();					\
 									\
-	local_save_flags(__flags);					\
+	efi_save_flags(__flags);					\
 	__s = arch_efi_call_virt(p, f, args);				\
 	efi_call_virt_check_flags(__flags, __stringify(f));		\
 									\
@@ -1636,7 +1644,7 @@ enum efi_secureboot_mode {
 									\
 	arch_efi_call_virt_setup();					\
 									\
-	local_save_flags(__flags);					\
+	efi_save_flags(__flags);					\
 	arch_efi_call_virt(p, f, args);					\
 	efi_call_virt_check_flags(__flags, __stringify(f));		\
 									\
-- 
1.9.1




-- 
Julien Thierry
