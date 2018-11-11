Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4ADC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C250208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C250208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbeKKV42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:56:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38150 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727492AbeKKV41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:56:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 06423307D913;
        Sun, 11 Nov 2018 12:08:04 +0000 (UTC)
Received: from oldenburg.str.redhat.com (ovpn-116-74.ams2.redhat.com [10.36.116.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A4C55C1B4;
        Sun, 11 Nov 2018 12:07:59 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha\@sourceware.org" <libc-alpha@sourceware.org>
Subject: Re: Official Linux system wrapper library?
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
        <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com>
        <20181111081725.GA30248@1wt.eu>
        <87y39zx5xa.fsf@oldenburg.str.redhat.com>
        <20181111110236.GA4189@1wt.eu>
Date:   Sun, 11 Nov 2018 13:07:54 +0100
In-Reply-To: <20181111110236.GA4189@1wt.eu> (Willy Tarreau's message of "Sun,
        11 Nov 2018 12:02:36 +0100")
Message-ID: <87tvknvmud.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Sun, 11 Nov 2018 12:08:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Willy Tarreau:

> On Sun, Nov 11, 2018 at 11:30:25AM +0100, Florian Weimer wrote:
>> * Willy Tarreau:
>> 
>> > On Sun, Nov 11, 2018 at 07:55:30AM +0100, Michael Kerrisk (man-pages) wrote:
>> >> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=6399 is a
>> >>     longstanding example.
>> >
>> > This one was a sad read and shows that applications will continue to
>> > suffer from glibc's prehistorical view on operating systems and will
>> > continue to have to define their own syscall wrappers to exploit the
>> > full potential of the modern operating systems they execute on.
>> 
>> What's modern about a 15-bit thread identifier?
>
> It's 15-bit on 32-bit systems, and 22 on 64-bit, hence you can have
> 4 million threads and/or processes on a single system image provided
> you have the resources for that of course.

I believe the default for pid_max is still 32768.

>> I understand that using this interface is required in some cases (which
>> includes some system calls for which glibc does provide wrappers), but I
>> assumed that it was at least understood that these reusable IDs for
>> tasks were an extremely poor interface.  Aren't the resulting bugs
>> common knowledge?
>
> Sure, just as are the bugs created by people trying to implement their
> own syscall wrappers. It's not by denying access to some native system
> interfaces that you will prevent users from accessing them, you'll just
> force them to work around the restriction and make things even worse.

Well, once we have the fixed interface, it becomes easier to use if we
only expose that, and not the confusing interface which is described in
countless Stackoverflow answers.  More choice isn't always good.

>> > This reminds me when one had to write their own spinlocks and atomics
>> > many years ago. Seeing comments suggesting an application should open
>> > /proc/$PID makes me really wonder if people actually want to use slow
>> > and insecure applications designed this way.
>> 
>> I don't understand.  If you want a non-reusable identifier, you have to
>> go through the /proc interface anyway.  I think the recommendation is to
>> use the PID/start time combination to get a unique process identifier or
>> something like that.
>
> It depends what you want to achieve. If you just need the tid, the one
> you'll pass to sched_setaffinity(), gettid() is fine.

You can use pthread_setaffinity_np to control the affinity mask of a
thread without knowing its TID, and you can call sched_setaffinity on
the current thread without knowing its TID anyway.

And for sched_setattr, you need to call syscall anyway because there is
no wrapper, so calling gettid via syscall isn't that bad.  (We can't add
wrappers for sched_setattr because it's not entirely clear how the
userspace ABI will evolve in the future.)

> There are two issues
> with abusing /proc to emulate syscalls :
>   - it's sometimes much slower than the equivalent syscall and can
>     encourage users to cache the resulting values when they should not
>   - either it's done upon process startup and it may not get valid value
>     or may not work if /proc is not mounted yet (think init, mount etc),
>     or it's done upon first use and can break daemons which chroot()
>     themselves.

Sure, but many kernel developers prefer /proc and file-based interfaces.
See getumask for a particularly illuminating example.

> Syscalls don't have such limitations and are much safer to use. For other
> things it's quite possible that you cannot rely on this syscall at all,
> it's not a solution to everything, but it's a nice solution to all cases
> where you need to access the system-wide identifier to pin a thread to a
> given CPU set or renice it.

Again, you don't need gettid for that at all.  glibc has covered this
fully.

Surely there is a better justification for using gettid?

I suspect quite a few calls to the gettid system calls could actually be
getpid, and the programmer used __NR_gettid instead of __NR_getpid to
bypass the glibc PID cache.  But the cache isn't used by the syscall
code path anyway, so it really does not matter.

>> I wanted to add gettid to glibc this cycle, but your comments suggest to
>> me that if we did this, we'd likely never get a proper non-reusable
>> thread identifier from the kernel.  So I'm not sure what do anymore.
>
> "Look people, I was about to do what we all refused to do for 10 years
> now and Willy's comment made me change my mind, I'm sorry". The *real*
> argument that most users could understand is "guys, we're sorry, but we
> are running out of time and we won't work on this low priority stuff,
> so someone else will have to take care of it".

I can assure you that in the past, a glibc patch for gettid would have
been rejected even if it were perfectly fine as far as the contribution
guidelines go (that is, copyright assignment, coding style, manual
update, ABI list update etc.).  It's not a matter of resources or lack
thereof.

> In my opinion what matters is not whether or not people will use it
> appropriately, but that its validity, side effects and wrong assumptions
> are properly documented so that users don't shoot themselves in the foot.

Well, there I disagree.  I think adding bad interfaces that confuse
developers is not a good idea, particularly if there is no compelling
use case.  On the other hand, a userspace interface that is different
from what the kernel provides is confusing as well and leads to bugs
(see clone).

Thanks,
Florian
