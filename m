Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826A2C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202572159D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="esLzEebS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 202572159D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbeI0PIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:08:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38786 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeI0PIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:08:17 -0400
Received: by mail-wr1-f68.google.com with SMTP id j8-v6so1663675wrw.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 01:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Hst4Xmssk5t5MSzJ6l4LGDPoTA7TiBmRxnOh47JqGw=;
        b=esLzEebS9YFaA1LjD25exnWeIGHrQzAhSd5WDcGGNtOerRfxPjzd5KqG1uGLqVWrUH
         1XqPRqAg66LTCEcivcHFxTyqJ986X8GeJFiImJ0lGGMcNHHZQpPHOZsPijuyZndoph0T
         0RwgecSmHBAwkf+1qlweJjgCFt9gfSi5U/QPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Hst4Xmssk5t5MSzJ6l4LGDPoTA7TiBmRxnOh47JqGw=;
        b=J35XwvWfxCGdT6VnrhGOAWyDxU0804rUIr1MrsWafW2XOF9p0nIxFA0uCvNg/Y+e0S
         CoRh4A+nZJfMwUiF4imvCLUbYhoCR9WCGqozjSV9oxRxi0SKQn0339+gcf3JzZsYY01h
         J/+tAVmdZVJS2i2zY570Fn5pWU5ouiOZVDgssgf+MpuWtPk88N2IKqj3D2AWBaltKE5C
         V0z1NaWpiKZYpzXwtoRXZQAlGUkL/u4Ts3uYYeV/YPxz6pp55CIOpP21WIYNpDQwKy0R
         +9tGDuBKFY6LNXvVqo14bH47udINdI2DgsgQde5Uu9oj51Wf/PoybIutiVIi5lDj1ERV
         yjaw==
X-Gm-Message-State: ABuFfohR3bSjBTBPjTJDPLVWsOsmy45+LasMfoeor387bOX/a3a/97aQ
        K5e2+bNZ4TWNbDn5TL16ce8eEEko0tk=
X-Google-Smtp-Source: ACcGV62wKtETFP2cPJo5EPRjxFXgRUOr7EPKjIdYmbKM+G8rmPK76+nHFtZiudcYSiIDT1oCYvx31Q==
X-Received: by 2002:adf:b2d7:: with SMTP id g81-v6mr7829116wrd.48.1538038266464;
        Thu, 27 Sep 2018 01:51:06 -0700 (PDT)
Received: from rev03.home ([2a01:cb1d:112:6f00:546e:3c44:5966:2f5e])
        by smtp.gmail.com with ESMTPSA id p11-v6sm1304055wrd.74.2018.09.27.01.51.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 01:51:05 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-efi@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Alistair Strachan <astrachan@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Robinson <pbrobinson@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 07/11] efi/x86: Handle page faults occurring while running EFI runtime services
Date:   Thu, 27 Sep 2018 10:50:34 +0200
Message-Id: <20180927085039.8391-8-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sai Praneeth <sai.praneeth.prakhya@intel.com>

Memory accesses performed by UEFI runtime services should be limited to:
- reading/executing from EFI_RUNTIME_SERVICES_CODE memory regions
- reading/writing from/to EFI_RUNTIME_SERVICES_DATA memory regions
- reading/writing by-ref arguments
- reading/writing from/to the stack.

Accesses outside these regions may cause the kernel to hang because the
memory region requested by the firmware isn't mapped in efi_pgd, which
causes a page fault in ring 0 and the kernel fails to handle it, leading
to die(). To save kernel from hanging, add an EFI specific page fault
handler which recovers from such faults by
1. If the efi runtime service is efi_reset_system(), reboot the machine
   through BIOS.
2. If the efi runtime service is _not_ efi_reset_system(), then freeze
   efi_rts_wq and schedule a new process.

The EFI page fault handler offers us two advantages:
1. Avoid potential hangs caused by buggy firmware.
2. Shout loud that the firmware is buggy and hence is not a kernel bug.

