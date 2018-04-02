Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754398AbeDBH6Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 03:58:16 -0400
Received: from mga06.intel.com ([134.134.136.31]:10022 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754270AbeDBH6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 03:58:00 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,394,1517904000";
   d="gz'50?scan'50,208,50";a="40018862"
Date: Mon, 2 Apr 2018 15:57:46 +0800
From: kbuild test robot <lkp@intel.com>
To: David Howells <dhowells@redhat.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/45] C++: x86: Fix the x86 syscall table production for
 C++
Message-ID: <201804021452.7uR1SOiJ%fengguang.wu@intel.com>
References: <152261526940.30503.3933152630838784113.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
In-Reply-To: <152261526940.30503.3933152630838784113.stgit@warthog.procyon.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi David,

I love your patch! Yet something to improve:

[auto build test ERROR on v4.16-rc7]
[cannot apply to linus/master tip/x86/core tip/locking/core v4.16 next-20180329]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Howells/C-Convert-the-kernel-to-C/20180402-120344
config: um-x86_64_defconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=um SUBARCH=x86_64

All errors (new ones prefixed by >>):

   cc1: warning: command line option '-fno-rtti' is valid for C++/ObjC++ but not for C
   cc1: warning: command line option '-fpermissive' is valid for C++/ObjC++ but not for C
   In file included from arch/x86/um/user-offsets.c:20:0:
   arch/x86/include/generated/asm/syscalls_64.h:135:1: error: implicit declaration of function '__NO_SYSCALL_'; did you mean '__SYSCALL_64'? [-Werror=implicit-function-declaration]
    __NO_SYSCALL_(134)
    ^~~~~~~~~~~~~
    __SYSCALL_64
>> arch/x86/um/user-offsets.c:18:37: error: subscripted value is neither array nor pointer nor vector
    #define __SYSCALL_64(nr, sym, qual) [nr] = 1,
                                        ^
   arch/x86/include/generated/asm/syscalls_64.h:136:1: note: in expansion of macro '__SYSCALL_64'
    __SYSCALL_64(135, sys_personality, )
    ^~~~~~~~~~~~
>> arch/x86/um/user-offsets.c:18:37: error: subscripted value is neither array nor pointer nor vector
    #define __SYSCALL_64(nr, sym, qual) [nr] = 1,
                                        ^
   arch/x86/include/generated/asm/syscalls_64.h:176:1: note: in expansion of macro '__SYSCALL_64'
    __SYSCALL_64(175, sys_init_module, )
    ^~~~~~~~~~~~
   In file included from arch/x86/um/user-offsets.c:20:0:
   arch/x86/include/generated/asm/syscalls_64.h:178:1: error: initializer element is not constant
    __NO_SYSCALL_(177)
    ^~~~~~~~~~~~~
   arch/x86/include/generated/asm/syscalls_64.h:178:1: note: (near initialization for 'syscalls[177]')
   arch/x86/include/generated/asm/syscalls_64.h:179:1: error: expected '}' before '__NO_SYSCALL_'
    __NO_SYSCALL_(178)
    ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [arch/x86/um/user-offsets.s] Error 1
   make[1]: *** [arch/x86/um/user-offsets.s] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +18 arch/x86/um/user-offsets.c

8d0b9dc9 arch/um/sys-x86_64/user-offsets.c Al Viro         2005-05-05  11  
45db1c61 arch/x86/um/user-offsets.c        H. Peter Anvin  2011-12-05  12  #ifdef __i386__
cfcbadb4 arch/x86/um/user-offsets.c        Andy Lutomirski 2016-01-28  13  #define __SYSCALL_I386(nr, sym, qual) [nr] = 1,
45db1c61 arch/x86/um/user-offsets.c        H. Peter Anvin  2011-12-05  14  static char syscalls[] = {
45db1c61 arch/x86/um/user-offsets.c        H. Peter Anvin  2011-12-05  15  #include <asm/syscalls_32.h>
45db1c61 arch/x86/um/user-offsets.c        H. Peter Anvin  2011-12-05  16  };
45db1c61 arch/x86/um/user-offsets.c        H. Peter Anvin  2011-12-05  17  #else
cfcbadb4 arch/x86/um/user-offsets.c        Andy Lutomirski 2016-01-28 @18  #define __SYSCALL_64(nr, sym, qual) [nr] = 1,
45db1c61 arch/x86/um/user-offsets.c        H. Peter Anvin  2011-12-05  19  static char syscalls[] = {
45db1c61 arch/x86/um/user-offsets.c        H. Peter Anvin  2011-12-05 @20  #include <asm/syscalls_64.h>
45db1c61 arch/x86/um/user-offsets.c        H. Peter Anvin  2011-12-05  21  };
45db1c61 arch/x86/um/user-offsets.c        H. Peter Anvin  2011-12-05  22  #endif
45db1c61 arch/x86/um/user-offsets.c        H. Peter Anvin  2011-12-05  23  

:::::: The code at line 18 was first introduced by commit
:::::: cfcbadb49dabb05efa23e1a0f95f3391c0a815bc x86/syscalls: Add syscall entry qualifiers

:::::: TO: Andy Lutomirski <luto@kernel.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--nFreZHaLTZJo0R7j
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--nFreZHaLTZJo0R7j--
