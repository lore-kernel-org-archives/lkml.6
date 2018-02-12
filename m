Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932791AbeBLXpt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 18:45:49 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35205 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932469AbeBLXps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 18:45:48 -0500
X-Google-Smtp-Source: AH8x2272Fmrb5CStSUZXhuy20t92V+TWichHLfZTI2x247H53OjqEjx4X8hkts9BwXNB7yUIgvL2Bw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: tchalamarla@cavium.com, rrichter@cavium.com, timur@codeaurora.org,
        opendmb@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm64: Make L1_CACHE_SHIFT configurable
Date: Mon, 12 Feb 2018 15:45:23 -0800
Message-Id: <1518479125-14428-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On many platforms, including, but not limited to Brahma-B53 platforms,
the L1 cache line size is 64bytes. Increasing the value to 128bytes
appears to be creating performance problems for workloads involving
network drivers and lots of data movement. In order to keep what was
introduced with 97303480753e ("arm64: Increase the max granular size"),
a kernel built for ARCH_THUNDER or ARCH_THUNDER2 will get a 128bytes
cache line size definition.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm64/Kconfig             | 10 ++++++++++
 arch/arm64/Kconfig.platforms   |  2 ++
 arch/arm64/include/asm/cache.h |  2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b488076d63c2..8060cbbbfd77 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -782,6 +782,16 @@ config ARCH_WANT_HUGE_PMD_SHARE
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
+config ARM64_L1_CACHE_SHIFT_7
+	bool
+	help
+	  Setting ARM64 L1 cache line size to 128 bytes.
+
+config ARM64_L1_CACHE_SHIFT
+	int
+	default 7 if ARM64_L1_CACHE_SHIFT_7
+	default 6
+
 source "mm/Kconfig"
 
 config SECCOMP
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 2401373565ff..b595f5624f75 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -228,11 +228,13 @@ config ARCH_SPRD
 
 config ARCH_THUNDER
 	bool "Cavium Inc. Thunder SoC Family"
+	select ARM64_L1_CACHE_SHIFT_7
 	help
 	  This enables support for Cavium's Thunder Family of SoCs.
 
 config ARCH_THUNDER2
 	bool "Cavium ThunderX2 Server Processors"
+	select ARM64_L1_CACHE_SHIFT_7
 	select GPIOLIB
 	help
 	  This enables support for Cavium's ThunderX2 CN99XX family of
diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index ea9bb4e0e9bb..2ff64929e6bd 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -29,7 +29,7 @@
 #define ICACHE_POLICY_VIPT	2
 #define ICACHE_POLICY_PIPT	3
 
-#define L1_CACHE_SHIFT		7
+#define L1_CACHE_SHIFT		CONFIG_ARM64_L1_CACHE_SHIFT
 #define L1_CACHE_BYTES		(1 << L1_CACHE_SHIFT)
 
 /*
-- 
2.7.4
