Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CA9C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBC152081C
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TKEh62fr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC152081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeK3RhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 12:37:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32984 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbeK3RhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 12:37:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so4147177wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 22:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gM00MDhgQklZaZWezzK6ngjmaYBWFbyqmF7GmheqEQg=;
        b=TKEh62frnscGyFp6YZBLcruTT1SvD6fHW8EwEzwM+oDcFWUImyYuMU+DZC5tGAVCHk
         mWbiothphEpa6a9gr/PtTA3Q6OVP4gAmZ2hePeL7MNEFD4FPYa4GwIkjXCvknNK9CN+r
         Vf2u6TDej3uW8gacT6TRk577keaCWSXjYAZj1YaR+KlYLQGjuF0Wg/94lS1kt9+GcyzB
         8FIyZciUo6P2y+3v0iqEe8I7HjVIEYWKWoDwtW2TqRPuz+xEz1EtA30B6xXvXGO2li23
         RXgyekPyCc1NJVW9/LcvnvDsXshA8T9BnWWkM3pfiGdYgM+FJngqvro3WdSeK+IdFZDZ
         nXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=gM00MDhgQklZaZWezzK6ngjmaYBWFbyqmF7GmheqEQg=;
        b=oGBSSnnK+QeH3B0augmal2lCUI071edDTUKLdPE02tC/9VtYuprGRoyyKi4bYfsbdt
         BOXEDrBcDMK7q+KJD6NTBy84e5N8cAYYsHi7gF6qyNWKpg2nGNCgaI9yHWVTG97kUDTL
         2UX4GMmx2X5n+MllXfTI1MVFB66BaPjoFyPKYwaCGa1vWc2VXbuwiA3QKQfPpwVEFGLk
         49IBfbnkWI45OX4GODuCiK2RwOxumy1kw2SMQlHCHEZZyKLjnPv9WvkTJE5iUHHRryw7
         da37X/2iS1O5WWcBMjPMOe8WJn3ALsh/PPNtzEsslTiUkpHs+dAVFUSFgTxXTNGbGTz9
         5tsQ==
X-Gm-Message-State: AA+aEWZMKegsnAauINioe4hslRNMgJQPVc4/KgACvSY5CUdIFNlrutqV
        LP6dgMCJ9zgU7HrIWVNkhN4=
X-Google-Smtp-Source: AFSGD/US6uKS94FcmRbRwW0mfzP0CswHHCfMcf9OGGNaPhEfw6hPMxPwyHr1NPyeu0fpsI1WgtLS+Q==
X-Received: by 2002:adf:b716:: with SMTP id l22mr4011091wre.186.1543559349283;
        Thu, 29 Nov 2018 22:29:09 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j33sm6378285wre.91.2018.11.29.22.29.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 22:29:08 -0800 (PST)
Date:   Fri, 30 Nov 2018 07:29:06 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86 fixes
Message-ID: <20181130062906.GA112090@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: 60c8144afc287ef09ce8c1230c6aa972659ba1bb x86/MCE/AMD: Fix the thresholding machinery initialization order

Misc fixes:

 - an MCE related boot crash fix on certain AMD systems
 - an FPU exception handling fix
 - an FPU handling race fix
 - a revert+rewrite of the RSDP boot protocol extension, use boot_params 
   instead
 - a documentation fix

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/MCE/AMD: Fix the thresholding machinery initialization order

Elvira Khabirova (1):
      x86/ptrace: Fix documentation for tracehook_report_syscall_entry()

Jann Horn (1):
      x86/fpu: Use the correct exception table macro in the XSTATE_OP wrapper

Juergen Gross (2):
      x86/boot: Mostly revert commit ae7e1238e68f2a ("Add ACPI RSDP address to setup_header")
      x86/acpi, x86/boot: Take RSDP address from boot params if available

