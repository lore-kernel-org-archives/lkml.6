Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeENSyT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:54:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:55033 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752019AbeENSwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:52:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="39244631"
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
Subject: [PATCH 04/15] x86/split_lock: Use non locked bit set instruction in set_cpu_cap
Date: Mon, 14 May 2018 11:52:14 -0700
Message-Id: <1526323945-211107-5-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
References: <1526323945-211107-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_bit() called by set_cpu_cap() is a locked bit set instruction for
atomic operation.

Since the c->x86_capability is not aligned to cache line depending on
compiler, the locked bit set instruction falls into split lock
situation which causes #AC exception when #AC exception is enabled by
split locked accesses.

But set_cpu_cap() is only called in early init phase on a CPU and
therefore there is no contention for set_cpu_cap(). So it's unnecessary
to be atomic operation.

Using __set_bit(), which is not a locked instruction, can fix the
kernel split lock issue and is faster than locked instruction.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Dave Hansen <dave.hansen@intel.com>
---
 arch/x86/include/asm/cpufeature.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index b27da9602a6d..604f4c514efa 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -128,7 +128,8 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 
 #define boot_cpu_has(bit)	cpu_has(&boot_cpu_data, bit)
 
-#define set_cpu_cap(c, bit)	set_bit(bit, (unsigned long *)((c)->x86_capability))
+#define set_cpu_cap(c, bit)	\
+	__set_bit(bit, (unsigned long *)((c)->x86_capability))
 
 extern void setup_clear_cpu_cap(unsigned int bit);
 extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
-- 
2.5.0
