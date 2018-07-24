Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF4BC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADDE20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 03:23:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ADDE20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbeGXE1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 00:27:30 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58619 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388131AbeGXE1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 00:27:30 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnup-0005VA-Pl; Mon, 23 Jul 2018 21:23:11 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fhnuo-0005W4-OM; Mon, 23 Jul 2018 21:23:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>
References: <bug-200447-5873-b2kAsSyE1X@https.bugzilla.kernel.org/>
        <CA+55aFyOaEGc_wjRuAxYZH7D4zi4xUQTqUwMmUzxFJQ__2pXuQ@mail.gmail.com>
        <87h8l9p7bg.fsf@xmission.com> <20180709104158.GA23796@redhat.com>
        <87sh4so5jv.fsf@xmission.com> <20180709145726.GA26149@redhat.com>
        <877em4nxo0.fsf@xmission.com>
        <CA+55aFwq90_KeRUesktap7L_4Hp3gatKZ28RYw1jXBYeOqUoeA@mail.gmail.com>
        <87lgakm4ol.fsf@xmission.com>
        <CA+55aFz1XFvOgJySKVNQD9VS4hys0J7rozxqd3s5ND0z80tfVw@mail.gmail.com>
        <20180710134639.GA2453@redhat.com>
        <CA+55aFxcjSYAj-CZFEuDwiwZyMg+prV_jeP_Vuh06RJA0BboSw@mail.gmail.com>
        <877em2jxyr.fsf_-_@xmission.com>
Date:   Mon, 23 Jul 2018 22:22:58 -0500
In-Reply-To: <877em2jxyr.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Tue, 10 Jul 2018 21:41:16 -0500")
Message-ID: <87efft5ncd.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fhnuo-0005W4-OM;;;mid=<87efft5ncd.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18LK28Ek+rcUtxQ6Ld97N4cAjvUx2CVWOM=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH 00/20] PIDTYPE_TGID removal of fork restarts
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This took longer than I thought to address all of the issues and double
check I am not missing something.  I have split of a few of the patches
so now the patch series appears longer.   It now covers less ground.

I realized while reviewing the group signals that for none of them is
siginfo important.  Which means by slightly lowering our quality of
implementation in delivering those signals to a brand new process (by
not queueing siginfo) I can collect them all in a sigset and the code
is no more difficult than a sequence counter.  Which means it is
straight forward to completely eliminate restarts from fork.

The implemenatation of PIDTYPE_TGID remains the same.  How it gets used
has changed to guarantee that looking up a thread group by the pid of
one of it's threads and sending it a signal continues to work exactly
the same as before.

Please take a look and verify that I have caught everything.  I think I
have but if not please let me know.

Thank you in advance,
Eric

Eric W. Biederman (20):
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
      fork: Have new threads join on-going signal group stops
      signal: Don't restart fork when signals come in.

 arch/ia64/kernel/asm-offsets.c       |  4 +-
 arch/ia64/kernel/fsys.S              | 12 ++---
 arch/s390/kernel/perf_cpum_sf.c      |  2 +-
 drivers/net/tun.c                    |  2 +-
 drivers/platform/x86/thinkpad_acpi.c |  1 +
 drivers/tty/sysrq.c                  |  2 +-
 drivers/tty/tty_io.c                 |  2 +-
 fs/autofs/autofs_i.h                 |  1 +
 fs/exec.c                            |  1 +
 fs/fcntl.c                           | 72 +++++++++++++--------------
 fs/fuse/file.c                       |  1 +
 fs/locks.c                           |  2 +-
 fs/notify/dnotify/dnotify.c          |  3 +-
 fs/notify/fanotify/fanotify.c        |  1 +
 include/linux/init_task.h            |  9 ----
 include/linux/pid.h                  | 11 +----
 include/linux/sched.h                | 31 +++---------
 include/linux/sched/signal.h         | 49 +++++++++++++++++--
 include/linux/signal.h               |  6 ++-
 include/net/scm.h                    |  1 +
 init/init_task.c                     | 12 +++--
 kernel/events/core.c                 |  2 +-
 kernel/exit.c                        | 12 ++---
 kernel/fork.c                        | 70 +++++++++++++++++++--------
 kernel/pid.c                         | 42 ++++++++--------
 kernel/signal.c                      | 94 ++++++++++++++++++++++++++----------
 kernel/time/itimer.c                 |  5 +-
 kernel/time/posix-cpu-timers.c       |  2 +-
 kernel/time/posix-timers.c           | 21 ++++----
 mm/oom_kill.c                        |  4 +-
 virt/kvm/kvm_main.c                  |  2 +-
 31 files changed, 282 insertions(+), 197 deletions(-)
