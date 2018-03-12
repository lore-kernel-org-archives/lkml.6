Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751727AbeCLOwi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:52:38 -0400
Received: from mga17.intel.com ([192.55.52.151]:4403 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751483AbeCLOwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:52:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="23617461"
Date: Mon, 12 Mar 2018 22:52:21 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Ingo Molnar <mingo@kernel.org>
Subject: [tip:locking/core 9/11]
 include/asm-generic/atomic-instrumented.h:288:24: sparse: cast truncates
 bits from constant value (100 becomes 0)
Message-ID: <201803122219.vHl3IwRo%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
head:   ac605bee0bfab40fd5d11964705e907d2d5a32de
commit: 8bf705d130396e69c04cd8e6e010244ad2ce71f4 [9/11] locking/atomic/x86: Switch atomic.h to use atomic-instrumented.h
reproduce:
        # apt-get install sparse
        git checkout 8bf705d130396e69c04cd8e6e010244ad2ce71f4
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   kernel/locking/qspinlock.c:418:22: sparse: incorrect type in assignment (different modifiers) @@    expected struct mcs_spinlock *prev @@    got struct struct mcs_spinlock *prev @@
   kernel/locking/qspinlock.c:418:22:    expected struct mcs_spinlock *prev
   kernel/locking/qspinlock.c:418:22:    got struct mcs_spinlock [pure] *
   kernel/locking/qspinlock_paravirt.h:519:1: sparse: symbol '__pv_queued_spin_unlock_slowpath' was not declared. Should it be static?
   kernel/locking/qspinlock.c:418:22: sparse: incorrect type in assignment (different modifiers) @@    expected struct mcs_spinlock *prev @@    got struct struct mcs_spinlock *prev @@
   kernel/locking/qspinlock.c:418:22:    expected struct mcs_spinlock *prev
   kernel/locking/qspinlock.c:418:22:    got struct mcs_spinlock [pure] *
>> include/asm-generic/atomic-instrumented.h:288:24: sparse: cast truncates bits from constant value (100 becomes 0)

vim +288 include/asm-generic/atomic-instrumented.h

b06ed71a6 Dmitry Vyukov 2018-01-29  282  
b06ed71a6 Dmitry Vyukov 2018-01-29  283  static __always_inline unsigned long
b06ed71a6 Dmitry Vyukov 2018-01-29  284  cmpxchg_size(volatile void *ptr, unsigned long old, unsigned long new, int size)
b06ed71a6 Dmitry Vyukov 2018-01-29  285  {
b06ed71a6 Dmitry Vyukov 2018-01-29  286  	switch (size) {
b06ed71a6 Dmitry Vyukov 2018-01-29  287  	case 1:
b06ed71a6 Dmitry Vyukov 2018-01-29 @288  		return arch_cmpxchg((u8 *)ptr, (u8)old, (u8)new);
b06ed71a6 Dmitry Vyukov 2018-01-29  289  	case 2:
b06ed71a6 Dmitry Vyukov 2018-01-29  290  		return arch_cmpxchg((u16 *)ptr, (u16)old, (u16)new);
b06ed71a6 Dmitry Vyukov 2018-01-29  291  	case 4:
b06ed71a6 Dmitry Vyukov 2018-01-29  292  		return arch_cmpxchg((u32 *)ptr, (u32)old, (u32)new);
b06ed71a6 Dmitry Vyukov 2018-01-29  293  	case 8:
b06ed71a6 Dmitry Vyukov 2018-01-29  294  		BUILD_BUG_ON(sizeof(unsigned long) != 8);
b06ed71a6 Dmitry Vyukov 2018-01-29  295  		return arch_cmpxchg((u64 *)ptr, (u64)old, (u64)new);
b06ed71a6 Dmitry Vyukov 2018-01-29  296  	}
b06ed71a6 Dmitry Vyukov 2018-01-29  297  	BUILD_BUG();
b06ed71a6 Dmitry Vyukov 2018-01-29  298  	return 0;
b06ed71a6 Dmitry Vyukov 2018-01-29  299  }
b06ed71a6 Dmitry Vyukov 2018-01-29  300  

:::::: The code at line 288 was first introduced by commit
:::::: b06ed71a624ba088a3e3e3ac7d4185f48c7c1660 locking/atomic, asm-generic: Add asm-generic/atomic-instrumented.h

:::::: TO: Dmitry Vyukov <dvyukov@google.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
