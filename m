Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ED8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A43721841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 23:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfBHXEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 18:04:55 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39970 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBHXEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 18:04:55 -0500
Received: by mail-qt1-f196.google.com with SMTP id j36so5872376qta.7;
        Fri, 08 Feb 2019 15:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GWnKTS8PcvSpGtSNLMzzyLJjbWcCiiXJ3eevLezV0CM=;
        b=gM2gFDqese9WAwi6HYBImuzwTmy6WsKitIzLALm2bcqvD9itAbZ8ik/qv0rYyCxHpp
         wTwkpBa4dN42RlcGk+8oFQ+kve46CzGTk/Rp0icmKJhn8Cl6Mgr8F8ImjrplAYQ6UE1v
         SDPk2FHueVNwTdn7DnyWC64lngv2oZ+lAASZGyL4kiWD36GhZy3lRrqH85UJA5UAT+Sf
         DHylpLHP34Q7JtZEeJst7dc5yH8uIQ0Wojz5CDsLkgBWNU825zDG4pMvVquAYBgIc5oQ
         Xspy/ifK4hq07WSHlfKq05Q8xI8NEvm/Nmr2EKv3wO+EriIsJZ27ZesqoX10psgkfLmc
         6A0A==
X-Gm-Message-State: AHQUAuYQFtW6lOa9LTtltl06QhsDvyEiJcTPN5WR0e6Zc6WD3UTLjrNZ
        BDWhMXq3F9Wvev9j3hsYv7ARF0NW7kjXvM13ahbtR9X8
X-Google-Smtp-Source: AHgI3IYtOcvuR2xGNJjMADge+PUWCY4jwMBgndHQPhUM+IsakDkFzzJX3mcuFX4xbxg/MuNT7vF83xBD1D+9V1UjTyE=
X-Received: by 2002:a0c:d791:: with SMTP id z17mr8606154qvi.149.1549667093790;
 Fri, 08 Feb 2019 15:04:53 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 9 Feb 2019 00:04:37 +0100
Message-ID: <CAK8P3a3pPwnOW7pXjOhU386zCekAda+p8AgzbOM6ybT=dKMGwA@mail.gmail.com>
Subject: [GIT PULL 1/2] arch: System call unification and cleanup
To:     Thomas Gleixner <tglx@linutronix.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:

  Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)

are available in the Git repository at:

  git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-syscall-cleanup

for you to fetch changes up to 805089c2f77047d81f47ddc227435d606ceb180e:

  syscalls: remove obsolete __IGNORE_ macros (2019-02-07 00:13:27 +0100)

----------------------------------------------------------------
arch: System call unification and cleanup

The system call tables have diverged a bit over the years, and a number
of the recent additions never made it into all architectures, for one
reason or another.

This is an attempt to clean it up as far as we can without breaking
compatibility, doing a number of steps:

- Add system calls that have not yet been integrated into all
  architectures but that we definitely want there. This includes
  {,f}statfs64() and get{eg,eu,g,p,u,pp}id() on alpha, which have
  been missing traditionally.

- The s390 compat syscall handling is cleaned up to be more like
  what we do on other architectures, while keeping the 31-bit
  pointer extension. This was merged as a shared branch by the
  s390 maintainers and is included here in order to base the other
  patches on top.

- Add the separate ipc syscalls on all architectures that
  traditionally only had sys_ipc(). This version is done without
  support for IPC_OLD that is we have in sys_ipc. The
  new semtimedop_time64 syscall will only be added here, not
  in sys_ipc

- Add syscall numbers for a couple of syscalls that we probably
  don't need everywhere, in particular pkey_* and rseq,
  for the purpose of symmetry: if it's in asm-generic/unistd.h,
  it makes sense to have it everywhere. I expect that any future
  system calls will get assigned on all platforms together, even
  when they appear to be specific to a single architecture.

- Prepare for having the same system call numbers for any future
  calls. In combination with the generated tables, this hopefully
  makes it easier to add new calls across all architectures
  together.

All of the above are technically separate from the y2038 work,
but are done as preparation before we add the new 64-bit time_t
system calls everywhere, providing a common baseline set of system
calls.

