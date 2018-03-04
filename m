Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeCDLQc (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 06:16:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:11223 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752190AbeCDLQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 06:16:30 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,422,1515484800";
   d="gz'50?scan'50,208,50";a="205363299"
Date: Sun, 4 Mar 2018 19:16:05 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com
Subject: [tip:WIP.sched/core 19/22] arch/m68k/include/asm/switch_to.h:30:12:
 error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
Message-ID: <201803041903.WlVM69or%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.sched/core
head:   ffce6fffa0033fa54d1bac1c7494862b71316978
commit: ecaf52c9ec5ad31395e5c06c01e293ebcf0e4350 [19/22] sched/headers: Simplify and clean up header usage in the scheduler
config: m68k-sun3_defconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout ecaf52c9ec5ad31395e5c06c01e293ebcf0e4350
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

   In file included from kernel/sched/core.c:8:0:
>> arch/m68k/include/asm/switch_to.h:30:12: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'void'
    asmlinkage void resume(void);
               ^~~~

vim +30 arch/m68k/include/asm/switch_to.h

803f69144 David Howells 2012-03-28   4  
803f69144 David Howells 2012-03-28   5  /*
803f69144 David Howells 2012-03-28   6   * switch_to(n) should switch tasks to task ptr, first checking that
803f69144 David Howells 2012-03-28   7   * ptr isn't the current task, in which case it does nothing.  This
803f69144 David Howells 2012-03-28   8   * also clears the TS-flag if the task we switched to has used the
803f69144 David Howells 2012-03-28   9   * math co-processor latest.
803f69144 David Howells 2012-03-28  10   */
803f69144 David Howells 2012-03-28  11  /*
803f69144 David Howells 2012-03-28  12   * switch_to() saves the extra registers, that are not saved
803f69144 David Howells 2012-03-28  13   * automatically by SAVE_SWITCH_STACK in resume(), ie. d0-d5 and
803f69144 David Howells 2012-03-28  14   * a0-a1. Some of these are used by schedule() and its predecessors
803f69144 David Howells 2012-03-28  15   * and so we might get see unexpected behaviors when a task returns
803f69144 David Howells 2012-03-28  16   * with unexpected register values.
803f69144 David Howells 2012-03-28  17   *
803f69144 David Howells 2012-03-28  18   * syscall stores these registers itself and none of them are used
803f69144 David Howells 2012-03-28  19   * by syscall after the function in the syscall has been called.
803f69144 David Howells 2012-03-28  20   *
803f69144 David Howells 2012-03-28  21   * Beware that resume now expects *next to be in d1 and the offset of
803f69144 David Howells 2012-03-28  22   * tss to be in a1. This saves a few instructions as we no longer have
803f69144 David Howells 2012-03-28  23   * to push them onto the stack and read them back right after.
803f69144 David Howells 2012-03-28  24   *
803f69144 David Howells 2012-03-28  25   * 02/17/96 - Jes Sorensen (jds@kom.auc.dk)
803f69144 David Howells 2012-03-28  26   *
803f69144 David Howells 2012-03-28  27   * Changed 96/09/19 by Andreas Schwab
803f69144 David Howells 2012-03-28  28   * pass prev in a0, next in a1
803f69144 David Howells 2012-03-28  29   */
803f69144 David Howells 2012-03-28 @30  asmlinkage void resume(void);
803f69144 David Howells 2012-03-28  31  #define switch_to(prev,next,last) do { \
803f69144 David Howells 2012-03-28  32    register void *_prev __asm__ ("a0") = (prev); \
803f69144 David Howells 2012-03-28  33    register void *_next __asm__ ("a1") = (next); \
803f69144 David Howells 2012-03-28  34    register void *_last __asm__ ("d1"); \
803f69144 David Howells 2012-03-28  35    __asm__ __volatile__("jbsr resume" \
803f69144 David Howells 2012-03-28  36  		       : "=a" (_prev), "=a" (_next), "=d" (_last) \
803f69144 David Howells 2012-03-28  37  		       : "0" (_prev), "1" (_next) \
803f69144 David Howells 2012-03-28  38  		       : "d0", "d2", "d3", "d4", "d5"); \
803f69144 David Howells 2012-03-28  39    (last) = _last; \
803f69144 David Howells 2012-03-28  40  } while (0)
803f69144 David Howells 2012-03-28  41  

:::::: The code at line 30 was first introduced by commit
:::::: 803f69144f0d48863c68f9d111b56849c7cef5bb Disintegrate asm/system.h for M68K

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--W/nzBZO5zC0uMSeA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--W/nzBZO5zC0uMSeA--
