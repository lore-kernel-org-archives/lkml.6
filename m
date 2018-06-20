Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13633C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E5A20872
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E5A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754106AbeFTGTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:19:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:7179 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753879AbeFTGTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:19:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2018 23:19:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,246,1526367600"; 
   d="scan'208";a="238683797"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jun 2018 23:19:51 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     kbuild-all@01.org, tipbuild@zytor.com, tglx@linutronix.de,
        fenghua.yu@intel.com, tony.luck@intel.com
Cc:     mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [PATCH] x86/intel_rdt: Fix passing of value to 32-bit register
Date:   Tue, 19 Jun 2018 23:19:27 -0700
Message-Id: <5773274f9947c4d8becbabd2655bd1628f060147.1529474468.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <201806200807.HysDJByu%fengguang.wu@intel.com>
References: <201806200807.HysDJByu%fengguang.wu@intel.com>
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

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---

Thank you 0-day!

 arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
index 3c24752873e5..c95de5bc45a1 100644
--- a/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
+++ b/arch/x86/kernel/cpu/intel_rdt_pseudo_lock.c
@@ -421,7 +421,11 @@ static int pseudo_lock_fn(void *_rdtgrp)
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
@@ -877,7 +881,11 @@ static int measure_cycles_lat_fn(void *_plr)
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
@@ -931,7 +939,11 @@ static int measure_cycles_perf_fn(void *_plr)
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

