Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 340A2C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1F620651
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 13:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393033AbfAPNPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 08:15:41 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:60305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732810AbfAPNPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 08:15:40 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1McpW6-1hIXcy2bvm-00ZyBr; Wed, 16 Jan 2019 14:15:34 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/5] s390: rework compat wrapper generation
Date:   Wed, 16 Jan 2019 14:15:18 +0100
Message-Id: <20190116131527.2071570-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:faJLbYrjfVsWCOx4uF8nvUPoeFUuxSJTgPlDXrgVEwnah50VklL
 yrkbRW/uA8Lof53eYweOQrHH0xcmJz9UATqXoGlRx2NvSMiaJy5ivTQSUbX9ujZpxHr1Ti8
 JY1gNvQcotoN3dOrMf2EomGIOuEcL96Q3xdXryDvS/lEtNl75S6z2N9uMjIBNDp9CvY6VaS
 MfrLadAmNU8ognGsSLtHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sWu9Xx03qVU=:MYzsshH0Hx5YU19ZwHjX42
 M2OFJWY5+6FQARuwbtzncUHOyPTXLPNwVNX16qC0GD0LKsk57e21scDIZRNMtpC1GZP+znQfp
 eRoR9iJ10Rw920xqIhk2xbg1jsvgIoQ6RhFvkSDhYe3JhjPhOT3pCMmtCt7+XTg0qkoslhhi0
 z6iFepDNU1t9zpMnm9A6Ba+whrgPakYnonvX6olYJPCxrBRpirJAkwyCFBbu9qVlhzfSET3ag
 VUJ41U7HMTiIDjLT48wHxAcRIqiXlG3hWxhlvUyfmGV5dQQvAffScYZTeiKhqf5auip9qd9W5
 AyZrm9dAc8ry4JcdGQpBPv6REWgrHd3unHnRYR4AmMvwo8WPfLcmj2ZO0Hu3Bv0gib2oTHbm6
 Ep4jHx8JaBYP8JQx2Ps0IwjiyxBjyO134FY+ajgnfTBCpe+Q5W2pCp9V0rWi1rKUcWtd3OrI4
 oVBl3igsfGBWDG/Mjwb4cVD9J2rDjsQoSOfz7NHQYFKAY1IsyHvWeSdVXmR4LMCUoDmncaGMr
 NYRU4/Z/9vFkSKAIOHSYPGrxtF68ufFZQQ56AfXewcMl9CsTjJreAGdHXr0qTWKI5M+9W+h5u
 oIuCOG2u7wBFR7AIRMslgMTqvNqQcarTc4VC0nTF+zWJCC0kpETDOOGbubIY6IS7FikaNKvc1
 P4QArB+uK4h+F3ebY4vLB9WWtkgViJkaBm3gH+rgqNafM7GJIODw3Xx1ai/ATj3/xhTkO1lK0
 6o/7Z7ENLHBlQZEvpdjjdZ/UJzIxyH95GOFb1A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko and Martin,

As promised, I gave this a go and changed the SYSCALL_DEFINEx()
infrastructure to always include the wrappers for doing the
31-bit argument conversion on s390 compat mode.

This does three main things:

- The UID16 rework saved a lot of duplicated code, and would
  probably make sense by itself, but is also required as
  we can no longer call sys_*() functions directly after the
  last step.

- Removing the compat_wrapper.c file is of course the main
  goal here, in order to remove the need to maintain the
  compat_wrapper.c file when new system calls get added.
  Unfortunately, this requires adding some complexity in
  syscall_wrapper.h, and trades a small reduction in source
  code lines for a small increase in binary size for
  unused wrappers.

- As an added benefit, the use of syscall_wrapper.h now makes
  it easy to change the syscall wrappers so they no longer
  see all user space register contents, similar to changes
  done in commits fa697140f9a2 ("syscalls/x86: Use 'struct pt_regs'
  based syscall calling convention for 64-bit syscalls") and
  4378a7d4be30 ("arm64: implement syscall wrappers").
  I leave the actual implementation of this for you, if you
  want to do it later.

I did not test the changes at runtime, but I looked at the
generated object code, which seems fine here and includes
the same conversions as before.

      Arnd

Arnd Bergmann (5):
  s390: open-code s390_personality syscall
  ipc: introduce ksys_ipc()/compat_ksys_ipc() for s390
  s390: use generic UID16 implementation
  s390: autogenerate compat syscall wrappers
  s390: remove compat_wrapper.c

 arch/s390/Kconfig                        |   2 +
 arch/s390/include/asm/syscall_wrapper.h  | 136 +++++++++++
 arch/s390/include/uapi/asm/posix_types.h |   6 +
 arch/s390/kernel/Makefile                |   2 +-
 arch/s390/kernel/compat_linux.c          | 235 +------------------
 arch/s390/kernel/compat_wrapper.c        | 186 ---------------
 arch/s390/kernel/entry.S                 |   4 +-
 arch/s390/kernel/sys_s390.c              |  14 +-
 arch/s390/kernel/syscalls/syscall.tbl    | 286 +++++++++++------------
 include/linux/syscalls.h                 |   4 +
 ipc/syscall.c                            |  20 +-
 11 files changed, 322 insertions(+), 573 deletions(-)
 create mode 100644 arch/s390/include/asm/syscall_wrapper.h
 delete mode 100644 arch/s390/kernel/compat_wrapper.c

-- 
2.20.0

