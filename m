Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D0EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A524C20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A524C20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeLFU32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:29:28 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:42095 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeLFU31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:29:27 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gV0Gz-0007ne-Ke; Thu, 06 Dec 2018 13:29:25 -0700
Received: from ip68-227-174-240.om.om.cox.net ([68.227.174.240] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1gV0Gy-0003sV-Nh; Thu, 06 Dec 2018 13:29:25 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        luto@kernel.org, arnd@arndb.de, serge@hallyn.com, jannh@google.com,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        dancol@google.com, timmurray@google.com, linux-man@vger.kernel.org,
        keescook@chromium.org, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org
References: <20181206121858.12215-1-christian@brauner.io>
        <87sgzahf7k.fsf@xmission.com>
        <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io>
        <875zw6bh2z.fsf@xmission.com>
        <20181206193017.wpxls5p3zgjd6rv2@brauner.io>
Date:   Thu, 06 Dec 2018 14:29:13 -0600
In-Reply-To: <20181206193017.wpxls5p3zgjd6rv2@brauner.io> (Christian Brauner's
        message of "Thu, 6 Dec 2018 20:30:19 +0100")
Message-ID: <871s6u9z6u.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1gV0Gy-0003sV-Nh;;;mid=<871s6u9z6u.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.240;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19OriSRERNH3jizl4ZALdryUhVDRipsGHQ=
X-SA-Exim-Connect-IP: 68.227.174.240
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian@brauner.io> writes:

> On Thu, Dec 06, 2018 at 01:17:24PM -0600, Eric W. Biederman wrote:
>> Christian Brauner <christian@brauner.io> writes:
>> 
>> > On December 7, 2018 4:01:19 AM GMT+13:00, ebiederm@xmission.com wrote:
>> >>Christian Brauner <christian@brauner.io> writes:
>> >>
>> >>> The kill() syscall operates on process identifiers (pid). After a
>> >>process
>> >>> has exited its pid can be reused by another process. If a caller
>> >>sends a
>> >>> signal to a reused pid it will end up signaling the wrong process.
>> >>This
>> >>> issue has often surfaced and there has been a push [1] to address
>> >>this
>> >>> problem.
>> >>>
>> >>> This patch uses file descriptors (fd) from proc/<pid> as stable
>> >>handles on
>> >>> struct pid. Even if a pid is recycled the handle will not change. The
>> >>fd
>> >>> can be used to send signals to the process it refers to.
>> >>> Thus, the new syscall taskfd_send_signal() is introduced to solve
>> >>this
>> >>> problem. Instead of pids it operates on process fds (taskfd).
>> >>
>> >>I am not yet thrilled with the taskfd naming.
>> >
>> > Userspace cares about what does this thing operate on?
>> > It operates on processes and threads.
>> > The most common term people use is "task".
>> > I literally "polled" ten non-kernel people for that purpose and asked:
>> > "What term would you use to refer to a process and a thread?"
>> > Turns out it is task. So if find this pretty apt.
>> > Additionally, the proc manpage uses task in the exact same way (also see the commit message).
>> > If you can get behind that name even if feeling it's not optimal it would be great.
>> 
>> Once I understand why threads and not process groups.  I don't see that
>> logic yet.
>
> The point is: userspace takes "task" to be a generic term for processes
> and tasks. Which is what is important. The term also covers process
> groups for all that its worth. Most of userspace isn't even aware of
> that distinction necessarily.
>
> fd_send_signal() makes the syscall name meaningless: what is userspace
> signaling too? The point being that there's a lot more that you require
> userspace to infer from fd_send_signal() than from task_send_signal()
> where most people get the right idea right away: "signals to a process
> or thread".
>
>> 
>> >>Is there any plan to support sesssions and process groups?
>> >
>> > I don't see the necessity.
>> > As I said in previous mails:
>> > we can emulate all interesting signal syscalls with this one.
>> 
>> I don't know what you mean by all of the interesting signal system
>> calls.  I do know you can not replicate kill(2).
>
> [1]: You cannot replicate certain aspects of kill *yet*. We have
> established this before. If we want process group support later we do
> have the flags argument to extend the sycall.

Then you have horrible contradiction in the API.

Either the grouping is a property of your file descriptor or the
grouping comes from the flags argument.

If the grouping is specified in the flags argument then pidfd is the
proper name for your file descriptors, and the appropriate prefix
for your system call.

If the grouping is a property of your file descriptor it does not make
sense to talk about using the flags argument later.

Your intention is to add the thread case to support pthreads once the
process case is sorted out.  So this is something that needs to be made
clear.  Did I miss how you plan to handle threads?

And this fundamentally and definitely gets into all of my concerns about
proper handling of pid_task and PIDTYPE_TGID etc.

>> Sending signals to a process group the "kill(-pgrp)" case with kill
>> sends the signals to an atomic snapshot of processes.  If the signal
>> is SIGKILL then it is guaranteed that then entire process group is
>> killed with no survivors.
>
> See [1].
>
>> 
>> > We succeeded in doing that.
>> 
>> I am not certain you have.
>
> See [1].
>
>> 
>> > No need to get more fancy.
>> > There's currently no obvious need for more features.
>> > Features should be implemented when someone actually needs them.
>> 
>> That is fair.  I don't understand what you are doing with sending
>> signals to a thread.  That seems like one of the least useful
>> corner cases of sending signals.
>
> It's what glibc and Florian care about for pthreads and their our
> biggest user atm so they get some I'd argue they get some say in this. :)

Fair enough.  If glibc could use this then we certainly have users and a
user case.

Eric
