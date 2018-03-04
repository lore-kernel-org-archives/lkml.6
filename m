Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeCDSMt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 13:12:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33118 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751692AbeCDSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 13:12:46 -0500
Subject: Re: [tip:WIP.sched/core 19/22] kernel/sched/core.c:2836:18: error:
 passing argument 1 of 'mips_install_watch_registers' from incompatible
 pointer type
To: kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
References: <201803041803.gY4ddHfJ%fengguang.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b8be96d0-8a53-104e-c90d-72a3ea158f8d@infradead.org>
Date: Sun, 4 Mar 2018 10:12:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201803041803.gY4ddHfJ%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2018 02:52 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.sched/core
> head:   ffce6fffa0033fa54d1bac1c7494862b71316978
> commit: ecaf52c9ec5ad31395e5c06c01e293ebcf0e4350 [19/22] sched/headers: Simplify and clean up header usage in the scheduler
> config: mips-jz4740 (attached as .config)
> compiler: mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout ecaf52c9ec5ad31395e5c06c01e293ebcf0e4350
>         # save the attached .config to linux build tree
>         make.cross ARCH=mips 
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from arch/mips/include/asm/switch_to.h:16:0,
>                     from kernel/sched/core.c:8:
>>> arch/mips/include/asm/watch.h:15:42: warning: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration
>     void mips_install_watch_registers(struct task_struct *t);
>                                              ^~~~~~~~~~~
>    In file included from arch/mips/include/asm/switch_to.h:16:0,
>                     from kernel/sched/core.c:8:
>    kernel/sched/core.c: In function 'context_switch':
>>> kernel/sched/core.c:2836:18: error: passing argument 1 of 'mips_install_watch_registers' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      switch_to(prev, next, prev);
>                      ^
>    arch/mips/include/asm/watch.h:24:32: note: in definition of macro '__restore_watch'
>       mips_install_watch_registers(task);   \
>                                    ^~~~
>    kernel/sched/core.c:2836:2: note: in expansion of macro 'switch_to'
>      switch_to(prev, next, prev);
>      ^~~~~~~~~
>    arch/mips/include/asm/watch.h:15:6: note: expected 'struct task_struct *' but argument is of type 'struct task_struct *'
>     void mips_install_watch_registers(struct task_struct *t);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> --
>    In file included from arch/mips/include/asm/switch_to.h:16:0,
>                     from kernel//sched/core.c:8:
>>> arch/mips/include/asm/watch.h:15:42: warning: 'struct task_struct' declared inside parameter list will not be visible outside of this definition or declaration
>     void mips_install_watch_registers(struct task_struct *t);
>                                              ^~~~~~~~~~~
>    In file included from arch/mips/include/asm/switch_to.h:16:0,
>                     from kernel//sched/core.c:8:
>    kernel//sched/core.c: In function 'context_switch':
>    kernel//sched/core.c:2836:18: error: passing argument 1 of 'mips_install_watch_registers' from incompatible pointer type [-Werror=incompatible-pointer-types]
>      switch_to(prev, next, prev);
>                      ^
>    arch/mips/include/asm/watch.h:24:32: note: in definition of macro '__restore_watch'
>       mips_install_watch_registers(task);   \
>                                    ^~~~
>    kernel//sched/core.c:2836:2: note: in expansion of macro 'switch_to'
>      switch_to(prev, next, prev);
>      ^~~~~~~~~
>    arch/mips/include/asm/watch.h:15:6: note: expected 'struct task_struct *' but argument is of type 'struct task_struct *'
>     void mips_install_watch_registers(struct task_struct *t);
>          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors

I don't have a tip git repo, but it looks like this would fix it (based on most
recent -next):

--- linux-next-20180302.orig/arch/mips/include/asm/watch.h
+++ linux-next-20180302/arch/mips/include/asm/watch.h
@@ -12,6 +12,8 @@
 
 #include <asm/mipsregs.h>
 
+struct task_struct;
+
 void mips_install_watch_registers(struct task_struct *t);
 void mips_read_watch_registers(void);
 void mips_clear_watch_registers(void);



