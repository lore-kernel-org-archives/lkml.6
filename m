Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755995AbeCHPBD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 10:01:03 -0500
Received: from terminus.zytor.com ([198.137.202.136]:46135 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755565AbeCHPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 10:01:00 -0500
Date: Thu, 8 Mar 2018 07:00:49 -0800
From: tip-bot for Borislav Petkov <tipbot@zytor.com>
Message-ID: <tip-24193c5de470358d0ed70e1f8e58fdaf83823b95@git.kernel.org>
Cc: bp@suse.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com, tglx@linutronix.de, tony.luck@intel.com
Reply-To: hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bp@suse.de, tglx@linutronix.de, tony.luck@intel.com
In-Reply-To: <20180306142143.19990-3-bp@alien8.de>
References: <20180306142143.19990-3-bp@alien8.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE: Cleanup and complete struct mce fields
 definitions
Git-Commit-ID: 24193c5de470358d0ed70e1f8e58fdaf83823b95
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  24193c5de470358d0ed70e1f8e58fdaf83823b95
Gitweb:     https://git.kernel.org/tip/24193c5de470358d0ed70e1f8e58fdaf83823b95
Author:     Borislav Petkov <bp@suse.de>
AuthorDate: Tue, 6 Mar 2018 15:21:42 +0100
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 8 Mar 2018 15:52:59 +0100

x86/MCE: Cleanup and complete struct mce fields definitions

The struct is part of the uapi, document that fact and all fields properly
and fix formatting.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20180306142143.19990-3-bp@alien8.de
---
 arch/x86/include/uapi/asm/mce.h | 52 ++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/uapi/asm/mce.h b/arch/x86/include/uapi/asm/mce.h
index 435db58a7bad..955c2a2e1cf9 100644
--- a/arch/x86/include/uapi/asm/mce.h
+++ b/arch/x86/include/uapi/asm/mce.h
@@ -5,32 +5,36 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
-/* Fields are zero when not available */
+/*
+ * Fields are zero when not available. Also, this struct is shared with
+ * userspace mcelog and thus must keep existing fields at current offsets.
+ * Only add new fields to the end of the structure
+ */
 struct mce {
-	__u64 status;
-	__u64 misc;
-	__u64 addr;
-	__u64 mcgstatus;
-	__u64 ip;
-	__u64 tsc;	/* cpu time stamp counter */
-	__u64 time;	/* wall time_t when error was detected */
-	__u8  cpuvendor;	/* cpu vendor as encoded in system.h */
-	__u8  inject_flags;	/* software inject flags */
-	__u8  severity;
+	__u64 status;		/* Bank's MCi_STATUS MSR */
+	__u64 misc;		/* Bank's MCi_MISC MSR */
+	__u64 addr;		/* Bank's MCi_ADDR MSR */
+	__u64 mcgstatus;	/* Machine Check Global Status MSR */
+	__u64 ip;		/* Instruction Pointer when the error happened */
+	__u64 tsc;		/* CPU time stamp counter */
+	__u64 time;		/* Wall time_t when error was detected */
+	__u8  cpuvendor;	/* Kernel's X86_VENDOR enum */
+	__u8  inject_flags;	/* Software inject flags */
+	__u8  severity;		/* Error severity */
 	__u8  pad;
-	__u32 cpuid;	/* CPUID 1 EAX */
-	__u8  cs;		/* code segment */
-	__u8  bank;	/* machine check bank */
-	__u8  cpu;	/* cpu number; obsolete; use extcpu now */
-	__u8  finished;   /* entry is valid */
-	__u32 extcpu;	/* linux cpu number that detected the error */
-	__u32 socketid;	/* CPU socket ID */
-	__u32 apicid;	/* CPU initial apic ID */
-	__u64 mcgcap;	/* MCGCAP MSR: machine check capabilities of CPU */
-	__u64 synd;	/* MCA_SYND MSR: only valid on SMCA systems */
-	__u64 ipid;	/* MCA_IPID MSR: only valid on SMCA systems */
-	__u64 ppin;	/* Protected Processor Inventory Number */
-	__u32 microcode;/* Microcode revision */
+	__u32 cpuid;		/* CPUID 1 EAX */
+	__u8  cs;		/* Code segment */
+	__u8  bank;		/* Machine check bank reporting the error */
+	__u8  cpu;		/* CPU number; obsoleted by extcpu */
+	__u8  finished;		/* Entry is valid */
+	__u32 extcpu;		/* Linux CPU number that detected the error */
+	__u32 socketid;		/* CPU socket ID */
+	__u32 apicid;		/* CPU initial APIC ID */
+	__u64 mcgcap;		/* MCGCAP MSR: machine check capabilities of CPU */
+	__u64 synd;		/* MCA_SYND MSR: only valid on SMCA systems */
+	__u64 ipid;		/* MCA_IPID MSR: only valid on SMCA systems */
+	__u64 ppin;		/* Protected Processor Inventory Number */
+	__u32 microcode;	/* Microcode revision */
 };
 
 #define MCE_GET_RECORD_LEN   _IOR('M', 1, int)
