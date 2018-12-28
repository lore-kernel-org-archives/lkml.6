Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367BBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 095BB2148E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 23:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeL1XUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 18:20:16 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeL1XUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 18:20:15 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B08D5BD1;
        Fri, 28 Dec 2018 23:20:13 +0000 (UTC)
Date:   Fri, 28 Dec 2018 15:20:12 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com,
        keescook@chromium.org, jannh@google.com, oleg@redhat.com,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH v5 RESEND] signal: add pidfd_send_signal() syscall
Message-Id: <20181228152012.dbf0508c2508138efc5f2bbe@linux-foundation.org>
In-Reply-To: <20181228224853.26032-1-christian@brauner.io>
References: <20181228224853.26032-1-christian@brauner.io>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 23:48:53 +0100 Christian Brauner <christian@brauner.io> wrote:

> The kill() syscall operates on process identifiers (pid). After a process
> has exited its pid can be reused by another process. If a caller sends a
> signal to a reused pid it will end up signaling the wrong process. This
> issue has often surfaced and there has been a push to address this problem [1].
> 
> This patch uses file descriptors (fd) from proc/<pid> as stable handles on
> struct pid. Even if a pid is recycled the handle will not change. The fd
> can be used to send signals to the process it refers to.
> Thus, the new syscall pidfd_send_signal() is introduced to solve this
> problem. Instead of pids it operates on process fds (pidfd).

I can't see a description of what happens when the target process has
exited.  Is the task_struct pinned by the fd?  Does the entire procfs
directory remain visible?  Just one entry within it?  Does the pid
remain reserved?  Do attempts to signal that fd return errors? 
etcetera.  These behaviors should be described in the changelog and
manipulate please.

The code in signal.c appears to be compiled in even when
CONFIG_PROC_FS=y.  Can we add the appropriate ifdefs and an entry in
sys_ni.c?

A selftest in toole/testing/selftests would be nice.  And it will be
helpful to architecture maintainers as they wire this up.

The feature doesn't have its own Kconfig setting.  Perhaps it should?
It should presumably depend on PROC_FS.

I must say that I dislike the linkage to procfs.  procfs is a
high-level thing which is manipulated using syscalls.  To turn around
and make a syscall dependent upon the presence of procfs seems just ...
wrong.  Is there a cleaner way of obtaining the fd?  Another syscall
perhaps.

This fd-for-a-process sounds like a handy thing and people may well
think up other uses for it in the future, probably unrelated to
signals.  Are the code and the interface designed to permit such future
applications?  I guess "no" - it presently assumes that anything which
is written to that fd is a signal.  Perhaps there should be a tag at
the start of the message (which is what it is) which identifies the
message's type?

Now I think about it, why a new syscall?  This thing is looking rather
like an ioctl?


