Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF195C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5982086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 17:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B5982086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIYXZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 19:25:51 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:43916 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeIYXZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 19:25:50 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4qxe-0004kk-2C; Tue, 25 Sep 2018 11:17:22 -0600
Received: from [105.184.227.67] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1g4qxN-0001Oy-Fx; Tue, 25 Sep 2018 11:17:21 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     <linux-kernel@vger.kernel.org>
Cc:     <linux-api@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Sep 2018 19:16:51 +0200
Message-ID: <87h8idv6nw.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1g4qxN-0001Oy-Fx;;;mid=<87h8idv6nw.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=105.184.227.67;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/wm5RZQcxt2WGN+93xR6NRyXihVwnfvCs=
X-SA-Exim-Connect-IP: 105.184.227.67
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [REVIEW][PATCH 0/6] signal: Shrinking the kernel's siginfo structure
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I am posting these patches for review in the hopes that if I have missed
something someone else might catch it.  If no issues turn up I intend to
merge these patches through my siginfo branch.

This set of patches make a few small ABI changes to areas of the linux
ABI where as far as I can determine no one cares.

- sigqueueinfo in all it's variants now fails if si_signo != sig
  instead of quietly changing si_signo.

  The deep issue is that the change happens after the code has already
  verified in copy_siginfom_from_user that the si_signo and si_code
  combination is meaningful.

- copy_siginfo_from_user now fails if the trailing bytes of siginfo
  are not 0, when the signal number and si_code combination is not
  recognized.

  If the si_signo and si_code combination is recognized we know any
  trailing bytes are meaningless as the meaningful bytes are in siginfo.

  This check is to allow people to define new siginfo union members and
  that will fail on older kernels.  The check makes it as safe as
  possible to have a kernel_siginfo that is smaller than the ABI defined
  siginfo that the kernel reads from and writes to userspace.

The net effect of this change is a kernel that only uses 48 bytes for
siginfo internally when the ABI defines siginfo to be 128 bytes.

The first EMT_TAGOVF change is not necesssary to strinking siginfo.

Eric W. Biederman (6):
      signal/sparc: Move EMT_TAGOVF into the generic siginfo.h
      signal: Fail sigqueueinfo if si_signo != sig
      signal: Remove the need for __ARCH_SI_PREABLE_SIZE and SI_PAD_SIZE
      signal: Introduce copy_siginfo_from_user and use it's return value
      signal: Distinguish between kernel_siginfo and siginfo
      signal: Use a smaller struct siginfo in the kernel

 arch/alpha/include/uapi/asm/siginfo.h   |   1 -
 arch/arm64/include/uapi/asm/Kbuild      |   1 +
 arch/arm64/include/uapi/asm/siginfo.h   |  24 ---
 arch/ia64/include/uapi/asm/siginfo.h    |   2 -
 arch/mips/include/uapi/asm/siginfo.h    |  11 --
 arch/parisc/include/uapi/asm/Kbuild     |   1 +
 arch/parisc/include/uapi/asm/siginfo.h  |  11 --
 arch/powerpc/include/uapi/asm/Kbuild    |   1 +
 arch/powerpc/include/uapi/asm/siginfo.h |  18 ---
 arch/riscv/include/uapi/asm/Kbuild      |   1 +
 arch/riscv/include/uapi/asm/siginfo.h   |  24 ---
 arch/s390/include/uapi/asm/Kbuild       |   1 +
 arch/s390/include/uapi/asm/siginfo.h    |  17 ---
 arch/sparc/include/uapi/asm/siginfo.h   |   7 -
 arch/x86/include/asm/compat.h           |   2 +-
 arch/x86/include/uapi/asm/siginfo.h     |   2 -
 drivers/usb/core/devio.c                |   4 +-
 fs/binfmt_elf.c                         |   6 +-
 fs/coredump.c                           |   2 +-
 fs/fcntl.c                              |   2 +-
 fs/signalfd.c                           |   6 +-
 include/linux/binfmts.h                 |   2 +-
 include/linux/compat.h                  |   4 +-
 include/linux/coredump.h                |   4 +-
 include/linux/lsm_hooks.h               |   4 +-
 include/linux/posix-timers.h            |   2 +-
 include/linux/ptrace.h                  |   2 +-
 include/linux/sched.h                   |   2 +-
 include/linux/sched/signal.h            |  18 +--
 include/linux/security.h                |   6 +-
 include/linux/signal.h                  |  16 +-
 include/linux/signal_types.h            |   8 +-
 include/trace/events/signal.h           |   4 +-
 include/uapi/asm-generic/siginfo.h      | 193 ++++++++++++-----------
 ipc/mqueue.c                            |   2 +-
 kernel/ptrace.c                         |  22 ++-
 kernel/seccomp.c                        |   6 +-
 kernel/signal.c                         | 263 ++++++++++++++++++++++----------
 kernel/time/posix-timers.c              |   2 +-
 security/apparmor/lsm.c                 |   2 +-
 security/security.c                     |   2 +-
 security/selinux/hooks.c                |   2 +-
 security/smack/smack_lsm.c              |   2 +-
 43 files changed, 356 insertions(+), 356 deletions(-)

Eric

