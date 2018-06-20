Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03502C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03D56208B3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03D56208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754577AbeFTIbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:31:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46163 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752725AbeFTIbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:31:02 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5K8UsJS3428587
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 20 Jun 2018 01:30:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5K8UrcM3428584;
        Wed, 20 Jun 2018 01:30:53 -0700
Date:   Wed, 20 Jun 2018 01:30:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Reinette Chatre <tipbot@zytor.com>
Message-ID: <tip-a9347363748fbfc25d0ba7b60d866b8a10ca4561@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        reinette.chatre@intel.com, mingo@kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
          reinette.chatre@intel.com, tglx@linutronix.de
In-Reply-To: <5773274f9947c4d8becbabd2655bd1628f060147.1529474468.git.reinette.chatre@intel.com>
References: <5773274f9947c4d8becbabd2655bd1628f060147.1529474468.git.reinette.chatre@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/cache] x86/intel_rdt: Fix passing of value to 32-bit
 register
Git-Commit-ID: a9347363748fbfc25d0ba7b60d866b8a10ca4561
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  a9347363748fbfc25d0ba7b60d866b8a10ca4561
Gitweb:     https://git.kernel.org/tip/a9347363748fbfc25d0ba7b60d866b8a10ca4561
Author:     Reinette Chatre <reinette.chatre@intel.com>
AuthorDate: Tue, 19 Jun 2018 23:19:27 -0700
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 20 Jun 2018 10:26:52 +0200

x86/intel_rdt: Fix passing of value to 32-bit register

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
