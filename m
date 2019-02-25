Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59358C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F452087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfBYUDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:03:18 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40942 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfBYUDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:03:17 -0500
Received: by mail-qk1-f194.google.com with SMTP id h28so6135587qkk.7;
        Mon, 25 Feb 2019 12:03:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZSxQE4/2QNpabhVEG2mIIDEhEuEwdxMsncM5Qr1jX0k=;
        b=i1N0iOYiG0Xs7yRG5pD6q+mN4ZhKMIge/yZ4NEJm0Pu3LnKhTCg99/bx/xDPanURhD
         uc62gcFaUxw6gQ7fAmbbeml7hk+oGNusg7k3+Ikh/Nk/cy5PG9Ozd3MfD5xBotLrE4jV
         31fCu8GxLOpxNHMAC5W7bcdGCX2cK2m6/xtGkYRJXFQbAT15wNqrqIoE3lol/b2yDh+T
         JKvhmI103EDp/SPeBPf4xbKeoSzUvAHmD0kQN0yrLVAoQmCxo9EuRQR1NyCBNQmdO6Y8
         ErDzG+LytIm9uNXG4YQ2eKi/+RVdZtEehcIZbhEFcwSO1DVsfPcQ6UCKjex9A7yZK811
         epKQ==
X-Gm-Message-State: AHQUAua9/nNwXvOFKksEXrbOiDqXS2YflcZMDY2wlMUu/W7Qv6oRy3vI
        40IziCJNXMi2n6hUCkkbRZ25QzYYSXbNwJsDQvc=
X-Google-Smtp-Source: AHgI3IblkfCFtb396nkfXi7Y5HTrdw60jicFKYXo8zDyfoe4Sn1fdzpwS8iMIzdW1Y78pIqnz8Oshxgtd72ddKGUpUc=
X-Received: by 2002:a37:7cf:: with SMTP id 198mr14261456qkh.173.1551124996030;
 Mon, 25 Feb 2019 12:03:16 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 25 Feb 2019 21:03:00 +0100
Message-ID: <CAK8P3a1ZZkBu0zhfATv12OeCtyE5hjSpqt=BOLqkh75U18Z0aA@mail.gmail.com>
Subject: [GIT PULL] y2038: additional syscall ABI cleanup
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        linux-riscv@lists.infradead.org,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 48166e6ea47d23984f0b481ca199250e1ce0730a:

  y2038: add 64-bit time_t syscalls to all 32-bit architectures
(2019-02-07 00:13:28 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
tags/y2038-syscall-abi

for you to fetch changes up to d4c08b9776b392e20efc6198ebe1bc8ec1911d9b:

  riscv: Use latest system call ABI (2019-02-25 20:53:52 +0100)

----------------------------------------------------------------
y2038: additional syscall ABI cleanup

This is a follow-up to the y2038 syscall patches already merged in the tip
tree.  As the final 32-bit RISC-V syscall ABI is still being decided on,
this is the last chance to make a few corrections to leave out interfaces
based on 32-bit time_t along with the old off_t and rlimit types.

The series achieves this in a few steps:

- A couple of bug fixes for minor regressions I introduced
  in the original series

- A couple of older patches from Yury Norov that I had never
  merged in the past, these fix up the openat/open_by_handle_at and
  getrlimit/setrlimit syscalls to disallow the old versions of off_t
  and rlimit.

- Hiding the deprecated system calls behind an #ifdef in
  include/uapi/asm-generic/unistd.h

- Change arch/riscv to drop all these ABIs.

Originally, the plan was to also leave these out on C-Sky, but that now
has a glibc port that uses the older interfaces, so we need to leave
them in place.

----------------------------------------------------------------

Arnd Bergmann (4):
      asm-generic: Make time32 syscall numbers optional
      unicore32: Fix __ARCH_WANT_STAT64 definition
      checksyscalls: fix up mq_timedreceive and stat exceptions
      riscv: Use latest system call ABI

Yury Norov (3):
      compat ABI: use non-compat openat and open_by_handle_at variants
      32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
      asm-generic: Drop getrlimit and setrlimit syscalls from default list

 arch/Kconfig                             | 10 ++++++++++
 arch/arc/Kconfig                         |  1 +
 arch/arc/include/uapi/asm/unistd.h       |  2 ++
 arch/arm/Kconfig                         |  1 +
 arch/arm64/include/uapi/asm/unistd.h     |  2 ++
 arch/c6x/Kconfig                         |  1 +
 arch/c6x/include/uapi/asm/unistd.h       |  2 ++
 arch/csky/Kconfig                        |  1 +
 arch/csky/include/uapi/asm/unistd.h      |  2 ++
 arch/h8300/Kconfig                       |  1 +
 arch/h8300/include/uapi/asm/unistd.h     |  2 ++
 arch/hexagon/Kconfig                     |  1 +
 arch/hexagon/include/uapi/asm/unistd.h   |  2 ++
 arch/m68k/Kconfig                        |  1 +
 arch/microblaze/Kconfig                  |  1 +
 arch/mips/Kconfig                        |  1 +
 arch/nds32/Kconfig                       |  1 +
 arch/nds32/include/uapi/asm/unistd.h     |  2 ++
 arch/nios2/Kconfig                       |  1 +
 arch/nios2/include/uapi/asm/unistd.h     |  2 ++
 arch/openrisc/Kconfig                    |  1 +
 arch/openrisc/include/uapi/asm/unistd.h  |  2 ++
 arch/parisc/Kconfig                      |  1 +
 arch/powerpc/Kconfig                     |  1 +
 arch/riscv/include/uapi/asm/unistd.h     |  1 +
 arch/riscv/kernel/vdso/Makefile          |  2 ++
 arch/sh/Kconfig                          |  1 +
 arch/sparc/Kconfig                       |  1 +
 arch/unicore32/Kconfig                   |  1 +
 arch/unicore32/include/uapi/asm/unistd.h |  4 +++-
 arch/x86/Kconfig                         |  1 +
 arch/x86/um/Kconfig                      |  1 +
 arch/xtensa/Kconfig                      |  1 +
 include/linux/fcntl.h                    |  2 +-
 include/uapi/asm-generic/unistd.h        | 46
+++++++++++++++++++++++++++++++++++++++++++---
 scripts/checksyscalls.sh                 | 15 ++++++++++++---
 36 files changed, 110 insertions(+), 8 deletions(-)
