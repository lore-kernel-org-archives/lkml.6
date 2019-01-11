Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCFBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1BB21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547217765;
	bh=+0th/WukIC0QQpvb+Lp3RvNBIw+8cl4B0gw3J/JOL4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aQOv69JFaFTZoqK/y5fUK6Gb5Zsh6R50C6ybOfYcpQXTf9bElEaAhvynr/spjuxWl
	 5Mjj7FFxZxdjmxO5RK/2y42Nbi3+JDNsfxpB0JqVITjIs7jhO/0HD4Gw8hR2uJv0KD
	 8k+2lihCfBPuDrVBwf1whnitFCY+tZuYvL8Bl9TY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404223AbfAKOmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:42:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:35434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404208AbfAKOmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:42:40 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD0212063F;
        Fri, 11 Jan 2019 14:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217759;
        bh=+0th/WukIC0QQpvb+Lp3RvNBIw+8cl4B0gw3J/JOL4s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2fEPQxEQEuKohIZ+IPfqPrgmZvFuJ5H2erUdRDWukJcWtBfxm4CIik0kVl1P0voT
         MTg9+0r6yV6HfCitJLWxfSQ1QGVmJBCFH4gcFV9ofdIypxOuNbkkcnIFOZd9KE/JcE
         2dPlHwLVC+eKWYbMv2QJZpkSriE0L75+4c8TuWFo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Tom Gundersen <teg@jklm.no>,
        David Herrmann <dh.herrmann@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.20 03/65] fork: record start_time late
Date:   Fri, 11 Jan 2019 15:14:49 +0100
Message-Id: <20190111131056.544951319@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131055.331350141@linuxfoundation.org>
References: <20190111131055.331350141@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1837,8 +1837,6 @@ static __latent_entropy struct task_stru
 
 	posix_cpu_timers_init(p);
 
-	p->start_time = ktime_get_ns();
-	p->real_start_time = ktime_get_boot_ns();
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
 	cgroup_fork(p);
@@ -2005,6 +2003,17 @@ static __latent_entropy struct task_stru
 		goto bad_fork_free_pid;
 
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
 	 * Make it visible to the rest of the system, but dont wake it up yet.
 	 * Need tasklist lock for parent etc handling!
 	 */


