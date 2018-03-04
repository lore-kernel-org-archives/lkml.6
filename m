Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeCDSN1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 13:13:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34438 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeCDSNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 13:13:23 -0500
Subject: Re: [tip:WIP.sched/core 19/22]
 arch/m68k/include/asm/switch_to.h:30:12: error: expected '=', ',', ';', 'asm'
 or '__attribute__' before 'void'
To: kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
References: <201803041903.WlVM69or%fengguang.wu@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8f2f3ce7-4ddf-096a-3a7b-4b52f7c99c73@infradead.org>
Date: Sun, 4 Mar 2018 10:13:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <201803041903.WlVM69or%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2018 03:16 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.sched/core
> head:   ffce6fffa0033fa54d1bac1c7494862b71316978
> commit: ecaf52c9ec5ad31395e5c06c01e293ebcf0e4350 [19/22] sched/headers: Simplify and clean up header usage in the scheduler
> config: m68k-sun3_defconfig (attached as .config)
> compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout ecaf52c9ec5ad31395e5c06c01e293ebcf0e4350
>         # save the attached .config to linux build tree
>         make.cross ARCH=m68k 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel/sched/core.c:8:0:
>>> arch/m68k/include/asm/switch_to.h:30:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
>     asmlinkage void resume(void);
>                ^~~~

another simple fix:

--- linux-next-20180302.orig/arch/m68k/include/asm/switch_to.h
+++ linux-next-20180302/arch/m68k/include/asm/switch_to.h
@@ -27,6 +27,9 @@
  * Changed 96/09/19 by Andreas Schwab
  * pass prev in a0, next in a1
  */
+
+#include <linux/linkage.h>
+
 asmlinkage void resume(void);
 #define switch_to(prev,next,last) do { \
   register void *_prev __asm__ ("a0") = (prev); \


> vim +30 arch/m68k/include/asm/switch_to.h
> 
> 803f69144 David Howells 2012-03-28   4  
> 803f69144 David Howells 2012-03-28   5  /*
> 803f69144 David Howells 2012-03-28   6   * switch_to(n) should switch tasks to task ptr, first checking that
> 803f69144 David Howells 2012-03-28   7   * ptr isn't the current task, in which case it does nothing.  This
> 803f69144 David Howells 2012-03-28   8   * also clears the TS-flag if the task we switched to has used the
> 803f69144 David Howells 2012-03-28   9   * math co-processor latest.
> 803f69144 David Howells 2012-03-28  10   */
> 803f69144 David Howells 2012-03-28  11  /*
> 803f69144 David Howells 2012-03-28  12   * switch_to() saves the extra registers, that are not saved
> 803f69144 David Howells 2012-03-28  13   * automatically by SAVE_SWITCH_STACK in resume(), ie. d0-d5 and
> 803f69144 David Howells 2012-03-28  14   * a0-a1. Some of these are used by schedule() and its predecessors
> 803f69144 David Howells 2012-03-28  15   * and so we might get see unexpected behaviors when a task returns
> 803f69144 David Howells 2012-03-28  16   * with unexpected register values.
> 803f69144 David Howells 2012-03-28  17   *
> 803f69144 David Howells 2012-03-28  18   * syscall stores these registers itself and none of them are used
> 803f69144 David Howells 2012-03-28  19   * by syscall after the function in the syscall has been called.
> 803f69144 David Howells 2012-03-28  20   *
> 803f69144 David Howells 2012-03-28  21   * Beware that resume now expects *next to be in d1 and the offset of
> 803f69144 David Howells 2012-03-28  22   * tss to be in a1. This saves a few instructions as we no longer have
> 803f69144 David Howells 2012-03-28  23   * to push them onto the stack and read them back right after.
> 803f69144 David Howells 2012-03-28  24   *
> 803f69144 David Howells 2012-03-28  25   * 02/17/96 - Jes Sorensen (jds@kom.auc.dk)
> 803f69144 David Howells 2012-03-28  26   *
> 803f69144 David Howells 2012-03-28  27   * Changed 96/09/19 by Andreas Schwab
> 803f69144 David Howells 2012-03-28  28   * pass prev in a0, next in a1
> 803f69144 David Howells 2012-03-28  29   */
> 803f69144 David Howells 2012-03-28 @30  asmlinkage void resume(void);
> 803f69144 David Howells 2012-03-28  31  #define switch_to(prev,next,last) do { \
> 803f69144 David Howells 2012-03-28  32    register void *_prev __asm__ ("a0") = (prev); \
> 803f69144 David Howells 2012-03-28  33    register void *_next __asm__ ("a1") = (next); \
> 803f69144 David Howells 2012-03-28  34    register void *_last __asm__ ("d1"); \
> 803f69144 David Howells 2012-03-28  35    __asm__ __volatile__("jbsr resume" \
> 803f69144 David Howells 2012-03-28  36  		       : "=a" (_prev), "=a" (_next), "=d" (_last) \
> 803f69144 David Howells 2012-03-28  37  		       : "0" (_prev), "1" (_next) \
> 803f69144 David Howells 2012-03-28  38  		       : "d0", "d2", "d3", "d4", "d5"); \
> 803f69144 David Howells 2012-03-28  39    (last) = _last; \
> 803f69144 David Howells 2012-03-28  40  } while (0)
> 803f69144 David Howells 2012-03-28  41  
> 
> :::::: The code at line 30 was first introduced by commit
> :::::: 803f69144f0d48863c68f9d111b56849c7cef5bb Disintegrate asm/system.h for M68K
> 
> :::::: TO: David Howells <dhowells@redhat.com>
> :::::: CC: David Howells <dhowells@redhat.com>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 


-- 
~Randy