Sebastian Andrzej Siewior (1):
      x86/fpu: Disable bottom halves while loading FPU registers


 Documentation/x86/boot.txt            | 32 +-------------------------------
 arch/x86/boot/header.S                |  6 +-----
 arch/x86/include/asm/fpu/internal.h   |  2 +-
 arch/x86/include/asm/x86_init.h       |  2 --
 arch/x86/include/uapi/asm/bootparam.h |  7 ++-----
 arch/x86/kernel/acpi/boot.c           |  2 +-
 arch/x86/kernel/cpu/mcheck/mce_amd.c  | 19 ++++++-------------
 arch/x86/kernel/fpu/signal.c          |  4 ++--
 arch/x86/kernel/head32.c              |  1 -
 arch/x86/kernel/head64.c              |  2 --
 arch/x86/kernel/setup.c               | 17 -----------------
 include/linux/tracehook.h             |  4 ++--
 12 files changed, 16 insertions(+), 82 deletions(-)

diff --git a/Documentation/x86/boot.txt b/Documentation/x86/boot.txt
index 7727db8f94bc..5e9b826b5f62 100644
--- a/Documentation/x86/boot.txt
+++ b/Documentation/x86/boot.txt
@@ -61,18 +61,6 @@ Protocol 2.12:	(Kernel 3.8) Added the xloadflags field and extension fields
 	 	to struct boot_params for loading bzImage and ramdisk
 		above 4G in 64bit.
 
-Protocol 2.13:	(Kernel 3.14) Support 32- and 64-bit flags being set in
-		xloadflags to support booting a 64-bit kernel from 32-bit
-		EFI
-
-Protocol 2.14:	(Kernel 4.20) Added acpi_rsdp_addr holding the physical
-		address of the ACPI RSDP table.
-		The bootloader updates version with:
-		0x8000 | min(kernel-version, bootloader-version)
-		kernel-version being the protocol version supported by
-		the kernel and bootloader-version the protocol version
-		supported by the bootloader.
-
 **** MEMORY LAYOUT
 
 The traditional memory map for the kernel loader, used for Image or
@@ -209,7 +197,6 @@ Offset	Proto	Name		Meaning
 0258/8	2.10+	pref_address	Preferred loading address
 0260/4	2.10+	init_size	Linear memory required during initialization
 0264/4	2.11+	handover_offset	Offset of handover entry point
-0268/8	2.14+	acpi_rsdp_addr	Physical address of RSDP table
 
 (1) For backwards compatibility, if the setup_sects field contains 0, the
     real value is 4.
@@ -322,7 +309,7 @@ Protocol:	2.00+
   Contains the magic number "HdrS" (0x53726448).
 
 Field name:	version
-Type:		modify
+Type:		read
 Offset/size:	0x206/2
 Protocol:	2.00+
 
@@ -330,12 +317,6 @@ Protocol:	2.00+
   e.g. 0x0204 for version 2.04, and 0x0a11 for a hypothetical version
   10.17.
 
-  Up to protocol version 2.13 this information is only read by the
-  bootloader. From protocol version 2.14 onwards the bootloader will
-  write the used protocol version or-ed with 0x8000 to the field. The
-  used protocol version will be the minimum of the supported protocol
-  versions of the bootloader and the kernel.
-
 Field name:	realmode_swtch
 Type:		modify (optional)
 Offset/size:	0x208/4
@@ -763,17 +744,6 @@ Offset/size:	0x264/4
 
   See EFI HANDOVER PROTOCOL below for more details.
 
-Field name:	acpi_rsdp_addr
-Type:		write
-Offset/size:	0x268/8
-Protocol:	2.14+
-
-  This field can be set by the boot loader to tell the kernel the
-  physical address of the ACPI RSDP table.
-
-  A value of 0 indicates the kernel should fall back to the standard
-  methods to locate the RSDP.
-
 
 **** THE IMAGE CHECKSUM
 
diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 4c881c850125..850b8762e889 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -300,7 +300,7 @@ _start:
 	# Part 2 of the header, from the old setup.S
 
 		.ascii	"HdrS"		# header signature
-		.word	0x020e		# header version number (>= 0x0105)
+		.word	0x020d		# header version number (>= 0x0105)
 					# or else old loadlin-1.5 will fail)
 		.globl realmode_swtch
 realmode_swtch:	.word	0, 0		# default_switch, SETUPSEG
