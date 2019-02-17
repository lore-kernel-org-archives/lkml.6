Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266C4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA115217F5
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 19:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfBQTAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 14:00:48 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:59892 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfBQTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 14:00:47 -0500
X-Greylist: delayed 750 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Feb 2019 14:00:47 EST
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1gvRTs-0004Fp-00; Sun, 17 Feb 2019 18:48:00 +0000
Date:   Sun, 17 Feb 2019 13:48:00 -0500
From:   Rich Felker <dalias@libc.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Regression in SYS_membarrier expedited
Message-ID: <20190217184800.GA16118@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a961e40917fb14614d368d8bc9782ca4d6a8cd11 made it so that the
MEMBARRIER_CMD_PRIVATE_EXPEDITED command cannot be used without first
registering intent to use it. However, registration is an expensive
operation since commit 3ccfebedd8cf54e291c809c838d8ad5cc00f5688, which
added synchronize_sched() to it; this means it's no longer possible to
lazily register intent at first use, and it's unreasonably expensive
to preemptively register intent for possibly extremely-short-lived
processes that will never use it. (My usage case is in libc (musl),
where I can't know if the process will be short- or long-lived;
unnecessary and potentially expensive syscalls can't be made
preemptively, only lazily at first use.)

Can we restore the functionality of MEMBARRIER_CMD_PRIVATE_EXPEDITED
to work even without registration? The motivation of requiring
registration seems to be:

    "Registering at this time removes the need to interrupt each and
    every thread in that process at the first expedited
    sys_membarrier() system call."

but interrupting every thread in the process is exactly what I expect,
and is not a problem. What does seem like a big problem is waiting for
synchronize_sched() to synchronize with an unboundedly large number of
cores (vs only a few threads in the process), especially in the
presence of full_nohz, where it seems like latency would be at least a
few ms and possibly unbounded.

Short of a working SYS_membarrier that doesn't require expensive
pre-registration, I'm stuck just implementing it in userspace with
signals...

Rich
