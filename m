Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754083AbeBUST2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 13:19:28 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:35330 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752677AbeBUSSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 13:18:33 -0500
X-Google-Smtp-Source: AH8x227ADJ4pEU9jk/DANpgB9SucaAxGaOcV49hmNOZYSSdiApAE+zGpcEVR0SaIosHw/5K2Ep9ZAw==
From: Kees Cook <keescook@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kees Cook <keescook@chromium.org>, Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>, Will Deacon <will.deacon@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: cpufeature: Relocate PAN emulation report
Date: Wed, 21 Feb 2018 10:18:21 -0800
Message-Id: <1519237102-46854-2-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1519237102-46854-1-git-send-email-keescook@chromium.org>
References: <1519237102-46854-1-git-send-email-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PAN emulation notification was only happening for non-boot CPUs
if CPU capabilities had already been configured. This seems to be the
wrong place, as it's system-wide and isn't attached to capabilities,
so its reporting didn't normally happen. Instead, report it once from
the boot CPU.

Before (missing PAN emulation report):

 SMP: Total of 4 processors activated.
 CPU features: detected feature: 32-bit EL0 Support
 CPU features: detected feature: Kernel page table isolation (KPTI)
 CPU: All CPU(s) started at EL2

After:

 SMP: Total of 4 processors activated.
 CPU features: detected feature: 32-bit EL0 Support
 CPU features: detected feature: Kernel page table isolation (KPTI)
 CPU features: emulated: Privileged Access Never (PAN) using TTBR0_EL1 switching
 CPU: All CPU(s) started at EL2

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 29b1f873e337..61aff55245ea 100644
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
