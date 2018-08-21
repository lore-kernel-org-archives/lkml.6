Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A1AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C02214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:00:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C02214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeHUQUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:20:04 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57700 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbeHUQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:20:04 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fs6GN-00085O-Qq; Tue, 21 Aug 2018 06:59:59 -0600
Received: from [105.224.248.17] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fs6G7-0002xt-Tq; Tue, 21 Aug 2018 06:59:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Wen Yang <wen.yang99@zte.com.cn>, majiang <ma.jiang@zte.com.cn>
Date:   Tue, 21 Aug 2018 14:59:37 +0200
Message-ID: <874lfnzxhi.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fs6G7-0002xt-Tq;;;mid=<874lfnzxhi.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=105.224.248.17;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/oF8bJPq/Y12CCiRgSDKRxOzk+IKYpP9E=
X-SA-Exim-Connect-IP: 105.224.248.17
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [GIT PULL] signal work for v4.19-rc1
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the siginfo-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git siginfo-linus

   HEAD: 84fe4cc09abc1a5ef3a282db3ed10f4d3f1e6a0b signal: Don't send signals to tasks that don't exist

It was observed that a periodic timer in combination with a sufficiently
expensive fork could prevent fork from every completing.   This branch
holds the set of changes to remove the need for that restart.

This set of changes is split into several parts.  The first part
makes PIDTYPE_TGID a proper pid type instead something only for very
special cases.  The part starts uses PIDTYPE_TGID enough so that in
__send_signal where signals are actually delivered we know if the signal
is being sent to a a group of processes or just a single process.  With
that prep work out of the way the logic in fork is modified so that fork
logically makes signals received while it is running appear to be
received after the fork completes.

Eric W. Biederman (22):
      pids: Initialize leader_pid in init_task
      pids: Move task_pid_type into sched/signal.h
      pids: Compute task_tgid using signal->leader_pid
      kvm: Don't open code task_pid in kvm_vcpu_ioctl
      pids: Move the pgrp and session pid pointers from task_struct to signal_struct
      pid: Implement PIDTYPE_TGID
      signal: Use PIDTYPE_TGID to clearly store where file signals will be sent
      posix-timers: Noralize good_sigevent
      signal: Pass pid and pid type into send_sigqueue
      signal: Pass pid type into group_send_sig_info
      signal: Pass pid type into send_sigio_to_task & send_sigurg_to_task
      signal: Pass pid type into do_send_sig_info
      signal: Push pid type down into send_signal
      signal: Push pid type down into __send_signal
      signal: Push pid type down into complete_signal.
      fork: Move and describe why the code examines PIDNS_ADDING
      fork: Unconditionally exit if a fatal signal is pending
      signal: Add calculate_sigpending()
      fork: Skip setting TIF_SIGPENDING in ptrace_init_task
      fork: Have new threads join on-going signal group stops
      signal: Don't restart fork when signals come in.
      signal: Don't send signals to tasks that don't exist

 arch/ia64/kernel/asm-offsets.c       |  4 +-
 arch/ia64/kernel/fsys.S              | 12 ++---
 arch/s390/kernel/perf_cpum_sf.c      |  2 +-
 drivers/net/tun.c                    |  2 +-
 drivers/platform/x86/thinkpad_acpi.c |  1 +
 drivers/tty/sysrq.c                  |  2 +-
 drivers/tty/tty_io.c                 |  2 +-
 fs/autofs/autofs_i.h                 |  1 +
 fs/exec.c                            |  1 +
 fs/fcntl.c                           | 74 ++++++++++++++-------------
 fs/fuse/file.c                       |  1 +
 fs/locks.c                           |  2 +-
 fs/notify/dnotify/dnotify.c          |  3 +-
 fs/notify/fanotify/fanotify.c        |  1 +
 include/linux/init_task.h            |  9 ----
 include/linux/pid.h                  | 11 +---
 include/linux/ptrace.h               |  2 -
 include/linux/sched.h                | 31 +++---------
 include/linux/sched/signal.h         | 49 ++++++++++++++++--
 include/linux/signal.h               |  6 ++-
 include/net/scm.h                    |  1 +
 init/init_task.c                     | 13 +++--
 kernel/events/core.c                 |  2 +-
 kernel/exit.c                        | 12 ++---
 kernel/fork.c                        | 75 +++++++++++++++++++--------
 kernel/pid.c                         | 42 ++++++++--------
 kernel/sched/core.c                  |  2 +
 kernel/signal.c                      | 98 ++++++++++++++++++++++++++----------
 kernel/time/itimer.c                 |  5 +-
 kernel/time/posix-cpu-timers.c       |  2 +-
 kernel/time/posix-timers.c           | 21 ++++----
 mm/oom_kill.c                        |  4 +-
 virt/kvm/kvm_main.c                  |  2 +-
 33 files changed, 294 insertions(+), 201 deletions(-)

Eric
