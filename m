Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25899C43444
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE08F20665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 11:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfAILsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 06:48:07 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:56102 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbfAILsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 06:48:06 -0500
Received: from localhost ([127.0.0.1] helo=bazinga.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1ghCL1-0007Al-9U; Wed, 09 Jan 2019 12:47:59 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH v6] x86: load FPU registers on return to userland
Date:   Wed,  9 Jan 2019 12:47:22 +0100
Message-Id: <20190109114744.10936-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.20.1
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

v5…v6:
Rebased on top of v5.0-rc1. Integrated a few fixes which I noticed while
looking over the patches, dropped the first few patches which were
already applied.

v4…v5:
Rebased on top of a fix, noticed a problem with XSAVES and then redid
the restore on sig return (patch #26 to #28).

I don't like very much the sig save+restore thing that we are doing. It
has been always like that. I *think* that this is just because we have
nowhere to stash the FPU state while we are handling the signal. We
could add another fpu->state for the signal handler and avoid the thing.
Debian code-search revealed that `criu' is using it (and I didn't
figure out why). Nothing else (that is packaged in Debian). Maybe we
could get rid of this and if `criu' would then use a dedicated interface
for its needs rather the signal interface that happen to do what it
wants :)

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

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bigeasy/staging.git x86_fpu_rtu_v6

for you to fetch changes up to b7b783d84166b6b74aed2bfd4a07128ff303fed6:

  x86/fpu: Defer FPU state load until return to userspace (2019-01-07 11:32:57 +0100)

----------------------------------------------------------------
Rik van Riel (5):
      x86/fpu: Add (__)make_fpregs_active helpers
      x86/fpu: Eager switch PKRU state
      x86/fpu: Always store the registers in copy_fpstate_to_sigframe()
      x86/fpu: Prepare copy_fpstate_to_sigframe() for TIF_NEED_FPU_LOAD
      x86/fpu: Defer FPU state load until return to userspace

Sebastian Andrzej Siewior (17):
      x86/fpu: Remove fpu->initialized usage in __fpu__restore_sig()
      x86/fpu: Remove fpu__restore()
      x86/fpu: Remove preempt_disable() in fpu__clear()
      x86/fpu: Always init the `state' in fpu__clear()
      x86/fpu: Remove fpu->initialized usage in copy_fpstate_to_sigframe()
      x86/fpu: Don't save fxregs for ia32 frames in copy_fpstate_to_sigframe()
      x86/fpu: Remove fpu->initialized
      x86/fpu: Remove user_fpu_begin()
      x86/fpu: Make __raw_xsave_addr() use feature number instead of mask
      x86/fpu: Make get_xsave_field_ptr() and get_xsave_addr() use feature number instead of mask
      x86/fpu: Only write PKRU if it is different from current
      x86/pkeys: Don't check if PKRU is zero before writting it
      x86/entry: Add TIF_NEED_FPU_LOAD
      x86/fpu: Update xstate's PKRU value on write_pkru()
      x86/fpu: Inline copy_user_to_fpregs_zeroing()
      x86/fpu: Let __fpu__restore_sig() restore the !32bit+fxsr frame from kernel memory
      x86/fpu: Merge the two code paths in __fpu__restore_sig()

 Documentation/preempt-locking.txt    |   1 -
 arch/x86/entry/common.c              |   8 ++
 arch/x86/ia32/ia32_signal.c          |  17 +--
 arch/x86/include/asm/fpu/api.h       |  31 ++++++
 arch/x86/include/asm/fpu/internal.h  | 151 +++++++++++---------------
 arch/x86/include/asm/fpu/signal.h    |   2 +-
 arch/x86/include/asm/fpu/types.h     |   9 --
 arch/x86/include/asm/fpu/xstate.h    |   5 +-
 arch/x86/include/asm/pgtable.h       |  20 +++-
 arch/x86/include/asm/special_insns.h |  13 ++-
 arch/x86/include/asm/thread_info.h   |   2 +
 arch/x86/include/asm/trace/fpu.h     |   8 +-
 arch/x86/kernel/fpu/core.c           | 193 ++++++++++++++++-----------------
 arch/x86/kernel/fpu/init.c           |   2 -
 arch/x86/kernel/fpu/regset.c         |  24 +---
 arch/x86/kernel/fpu/signal.c         | 205 ++++++++++++++++-------------------
 arch/x86/kernel/fpu/xstate.c         |  43 ++++----
 arch/x86/kernel/process.c            |   2 +-
 arch/x86/kernel/process_32.c         |  11 +-
 arch/x86/kernel/process_64.c         |  11 +-
 arch/x86/kernel/signal.c             |  17 ++-
 arch/x86/kernel/traps.c              |   2 +-
 arch/x86/kvm/x86.c                   |  48 +++++---
 arch/x86/math-emu/fpu_entry.c        |   3 -
 arch/x86/mm/mpx.c                    |   6 +-
 arch/x86/mm/pkeys.c                  |  14 +--
 26 files changed, 411 insertions(+), 437 deletions(-)

