Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F4DEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E19DA21783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547216133;
	bh=sAeZmfbFrisJPBcsaz9trwd91j/Fm7L1a5Xm+ilOvbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DbtN6Eo5mqm/xyYSSlvdbK4dbOyhb5kkKeI/aX2l18ga3V0xnhPg0GZn893fNPf94
	 /HSHIuqhrhRyUC4kFVs6x5UPyPez4HjgWjNDYM2NSp7Wh+ehAnP1iwLy2iygnv5jGl
	 LGG5L1Lcltda7Lbytv57IV0uPNbaJvbKqI5B3S0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387414AbfAKOPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:15:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387394AbfAKOPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:15:30 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76356214D8;
        Fri, 11 Jan 2019 14:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547216128;
        bh=sAeZmfbFrisJPBcsaz9trwd91j/Fm7L1a5Xm+ilOvbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mATZm+CUY1u4RcM1kYGdJ7e3OV6SZutK9AKW214/9JSVwQl2ix6lqcrT0eTti2swC
         iY/v9IROpYXMvIIom1vORPql8jlYrhZQWjq8CFTh20NqwmoVMt9UZ2F85R+Z0RBaVm
         axoyrvd7mZuBdfYvsMVyQShVAZTx9YVZ4busI21c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Tom Gundersen <teg@jklm.no>,
        David Herrmann <dh.herrmann@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3.18 32/47] fork: record start_time late
Date:   Fri, 11 Jan 2019 15:08:17 +0100
Message-Id: <20190111131000.231010024@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111130956.170952125@linuxfoundation.org>
References: <20190111130956.170952125@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Herrmann <dh.herrmann@gmail.com>

commit 7b55851367136b1efd84d98fea81ba57a98304cf upstream.

This changes the fork(2) syscall to record the process start_time after
initializing the basic task structure but still before making the new
process visible to user-space.

Technically, we could record the start_time anytime during fork(2).  But
this might lead to scenarios where a start_time is recorded long before
a process becomes visible to user-space.  For instance, with
userfaultfd(2) and TLS, user-space can delay the execution of fork(2)
for an indefinite amount of time (and will, if this causes network
access, or similar).

By recording the start_time late, it much closer reflects the point in
time where the process becomes live and can be observed by other
processes.

Lastly, this makes it much harder for user-space to predict and control
the start_time they get assigned.  Previously, user-space could fork a
process and stall it in copy_thread_tls() before its pid is allocated,
but after its start_time is recorded.  This can be misused to later-on
cycle through PIDs and resume the stalled fork(2) yielding a process
that has the same pid and start_time as a process that existed before.
This can be used to circumvent security systems that identify processes
by their pid+start_time combination.

Even though user-space was always aware that start_time recording is
flaky (but several projects are known to still rely on start_time-based
identification), changing the start_time to be recorded late will help
mitigate existing attacks and make it much harder for user-space to
control the start_time a process gets assigned.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Tom Gundersen <teg@jklm.no>
Signed-off-by: David Herrmann <dh.herrmann@gmail.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/fork.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1321,8 +1321,6 @@ static struct task_struct *copy_process(
 
 	posix_cpu_timers_init(p);
 
-	p->start_time = ktime_get_ns();
-	p->real_start_time = ktime_get_boot_ns();
 	p->io_context = NULL;
 	p->audit_context = NULL;
 	if (clone_flags & CLONE_THREAD)
@@ -1487,6 +1485,17 @@ static struct task_struct *copy_process(
 	spin_lock(&current->sighand->siglock);
 
 	/*
+	 * From this point on we must avoid any synchronous user-space
+	 * communication until we take the tasklist-lock. In particular, we do
+	 * not want user-space to be able to predict the process start-time by
+	 * stalling fork(2) after we recorded the start_time but before it is
+	 * visible to the system.
+	 */
+
+	p->start_time = ktime_get_ns();
+	p->real_start_time = ktime_get_boot_ns();
+
+	/*
 	 * Copy seccomp details explicitly here, in case they were changed
 	 * before holding sighand lock.
 	 */


