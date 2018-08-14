Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2694C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD8621728
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD8621728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388443AbeHNUO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:14:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51972 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387440AbeHNUO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:14:28 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D84D6CEA;
        Tue, 14 Aug 2018 17:26:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 4.18 33/79] Revert "x86/apic: Ignore secondary threads if nosmt=force"
Date:   Tue, 14 Aug 2018 19:16:52 +0200
Message-Id: <20180814171338.069745410@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171336.799314117@linuxfoundation.org>
References: <20180814171336.799314117@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

Dave Hansen reported, that it's outright dangerous to keep SMT siblings
disabled completely so they are stuck in the BIOS and wait for SIPI.

The reason is that Machine Check Exceptions are broadcasted to siblings and
the soft disabled sibling has CR4.MCE = 0. If a MCE is delivered to a
logical core with CR4.MCE = 0, it asserts IERR#, which shuts down or
reboots the machine. The MCE chapter in the SDM contains the following
blurb:

    Because the logical processors within a physical package are tightly
    coupled with respect to shared hardware resources, both logical
    processors are notified of machine check errors that occur within a
    given physical processor. If machine-check exceptions are enabled when
    a fatal error is reported, all the logical processors within a physical
    package are dispatched to the machine-check exception handler. If
    machine-check exceptions are disabled, the logical processors enter the
    shutdown state and assert the IERR# signal. When enabling machine-check
    exceptions, the MCE flag in control register CR4 should be set for each
    logical processor.

Reverting the commit which ignores siblings at enumeration time solves only
half of the problem. The core cpuhotplug logic needs to be adjusted as
well.

This thoughtful engineered mechanism also turns the boot process on all
Intel HT enabled systems into a MCE lottery. MCE is enabled on the boot CPU
before the secondary CPUs are brought up. Depending on the number of
physical cores the window in which this situation can happen is smaller or
larger. On a HSW-EX it's about 750ms:

MCE is enabled on the boot CPU:

[    0.244017] mce: CPU supports 22 MCE banks

The corresponding sibling #72 boots:

[    1.008005] .... node  #0, CPUs:    #72

That means if an MCE hits on physical core 0 (logical CPUs 0 and 72)
between these two points the machine is going to shutdown. At least it's a
known safe state.

It's obvious that the early boot can be hit by an MCE as well and then runs
into the same situation because MCEs are not yet enabled on the boot CPU.
But after enabling them on the boot CPU, it does not make any sense to
prevent the kernel from recovering.

Adjust the nosmt kernel parameter documentation as well.

Reverts: 2207def700f9 ("x86/apic: Ignore secondary threads if nosmt=force")
Reported-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/admin-guide/kernel-parameters.txt |    8 ++------
 arch/x86/include/asm/apic.h                     |    2 --
 arch/x86/kernel/acpi/boot.c                     |    3 +--
 arch/x86/kernel/apic/apic.c                     |   19 -------------------
 4 files changed, 3 insertions(+), 29 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2688,12 +2688,8 @@
 			Equivalent to smt=1.
 
 			[KNL,x86] Disable symmetric multithreading (SMT).
-			nosmt=force: Force disable SMT, similar to disabling
-				     it in the BIOS except that some of the
-				     resource partitioning effects which are
-				     caused by having SMT enabled in the BIOS
-				     cannot be undone. Depending on the CPU
-				     type this might have a performance impact.
+			nosmt=force: Force disable SMT, cannot be undone
+				     via the sysfs control file.
 
 	nospectre_v2	[X86] Disable all mitigations for the Spectre variant 2
 			(indirect branch prediction) vulnerability. System may
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -504,10 +504,8 @@ extern int default_check_phys_apicid_pre
 
 #ifdef CONFIG_SMP
 bool apic_id_is_primary_thread(unsigned int id);
-bool apic_id_disabled(unsigned int id);
 #else
 static inline bool apic_id_is_primary_thread(unsigned int id) { return false; }
-static inline bool apic_id_disabled(unsigned int id) { return false; }
 #endif
 
 extern void irq_enter(void);
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -181,8 +181,7 @@ static int acpi_register_lapic(int id, u
 	}
 
 	if (!enabled) {
-		if (!apic_id_disabled(id))
-			++disabled_cpus;
+		++disabled_cpus;
 		return -EINVAL;
 	}
 
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2207,16 +2207,6 @@ bool apic_id_is_primary_thread(unsigned
 	return !(apicid & mask);
 }
 
-/**
- * apic_id_disabled - Check whether APIC ID is disabled via SMT control
- * @id:	APIC ID to check
- */
-bool apic_id_disabled(unsigned int id)
-{
-	return (cpu_smt_control == CPU_SMT_FORCE_DISABLED &&
-		!apic_id_is_primary_thread(id));
-}
-
 /*
  * Should use this API to allocate logical CPU IDs to keep nr_logical_cpuids
  * and cpuid_to_apicid[] synchronized.
@@ -2312,15 +2302,6 @@ int generic_processor_info(int apicid, i
 		return -EINVAL;
 	}
 
-	/*
-	 * If SMT is force disabled and the APIC ID belongs to
-	 * a secondary thread, ignore it.
-	 */
-	if (apic_id_disabled(apicid)) {
-		pr_info_once("Ignoring secondary SMT threads\n");
-		return -EINVAL;
-	}
-
 	if (apicid == boot_cpu_physical_apicid) {
 		/*
 		 * x86_bios_cpu_apicid is required to have processors listed


