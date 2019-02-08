Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE279C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C718720863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbfBHPI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:08:29 -0500
Received: from verein.lst.de ([213.95.11.211]:42835 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbfBHPI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:08:28 -0500
Received: by newverein.lst.de (Postfix, from userid 2005)
        id 44EBC68DD2; Fri,  8 Feb 2019 16:08:26 +0100 (CET)
To:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org
Subject: [PATCH v8 0/5] arm64: ftrace with regs
Message-Id: <20190208150826.44EBC68DD2@newverein.lst.de>
Date:   Fri,  8 Feb 2019 16:08:26 +0100 (CET)
From:   duwe@lst.de (Torsten Duwe)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series v8, as discussed.
The whole series applies cleanly on 5.0-rc5

---
 arch/arm64/Kconfig                    |    4 +
 arch/arm64/Makefile                   |   10 ++
 arch/arm64/include/asm/ftrace.h       |   16 ++++
 arch/arm64/include/asm/module.h       |    3 
 arch/arm64/kernel/Makefile            |   12 +--
 arch/arm64/kernel/entry-ftrace.S      |  125 ++++++++++++++++++++++++++++++++--
 arch/arm64/kernel/ftrace.c            |  117 ++++++++++++++++++++++++-------
 arch/arm64/kernel/module-plts.c       |    3 
 arch/arm64/kernel/module.c            |    2 
 arch/arm64/lib/Makefile               |    4 -
 drivers/firmware/efi/libstub/Makefile |   12 +--
 include/asm-generic/vmlinux.lds.h     |    2 
 include/linux/compiler_types.h        |    4 +
 kernel/module.c                       |   14 +++
 mm/kasan/Makefile                     |    8 +-
 15 files changed, 281 insertions(+), 55 deletions(-)
---
changes since v7:

* -pg -> $(CC_FLAGS_FTRACE) cleanup now split according to subtree
  maintainership.

* REC_IP_BRANCH_OFFSET is gone, the functionality went into
  ftrace_call_adjust(), where it belongs.

* MOV_X9_X30 macro is gone (why did we argue about its name anyway?);
  it is only used once now in the initial ftrace_make_nop new helper
  function ftrace_setup_lr_saver(), suggested by Julien.

* call site processing was missing for modules. Fixed.

changes since v6:

* change the stack layout once more; I hope I have it the "standard" way now.
  And yes, it looks simpler and cleaner; thanks, Mark, for nagging.

* split out the independent Kconfig and Makefile changes

* fixed style issues

* s/fp/x29/g

* MCOUNT_ADDR is now merely a 64-bit magic, as this is totally sufficient.

* QUICK_LR_SAVE renamed back to MOV_X9_X30.

* place MOV_X9_X30 insns on bootup, and only flip b <-> nop at runtime

* graph tracer "ifdeffery" reshuffle

	Torsten
  
