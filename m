Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF30C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE3F21C16
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 06:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BE3F21C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbeHIJQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 05:16:55 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42808 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727371AbeHIJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 05:16:54 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fnep8-0000Mk-Am; Thu, 09 Aug 2018 00:53:30 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fneos-0004l2-Vs; Thu, 09 Aug 2018 00:53:30 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Wen Yang <wen.yang99@zte.com.cn>,
        majiang <ma.jiang@zte.com.cn>,
        Linus Torvalds <torvalds@linux-foundation.org>
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
        <877em2jxyr.fsf_-_@xmission.com> <87efft5ncd.fsf_-_@xmission.com>
Date:   Thu, 09 Aug 2018 01:53:02 -0500
In-Reply-To: <87efft5ncd.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Mon, 23 Jul 2018 22:22:58 -0500")
Message-ID: <87wot0yqsx.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fneos-0004l2-Vs;;;mid=<87wot0yqsx.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19pYWtLigVphRuYEECAG2OafgkXfmadnUI=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: [PATCH v5 0/6] Not restarting for due to signals.
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This builds on patches 1-15 of my previous patch posting.  As those are
non-controversial I am not posting them again.

I took longer than I had hoped to get this set together because a kernel
testing robot noticed some random corruption with the way I had been
adding to the list.  I finally tracked it down to failing to remove the
sigset from the list during fork_idle.  So I have made that logic
simpler and use hlist_del_init which will only remove an item from a
list if it was placed on the list in the first place.

I took Oleg's suggesting and moved calculate_sigpending into
schedule_tail where recalc_sigpending an be used directly.  Then in
calculate_sigpending I just unconditionally set TIF_SIGPENDING and allow
recalc_sigpending to clear TIF_SIGPENDING if we don't need it.

I also now handle the stop/continue signal magic where we only let one
of stop signals and SIGCONT be pending at a time.  Looking at it from
first principles dropping one of SIGTSTP SIGTTIN SIGTTOU or SIGCONT
before calling it's handler feels wrong.  I checked and it is our
historical behavior, so I won't even thinking of introducing different
behavior at this point.

Eric W. Biederman (6):
      fork: Move and describe why the code examines PIDNS_ADDING
      fork: Unconditionally exit if a fatal signal is pending
      signal: Add calculate_sigpending()
      fork: Skip setting TIF_SIGPENDING in ptrace_init_task
      fork: Have new threads join on-going signal group stops
      signal: Don't restart fork when signals come in.

 include/linux/ptrace.h       |  2 --
 include/linux/sched/signal.h | 11 ++++++++++
 init/init_task.c             |  1 +
 kernel/fork.c                | 49 ++++++++++++++++++++++++++++++--------------
 kernel/sched/core.c          |  2 ++
 kernel/signal.c              | 43 ++++++++++++++++++++++++++++++++++++++
 6 files changed, 91 insertions(+), 17 deletions(-)

Eric
