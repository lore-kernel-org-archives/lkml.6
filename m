Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65086C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19AEF21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 09:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19AEF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbeJIQlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 12:41:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35807 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbeJIQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 12:41:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id w5-v6so1007019wrt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 02:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/nAyLMxpH9s4E46HBDHeoDAN6FnEJv1pqvOwHeVF55c=;
        b=lv5DXIQO7WfZwua/2ImVP7djtT96EeNRtD6YHRqKuP8XhXpwingWHIATh0CaXOlwGn
         IPTdKbjYUtznQW7DcR90yDUGPS5QWxj3ZHmB6padxpkdCRMlxZFXvAP+T4iocOYn5VLe
         302rAB7QEjsyuX0tf5IIJ0Abr1Ql73M7lSqydM0nxdQtC9aN1hN2RbuEs3ZszPRKjkL2
         tx2DFntkjXlXmFfyAoFnAJRo577VTBGRORWPMx1cPsP/FDW+cy75sHNIum3eaaKjev1R
         kqKC6rqJOonv6na8gfl6R09uBfwFhuHyRcYNWKW2rubPS4LV7/pQojPHW68kERL8MSqc
         TZrA==
X-Gm-Message-State: ABuFfogannEf9NQeaHoXEEcdcVwqHSNhxNrEgYDxD3fg9wVsYW+ESbQW
        3r3LE1savnzQyIoBu5ZzjNrGMA==
X-Google-Smtp-Source: ACcGV61qaZZifmcOLyReP+8qKubttQmSUga0xTRKgt6WjZP3Yz3jGHCubQGa6/lbTRil9b4EEdmKuA==
X-Received: by 2002:a5d:4292:: with SMTP id k18-v6mr18795075wrq.225.1539077102238;
        Tue, 09 Oct 2018 02:25:02 -0700 (PDT)
Received: from localhost.localdomain.Speedport_W_921V_1_44_000 (p200300EF2BD31613C1F2E846AEDA540D.dip0.t-ipconnect.de. [2003:ef:2bd3:1613:c1f2:e846:aeda:540d])
        by smtp.gmail.com with ESMTPSA id o201-v6sm16049413wmg.16.2018.10.09.02.25.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:25:01 -0700 (PDT)
From:   Juri Lelli <juri.lelli@redhat.com>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        alessio.balsini@gmail.com, bristot@redhat.com, will.deacon@arm.com,
        andrea.parri@amarulasolutions.com, dietmar.eggemann@arm.com,
        patrick.bellasi@arm.com, henrik@austad.us,
        linux-rt-users@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Subject: [RFD/RFC PATCH 0/8] Towards implementing proxy execution
