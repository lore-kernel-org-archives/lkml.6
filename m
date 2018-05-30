Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753592AbeE3LeH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:34:07 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60822 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752352AbeE3LHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:02 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Yazen Ghannam" <yazen.ghannam@amd.com>,
        "linux-edac" <linux-edac@vger.kernel.org>,
        "Borislav Petkov" <bp@suse.de>, "Tony Luck" <tony.luck@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.250029342@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 119/153] x86/MCE: Save microcode revision in machine
 check records
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Luck <tony.luck@intel.com>

commit fa94d0c6e0f3431523f5701084d799c77c7d4a4f upstream.

Updating microcode used to be relatively rare. Now that it has become
more common we should save the microcode version in a machine check
record to make sure that those people looking at the error have this
important information bundled with the rest of the logged information.

[ Borislav: Simplify a bit. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac <linux-edac@vger.kernel.org>
Link: http://lkml.kernel.org/r/20180301233449.24311-1-tony.luck@intel.com
[bwh: Backported to 3.2:
 - Add other new fields to struct mce, to match upstream UAPI
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -76,6 +76,10 @@ struct mce {
 	__u32 socketid;	/* CPU socket ID */
 	__u32 apicid;	/* CPU initial apic ID */
 	__u64 mcgcap;	/* MCGCAP MSR: machine check capabilities of CPU */
+	__u64 synd;	/* MCA_SYND MSR: only valid on SMCA systems */
+	__u64 ipid;	/* MCA_IPID MSR: only valid on SMCA systems */
+	__u64 ppin;	/* Protected Processor Inventory Number */
+	__u32 microcode;/* Microcode revision */
 };
 
 /*
--- a/arch/x86/kernel/cpu/mcheck/mce.c
+++ b/arch/x86/kernel/cpu/mcheck/mce.c
@@ -125,6 +125,8 @@ void mce_setup(struct mce *m)
 	m->socketid = cpu_data(m->extcpu).phys_proc_id;
 	m->apicid = cpu_data(m->extcpu).initial_apicid;
 	rdmsrl(MSR_IA32_MCG_CAP, m->mcgcap);
+
+	m->microcode = boot_cpu_data.microcode;
 }
 
 DEFINE_PER_CPU(struct mce, injectm);
@@ -221,7 +223,7 @@ static void print_mce(struct mce *m)
 	 */
 	pr_emerg(HW_ERR "PROCESSOR %u:%x TIME %llu SOCKET %u APIC %x microcode %x\n",
 		m->cpuvendor, m->cpuid, m->time, m->socketid, m->apicid,
-		cpu_data(m->extcpu).microcode);
+		m->microcode);
 
 	/*
 	 * Print out human-readable details about the MCE error,
