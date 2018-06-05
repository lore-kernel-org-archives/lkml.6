Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751963AbeFEMTH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:19:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:38223 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbeFEMTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:19:06 -0400
Date: Tue, 5 Jun 2018 14:19:04 +0200
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 4.18
Message-ID: <20180605121904.peswul2awot5drtg@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-4.18

There will be conflicts in lib/vsprintf.c that are caused by late fixes for
4.17. The proposed resolution can be found in the branch

  git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk.git for-4.18-vsprintf-conflict

Also I am sorry that I have rebased today. I added one late ack and
removed one fix that was not good enough. I found a race in that fix
when writing this summary.

==============

- Help userspace log daemons to catch up with a flood of messages. They
  will get waken after each message even if the console is far behind and
  handled by another process.

- Flush printk safe buffers safely even when panic() happens in the normal
  context.

- Fix possible va_list reuse when race happened in printk_safe().

- Remove %pCr printf format to prevent sleeping in the atomic context.

- Misc vsprintf code cleanup.

----------------------------------------------------------------
Andy Shevchenko (7):
      lib/test_printf: Mark big constant with UL
      lib/vsprintf: Make dec_spec global
      lib/vsprintf: Make strspec global
      lib/vsprintf: Make flag_spec global
      lib/vsprintf: Move pointer_string() upper
      lib/vsprintf: Deduplicate pointer_string()
      lib/vsprintf: Mark expected switch fall-through

Geert Uytterhoeven (4):
      clk: renesas: cpg-mssr: Stop using printk format %pCr
      thermal: bcm2835: Stop using printk format %pCr
      serial: sh-sci: Stop using printk format %pCr
      lib/vsprintf: Remove atomic-unsafe support for %pCr

Petr Mladek (2):
      Merge branch 'for-4.18-vsprintf-cleanup' into for-4.18
      Merge branch 'for-4.18-vsprintf-pcr-removal' into for-4.18

Sergey Senozhatsky (3):
      vsprintf: Tweak pF/pf comment
      printk: wake up klogd in vprintk_emit
      printk: drop in_nmi check from printk_safe_flush_on_panic()

Shunyong Yang (1):
      lib/vsprintf: Replace space with '_' before crng is ready

Tetsuo Handa (1):
      printk: fix possible reuse of va_list variable

 Documentation/core-api/printk-formats.rst  |   3 +-
 drivers/clk/renesas/renesas-cpg-mssr.c     |   9 +-
 drivers/thermal/broadcom/bcm2835_thermal.c |   4 +-
 drivers/tty/serial/sh-sci.c                |   4 +-
 kernel/printk/printk.c                     |  14 +--
 kernel/printk/printk_safe.c                |   7 +-
 lib/test_printf.c                          |   2 +-
 lib/vsprintf.c                             | 133 ++++++++++++-----------------
 8 files changed, 71 insertions(+), 105 deletions(-)
