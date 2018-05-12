Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752049AbeELVMD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 17:12:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49797 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751806AbeELVMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 17:12:02 -0400
Date: Sat, 12 May 2018 14:11:54 -0700
From: tip-bot for Suravee Suthikulpanit <tipbot@zytor.com>
Message-ID: <tip-6c4f5abaf3566dbf5b26e7b14f4392be400f12e3@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com,
        suravee.suthikulpanit@amd.com, mingo@kernel.org, tglx@linutronix.de,
        bp@suse.de
Reply-To: bp@suse.de, tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com
In-Reply-To: <1524865681-112110-2-git-send-email-suravee.suthikulpanit@amd.com>
References: <1524865681-112110-2-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cpu] x86/CPU: Modify detect_extended_topology() to return
 result
Git-Commit-ID: 6c4f5abaf3566dbf5b26e7b14f4392be400f12e3
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

Commit-ID:  6c4f5abaf3566dbf5b26e7b14f4392be400f12e3
Gitweb:     https://git.kernel.org/tip/6c4f5abaf3566dbf5b26e7b14f4392be400f12e3
Author:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
AuthorDate: Fri, 27 Apr 2018 16:48:00 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sun, 6 May 2018 12:49:16 +0200

x86/CPU: Modify detect_extended_topology() to return result

Current implementation does not communicate whether it can successfully
detect CPUID function 0xB information. Therefore, modify the function to
return success or error codes. This will be used by subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: http://lkml.kernel.org/r/1524865681-112110-2-git-send-email-suravee.suthikulpanit@amd.com

---
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/kernel/cpu/topology.c   | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4fa4206029e3..7aa2caa82b2d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -193,7 +193,7 @@ extern u32 get_scattered_cpuid_leaf(unsigned int level,
 extern unsigned int init_intel_cacheinfo(struct cpuinfo_x86 *c);
 extern void init_amd_cacheinfo(struct cpuinfo_x86 *c);
 
-extern void detect_extended_topology(struct cpuinfo_x86 *c);
+extern int detect_extended_topology(struct cpuinfo_x86 *c);
 extern void detect_ht(struct cpuinfo_x86 *c);
 
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index b099024d339c..81c0afb39d0a 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -27,7 +27,7 @@
  * exists, use it for populating initial_apicid and cpu topology
  * detection.
  */
-void detect_extended_topology(struct cpuinfo_x86 *c)
+int detect_extended_topology(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_SMP
 	unsigned int eax, ebx, ecx, edx, sub_index;
@@ -36,7 +36,7 @@ void detect_extended_topology(struct cpuinfo_x86 *c)
 	static bool printed;
 
 	if (c->cpuid_level < 0xb)
-		return;
+		return -1;
 
 	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
 
@@ -44,7 +44,7 @@ void detect_extended_topology(struct cpuinfo_x86 *c)
 	 * check if the cpuid leaf 0xb is actually implemented.
 	 */
 	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE))
-		return;
+		return -1;
 
 	set_cpu_cap(c, X86_FEATURE_XTOPOLOGY);
 
@@ -95,6 +95,6 @@ void detect_extended_topology(struct cpuinfo_x86 *c)
 			       c->cpu_core_id);
 		printed = 1;
 	}
-	return;
 #endif
+	return 0;
 }
