Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeBTWAi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 17:00:38 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54489 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeBTWAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 17:00:23 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Nicolas Pitre <nico@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 5/7] ARM: fix __inflate_kernel_data stack warning for LTO
Date: Tue, 20 Feb 2018 22:59:52 +0100
Message-Id: <20180220215954.4092811-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220215954.4092811-1-arnd@arndb.de>
References: <20180220215954.4092811-1-arnd@arndb.de>
X-Provags-ID: V03:K0:j6Z6mLTdh/+X4G+YKxS3ATVR3daU4zabNyhWk408l8/5Z67spBE
 n0pCT5KxKMZP6OlGOXCaY4YuZzd5g3HbUizruyCE50CaCAsxfBFR9jVQ4Eu2LQsolfPl3G4
 q3lDsZjZcv6hmaVQ7MDfjV1cRrs+BKjiSgFpfI70u5wuuA7+ZFfD31tcTE5lxsh/AJs95E6
 TVpmCU33xqIXuheIpHF2w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4WRBaSnnQvU=:Rj3TLw5/GN9ssMjC4jMoO+
 iJAgM4VFA9XC0WrCQzLMPzyCikr01S4ZHDiLzLhvAJtk7YgoBk2PT9lxQJman5mdq5/af5tGn
 3ql21rvSJJ0xC3ANc92k4Lqr9s08WU5lVyaQZLwKz+ASlmtfsDL1h3NPAoKdYD2WWfmlonC8+
 QUPWpbFZDHp1HJKKZVrrQ8oO8+UgrgFsJWwoUcglUVxBV0PhB5vcXtWUJhAIZtA9vJDVOJQ9t
 Wf7h40IIfXWSoG3NKg5r7JISuRX+0ByIt0unvE8VBsAqVORyYxP8/LYsHc61g35LTEd/YKxkv
 4T+m5/p+pEBe5MzwHI3L6YxeDp7KaNkAUDhMgVGc4sAzAKu+gGvU2egPBwTVUp3cl5Gcq3yaM
 y+DaSTZF5gH9DyFXB4Bv8+fa04aUPN9ydwfRkEIWL5O/itpPcpuCOdqmxcoNxgW1u2jXsmTwP
 ovpKnXAQJgWSoDJwEHt+5c4XLriKEI6StcFm8HWHnFpdB0iMZBJvHotp5Yjk+pZkIGu46zuG2
 qLtNx7IVmUiLhJQOYTivJSTrbcJ0VZ4Z9eXgrG+XV5VAeIky8nkr1Y4/2LRLevJVrl0jHgC1c
 ZhAYFCbzVYWbeDIRwK2bLgaWjLpkUJZ3HiO3A1fbiP9opg6mmCvJ98gEKzGnEFxjmDiRLvWjO
 LQu1/b6NGv7fRPNWRypRDVfEkuOuFHC4V7b17fsaRAafjZEJJOQXscsGdhP2HHIS9sfpKvMVD
 uICgi2PPEX47Gk4KJAbG4ClxS+ylAqiRs/0vIKiGQK037s+SKZPSMj3zqtTgnEE2B8yk/54XM
 HriashmaS2qdVjIahAci/6kBIDH95HMogzKRiB8hwSCkovlhaporkLeFgISLQvt0+ZO5ZFQWa
 gecCpyUtrUkN5HTIRhPXmEkv1O3/XalFke0PxR7ZHM3Xsbw3QI/qQW8frYnauG
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ca8b5d97d6bf ("ARM: XIP kernel: store .data compressed in ROM")
moved the decompressor workspace to the stack and added a compiler
flag to avoid the stack size warning.

With LTO, that warning comes back. Moving the workspace into an initdata
variable avoids that warning but presumably also undoes the optimization.

We could also try disabling the warning locally in that file with
_Pragma("GCC disagnostic"), but we lack a little bit of infrastructure
to do that nicely.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/kernel/Makefile            | 3 ---
 arch/arm/kernel/head-inflate-data.c | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index b59ac4bf82b8..2e8d40d442a2 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -88,9 +88,6 @@ head-y			:= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
-# This is executed very early using a temporary stack when no memory allocator
-# nor global data is available. Everything has to be allocated on the stack.
-CFLAGS_head-inflate-data.o := $(call cc-option,-Wframe-larger-than=10240)
 obj-$(CONFIG_XIP_DEFLATED_DATA) += head-inflate-data.o
 
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
diff --git a/arch/arm/kernel/head-inflate-data.c b/arch/arm/kernel/head-inflate-data.c
index 6dd0ce5e6058..b208c4541bd1 100644
--- a/arch/arm/kernel/head-inflate-data.c
+++ b/arch/arm/kernel/head-inflate-data.c
@@ -35,10 +35,11 @@ extern char _sdata[];
  * stack then there is no need to clean up before returning.
  */
 
+static __initdata struct inflate_state state;
+
 int __init __inflate_kernel_data(void)
 {
 	struct z_stream_s stream, *strm = &stream;
-	struct inflate_state state;
 	char *in = __data_loc;
 	int rc;
 
-- 
2.9.0