Tested-by: Bhupesh Sharma <bhsharma@redhat.com>
Suggested-by: Matt Fleming <matt@codeblueprint.co.uk>
Based-on-code-from: Ricardo Neri <ricardo.neri@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
[ardb: clarify commit log]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/efi.h              |  1 +
 arch/x86/mm/fault.c                     |  9 +++
 arch/x86/platform/efi/quirks.c          | 78 +++++++++++++++++++++++++
 drivers/firmware/efi/runtime-wrappers.c |  8 +++
 include/linux/efi.h                     |  8 ++-
 5 files changed, 103 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index cec5fae23eb3..eea40d52ca78 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -140,6 +140,7 @@ extern void __init efi_apply_memmap_quirks(void);
 extern int __init efi_reuse_config(u64 tables, int nr_tables);
 extern void efi_delete_dummy_variable(void);
 extern void efi_switch_mm(struct mm_struct *mm);
+extern void efi_recover_from_page_fault(unsigned long phys_addr);
 
 struct efi_setup_data {
 	u64 fw_vendor;
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 47bebfe6efa7..a5b9ddb0f1fe 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -16,6 +16,7 @@
 #include <linux/prefetch.h>		/* prefetchw			*/
 #include <linux/context_tracking.h>	/* exception_enter(), ...	*/
 #include <linux/uaccess.h>		/* faulthandler_disabled()	*/
+#include <linux/efi.h>			/* efi_recover_from_page_fault()*/
 #include <linux/mm_types.h>
 
 #include <asm/cpufeature.h>		/* boot_cpu_has, ...		*/
@@ -25,6 +26,7 @@
 #include <asm/vsyscall.h>		/* emulate_vsyscall		*/
 #include <asm/vm86.h>			/* struct vm86			*/
 #include <asm/mmu_context.h>		/* vma_pkey()			*/
+#include <asm/efi.h>			/* efi_recover_from_page_fault()*/
 
 #define CREATE_TRACE_POINTS
 #include <asm/trace/exceptions.h>
@@ -788,6 +790,13 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	if (is_errata93(regs, address))
 		return;
 
+	/*
+	 * Buggy firmware could access regions which might page fault, try to
+	 * recover from such faults.
+	 */
+	if (IS_ENABLED(CONFIG_EFI))
+		efi_recover_from_page_fault(address);
+
 	/*
 	 * Oops. The kernel tried to access some bad page. We'll have to
 	 * terminate things with extreme prejudice:
diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index 844d31cb8a0c..669babcaf245 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -16,6 +16,7 @@
 #include <asm/efi.h>
 #include <asm/uv/uv.h>
 #include <asm/cpu_device_id.h>
+#include <asm/reboot.h>
 
 #define EFI_MIN_RESERVE 5120
 
@@ -654,3 +655,80 @@ int efi_capsule_setup_info(struct capsule_info *cap_info, void *kbuff,
 }
 
 #endif
+
+/*
+ * If any access by any efi runtime service causes a page fault, then,
+ * 1. If it's efi_reset_system(), reboot through BIOS.
+ * 2. If any other efi runtime service, then
+ *    a. Return error status to the efi caller process.
+ *    b. Disable EFI Runtime Services forever and
+ *    c. Freeze efi_rts_wq and schedule new process.
+ *
+ * @return: Returns, if the page fault is not handled. This function
+ * will never return if the page fault is handled successfully.
+ */
+void efi_recover_from_page_fault(unsigned long phys_addr)
+{
+	if (!IS_ENABLED(CONFIG_X86_64))
+		return;
+
+	/*
+	 * Make sure that an efi runtime service caused the page fault.
+	 * "efi_mm" cannot be used to check if the page fault had occurred
+	 * in the firmware context because efi=old_map doesn't use efi_pgd.
+	 */
+	if (efi_rts_work.efi_rts_id == NONE)
+		return;
+
+	/*
+	 * Address range 0x0000 - 0x0fff is always mapped in the efi_pgd, so
+	 * page faulting on these addresses isn't expected.
+	 */
+	if (phys_addr >= 0x0000 && phys_addr <= 0x0fff)
+		return;
+
+	/*
+	 * Print stack trace as it might be useful to know which EFI Runtime
+	 * Service is buggy.
+	 */
+	WARN(1, FW_BUG "Page fault caused by firmware at PA: 0x%lx\n",
+	     phys_addr);
+
+	/*
+	 * Buggy efi_reset_system() is handled differently from other EFI
+	 * Runtime Services as it doesn't use efi_rts_wq. Although,
+	 * native_machine_emergency_restart() says that machine_real_restart()
+	 * could fail, it's better not to compilcate this fault handler
+	 * because this case occurs *very* rarely and hence could be improved
+	 * on a need by basis.
+	 */
+	if (efi_rts_work.efi_rts_id == RESET_SYSTEM) {
+		pr_info("efi_reset_system() buggy! Reboot through BIOS\n");
+		machine_real_restart(MRR_BIOS);
+		return;
+	}
+
+	/*
+	 * Before calling EFI Runtime Service, the kernel has switched the
+	 * calling process to efi_mm. Hence, switch back to task_mm.
+	 */
+	arch_efi_call_virt_teardown();
+
+	/* Signal error status to the efi caller process */
+	efi_rts_work.status = EFI_ABORTED;
+	complete(&efi_rts_work.efi_rts_comp);
+
+	clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
+	pr_info("Froze efi_rts_wq and disabled EFI Runtime Services\n");
+
+	/*
+	 * Call schedule() in an infinite loop, so that any spurious wake ups
+	 * will never run efi_rts_wq again.
+	 */
+	for (;;) {
+		set_current_state(TASK_IDLE);
+		schedule();
+	}
+
+	return;
+}
diff --git a/drivers/firmware/efi/runtime-wrappers.c b/drivers/firmware/efi/runtime-wrappers.c
index b18b2d864c2c..a19d845bdb06 100644
--- a/drivers/firmware/efi/runtime-wrappers.c
+++ b/drivers/firmware/efi/runtime-wrappers.c
@@ -61,6 +61,11 @@ struct efi_runtime_work efi_rts_work;
 ({									\
 	efi_rts_work.status = EFI_ABORTED;				\
 									\
+	if (!efi_enabled(EFI_RUNTIME_SERVICES)) {			\
+		pr_warn_once("EFI Runtime Services are disabled!\n");	\
+		goto exit;						\
+	}								\
+									\
 	init_completion(&efi_rts_work.efi_rts_comp);			\
 	INIT_WORK_ONSTACK(&efi_rts_work.work, efi_call_rts);		\
 	efi_rts_work.arg1 = _arg1;					\
@@ -79,6 +84,8 @@ struct efi_runtime_work efi_rts_work;
 	else								\
 		pr_err("Failed to queue work to efi_rts_wq.\n");	\
 									\
+exit:									\
+	efi_rts_work.efi_rts_id = NONE;					\
 	efi_rts_work.status;						\
 })
 
@@ -393,6 +400,7 @@ static void virt_efi_reset_system(int reset_type,
 			"could not get exclusive access to the firmware\n");
 		return;
 	}
+	efi_rts_work.efi_rts_id = RESET_SYSTEM;
 	__efi_call_virt(reset_system, reset_type, status, data_size, data);
 	up(&efi_runtime_lock);
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index a929d2bf41fa..845174e113ce 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1662,8 +1662,13 @@ struct linux_efi_tpm_eventlog {
 
 extern int efi_tpm_eventlog_init(void);
 
-/* efi_runtime_service() function identifiers */
+/*
+ * efi_runtime_service() function identifiers.
+ * "NONE" is used by efi_recover_from_page_fault() to check if the page
+ * fault happened while executing an efi runtime service.
+ */
 enum efi_rts_ids {
+	NONE,
 	GET_TIME,
 	SET_TIME,
 	GET_WAKEUP_TIME,
@@ -1673,6 +1678,7 @@ enum efi_rts_ids {
 	SET_VARIABLE,
 	QUERY_VARIABLE_INFO,
 	GET_NEXT_HIGH_MONO_COUNT,
+	RESET_SYSTEM,
 	UPDATE_CAPSULE,
 	QUERY_CAPSULE_CAPS,
 };
-- 
2.18.0

