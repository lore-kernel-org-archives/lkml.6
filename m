Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeEBOs4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:48:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56235 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEBOsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:48:51 -0400
Date: Wed, 2 May 2018 07:48:45 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-c65732e4f72124ca5a3a0dd3bee0d3cee39c7170@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tim.c.chen@linux.intel.com, jrg.otte@gmail.com, mingo@kernel.org,
        hpa@zytor.com, torvalds@linux-foundation.org
Reply-To: mingo@kernel.org, tim.c.chen@linux.intel.com, jrg.otte@gmail.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, hpa@zytor.com
In-Reply-To: <alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/cpu: Restore CPUID_8000_0008_EBX reload
Git-Commit-ID: c65732e4f72124ca5a3a0dd3bee0d3cee39c7170
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

Commit-ID:  c65732e4f72124ca5a3a0dd3bee0d3cee39c7170
Gitweb:     https://git.kernel.org/tip/c65732e4f72124ca5a3a0dd3bee0d3cee39c7170
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Mon, 30 Apr 2018 21:47:46 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 2 May 2018 16:44:38 +0200

x86/cpu: Restore CPUID_8000_0008_EBX reload

The recent commt which addresses the x86_phys_bits corruption with
encrypted memory on CPUID reload after a microcode update lost the reload
of CPUID_8000_0008_EBX as well.

As a consequence IBRS and IBRS_FW are not longer detected

Restore the behaviour by bringing the reload of CPUID_8000_0008_EBX
back. This restore has a twist due to the convoluted way the cpuid analysis
works:

CPUID_8000_0008_EBX is used by AMD to enumerate IBRB, IBRS, STIBP. On Intel
EBX is not used. But the speculation control code sets the AMD bits when
running on Intel depending on the Intel specific speculation control
bits. This was done to use the same bits for alternatives.

The change which moved the 8000_0008 evaluation out of get_cpu_cap() broke
this nasty scheme due to ordering. So that on Intel the store to
CPUID_8000_0008_EBX clears the IBRB, IBRS, STIBP bits which had been set
before by software.

So the actual CPUID_8000_0008_EBX needs to go back to the place where it
was and the phys/virt address space calculation cannot touch it.

In hindsight this should have used completely synthetic bits for IBRB,
IBRS, STIBP instead of reusing the AMD bits, but that's for 4.18.

/me needs to find time to cleanup that steaming pile of ...

Fixes: d94a155c59c9 ("x86/cpu: Prevent cpuinfo_x86::x86_phys_bits adjustment corruption")
Reported-by: Jörg Otte <jrg.otte@gmail.com>
Reported-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jörg Otte <jrg.otte@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kirill.shutemov@linux.intel.com
Cc: Borislav Petkov <bp@alien8.de
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1805021043510.1668@nanos.tec.linutronix.de
---
 arch/x86/kernel/cpu/common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8a5b185735e1..ce243f7d2d4e 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -848,6 +848,11 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_power = edx;
 	}
 
+	if (c->extended_cpuid_level >= 0x80000008) {
+		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
+		c->x86_capability[CPUID_8000_0008_EBX] = ebx;
+	}
+
 	if (c->extended_cpuid_level >= 0x8000000a)
 		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
 
@@ -871,7 +876,6 @@ static void get_cpu_address_sizes(struct cpuinfo_x86 *c)
 
 		c->x86_virt_bits = (eax >> 8) & 0xff;
 		c->x86_phys_bits = eax & 0xff;
-		c->x86_capability[CPUID_8000_0008_EBX] = ebx;
 	}
 #ifdef CONFIG_X86_32
 	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
