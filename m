Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeDKMv5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:51:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:37927 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752981AbeDKMv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:51:56 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,436,1517904000";
   d="scan'208";a="45320243"
Date: Wed, 11 Apr 2018 20:51:29 +0800
From: kbuild test robot <lkp@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: kbuild-all@01.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@kernel.org, longman@redhat.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbues@suse.de>
Subject: Re: [PATCH 2/2] rtmutex: Reduce top-waiter blocking on a lock
Message-ID: <201804112023.tAv7vUah%fengguang.wu@intel.com>
References: <20180410162750.8290-2-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410162750.8290-2-dave@stgolabs.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Davidlohr,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.16 next-20180411]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Davidlohr-Bueso/locking-rtmutex-Delete-save_state-member-of-struct-rt_mutex/20180411-155733
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> kernel/locking/rtmutex_common.h:62:9: sparse: context imbalance in '__rt_mutex_slowlock' - unexpected unlock

vim +/__rt_mutex_slowlock +62 kernel/locking/rtmutex_common.h

23f78d4a0 kernel/rtmutex_common.h         Ingo Molnar    2006-06-27  51  
23f78d4a0 kernel/rtmutex_common.h         Ingo Molnar    2006-06-27  52  static inline struct rt_mutex_waiter *
23f78d4a0 kernel/rtmutex_common.h         Ingo Molnar    2006-06-27  53  rt_mutex_top_waiter(struct rt_mutex *lock)
23f78d4a0 kernel/rtmutex_common.h         Ingo Molnar    2006-06-27  54  {
c28d62cf5 kernel/locking/rtmutex_common.h Peter Zijlstra 2018-03-27  55  	struct rb_node *leftmost = rb_first_cached(&lock->waiters);
c28d62cf5 kernel/locking/rtmutex_common.h Peter Zijlstra 2018-03-27  56  	struct rt_mutex_waiter *w = NULL;
23f78d4a0 kernel/rtmutex_common.h         Ingo Molnar    2006-06-27  57  
c28d62cf5 kernel/locking/rtmutex_common.h Peter Zijlstra 2018-03-27  58  	if (leftmost) {
c28d62cf5 kernel/locking/rtmutex_common.h Peter Zijlstra 2018-03-27  59  		w = rb_entry(leftmost, struct rt_mutex_waiter, tree_entry);
23f78d4a0 kernel/rtmutex_common.h         Ingo Molnar    2006-06-27  60  		BUG_ON(w->lock != lock);
c28d62cf5 kernel/locking/rtmutex_common.h Peter Zijlstra 2018-03-27  61  	}
23f78d4a0 kernel/rtmutex_common.h         Ingo Molnar    2006-06-27 @62  	return w;
23f78d4a0 kernel/rtmutex_common.h         Ingo Molnar    2006-06-27  63  }
23f78d4a0 kernel/rtmutex_common.h         Ingo Molnar    2006-06-27  64  

:::::: The code at line 62 was first introduced by commit
:::::: 23f78d4a03c53cbd75d87a795378ea540aa08c86 [PATCH] pi-futex: rt mutex core

:::::: TO: Ingo Molnar <mingo@elte.hu>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
