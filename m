Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755123AbeCGX5l (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 18:57:41 -0500
Received: from mail-pl0-f46.google.com ([209.85.160.46]:40029 "EHLO
        mail-pl0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755099AbeCGX5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 18:57:39 -0500
X-Google-Smtp-Source: AG47ELvMsDYfaEI4eC2wifuoApkeks0/Cg44OhIVEILdtEqjwrkkEJ7qhZStDfdTA6JoFxfH3Yb0nQ==
Subject: Make set_handle_irq and handle_arch_irq generic, v3
Date: Wed,  7 Mar 2018 15:57:26 -0800
Message-Id: <20180307235731.22627-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.1
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

I've build tested this with defconfigs on all the modified architectures
after both patch 1 and 5.  I've left the old acks in for the later
patches as the patch set has changed very little since I last submitted
it.

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


[PATCH v3 1/5] irq: Add CONFIG_GENERIC_IRQ_MULTI_HANDLER
[PATCH v3 2/5] RISC-V: Move to the new GENERIC_IRQ_MULTI_HANDLER
[PATCH v3 3/5] arm: Convert to GENERIC_IRQ_MULTI_HANDLER
[PATCH v3 4/5] arm64: Use the new GENERIC_IRQ_MULTI_HANDLER
[PATCH v3 5/5] openrisc: Use the new GENERIC_IRQ_MULTI_HANDLER
