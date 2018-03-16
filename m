Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933436AbeCPRIK (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:08:10 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43112 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933433AbeCPRHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:07:03 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        davem@davemloft.net
Cc: netdev@vger.kernel.org
Subject: [PATCH -next 00/22] remove in-kernel syscall invocations (part 2 == netdev)
Date: Fri, 16 Mar 2018 18:05:52 +0100
Message-Id: <20180316170614.5392-1-linux@dominikbrodowski.net>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is another series of patches which reduce the number of syscall
invocations from within the kernel. This series is focused solely on
the net/ part of the kernel and get rids of syscall and compat_syscall
invocations from within the kernel completely. It is also available at

	https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-net-next

The rationale of this change is described in patch 1 of part 1[*] as follows:

	The syscall entry points to the kernel defined by SYSCALL_DEFINEx()
	and COMPAT_SYSCALL_DEFINEx() should only be called from userspace
	through kernel entry points, but not from the kernel itself. This
	will allow cleanups and optimizations to the entry paths *and* to
	the parts of the kernel code which currently need to pretend to be
	userspace in order to make use of syscalls.

At present, these patches are based on v4.16-rc5; there is one trivial
conflict against net-next. Dave, I presume that you prefer to take them
through net-next? If you want to, I can re-base them against net-next.
If you prefer otherwise, though, I can route them as part of my whole
syscall series.

Thanks,
	Dominik

[*] The cover letter for v2 is available at
    http://lkml.kernel.org/r/20180315190529.20943-1-linux@dominikbrodowski.net ;
    the whole patchset -- in its current, slightly modified form -- is available at
    at https://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux.git syscalls-next	

Dominik Brodowski (22):
  net: socket: add __sys_recvfrom() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_sendto() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_accept4() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_socket() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_bind() helper; remove in-kernel call to syscall
  net: socket: add __sys_connect() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_listen() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_getsockname() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_getpeername() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_socketpair() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_shutdown() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_setsockopt() helper; remove in-kernel call to
    syscall
  net: socket: add __sys_getsockopt() helper; remove in-kernel call to
    syscall
  net: socket: add do_sys_recvmmsg() helper; remove in-kernel call to
    syscall
  net: socket: move check for forbid_cmsg_compat to __sys_...msg()
  net: socket: replace calls to sys_send() with __sys_sendto()
  net: socket: replace call to sys_recv() with __sys_recvfrom()
  net: socket: add __compat_sys_recvfrom() helper; remove in-kernel call
    to compat syscall
  net: socket: add __compat_sys_setsockopt() helper; remove in-kernel
    call to compat syscall
  net: socket: add __compat_sys_getsockopt() helper; remove in-kernel
    call to compat syscall
  net: socket: add __compat_sys_recvmmsg() helper; remove in-kernel call
    to compat syscall
  net: socket: add __compat_sys_...msg() helpers; remove in-kernel calls
    to compat syscalls

 include/linux/socket.h |  37 +++++++-
 net/compat.c           | 136 +++++++++++++++++++---------
 net/socket.c           | 234 ++++++++++++++++++++++++++++++++++---------------
 3 files changed, 291 insertions(+), 116 deletions(-)

-- 
2.16.2
