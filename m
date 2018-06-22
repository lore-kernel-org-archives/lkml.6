Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB983C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABAD24979
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 22:49:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABAD24979
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754870AbeFVWta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 18:49:30 -0400
Received: from mga17.intel.com ([192.55.52.151]:52517 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754643AbeFVWmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 18:42:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jun 2018 15:42:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,259,1526367600"; 
   d="scan'208";a="234843470"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2018 15:42:48 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        vikas.shivappa@linux.intel.com
Cc:     gavin.hindman@intel.com, jithu.joseph@intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>, kbuild-all@01.org,
        tipbuild@zytor.com
Subject: [PATCH V7 40/41] x86/intel_rdt: Fix passing of value to 32-bit register
Date:   Fri, 22 Jun 2018 15:42:31 -0700
Message-Id: <2a3c3a9a1107224af78e6eaa6a7eabda71a4e5dd.1529706536.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1529706536.git.reinette.chatre@intel.com>
References: <cover.1529706536.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

0-day kbuild test robot reported the following issue:

   arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c: In function 'pseudo_lock_fn':
>> arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:363:1: warning: unsupported size for integer register
    }
    ^
>> arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c:363:1: warning: unsupported size for integer register

vim +363 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c

   361          wake_up_interruptible(&plr->lock_thread_wq);
   362          return 0;
 > 363  }
   364

The issue is earlier in the code, and in more locations, where (in 32-bit)
a u64 variable (i below) is used as the value of a 32-bit register:

                asm volatile("mov (%0,%1,1), %%eax\n\t"
                        :
                        : "r" (mem_r), "r" (i)
                        : "%eax", "memory");

The behavior in this case would be that only the 32 bit lower part of the
variable is passed. The variable is used as a counter in a for loop that
iterates over the pseudo-locked region and its maximum value is thus the
largest size of a pseudo-locked region. No pseudo-locked region currently
supported would need more than 32-bits for its size. There is thus no
potential for harm in the current state when using the u64 variable, but
this should be fixed.

Modify the variable with which the registers are initialized to be 64-bit
when used for 64-bit register and 32-bit when used for 32-bit register.

Fixes: 0438fb1aebf4 ("x86/intel_rdt: Pseudo-lock region creation/removal core")
Reported-by: lkp@intel.com
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: kbuild-all@01.org
Cc: tipbuild@zytor.com
Cc: fenghua.yu@intel.com
Cc: tony.luck@intel.com
Cc: hpa@zytor.com
Link: https://lkml.kernel.org/r/5773274f9947c4d8becbabd2655bd1628f060147.1529474468.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 0d44dc1f7146..a1670e50d6ce 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -415,7 +415,11 @@ static int pseudo_lock_fn(void *_rdtgrp)
 	struct rdtgroup *rdtgrp = _rdtgrp;
 	struct pseudo_lock_region *plr = rdtgrp->plr;
 	u32 rmid_p, closid_p;
+#ifdef CONFIG_X86_64
 	u64 i;
+#else
+	u32 i;
+#endif
 #ifdef CONFIG_KASAN
 	/*
 	 * The registers used for local register variables are also used
@@ -870,7 +874,11 @@ static int measure_cycles_lat_fn(void *_plr)
 {
 	struct pseudo_lock_region *plr = _plr;
 	u64 start, end;
+#ifdef CONFIG_X86_64
 	u64 i;
+#else
+	u32 i;
+#endif
 #ifdef CONFIG_KASAN
 	/*
 	 * The registers used for local register variables are also used
@@ -924,7 +932,11 @@ static int measure_cycles_perf_fn(void *_plr)
 	struct pseudo_lock_region *plr = _plr;
 	unsigned long long l2_hits, l2_miss;
 	u64 l2_hit_bits, l2_miss_bits;
+#ifdef CONFIG_X86_64
 	u64 i;
+#else
+	u32 i;
+#endif
 #ifdef CONFIG_KASAN
 	/*
 	 * The registers used for local register variables are also used
-- 
2.17.0