Date:   Tue,  9 Oct 2018 11:24:26 +0200
Message-Id: <20181009092434.26221-1-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Proxy Execution (also goes under several other names) isn't a new
concept, it has been mentioned already in the past to this community
(both in email discussions and at conferences [1, 2]), but no actual
implementation that applies to a fairly recent kernel exists as of today
(of which I'm aware of at least - happy to be proven wrong).

Very broadly speaking, more info below, proxy execution enables a task
to run using the context of some other task that is "willing" to
participate in the mechanism, as this helps both tasks to improve
performance (w.r.t. the latter task not participating to proxy
execution).

This RFD/proof of concept aims at starting a discussion about how we can
get proxy execution in mainline. But, first things first, why do we even
care about it?

I'm pretty confident with saying that the line of development that is
mainly interested in this at the moment is the one that might benefit
in allowing non privileged processes to use deadline scheduling [3].
The main missing bit before we can safely relax the root privileges
constraint is a proper priority inheritance mechanism, which translates
to bandwidth inheritance [4, 5] for deadline scheduling, or to some sort
of interpretation of the concept of running a task holding a (rt_)mutex
within the bandwidth allotment of some other task that is blocked on the
same (rt_)mutex.

The concept itself is pretty general however, and it is not hard to
foresee possible applications in other scenarios (say for example nice
values/shares across co-operating CFS tasks or clamping values [6]).
But I'm already digressing, so let's get back to the code that comes
with this cover letter.

One can define the scheduling context of a task as all the information
in task_struct that the scheduler needs to implement a policy and the
execution contex as all the state required to actually "run" the task.
An example of scheduling context might be the information contained in
task_struct se, rt and dl fields; affinity pertains instead to execution
context (and I guess decideing what pertains to what is actually up for
discussion as well ;-). Patch 04/08 implements such distinction.

As implemented in this set, a link between scheduling contexts of
different tasks might be established when a task blocks on a mutex held
by some other task (blocked_on relation). In this case the former task
starts to be considered a potential proxy for the latter (mutex owner).
One key change in how mutexes work made in here is that waiters don't
really sleep: they are not dequeued, so they can be picked up by the
scheduler when it runs.  If a waiter (potential proxy) task is selected
by the scheduler, the blocked_on relation is used to find the mutex
owner and put that to run on the CPU, using the proxy task scheduling
context.

   Follow the blocked-on relation:
  
                  ,-> task           <- proxy, picked by scheduler
                  |     | blocked-on
                  |     v
     blocked-task |   mutex
                  |     | owner
                  |     v
                  `-- task           <- gets to run using proxy info

Now, the situation is (of course) more tricky than depicted so far
because we have to deal with all sort of possible states the mutex
owner might be in while a potential proxy is selected by the scheduler,
e.g. owner might be sleeping, running on a different CPU, blocked on
another mutex itself... so, I'd kindly refer people to have a look at
05/08 proxy() implementation and comments.

Peter kindly shared his WIP patches with us (me, Luca, Tommaso, Claudio,
Daniel, the Pisa gang) a while ago, but I could seriously have a decent
look at them only recently (thanks a lot to the other guys for giving a
first look at this way before me!). This set is thus composed of Peter's
original patches (which I rebased on tip/sched/core as of today,
commented and hopefully duly reported in changelogs what have I possibly
broke) plus a bunch of additional changes that seemed required to make
all this boot "successfully" on a virtual machine. So be advised! This
is good only for fun ATM (I actually really hope this is good enough for
discussion), pretty far from production I'm afraid. Share early, share
often, right?  :-)

The main concerns I have with the current approach is that, being based
on mutex.c, it's both

 - not linked with futexes
 - not involving "legacy" priority inheritance (rt_mutex.c)

I believe one of the main reasons Peter started this on mutexes is to
have better coverage of potential problems (which I can assure everybody
it had). I'm not yet sure what should we do moving forward, and this is
exactly what I'd be pleased to hear your opinions on.

https://github.com/jlelli/linux.git experimental/deadline/proxy-rfc-v1

Thanks a lot in advance!

- Juri

1 - https://wiki.linuxfoundation.org/_media/realtime/events/rt-summit2017/proxy-execution_peter-zijlstra.pdf
2 - https://lwn.net/Articles/397422/ which "points" to https://goo.gl/3VrLza
3 - https://marc.info/?l=linux-rt-users&m=153450086400459&w=2
4 - https://ieeexplore.ieee.org/document/5562902
5 - http://retis.sssup.it/~lipari/papers/rtlws2013.pdf
6 - https://lore.kernel.org/lkml/20180828135324.21976-1-patrick.bellasi@arm.com/

Juri Lelli (3):
  locking/mutex: make mutex::wait_lock irq safe
  sched: Ensure blocked_on is always guarded by blocked_lock
  sched: Fixup task CPUs for potential proxies.

Peter Zijlstra (5):
  locking/mutex: Convert mutex::wait_lock to raw_spinlock_t
  locking/mutex: Removes wakeups from under mutex::wait_lock
  locking/mutex: Rework task_struct::blocked_on
  sched: Split scheduler execution context
  sched: Add proxy execution

 include/linux/mutex.h        |   4 +-
 include/linux/sched.h        |   8 +-
 init/Kconfig                 |   4 +
 init/init_task.c             |   1 +
 kernel/Kconfig.locks         |   2 +-
 kernel/fork.c                |   8 +-
 kernel/locking/mutex-debug.c |  12 +-
 kernel/locking/mutex.c       | 127 +++++++--
 kernel/sched/core.c          | 510 +++++++++++++++++++++++++++++++++--
 kernel/sched/deadline.c      |   2 +-
 kernel/sched/fair.c          |   7 +
 kernel/sched/rt.c            |   2 +-
 kernel/sched/sched.h         |  30 ++-
 13 files changed, 642 insertions(+), 75 deletions(-)

-- 
2.17.1

