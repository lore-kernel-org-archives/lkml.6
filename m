Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE12C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9902146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 12:55:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9902146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbeLDMzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 07:55:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbeLDMzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 07:55:19 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 126A33002887;
        Tue,  4 Dec 2018 12:55:18 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-219.str.redhat.com [10.33.192.219])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F170D5C23E;
        Tue,  4 Dec 2018 12:55:11 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     ebiederm@xmission.com, linux-kernel@vger.kernel.org,
        serge@hallyn.com, jannh@google.com, luto@kernel.org,
        akpm@linux-foundation.org, oleg@redhat.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, dancol@google.com, timmurray@google.com,
        linux-man@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] signal: add procfd_signal() syscall
References: <20181120105124.14733-1-christian@brauner.io>
        <87in0g5aqo.fsf@oldenburg.str.redhat.com>
        <746B7C49-CC7B-4040-A7EF-82491796D360@brauner.io>
        <20181202100304.labt63mzrlr5utdl@brauner.io>
        <8736rebl9s.fsf@oldenburg.str.redhat.com>
        <20181203180224.fkvw4kajtbvru2ku@brauner.io>
Date:   Tue, 04 Dec 2018 13:55:10 +0100
In-Reply-To: <20181203180224.fkvw4kajtbvru2ku@brauner.io> (Christian Brauner's
        message of "Mon, 3 Dec 2018 19:02:29 +0100")
Message-ID: <874lbtjvtd.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Tue, 04 Dec 2018 12:55:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Brauner:

> On Mon, Dec 03, 2018 at 05:57:51PM +0100, Florian Weimer wrote:
>> * Christian Brauner:
>> 
>> > Ok, I finally have access to source code again. Scratch what I said above!
>> > I looked at the code and tested it. If the process has exited but not
>> > yet waited upon aka is a zombie procfd_send_signal() will return 0. This
>> > is identical to kill(2) behavior. It should've been sort-of obvious
>> > since when a process is in zombie state /proc/<pid> will still be around
>> > which means that struct pid must still be around.
>> 
>> Should we make this state more accessible, by providing a different
>> error code?
>
> No, I don't think we want that. Imho, It's not really helpful. Signals
> are still delivered to zombies. If zombie state were to always mean that
> no-one is going to wait on this thread anymore then it would make sense
> to me. But given that zombie can also mean that someone put a
> sleep(1000) right before their wait() call in the parent it seems odd to
> report back that it is a zombie.

It allows for error checking that the recipient of a signal is still
running.  It's obviously not reliable, but I think it could be helpful
in the context of closely cooperating processes.

>> Will the system call ever return ESRCH, given that you have a handle for
>> the process?
>
> Yes, whenever you signal a process that has already been waited upon:
> - get procfd handle referring to <proc>
> - <proc> exits and is waited upon
> - procfd_send_signal(procfd, ...) returns -1 with errno == ESRCH

I see, thanks.

>> Do you want to land all this in one kernel release?  I wonder how
>> applications are supposed to discover kernel support if functionality is
>> split across several kernel releases.  If you get EINVAL or EBADF, it
>> may not be obvious what is going on.
>
> Sigh, I get that but I really don't want to have to land this in one big
> chunk. I want this syscall to go in in a as soon as we can to fulfill
> the most basic need: having a way that guarantees us that we signal the
> process that we intended to signal.
>
> The thread case is easy to implement on top of it. But I suspect we will
> quibble about the exact semantics for a long time. Even now we have been
> on multiple - justified - detrous. That's all pefectly fine and
> expected. But if we have the basic functionality in we have time to do
> all of that. We might even land it in the same kernel release still. I
> really don't want to come of as tea-party-kernel-conservative here but I
> have time-and-time again seen that making something fancy and cover ever
> interesting feature in one patchset takes a very very long time.
>
> If you care about userspace being able to detect that case I can return
> EOPNOTSUPP when a tid descriptor is passed.

I suppose that's fine.  Or alternatively, when thread group support is
added, introduce a flag that applications have to use to enable it, so
that they can probe for support by checking support for the flag.

I wouldn't be opposed to a new system call like this either:

  int procfd_open (pid_t thread_group, pid_t thread_id, unsigned flags);

But I think this is frowned upon on the kernel side.

>> What happens if you use the new interface with an O_PATH descriptor?
>
> You get EINVAL. When an O_PATH file descriptor is created the kernel
> will set file->f_op = &empty_fops at which point the check I added 
>         if (!proc_is_tgid_procfd(f.file))
>                 goto err;
> will fail. Imho this is correct behavior since technically signaling a
> struct pid is the equivalent of writing to a file and hence doesn't
> purely operate on the file descriptor level.

Yes, that's quite reasonable.  Thanks.

Florian