I expect that glibc and other libraries that want to use 64-bit
time_t will require linux-5.1 kernel headers for building in
the future, and at a much later point may also require linux-5.1
or a later version as the minimum kernel at runtime. Having a
common baseline then allows the removal of many architecture or
kernel version specific workarounds.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (22):
      s390: open-code s390_personality syscall
      ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
      s390: use generic UID16 implementation
      s390: autogenerate compat syscall wrappers
      s390: remove compat_wrapper.c
      ia64: add __NR_umount2 definition
      ia64: add statx and io_pgetevents syscalls
      ia64: assign syscall numbers for perf and seccomp
      alpha: wire up io_pgetevents system call
      alpha: update syscall macro definitions
      ARM: add migrate_pages() system call
      ARM: add kexec_file_load system call number
      m68k: assign syscall number for seccomp
      sh: remove duplicate unistd_32.h file
      sh: add statx system call
      sparc64: fix sparc_ipc type conversion
      ipc: rename old-style shmctl/semctl/msgctl syscalls
      arch: add split IPC system calls where needed
      arch: add pkey and rseq syscall numbers everywhere
      alpha: add standard statfs64/fstatfs64 syscalls
      alpha: add generic get{eg,eu,g,p,u,pp}id() syscalls
      syscalls: remove obsolete __IGNORE_ macros

 arch/alpha/include/asm/unistd.h             |  21 --
 arch/alpha/include/uapi/asm/unistd.h        |  10 +
 arch/alpha/kernel/syscalls/syscall.tbl      |  20 +-
 arch/arm/include/asm/unistd.h               |   1 -
 arch/arm/tools/syscall.tbl                  |   8 +-
 arch/arm64/include/asm/unistd.h             |   2 +-
 arch/arm64/include/asm/unistd32.h           |  10 +-
 arch/ia64/include/asm/unistd.h              |  14 -
 arch/ia64/include/uapi/asm/unistd.h         |   2 +
 arch/ia64/kernel/syscalls/syscall.tbl       |  10 +-
 arch/m68k/kernel/syscalls/syscall.tbl       |  16 ++
 arch/microblaze/kernel/syscalls/syscall.tbl |   6 +-
 arch/mips/include/asm/unistd.h              |  13 -
 arch/mips/kernel/syscalls/syscall_n32.tbl   |   6 +-
 arch/mips/kernel/syscalls/syscall_n64.tbl   |   6 +-
 arch/mips/kernel/syscalls/syscall_o32.tbl   |  11 +
 arch/parisc/include/asm/unistd.h            |   4 -
 arch/parisc/kernel/syscalls/syscall.tbl     |   4 +
 arch/powerpc/kernel/syscalls/syscall.tbl    |  13 +
 arch/s390/Kconfig                           |   2 +
 arch/s390/include/asm/syscall_wrapper.h     | 135 ++++++++++
 arch/s390/include/asm/unistd.h              |   5 -
 arch/s390/include/uapi/asm/posix_types.h    |   6 +
 arch/s390/kernel/Makefile                   |   2 +-
 arch/s390/kernel/compat_linux.c             | 235 +---------------
 arch/s390/kernel/compat_wrapper.c           | 186 -------------
 arch/s390/kernel/entry.S                    |   4 +-
 arch/s390/kernel/sys_s390.c                 |  16 +-
 arch/s390/kernel/syscalls/syscall.tbl       | 301 +++++++++++----------
 arch/sh/include/uapi/asm/unistd_32.h        | 403 ----------------------------
 arch/sh/kernel/syscalls/syscall.tbl         |  16 ++
 arch/sparc/include/asm/unistd.h             |   5 -
 arch/sparc/kernel/sys_sparc_64.c            |   2 +-
 arch/sparc/kernel/syscalls/syscall.tbl      |  16 ++
 arch/x86/entry/syscalls/syscall_32.tbl      |  11 +
 arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
 arch/xtensa/include/asm/unistd.h            |  12 -
 arch/xtensa/kernel/syscalls/syscall.tbl     |   7 +-
 include/linux/syscalls.h                    |   7 +
 include/uapi/asm-generic/unistd.h           |   1 +
 ipc/msg.c                                   |  39 ++-
 ipc/sem.c                                   |  39 ++-
 ipc/shm.c                                   |  40 ++-
 ipc/syscall.c                               |  32 ++-
 ipc/util.h                                  |  21 +-
 kernel/sys_ni.c                             |   4 +
 46 files changed, 608 insertions(+), 1118 deletions(-)
 create mode 100644 arch/s390/include/asm/syscall_wrapper.h
 delete mode 100644 arch/s390/kernel/compat_wrapper.c
 delete mode 100644 arch/sh/include/uapi/asm/unistd_32.h
