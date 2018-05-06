Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751572AbeEFIDY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 04:03:24 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47173 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751091AbeEFIDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 04:03:20 -0400
Date: Sun, 6 May 2018 10:03:18 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] x86 fix for 4.17
Message-ID: <alpine.DEB.2.21.1805060959310.1685@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

Unbreak the CPUID CPUID_8000_0008_EBX reload which got dropped when the
evaluation of physical and virtual bits which uses the same CPUID leaf was
moved out of get_cpu_cap(),

Thanks,

	tglx

------------------>
Thomas Gleixner (1):
      x86/cpu: Restore CPUID_8000_0008_EBX reload


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
