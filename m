Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbeBTWq2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:46:28 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46019 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750884AbeBTWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:46:27 -0500
X-Google-Smtp-Source: AH8x226orPH4l1F1TsyqrFiEO6UIjPNRV/JSbl22aj4s36sgxC+GXk+glF0eYQGnoPBUKVjti6sOZA==
Date: Tue, 20 Feb 2018 14:46:24 -0800
From: Kees Cook <keescook@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: cpufeature: Trim feature reporting and include PAN
 emulation
Message-ID: <20180220224624.GA28218@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PAN emulation notification was only happening for non-boot CPUs
if CPU capabilities had already been configured. This seems to be the
wrong place, as it's system-wide and isn't attached to capabilities,
so its reporting didn't normally happen. Instead, report it once from
the boot CPU. Additionally removes the redundant "feature" word from the
"CPU features:" line.

Before (redundant "feature", and missing PAN emulation report):

 SMP: Total of 4 processors activated.
 CPU features: detected feature: 32-bit EL0 Support
 CPU features: detected feature: Kernel page table isolation (KPTI)
 CPU: All CPU(s) started at EL2

After:

 SMP: Total of 4 processors activated.
 CPU features: detected: 32-bit EL0 Support
 CPU features: detected: Kernel page table isolation (KPTI)
 CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
 CPU: All CPU(s) started at EL2

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/cpufeature.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 29b1f873e337..6c799ca58b53 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1333,9 +1333,6 @@ static void verify_local_cpu_capabilities(void)
 
 	if (system_supports_sve())
 		verify_sve_features();
-
-	if (system_uses_ttbr0_pan())
-		pr_info("Emulating Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
 }
 
 void check_local_cpu_capabilities(void)
@@ -1360,7 +1357,7 @@ void check_local_cpu_capabilities(void)
 
 static void __init setup_feature_capabilities(void)
 {
-	update_cpu_capabilities(arm64_features, "detected feature:");
+	update_cpu_capabilities(arm64_features, "detected:");
 	enable_cpu_capabilities(arm64_features);
 }
 
@@ -1394,6 +1391,9 @@ void __init setup_cpu_features(void)
 	if (system_supports_32bit_el0())
 		setup_elf_hwcaps(compat_elf_hwcaps);
 
+	if (system_uses_ttbr0_pan())
+		pr_info("emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching\n");
+
 	sve_setup();
 
 	/* Advertise that we have computed the system capabilities */
-- 
2.7.4


-- 
Kees Cook
Pixel Security
