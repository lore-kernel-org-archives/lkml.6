Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964932AbeBPL1N (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 06:27:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50346 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964872AbeBPL0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 06:26:53 -0500
From: Borislav Petkov <bp@alien8.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] x86/CPU: Check CPU feature bits after microcode upgrade
Date: Fri, 16 Feb 2018 12:26:40 +0100
Message-Id: <20180216112640.11554-4-bp@alien8.de>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20180216112640.11554-1-bp@alien8.de>
References: <20180216112640.11554-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

With some microcode upgrades, new CPUID features can become visible on
the CPU. Check what the kernel has mirrored now and issue a warning
hinting at possible things the user/admin can do to make use of the
newly visible features.

Originally-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/common.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 82c142b33bf3..768eb680db8d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1757,5 +1757,25 @@ core_initcall(init_cpu_syscore);
  */
 void microcode_check(void)
 {
+	struct cpuinfo_x86 info;
+
 	perf_check_microcode();
+
+	/* Reload CPUID max function as it might've changed. */
+	info.cpuid_level = cpuid_eax(0);
+
+	/*
+	 * Copy all capability leafs to pick up the synthetic ones so that
+	 * memcmp() below doesn't fail on that. The ones coming from CPUID will
+	 * get overwritten in get_cpu_cap().
+	 */
+	memcpy(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability));
+
+	get_cpu_cap(&info);
+
+	if (!memcmp(&info.x86_capability, &boot_cpu_data.x86_capability, sizeof(info.x86_capability)))
+		return;
+
+	pr_warn("x86/CPU: CPU features have changed after loading microcode, but might not take effect.\n");
+	pr_warn("x86/CPU: Please consider either early loading through initrd/built-in or a potential BIOS update.\n");
 }
-- 
2.13.0
