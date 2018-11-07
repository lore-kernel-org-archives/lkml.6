Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1A3C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5BE920837
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 19:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5BE920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeKHFXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:23:53 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41829 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeKHFVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:21:02 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gKTp3-00070Q-Ut; Wed, 07 Nov 2018 20:49:06 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v4] x86: load FPU registers on return to userland
Date:   Wed,  7 Nov 2018 20:48:35 +0100
Message-Id: <20181107194858.9380-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a refurbished series originally started by by Rik van Riel. The
goal is load the FPU registers on return to userland and not on every
context switch. By this optimisation we can:
- avoid loading the registers if the task stays in kernel and does
  not return to userland
- make kernel_fpu_begin() cheaper: it only saves the registers on the
  first invocation. The second invocation does not need save them again.

To access the FPU registers in kernel we need:
- disable preemption to avoid that the scheduler switches tasks. By
  doing so it would set TIF_NEED_FPU_LOAD and the FPU registers would be
  not valid.
- disable BH because the softirq might use kernel_fpu_begin() and then
  set TIF_NEED_FPU_LOAD instead loading the FPU registers on completion.

v3…v4:
It has been suggested to remove the `initialized' member of the struct
fpu because it should not required be needed with lazy-FPU-restore and
would make the review easier. This is the first part of the series, the
second is basically the rebase of the v3 queue. As a result, the
diffstat became negative (which wasn't the case in previous version) :)
I tried to incorporate all the review comments that came up, some of
them were "outdated" after the removal of the `initialized' member. I'm
sorry should I missed any.

v1…v3:
v2 was never posted. I followed the idea to completely decouple PKRU
from xstate. This didn't quite work and made a few things complicated. 
One obvious required fixup is copy_fpstate_to_sigframe() where the PKRU
state needs to be fiddled into xstate. This required another
xfeatures_mask so that the sanity checks were performed and
xstate_offsets would be computed. Additionally ptrace also reads/sets
xstate in order to get/set the register and PKRU is one of them. So this
would need some fiddle, too.
In v3 I dropped that decouple idea. I also learned that the wrpkru
instruction is not privileged and so caching it in kernel does not work.
Instead I keep PKRU in xstate area and load it at context switch time
while the remaining registers are deferred (until return to userland).
The offset of PKRU within xstate is enumerated at boot time so why not
use it.

Rik van Riel (5):
  x86/fpu: Add (__)make_fpregs_active helpers
  x86/fpu: Eager switch PKRU state
  x86/fpu: Always store the registers in copy_fpstate_to_sigframe()
  x86/fpu: Prepare copy_fpstate_to_sigframe() for TIF_NEED_FPU_LOAD
  x86/fpu: Defer FPU state load until return to userspace

Sebastian Andrzej Siewior (18):
  x86/fpu: Use ULL for shift in xfeature_uncompacted_offset()
  x86/fpu: Remove fpu->initialized usage in __fpu__restore_sig()
  x86/fpu: Remove fpu__restore()
  x86/entry/32: Remove asm/math_emu.h include
  x86/fpu: Remove preempt_disable() in fpu__clear()
  x86/fpu: Always init the `state' in fpu__clear()
  x86/fpu: Remove fpu->initialized usage in copy_fpstate_to_sigframe()
  x86/fpu: Remove fpu->initialized
  x86/fpu: Remove user_fpu_begin()
  x86/entry: Remove _TIF_ALLWORK_MASK
  x86/fpu: Make __raw_xsave_addr() use feature number instead of mask
  x86/fpu: Make get_xsave_field_ptr() and get_xsave_addr() use feature
    number instead of mask
  x86/pkeys: Make init_pkru_value static
  x86/fpu: Only write PKRU if it is different from current
  x86/pkeys: Don't check if PKRU is zero before writting it
  x86/entry: Add TIF_NEED_FPU_LOAD
  x86/fpu: Update xstate's PKRU value on write_pkru()
  x86/fpu: Don't restore the FPU state directly from userland in
    __fpu__restore_sig()

 Documentation/preempt-locking.txt    |   1 -
 arch/x86/entry/common.c              |   8 ++
 arch/x86/ia32/ia32_signal.c          |  17 +--
 arch/x86/include/asm/fpu/api.h       |  25 ++++
 arch/x86/include/asm/fpu/internal.h  | 149 ++++++----------------
 arch/x86/include/asm/fpu/signal.h    |   2 +-
 arch/x86/include/asm/fpu/types.h     |   9 --
 arch/x86/include/asm/fpu/xstate.h    |   6 +-
 arch/x86/include/asm/pgtable.h       |  19 ++-
 arch/x86/include/asm/special_insns.h |  13 +-
 arch/x86/include/asm/thread_info.h   |  10 +-
 arch/x86/include/asm/trace/fpu.h     |   8 +-
 arch/x86/kernel/fpu/core.c           | 181 +++++++++++++--------------
 arch/x86/kernel/fpu/init.c           |   2 -
 arch/x86/kernel/fpu/regset.c         |  24 +---
 arch/x86/kernel/fpu/signal.c         | 133 +++++++++-----------
 arch/x86/kernel/fpu/xstate.c         |  45 ++++---
 arch/x86/kernel/process.c            |   2 +-
 arch/x86/kernel/process_32.c         |  14 +--
 arch/x86/kernel/process_64.c         |  11 +-
 arch/x86/kernel/signal.c             |  17 ++-
 arch/x86/kernel/traps.c              |   2 +-
 arch/x86/kvm/x86.c                   |  47 ++++---
 arch/x86/math-emu/fpu_entry.c        |   3 -
 arch/x86/mm/mpx.c                    |   6 +-
 arch/x86/mm/pkeys.c                  |  15 +--
 26 files changed, 343 insertions(+), 426 deletions(-)

 git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git x86_fpu_rtu_v4

Sebastian

