Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5943AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BFF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbfBLOax (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:30:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:43848 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbfBLOav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:30:51 -0500
Received: from [5.158.153.53] (helo=linux.lab.linutronix.de.)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1gtZ4c-0005Af-6o; Tue, 12 Feb 2019 15:30:10 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Wang <wonderfly@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Peter Feiner <pfeiner@google.com>,
        linux-serial@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [RFC PATCH v1 00/25] printk: new implementation
Date:   Tue, 12 Feb 2019 15:29:38 +0100
Message-Id: <20190212143003.48446-1-john.ogness@linutronix.de>
X-Mailer: git-send-email 2.11.0
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

As probably many of you are aware, the current printk implementation
has some issues. This series (against 5.0-rc6) makes some fundamental
changes in an attempt to address these issues. The particular issues I
am referring to:

1. The printk buffer is protected by a global raw spinlock for readers
   and writers. This restricts the contexts that are allowed to
   access the buffer.

2. Because of #1, NMI and recursive contexts are handled by deferring
   logging/printing to a spinlock-safe context. This means that
   messages will not be visible if (for example) the kernel dies in
   NMI context and the irq_work mechanism does not survive.

3. Because of #1, when *not* using features such as PREEMPT_RT, large
   latencies exist when printing to slow consoles.

4. Because of #1, when _using_ features such as PREEMPT_RT, printing
   to the consoles is further restricted to contexts that can sleep.
   This can cause large latencies in seeing the messages.

5. Printing to consoles is the responsibility of the printk caller
   and that caller may be required to print many messages that other
   printk callers inserted. Because of this there can be enormous
   variance in the runtime of a printk call.

6. The timestamps on the printk messages are generated when the
   message is inserted into the buffer. But the call to printk may
   have occurred long before that. This is especially true for
   messages in the printk_safe context. This means that printk timing
   information (although neatly "sorted") is neither accurate nor
   reliable.

7. Loglevel INFO is handled the same as ERR. There seems to be an
   endless effort to get printk to show _all_ messages as quickly as
   possible in case of a panic (i.e. printing from any context), but
   at the same time try not to have printk be too intrusive for the
   callers. These are conflicting requirements that lead to a printk
   implementation that does a sub-optimal job of satisfying both
   sides.

To address these issues this series makes the following changes:

- Implements a new printk ringbuffer that supports lockless multiple
  readers. Writers are synchronized per-cpu with support for all
  contexts (including NMI). (This implementation was inspired by a
  post[0] from Peter Zijlstra.)

- The new printk ringbuffer uses the initialized data segment of the
  kernel for its data buffer so that it is available on early boot.

- Timestamps are captured at the beginning of the printk call.

- A dedicated kernel thread is created for printing to all consoles in
  a fully preemptible context.

- A new (optional) console operation "write_atomic" is introduced that
  console drivers may implement. This function must be NMI-safe. An
  implementation for the 8250 UART driver is provided.

- The concept of "emergency messages" is introduced that allows
  important messages (based on a new emergency loglevel threshold) to
  be immediately written to any consoles supporting write_atomic,
  regardless of the context. This allows non-emergency printk calls
  (i.e. INFO) to run in nearly constant time, with their console
  printing taking place in a separate fully preemptible context. And
  emergency messages (i.e. ERR) are printed immediately for the user.

- Individual emergency messages are written contiguously and a CPU-ID
  field is added to all output to allow for sorting of messages being
  printed by multiple CPUs simultaneously.

Although the RFC series works, there are some open issues that I chose
to leave open until I received some initial feedback from the community.
These issues are:

- The behavior of LOG_CONT has been changed. Rather than using the
  current task as the "cont owner", the CPU ID is used. NMIs have
  their own cont buffer so NMI and non-NMI tasks can safely use
  LOG_CONT.

- The runtime resizing features of the printk buffer are not
  implemented.

- The exported vmcore symbols relating to the printk buffer no longer
  exist and no replacements have been defined. I do not know all the
  userspace consequences of making a change here.

- The introduction of the CPU-ID field not only changes the usual
  printk output, but also defines a new field in the extended console
  output. I do not know the userspace consequences of making a change
  here.

- console_flush_on_panic() currently is a NOP. It is pretty clear how
  this could be implemented if atomic_write was available. But if no
  such console is registered, it is not clear what should be done. Is
  this function really even needed?

- Right now the emergency messages are set apart from the
  non-emergency messages using '\n'. There have been requests that
  some special markers could be specifiable to make it easier for
  parsers. Possibly as CONFIG_ and boot options?

- Be aware that printk output is no longer time-sorted. Actually, it
  never was, but now you see the real timestamps. This seems strange
  at first.

- The ringbuffer API is not very pretty. It grew to be what it is
  due to the varying requirements of the different aspects of printk
  (syslog, kmsg_dump, /dev/kmsg, console) and the complexity of
  handling lockless reading, which can fall behind at any moment.

- Memory barriers are not my specialty. A critical eye on their
  usage (or lack thereof) in the ringbuffer code would be greatly
  appreciated.

The first 7 patches introduce the new printk ringbuffer. The
remaining 18 go through and replace the various components of the
printk implementation. All patches are against 5.0-rc6 and each
yield a buildable/testable system.

John Ogness

[0] http://lkml.kernel.org/r/20181017140044.GK3121@hirez.programming.kicks-ass.net

John Ogness (25):
  printk-rb: add printk ring buffer documentation
  printk-rb: add prb locking functions
  printk-rb: define ring buffer struct and initializer
  printk-rb: add writer interface
  printk-rb: add basic non-blocking reading interface
  printk-rb: add blocking reader support
  printk-rb: add functionality required by printk
  printk: add ring buffer and kthread
  printk: remove exclusive console hack
  printk: redirect emit/store to new ringbuffer
  printk_safe: remove printk safe code
  printk: minimize console locking implementation
  printk: track seq per console
  printk: do boot_delay_msec inside printk_delay
  printk: print history for new consoles
  printk: implement CON_PRINTBUFFER
  printk: add processor number to output
  console: add write_atomic interface
  printk: introduce emergency messages
  serial: 8250: implement write_atomic
  printk: implement KERN_CONT
  printk: implement /dev/kmsg
  printk: implement syslog
  printk: implement kmsg_dump
  printk: remove unused code

 Documentation/printk-ringbuffer.txt |  377 +++++++
 drivers/tty/serial/8250/8250.h      |    4 +
 drivers/tty/serial/8250/8250_core.c |   19 +-
 drivers/tty/serial/8250/8250_dma.c  |    5 +-
 drivers/tty/serial/8250/8250_port.c |  154 ++-
 fs/proc/kmsg.c                      |    4 +-
 include/linux/console.h             |    6 +
 include/linux/hardirq.h             |    2 -
 include/linux/kmsg_dump.h           |    6 +-
 include/linux/printk.h              |   30 +-
 include/linux/printk_ringbuffer.h   |  114 +++
 include/linux/serial_8250.h         |    5 +
 init/main.c                         |    1 -
 kernel/kexec_core.c                 |    1 -
 kernel/panic.c                      |    3 -
 kernel/printk/Makefile              |    1 -
 kernel/printk/internal.h            |   79 --
 kernel/printk/printk.c              | 1895 +++++++++++++++++------------------
 kernel/printk/printk_safe.c         |  427 --------
 kernel/trace/trace.c                |    2 -
 lib/Kconfig.debug                   |   17 +
 lib/Makefile                        |    2 +-
 lib/bust_spinlocks.c                |    3 +-
 lib/nmi_backtrace.c                 |    6 -
 lib/printk_ringbuffer.c             |  583 +++++++++++
 25 files changed, 2137 insertions(+), 1609 deletions(-)
 create mode 100644 Documentation/printk-ringbuffer.txt
 create mode 100644 include/linux/printk_ringbuffer.h
 delete mode 100644 kernel/printk/internal.h
 delete mode 100644 kernel/printk/printk_safe.c
 create mode 100644 lib/printk_ringbuffer.c

-- 
2.11.0

