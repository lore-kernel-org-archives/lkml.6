Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751221AbeBTWAT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:00:19 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:50007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeBTWAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:00:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Nicolas Pitre <nico@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/7] ARM: LTO: avoid THUMB2_KERNEL+LTO
Date: Tue, 20 Feb 2018 22:59:49 +0100
Message-Id: <20180220215954.4092811-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
X-Provags-ID: V03:K0:u3KJWzqET9ns5Lg+m/MiDFxCNf+0k3MQUUUfTn6++ORQZePXN1j
 mi6mz90RJHWy+PVhAkmNYeriJ35b4438nHM6SFXwhRhgsyXBB96WYGpwm3QP2TEatBilBtx
 IAk8ErVh57EmlAbnHvtWBTTKfMwUJ6jXq0i/gjvgIhsnhQy1UZ2TMUr7fytlRBnhbH60/zW
 p8KUauJSv6ARo5IvkBcuw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lq2vHQPEv3M=:5SSk4VkGusr2hEy+y4tCo3
 eTpGu9WiFscv9HdHREs8x0QHu5x0jy/xu3meN1t+p4LeX000RpuTf23cyvUIp9ibKnqYK8B2q
 jSdGvNhJpmFjIzraWeeev6C8Y6YfWP4Jv+gA7DM6FxfV/RRjG9E1Ohs3WCqwPTuAyOUZxjg+t
 HzudzChvronAoGTK9P8cBSygtoZNqZUb4MTPQiCPOk9hXH1m4n8tNYX8Bx+Ts7hOeF0whtDPw
 4btdT87XipB+CIL/zLclhSTzN0vImmD8wnzQCtNRr7ijuitfbnykLWd5HroZQC3H0Bg8htsQL
 H+vsfKpZYAc/FCj2+ICIHNk9LKfjM/gdxylM3ex4QR28AKVQiXqXnvz4w7a8yXdtBJl/Q/U1q
 XeIUeYM3ygLyS8pzt3ELvplVHCLdRxtap9s89yHJdoGNwddES+RlcVFZFtSirOINeSq67+L3n
 TJdbvy+iJ26nVcF6IpcRXrDWeE6FwwO1JmOUVBBvtEIS2EA5h2eqyVzv1a90DSTpeKb9r5X26
 C39dbtdxmoIxX24WTuZpWVyhXruDUeOZ8FUtn2HiHOnHUFGiQ+kAHdR8XQUoUXR5zcEHXc7rf
 llH0nCtFeOvORdyHS5+TKSwR6J4kkwrJ5vgRd4znffaF12JtHl6Jt1zhC8g9kIWWIVT8cuvZL
 scppz2aNVch0hVvKBqzPn9T3wtVM9SAVy1o/+Y4OhWwRnd9Ik+tyPmt25ZEYZBMu9PRxVT7zd
 wS0eSnUaP6KWOdsq8K+dGUUy4s9VIN1mxoFWpQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to build an LTO-Enabled kernel with Thumb2 instructions failed
horribly for me, with an endless output of things like

ccVnNycO.s:2665: Error: thumb conditional instruction should be in IT block -- `bxne lr'
ccVnNycO.s:7128: Error: thumb conditional instruction should be in IT block -- `strexeq r5,r2,[r3]'
ccVnNycO.s:7258: Error: thumb conditional instruction should be in IT block -- `strexeq lr,r0,[r3]'
ccVnNycO.s:17380: Error: thumb conditional instruction should be in IT block -- `strexeq r1,r2,[r6]'
ccVnNycO.s:19163: Error: thumb conditional instruction should be in IT block -- `strexeq r8,r6,[r3]'
ccVnNycO.s:22722: Error: thumb conditional instruction should be in IT block -- `strexeq r7,r1,[r0]'
ccVnNycO.s:24105: conditional infixes are deprecated in unified syntax
ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `sbcccs r1,r1,r3'
ccVnNycO.s:24105: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'
ccVnNycO.s:24210: conditional infixes are deprecated in unified syntax
ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `sbcccs r2,r2,r3'
ccVnNycO.s:24210: Error: thumb conditional instruction should be in IT block -- `movcc r3,#0'

I did not investigate this too much, disabling Thumb2 support when LTO is
set lets me build randconfig kernels.

Since ARM_SINGLE_ARMV7M is Thumb2-only, I have to disallow LTO for V7-M
targets.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 8ed0f664f86f..fbf2c3ab9a97 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -18,7 +18,7 @@ config ARM
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
 	select ARCH_SUPPORTS_ATOMIC_RMW
-	select ARCH_SUPPORTS_LTO
+	select ARCH_SUPPORTS_LTO if !ARM_SINGLE_ARMV7M
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_WANT_IPC_PARSE_VERSION
@@ -1533,6 +1533,7 @@ config SCHED_HRTICK
 config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode" if !CPU_THUMBONLY
 	depends on (CPU_V7 || CPU_V7M) && !CPU_V6 && !CPU_V6K
+	depends on !LTO
 	default y if CPU_THUMBONLY
 	select ARM_UNWIND
 	help
-- 
2.9.0
