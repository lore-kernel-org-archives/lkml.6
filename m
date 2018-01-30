Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751796AbeA3JZ1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 04:25:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:35201 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751429AbeA3JZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 04:25:24 -0500
Date: Tue, 30 Jan 2018 10:25:21 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 4.16
Message-ID: <20180130092521.bjbl3ylbglmzx3r2@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git for-linus

=============

- Add console_msg_format command line option. The value "default" keeps
  the old "[time stamp] text\n" format. The value "syslog" allows to see
  the syslog-like "<log level>[timestamp] text" format.

  This feature was requested by people doing regression tests, for example,
  0day robot. They want to have both filtered and full logs at hands.


- Reduce the risk of softlockup by passing the console owner in a busy loop.

  This is a new approach to the old problem. It was first proposed
  by Steven Rostedt on Kernel Summit 2017. It marks a context in which
  the console_lock owner calls console drivers and could not sleep.
  On the other side, printk() callers could detect this state and
  use a busy wait instead of a simple console_trylock(). Finally,
  the console_lock owner checks if there is a busy waiter at
  the end of the special context and eventually passes
  the console_lock to the waiter.

  The hand-off works surprisingly well and helps in many situations.
  Well, there is still a possibility of the softlockup, for example,
  when the flood of messages stops and the last owner still has too
  much to flush.

  There is increasing number of people having problems with
  printk-related softlockups. We might eventually need to get
  better solution. Anyway, this looks like a good start and
  promising direction.


- Do not allow to schedule in console_unlock() called from
  printk().

  This reverts an older controversial commit. The reschedule
  helped to avoid softlockups. But it also slowed down the console
  output. This patch is obsoleted by the new console waiter logic
  described above. In fact, the reschedule made the hand-off
  less effective.


- Deprecate "%pf" and "%pF" format specifier. It was needed on
  ia64, ppc64 and parisc64 to dereference function descriptors
  and show the real function address. It is done transparently
  by "%ps" and "pS" format specifier now.

  Sergey Senozhatsky found that all the function descriptors
  were in a special elf section and could be easily detected.


- Remove printk_symbol() API. It has been obsoleted by "%pS" format
  specifier.

  This change helped to remove few continuous lines and a less
  intuitive old API.


- Sergey removed unnecessary memset when processing printk.devkmsg
  command line option.

===========

There will be few merge conflicts:

- in Documentation/printk-formats.txt:

   - This merge commit removes the obsolete examples for "%pf"
     format specifier.

   - The commit 553d8e8b107159088cc4 ("docs: correct documentation for
     %pK") removed empty line right below this paragraph.


- scripts/checkpatch.pl:

   - This merge commit removes "fF" from the list of valid specifiers.
     checkpatch.pl is going to suggests "%ps" or "%pS" instead.

   - the commit 7b1924a1d930eb27fc ("vsprintf: add printk specifier %px")
     added the "x" specifier to the list.


- one more in Documentation/printk-formats.txt:

   - Jonathan Corbet is going to send conversion of this file to the .rst
     format.


Just in case, you might find the first two conflicts resolved
in
git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git tmp


----------------------------------------------------------------
Joel Stanley (1):
      openrisc: Fix conflicting types for _exext and _stext

Petr Mladek (4):
      printk: Hide console waiter logic into helpers
      Merge branch 'for-4.16-deprecate-printk-pf' into for-4.16
      Merge branch 'for-4.16-print-symbol' into for-4.16
      Merge branch 'for-4.16-console-waiter-logic' into for-4.16

Sergey Senozhatsky (24):
      sched/autogroup: remove unneeded kallsyms include
      sched/autogroup: move sched.h include
      printk: add console_msg_format command line option
      arm: do not use print_symbol()
      arm64: do not use print_symbol()
      c6x: do not use print_symbol()
      ia64: do not use print_symbol()
      mn10300: do not use print_symbol()
      sh: do not use print_symbol()
      unicore32: do not use print_symbol()
      x86: do not use print_symbol()
      drivers: do not use print_symbol()
      sysfs: do not use print_symbol()
      irq debug: do not use print_symbol()
      lib: do not use print_symbol()
      sections: split dereference_function_descriptor()
      ia64: Add .opd based function descriptor dereference
      powerpc64: Add .opd based function descriptor dereference
      parisc64: Add .opd based function descriptor dereference
      symbol lookup: introduce dereference_symbol_descriptor()
      checkpatch: add pF/pf deprecation warning
      kallsyms: remove print_symbol() function
      printk: Never set console_may_schedule in console_trylock()
      printk: drop redundant devkmsg_log_str memsets

Steven Rostedt (VMware) (1):
      printk: Add console owner and waiter logic to load balance console writes

 Documentation/admin-guide/kernel-parameters.txt    |  14 ++
 Documentation/filesystems/sysfs.txt                |   4 +-
 Documentation/printk-formats.txt                   |  35 ++--
 .../translations/zh_CN/filesystems/sysfs.txt       |   4 +-
 arch/arm/kernel/process.c                          |   5 +-
 arch/arm64/kernel/process.c                        |   5 +-
 arch/c6x/kernel/traps.c                            |   4 +-
 arch/ia64/include/asm/sections.h                   |  10 +-
 arch/ia64/kernel/module.c                          |  12 ++
 arch/ia64/kernel/process.c                         |  10 +-
 arch/ia64/kernel/vmlinux.lds.S                     |   2 +
 arch/mn10300/kernel/traps.c                        |   4 +-
 arch/openrisc/kernel/traps.c                       |   3 +-
 arch/parisc/boot/compressed/vmlinux.lds.S          |   2 +
 arch/parisc/include/asm/sections.h                 |   6 +
 arch/parisc/kernel/module.c                        |  16 ++
 arch/parisc/kernel/process.c                       |   9 +
 arch/parisc/kernel/vmlinux.lds.S                   |   2 +
 arch/powerpc/include/asm/module.h                  |   3 +
 arch/powerpc/include/asm/sections.h                |  12 ++
 arch/powerpc/kernel/module_64.c                    |  14 ++
 arch/powerpc/kernel/vmlinux.lds.S                  |   2 +
 arch/sh/kernel/process_32.c                        |   5 +-
 arch/unicore32/kernel/process.c                    |   5 +-
 arch/x86/kernel/cpu/mcheck/mce.c                   |   3 +-
 arch/x86/mm/mmio-mod.c                             |   5 +-
 drivers/base/core.c                                |   5 +-
 fs/sysfs/file.c                                    |   5 +-
 include/asm-generic/sections.h                     |   8 +-
 include/linux/kallsyms.h                           |  72 +++++--
 include/linux/module.h                             |  10 +
 kernel/irq/debug.h                                 |  14 +-
 kernel/kallsyms.c                                  |  46 -----
 kernel/module.c                                    |   6 +
 kernel/printk/printk.c                             | 215 ++++++++++++++++++---
 kernel/sched/autogroup.c                           |   5 +-
 lib/smp_processor_id.c                             |   3 +-
 lib/vsprintf.c                                     |   5 +-
 scripts/checkpatch.pl                              |  11 +-
 39 files changed, 428 insertions(+), 173 deletions(-)
