Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B56C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FFE3208EB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 02:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFE3208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732396AbeGKCnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 22:43:25 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:41283 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732277AbeGKCnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 22:43:25 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd54E-0006iy-TI; Tue, 10 Jul 2018 20:41:22 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fd54D-0005jD-3E; Tue, 10 Jul 2018 20:41:22 -0600
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
Date:   Tue, 10 Jul 2018 21:41:16 -0500
In-Reply-To: <CA+55aFxcjSYAj-CZFEuDwiwZyMg+prV_jeP_Vuh06RJA0BboSw@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 10 Jul 2018 10:02:42 -0700")
Message-ID: <877em2jxyr.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fd54D-0005jD-3E;;;mid=<877em2jxyr.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18L25p+MLUSS34t6z2IOM0XQWWRMab/I9Y=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [RFC][PATCH 0/11] PIDTYPE_TGID and fewer fork restarts
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


The following patches should be close.  I took some patches I haven't
taken the time to merge yet that make PIDTYPE_TGID not a hack.

Updated the code that deals with signals to handle PIDTYPE_TGID.

Pushed the pid type down from the signal senders all of the way
down into __send_signal.  That work could probably use being
split into more than one patch for readability, but it seems
reasonble and less of a hack than the "bool group" we have
currently.

I think I have gotten all of the places we send signals to multiple
processes.  But I have yet to make an exhaustive examination.  I would
appreciate some review feedback before I burn a day doing that.

All in all this changes a little more than I might hope for but it seems
a nicely targted cleanup that sorts out the fork issue.

Comments please.

I think I am 99% of the way to solving this cleanly but any feedback would
be very appreciated.

Thank you in advance.

Eric W. Biederman (11):
      pids: Initialize leader_pid in init_task
      pids: Move task_pid_type into sched/signal.h
      pids: Compute task_tgid using signal->leader_pid
      kvm: Don't open code task_pid in kvm_vcpu_ioctl
      pids: Move the pgrp and session pid pointers from task_struct to signal_struct
      pid: Implement PIDTYPE_TGID
      signal: Deliver group signals via PIDTYPE_TGID not PIDTYPE_PID
      signal: Use PIDTYPE_TGID to clearly store where file signals will be sent
      tty_io: Use do_send_sig_info in __do_SACK  to forcibly kill tasks
      signal: Push pid type from signal senders down into __send_signal
      signal: Ignore all but multi-process signals that come in during fork.

 arch/ia64/kernel/asm-offsets.c       |  4 +--
 arch/ia64/kernel/fsys.S              | 12 +++----
 arch/s390/kernel/perf_cpum_sf.c      |  2 +-
 drivers/net/tun.c                    |  2 +-
 drivers/platform/x86/thinkpad_acpi.c |  1 +
 drivers/tty/sysrq.c                  |  2 +-
 drivers/tty/tty_io.c                 | 10 +++---
 fs/autofs/autofs_i.h                 |  1 +
 fs/exec.c                            |  1 +
 fs/fcntl.c                           | 38 ++++++++--------------
 fs/fuse/file.c                       |  1 +
 fs/locks.c                           |  2 +-
 fs/notify/dnotify/dnotify.c          |  3 +-
 fs/notify/fanotify/fanotify.c        |  1 +
 include/linux/init_task.h            |  9 ------
 include/linux/pid.h                  | 11 ++-----
 include/linux/sched.h                | 31 ++++--------------
 include/linux/sched/signal.h         | 39 +++++++++++++++++++++--
 include/linux/signal.h               |  6 ++--
 include/net/scm.h                    |  1 +
 include/trace/events/signal.h        | 12 +++----
 init/init_task.c                     | 12 ++++---
 kernel/events/core.c                 |  2 +-
 kernel/exit.c                        | 12 ++-----
 kernel/fork.c                        | 45 +++++++++++++++++++++-----
 kernel/pid.c                         | 42 ++++++++++++-------------
 kernel/signal.c                      | 61 ++++++++++++++++++++----------------
 kernel/time/itimer.c                 |  5 +--
 kernel/time/posix-cpu-timers.c       |  2 +-
 kernel/time/posix-timers.c           | 13 +++-----
 mm/oom_kill.c                        |  4 +--
 virt/kvm/kvm_main.c                  |  2 +-
 32 files changed, 205 insertions(+), 184 deletions(-)

