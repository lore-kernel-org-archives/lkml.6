Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753425AbeBBTOx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 14:14:53 -0500
Received: from mga03.intel.com ([134.134.136.65]:37522 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752575AbeBBTOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 14:14:45 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="gz'50?scan'50,208,50";a="24463326"
Date: Sat, 3 Feb 2018 03:14:01 +0800
From: kbuild test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kbuild-all@01.org, Stafford Horne <shorne@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: asm-generic: Disallow no-op mb() for SMP systems
Message-ID: <201802030203.kIXRmGUe%fengguang.wu@intel.com>
References: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

I love your patch! Yet something to improve:

[auto build test ERROR on asm-generic/master]
[also build test ERROR on v4.15 next-20180202]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Zijlstra/asm-generic-Disallow-no-op-mb-for-SMP-systems/20180203-000108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
config: mn10300-asb2364_defconfig (attached as .config)
compiler: am33_2.0-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mn10300 

All errors (new ones prefixed by >>):

   warning: (MN10300) selects HAVE_NMI_WATCHDOG which has unmet direct dependencies (HAVE_NMI)
   warning: (MN10300) selects HAVE_NMI_WATCHDOG which has unmet direct dependencies (HAVE_NMI)
   In file included from ./arch/mn10300/include/generated/asm/barrier.h:1:0,
                    from arch/mn10300/include/asm/bitops.h:21,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/asm-generic/bug.h:13,
                    from arch/mn10300/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/thread_info.h:11,
                    from arch/mn10300/include/asm/current.h:14,
                    from include/linux/sched.h:11,
                    from arch/mn10300/kernel/asm-offsets.c:7:
   include/asm-generic/atomic-long.h: In function 'atomic_long_read_acquire':
>> include/asm-generic/barrier.h:64:20: error: implicit declaration of function 'mb'; did you mean 'rmb'? [-Werror=implicit-function-declaration]
    #define __smp_mb() mb()
                       ^
   include/asm-generic/barrier.h:143:2: note: in expansion of macro '__smp_mb'
     __smp_mb();       \
     ^~~~~~~~
   include/asm-generic/barrier.h:167:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   include/linux/atomic.h:26:34: note: in expansion of macro 'smp_load_acquire'
    #define  atomic_read_acquire(v)  smp_load_acquire(&(v)->counter)
                                     ^~~~~~~~~~~~~~~~
   include/asm-generic/atomic-long.h:33:28: note: in expansion of macro 'atomic_read_acquire'
    #define ATOMIC_LONG_PFX(x) atomic ## x
                               ^~~~~~
   include/asm-generic/atomic-long.h:42:15: note: in expansion of macro 'ATOMIC_LONG_PFX'
     return (long)ATOMIC_LONG_PFX(_read##mo)(v);   \
                  ^~~~~~~~~~~~~~~
   include/asm-generic/atomic-long.h:45:1: note: in expansion of macro 'ATOMIC_LONG_READ_OP'
    ATOMIC_LONG_READ_OP(_acquire)
    ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [arch/mn10300/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +64 include/asm-generic/barrier.h

885df91c David Howells      2012-03-28  62  
a9e4252a Michael S. Tsirkin 2015-12-27  63  #ifndef __smp_mb
a9e4252a Michael S. Tsirkin 2015-12-27 @64  #define __smp_mb()	mb()
a9e4252a Michael S. Tsirkin 2015-12-27  65  #endif
a9e4252a Michael S. Tsirkin 2015-12-27  66  

:::::: The code at line 64 was first introduced by commit
:::::: a9e4252a9b147043142282ebb65da94dcb951e2a asm-generic: add __smp_xxx wrappers

:::::: TO: Michael S. Tsirkin <mst@redhat.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--wRRV7LY7NUeQGEoC
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
xuKnn4wAAA==

--wRRV7LY7NUeQGEoC--