@@ -558,10 +558,6 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 init_size:		.long INIT_SIZE		# kernel initialization size
 handover_offset:	.long 0			# Filled in by build.c
 
-acpi_rsdp_addr:		.quad 0			# 64-bit physical pointer to the
-						# ACPI RSDP table, added with
-						# version 2.14
-
 # End of setup header #####################################################
 
 	.section ".entrytext", "ax"
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 5f7290e6e954..69dcdf195b61 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -226,7 +226,7 @@ static inline void copy_fxregs_to_kernel(struct fpu *fpu)
 		     "3: movl $-2,%[err]\n\t"				\
 		     "jmp 2b\n\t"					\
 		     ".popsection\n\t"					\
-		     _ASM_EXTABLE_UA(1b, 3b)				\
+		     _ASM_EXTABLE(1b, 3b)				\
 		     : [err] "=r" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 0f842104862c..b85a7c54c6a1 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -303,6 +303,4 @@ extern void x86_init_noop(void);
 extern void x86_init_uint_noop(unsigned int unused);
 extern bool x86_pnpbios_disabled(void);
 
-void x86_verify_bootdata_version(void);
-
 #endif
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 22f89d040ddd..60733f137e9a 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -16,9 +16,6 @@
 #define RAMDISK_PROMPT_FLAG		0x8000
 #define RAMDISK_LOAD_FLAG		0x4000
 
-/* version flags */
-#define VERSION_WRITTEN	0x8000
-
 /* loadflags */
 #define LOADED_HIGH	(1<<0)
 #define KASLR_FLAG	(1<<1)