> vim +/mips_install_watch_registers +2836 kernel/sched/core.c
> 
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2791  
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2792  /*
> dfa50b60 kernel/sched/core.c Oleg Nesterov       2014-10-09  2793   * context_switch - switch to the new MM and the new thread's register state.
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2794   */
> 04936948 kernel/sched/core.c Josh Poimboeuf      2016-02-28  2795  static __always_inline struct rq *
> 70b97a7f kernel/sched.c      Ingo Molnar         2006-07-03  2796  context_switch(struct rq *rq, struct task_struct *prev,
> d8ac8971 kernel/sched/core.c Matt Fleming        2016-09-21  2797  	       struct task_struct *next, struct rq_flags *rf)
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2798  {
> dd41f596 kernel/sched.c      Ingo Molnar         2007-07-09  2799  	struct mm_struct *mm, *oldmm;
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2800  
> e107be36 kernel/sched.c      Avi Kivity          2007-07-26  2801  	prepare_task_switch(rq, prev, next);
> fe4b04fa kernel/sched.c      Peter Zijlstra      2011-02-02  2802  
> dd41f596 kernel/sched.c      Ingo Molnar         2007-07-09  2803  	mm = next->mm;
> dd41f596 kernel/sched.c      Ingo Molnar         2007-07-09  2804  	oldmm = prev->active_mm;
> 9226d125 kernel/sched.c      Zachary Amsden      2007-02-13  2805  	/*
> 9226d125 kernel/sched.c      Zachary Amsden      2007-02-13  2806  	 * For paravirt, this is coupled with an exit in switch_to to
> 9226d125 kernel/sched.c      Zachary Amsden      2007-02-13  2807  	 * combine the page table reload and the switch backend into
> 9226d125 kernel/sched.c      Zachary Amsden      2007-02-13  2808  	 * one hypercall.
> 9226d125 kernel/sched.c      Zachary Amsden      2007-02-13  2809  	 */
> 224101ed kernel/sched.c      Jeremy Fitzhardinge 2009-02-18  2810  	arch_start_context_switch(prev);
> 9226d125 kernel/sched.c      Zachary Amsden      2007-02-13  2811  
> 306e0604 kernel/sched/core.c Mathieu Desnoyers   2018-01-29  2812  	/*
> 306e0604 kernel/sched/core.c Mathieu Desnoyers   2018-01-29  2813  	 * If mm is non-NULL, we pass through switch_mm(). If mm is
> 306e0604 kernel/sched/core.c Mathieu Desnoyers   2018-01-29  2814  	 * NULL, we will pass through mmdrop() in finish_task_switch().
> 306e0604 kernel/sched/core.c Mathieu Desnoyers   2018-01-29  2815  	 * Both of these contain the full memory barrier required by
> 306e0604 kernel/sched/core.c Mathieu Desnoyers   2018-01-29  2816  	 * membarrier after storing to rq->curr, before returning to
> 306e0604 kernel/sched/core.c Mathieu Desnoyers   2018-01-29  2817  	 * user-space.
> 306e0604 kernel/sched/core.c Mathieu Desnoyers   2018-01-29  2818  	 */
> 31915ab4 kernel/sched.c      Heiko Carstens      2010-09-16  2819  	if (!mm) {
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2820  		next->active_mm = oldmm;
> f1f10076 kernel/sched/core.c Vegard Nossum       2017-02-27  2821  		mmgrab(oldmm);
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2822  		enter_lazy_tlb(oldmm, next);
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2823  	} else
> f98db601 kernel/sched/core.c Andy Lutomirski     2016-04-26  2824  		switch_mm_irqs_off(oldmm, mm, next);
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2825  
> 31915ab4 kernel/sched.c      Heiko Carstens      2010-09-16  2826  	if (!prev->mm) {
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2827  		prev->active_mm = NULL;
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2828  		rq->prev_mm = oldmm;
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2829  	}
> 92509b73 kernel/sched/core.c Matt Fleming        2016-09-21  2830  
> cb42c9a3 kernel/sched/core.c Matt Fleming        2016-09-21  2831  	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
> 92509b73 kernel/sched/core.c Matt Fleming        2016-09-21  2832  
> 269d5992 kernel/sched/core.c Peter Zijlstra      2018-02-06  2833  	prepare_lock_switch(rq, next, rf);
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2834  
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2835  	/* Here we just switch the register state and the stack. */
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16 @2836  	switch_to(prev, next, prev);
> dd41f596 kernel/sched.c      Ingo Molnar         2007-07-09  2837  	barrier();
> dfa50b60 kernel/sched/core.c Oleg Nesterov       2014-10-09  2838  
> dfa50b60 kernel/sched/core.c Oleg Nesterov       2014-10-09  2839  	return finish_task_switch(prev);
> ^1da177e kernel/sched.c      Linus Torvalds      2005-04-16  2840  }
> f711f609 kernel/sched.c      Gautham R Shenoy    2009-04-14  2841  
> 
> :::::: The code at line 2836 was first introduced by commit
> :::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2
> 
> :::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
> :::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


-- 
~Randy
