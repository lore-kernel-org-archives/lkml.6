Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033150AbeE0Pts (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 11:49:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:28383 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032739AbeE0PqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 11:46:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,448,1520924400";
   d="scan'208";a="227741076"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>
Cc: "Ashok Raj" <ashok.raj@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Tony Luck" <tony.luck@intel.com>, "Alan Cox" <alan@linux.intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>, "x86" <x86@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [RFC PATCH 05/16] x86/split_lock: Use non atomic set and clear bit instructions in clear_cpufeature()
Date: Sun, 27 May 2018 08:45:54 -0700
Message-Id: <1527435965-202085-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
References: <1527435965-202085-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_capability can span two cache lines depending on kernel configuration
and building environment. When #AC exception is enabled for split locked
accesses, clear_cpufeature() may generate #AC exception because of atomic
setting or clearing bits in x86_capability.

But kernel clears cpufeature only during a CPU is booting up. Therefore,
there is no racing condition when clear_cpufeature() is called and no need
to atomically clear or set bits in x86_capability.

To avoid #AC exception caused by split lock, call non atomic __set_bit()
and __clear_bit(). They are faster than atomic set_bit() and clear_bit()
as well.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 2c0bd38a44ab..b2c2a004c769 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -65,15 +65,15 @@ static const struct cpuid_dep cpuid_deps[] = {
 static inline void clear_feature(struct cpuinfo_x86 *c, unsigned int feature)
 {
 	/*
-	 * Note: This could use the non atomic __*_bit() variants, but the
-	 * rest of the cpufeature code uses atomics as well, so keep it for
-	 * consistency. Cleanup all of it separately.
+	 * Because this code is only called during boot time and there
+	 * is no need to be atomic, use non atomic __*_bit() for better
+	 * performance and to avoid #AC exception for split locked access.
 	 */
 	if (!c) {
 		clear_cpu_cap(&boot_cpu_data, feature);
-		set_bit(feature, (unsigned long *)cpu_caps_cleared);
+		__set_bit(feature, (unsigned long *)cpu_caps_cleared);
 	} else {
-		clear_bit(feature, (unsigned long *)c->x86_capability);
+		__clear_bit(feature, (unsigned long *)c->x86_capability);
 	}
 }
 
-- 
2.5.0