@@ -89,7 +86,6 @@ struct setup_header {
 	__u64	pref_address;
 	__u32	init_size;
 	__u32	handover_offset;
-	__u64	acpi_rsdp_addr;
 } __attribute__((packed));
 
 struct sys_desc_table {
@@ -159,7 +155,8 @@ struct boot_params {
 	__u8  _pad2[4];					/* 0x054 */
 	__u64  tboot_addr;				/* 0x058 */
 	struct ist_info ist_info;			/* 0x060 */
-	__u8  _pad3[16];				/* 0x070 */
+	__u64 acpi_rsdp_addr;				/* 0x070 */
+	__u8  _pad3[8];					/* 0x078 */
 	__u8  hd0_info[16];	/* obsolete! */		/* 0x080 */
 	__u8  hd1_info[16];	/* obsolete! */		/* 0x090 */
 	struct sys_desc_table sys_desc_table; /* obsolete! */	/* 0x0a0 */
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 92c76bf97ad8..06635fbca81c 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1776,5 +1776,5 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 
 u64 x86_default_get_root_pointer(void)
 {
-	return boot_params.hdr.acpi_rsdp_addr;
+	return boot_params.acpi_rsdp_addr;
 }
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index dd33c357548f..e12454e21b8a 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -56,7 +56,7 @@
 /* Threshold LVT offset is at MSR0xC0000410[15:12] */
 #define SMCA_THR_LVT_OFF	0xF000
 
-static bool thresholding_en;
+static bool thresholding_irq_en;
 
 static const char * const th_names[] = {
 	"load_store",
@@ -534,9 +534,8 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 
 set_offset:
 	offset = setup_APIC_mce_threshold(offset, new);
-
-	if ((offset == new) && (mce_threshold_vector != amd_threshold_interrupt))
-		mce_threshold_vector = amd_threshold_interrupt;
+	if (offset == new)
+		thresholding_irq_en = true;
 
 done:
 	mce_threshold_block_init(&b, offset);
@@ -1357,9 +1356,6 @@ int mce_threshold_remove_device(unsigned int cpu)
 {
 	unsigned int bank;
 
-	if (!thresholding_en)
-		return 0;
-
 	for (bank = 0; bank < mca_cfg.banks; ++bank) {
 		if (!(per_cpu(bank_map, cpu) & (1 << bank)))
 			continue;
@@ -1377,9 +1373,6 @@ int mce_threshold_create_device(unsigned int cpu)
 	struct threshold_bank **bp;
 	int err = 0;
 
-	if (!thresholding_en)
-		return 0;
-
 	bp = per_cpu(threshold_banks, cpu);
 	if (bp)
 		return 0;
@@ -1408,9 +1401,6 @@ static __init int threshold_init_device(void)
 {
 	unsigned lcpu = 0;
 
-	if (mce_threshold_vector == amd_threshold_interrupt)
-		thresholding_en = true;
-
 	/* to hit CPUs online before the notifier is up */
 	for_each_online_cpu(lcpu) {
 		int err = mce_threshold_create_device(lcpu);
@@ -1419,6 +1409,9 @@ static __init int threshold_init_device(void)
 			return err;
 	}
 
+	if (thresholding_irq_en)
+		mce_threshold_vector = amd_threshold_interrupt;
+
 	return 0;
 }
 /*
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 61a949d84dfa..d99a8ee9e185 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -344,10 +344,10 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			sanitize_restored_xstate(tsk, &env, xfeatures, fx_only);
 		}
 
+		local_bh_disable();
 		fpu->initialized = 1;
-		preempt_disable();
 		fpu__restore(fpu);
-		preempt_enable();
+		local_bh_enable();
 
 		return err;
 	} else {
diff --git a/arch/x86/kernel/head32.c b/arch/x86/kernel/head32.c
index 76fa3b836598..ec6fefbfd3c0 100644
--- a/arch/x86/kernel/head32.c
+++ b/arch/x86/kernel/head32.c
@@ -37,7 +37,6 @@ asmlinkage __visible void __init i386_start_kernel(void)
 	cr4_init_shadow();
 
 	sanitize_boot_params(&boot_params);
-	x86_verify_bootdata_version();
 
 	x86_early_init_platform_quirks();
 
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 7663a8eb602b..16b1cbd3a61e 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -457,8 +457,6 @@ void __init x86_64_start_reservations(char *real_mode_data)
 	if (!boot_params.hdr.version)
 		copy_bootdata(__va(real_mode_data));
 
-	x86_verify_bootdata_version();
-
 	x86_early_init_platform_quirks();
 
 	switch (boot_params.hdr.hardware_subarch) {
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b74e7bfed6ab..d494b9bfe618 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1280,23 +1280,6 @@ void __init setup_arch(char **cmdline_p)
 	unwind_init();
 }
 
-/*
- * From boot protocol 2.14 onwards we expect the bootloader to set the
- * version to "0x8000 | <used version>". In case we find a version >= 2.14
- * without the 0x8000 we assume the boot loader supports 2.13 only and
- * reset the version accordingly. The 0x8000 flag is removed in any case.
- */
-void __init x86_verify_bootdata_version(void)
-{
-	if (boot_params.hdr.version & VERSION_WRITTEN)
-		boot_params.hdr.version &= ~VERSION_WRITTEN;
-	else if (boot_params.hdr.version >= 0x020e)
-		boot_params.hdr.version = 0x020d;
-
-	if (boot_params.hdr.version < 0x020e)
-		boot_params.hdr.acpi_rsdp_addr = 0;
-}
-
 #ifdef CONFIG_X86_32
 
 static struct resource video_ram_resource = {
diff --git a/include/linux/tracehook.h b/include/linux/tracehook.h
index 40b0b4c1bf7b..df20f8bdbfa3 100644
--- a/include/linux/tracehook.h
+++ b/include/linux/tracehook.h
@@ -83,8 +83,8 @@ static inline int ptrace_report_syscall(struct pt_regs *regs)
  * tracehook_report_syscall_entry - task is about to attempt a system call
  * @regs:		user register state of current task
  *
- * This will be called if %TIF_SYSCALL_TRACE has been set, when the
- * current task has just entered the kernel for a system call.
+ * This will be called if %TIF_SYSCALL_TRACE or %TIF_SYSCALL_EMU have been set,
+ * when the current task has just entered the kernel for a system call.
  * Full user register state is available here.  Changing the values
  * in @regs can affect the system call number and arguments to be tried.
  * It is safe to block here, preventing the system call from beginning.
