Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeENSyS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:54:18 -0400
Received: from mga06.intel.com ([134.134.136.31]:55035 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbeENSwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244635"
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@linux.intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        "Arjan van de Ven" <arjan@infradead.org>,
        "Alan Cox" <alan@linux.intel.com>
Cc: "x86" <x86@kernel.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 05/15] x86/split_lock: Use non atomic set and clear bit instructions to clear cpufeature
Date: Mon, 14 May 2018 11:52:15 -0700
Message-Id: <1526323945-211107-6-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When #AC exception is enabled for split locked accesses,
clear_cpufeature() generates #AC exception because of atomic setting
or clearing bits in non cache line aligned x86_capability depending
on compiler.

But kernel clears cpufeatures only when a CPU boots up. Therefore, there
is no racing condition when clear_cpufeature() is called and no need to
atomically clear or set x86_capability.

To avoid #AC exception caused by split lock and get better performance,
call non atomic __set_bit() and __clear_bit().

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 arch/x86/kernel/cpu/cpuid-deps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 2c0bd38a44ab..0c02c6e44ea7 100644
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
+	 * is no need to be atomic, use non atomic __*_bit() to avoid
+	 * #AC exception for split locked access.
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
