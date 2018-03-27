Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeC0QT2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 12:19:28 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38672 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeC0QT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 12:19:26 -0400
X-Google-Smtp-Source: AG47ELsNY668FtDAsGwErL7RfG+MeKpn6ZqRQ0mEcxTHD92rcR2VPReUPzuRB3vqDbTT6lFSOGFTxQ==
Subject: Make set_handle_irq and handle_arch_irq generic, v4
Date: Tue, 27 Mar 2018 09:19:03 -0700
Message-Id: <20180327161911.14086-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
Cc: Arnd Bergmann <arnd@arndb.de>
From: Palmer Dabbelt <palmer@sifive.com>
To: linux@armlinux.org.uk, catalin.marinas@arm.com,
        Will Deacon <will.deacon@arm.com>, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is my third version of this patch set, but the original cover
letter is still the most relevant description I can come up with.

    This patch set has been sitting around for a while, but it got a bit lost
    in the shuffle.  In RISC-V land we currently couple do_IRQ (the C entry
    point for interrupt handling) to our first-level interrupt controller.
    While this isn't completely crazy (as the first-level interrupt controller
    is specified by the ISA), it is a bit awkward.

    This patch set decouples our trap handler from our first-level IRQ chip
    driver by copying what a handful of other architectures are doing.  This
    does add an additional load to the interrupt handling path, but there's a
    handful of performance problems in there that I've been meaning to look at
    so I don't mind adding another one for now.  The advantage is that our
    irqchip driver is decoupled from our arch port, at least at compile time.

Hopefully this time I've managed to produce a properly bisectable patch
set.  There were two big bugs in the last version:

* I missed the generic irqchip drivers that set MULTI_IRQ_HANDLER.  This
  caused all sorts of non-defconfig ARM builds to fail.
* MULTI_IRQ_HANDLER and GENERIC_IRQ_MULTI_HANDLER could both get set by
  randconfig builds.  This caused the patch set to be non-bisectable.

I've gone through a bit of a song-and-dance to work around these, but I
think it's sound.  The patch set works as follows (the order is
important):

* MULTI_IRQ_HANDLER is added to the arm64 and openriscv ports,
  forced to true.  Nothing in these ports actually looks at
  CONFIG_MULTI_IRQ_HANDLER (it's forced to true anyway, so there's no
  point in looking), it's just there to indicate that set_handle_irq()
  is defined by these ports.
* Every generic irqchip driver is modified to set
  GENERIC_IRQ_MULTI_HANDLER, but only if MULTI_IRQ_HANDLER is false.
  These generic drivers depend on set_handle_irq() so they need one of
  these symbols to be set, but the two Kconfig symbols are mutually
  exclusive so I can't just select both (I just found out that select
  ignores dependencies :)).
* GENERIC_IRQ_MULTI_HANDLER is added to all ports, with a dependency on
  !MULTI_IRQ_HANDLER as they define the same symbols.
* Support for GENERIC_IRQ_MULTI_HANDLER is added to the RISC-V, arm,
  arm64, and openrisc ports.  This is a pretty mechanical change for
  the other ports (just changing the #ifdefs), and a simple one for the
  RISC-V port.

This patch set assumes that the two patches currently on tip are
dropped, but if that's not OK then I can create another patch set based
on those two.  Of course, it won't be fully bisectable (arm randconfig
will still be broken somewhere in the middle).

I built this patch set after patches 3, 7, and 8 on arm, arm64, and
openrisc defconfigs as well as an arm randconfig that broke my v3 patch
set.

Sorry for breaking things, hopefully it works this time!

Changes since v3:

* There's now three new patches: #1 and #2 add MULTI_IRQ_HANDLER on
  arm64 and openrisc so they match ARM, while #8 removes all
  MULTI_IRQ_HANDLER references.
* All the generic irqchip drivers have been converted from
  MULTI_IRQ_HANDLER to GENERIC_IRQ_MULTI_HANDLER.
* A handful of commit messages have been cleaned up.

Changes since v2:

* This is now called CONFIG_GENERIC_IRQ_MULTI_HANDLER instead of
  MULTI_IRQ_HANDLER.
* Rather than converting the ARM code to generic code, this adds new
  generic code (based on the ARM implementation) and then provides
  separate patches to convert each architecture over to use
  CONFIG_GENERIC_IRQ_MULTI_HANDLER.

Changes since v1:

* I based this on arm instead of arm64, which means we guard the selection of
  these routines with CONFIG_MULTI_IRQ_HANDLER.
* The changes are in kernel/irq/handle.c and include/linux/irq.h instead of
  lib.
* I've converted the arm, arm64, and openrisc ports to use the generic versions
  of these routines.

[PATCH v4 1/8] arm64: Set CONFIG_MULTI_IRQ_HANDLER
[PATCH v4 2/8] openrisc: Set CONFIG_MULTI_IRQ_HANDLER
[PATCH v4 3/8] irq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER
[PATCH v4 4/8] RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER
[PATCH v4 5/8] arm: Convert to GENERIC_IRQ_MULTI_HANDLER
[PATCH v4 6/8] arm64: Use the new GENERIC_IRQ_MULTI_HANDLER
[PATCH v4 7/8] openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER
[PATCH v4 8/8] irq: Remove MULTI_IRQ_HANDLER as it's now obselete
