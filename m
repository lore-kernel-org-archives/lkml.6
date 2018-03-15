Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeCORae (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:49642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750987AbeCORad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:30:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 851C8217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELuO+NKf2KWWDBOYjwdbDT52ab6YVBzamYsaZRtPYhQqbSUVE3qY5ci87HRK61BQvt4HeB7ExLQi0S94Dt6Ykl0=
MIME-Version: 1.0
In-Reply-To: <20180315172558.GA28108@gmail.com>
References: <CALCETrVnvbZLx5v=DMu2N1JtR+ys507X5CYBi-qQnus3VMQdwg@mail.gmail.com>
 <20180315170509.GA32766@mail.hallyn.com> <CALCETrXPcCNbpFJhXktkVS9gOPpmnU_bbY6Z8RrsBarq0dP4Lg@mail.gmail.com>
 <20180315172558.GA28108@gmail.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 15 Mar 2018 17:30:11 +0000
X-Gmail-Original-Message-ID: <CALCETrVDj97L2VBbQNrPwJD7Z2VZcC3ffgVv-UgmY=kZz6yZZA@mail.gmail.com>
Message-ID: <CALCETrVDj97L2VBbQNrPwJD7Z2VZcC3ffgVv-UgmY=kZz6yZZA@mail.gmail.com>
Subject: Re: [RFC 0/3] seccomp trap to userspace
To: Christian Brauner <christian.brauner@canonical.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 5:25 PM, Christian Brauner
<christian.brauner@canonical.com> wrote:
> On Thu, Mar 15, 2018 at 05:11:32PM +0000, Andy Lutomirski wrote:
>> On Thu, Mar 15, 2018 at 5:05 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
>> > Quoting Andy Lutomirski (luto@kernel.org):
>> >> On Thu, Mar 15, 2018 at 4:09 PM, Christian Brauner
>> >> <christian.brauner@canonical.com> wrote:
>> >> > On Sun, Feb 04, 2018 at 11:49:43AM +0100, Tycho Andersen wrote:
>> >> >> Several months ago at Linux Plumber's, we had a discussion about adding a
>> >> >> feature to seccomp which would allow seccomp to trigger a notification for some
>> >> >> other process. Here's a draft of that feature.
>> >> >>
>> >> >> Patch 1 contains the bulk of it, patches 2 & 3 offer an alternative way to
>> >> >> acquire the fd that receives notifications via ptrace (the method in patch 1
>> >> >> poses some problems). Other suggestions for how to acquire one of these fds
>> >> >> would be welcome.
>> >> >>
>> >> >> Take a close look at the synchronization. I think I've got it right, but I
>> >> >> probably don't :)
>> >> >>
>> >> >> Thanks!
>> >> >>
>> >> >> Tycho Andersen (3):
>> >> >>   seccomp: add a return code to trap to userspace
>> >> >>   seccomp: hoist out filter resolving logic
>> >> >>   seccomp: add a way to get a listener fd from ptrace
>> >> >>
>> >> >>  arch/Kconfig                                  |   7 +
>> >> >>  include/linux/seccomp.h                       |  14 +-
>> >> >>  include/uapi/linux/ptrace.h                   |   1 +
>> >> >>  include/uapi/linux/seccomp.h                  |  18 +-
>> >> >>  kernel/ptrace.c                               |   4 +
>> >> >>  kernel/seccomp.c                              | 467 ++++++++++++++++++++++++--
>> >> >>  tools/testing/selftests/seccomp/seccomp_bpf.c | 180 +++++++++-
>> >> >>  7 files changed, 653 insertions(+), 38 deletions(-)
>> >> >
>> >> > Hey,
>> >> >
>> >> > So, I've been following the discussion silently in the background and I
>> >> > see that it got sidetracked into seccomp + ebpf. While I can see that
>> >> > there is value in adding epbf support to seccomp I'd really like to see
>> >> > this decoupled from this patchset. Afaict, this patchset would just work
>> >> > fine without the ebpf portion (but I might be just have missed the
>> >> > point). So if possible I would like to see a second version of this with
>> >> > the comments accounted for and - if possible - have this up for merging
>> >> > independent of the ebpf patchset that's floating around.
>> >> >
>> >>
>> >> The issue is that it might be (and, then again, might not be) nicer to
>> >> to *synchronously* call out to the monitor in the filter.  eBPF can do
>> >> that very cleanly, whereas classic BPF can't.
>> >
>> > Hm, synchronously - that brings to mind a thought...  I should re-look at
>> > Tycho's patches first, but, if I'm in a container, start some syscall that
>> > gets trapped to userspace, then I hit ctrl-c.  I'd like to be able to have
>> > the handler be interrupted and have it return -EINTR.  Is that going to
>> > be possible with the synchronous approach?
>>
>> I think so, but it should be possible with the classic async approach
>> too.  The main issue is the difference between a classic filter like
>> this (pseudocode):
>>
>> if (nr == SYS_mount) return TRAP_TO_USERSPACE;
>>
>> and the eBPF variant:
>>
>> if (nr == SYS_mount) trap_to_userspace();
>>
>> I admit that it's still not 100% clear to me that the latter is
>> genuinely more useful than the former.
>
> We've just discussed this on irc and the fact that most problems can be
> addressed by interfaces we already have makes it questionable what ebpf
> brings to the game here. Especially since the discussion gave the
> impression that if ebpf ever makes it to seccomp it will basically be
> because it allows a nice implementation of the trap to userspace. If
> it's even unclear whether it is really the better choice for this task
> then we could consider to no try and make this patchset use it. (I
> probably sound way more polemic than I intend to.)
>

No argument from me.

To be clear, I don't think that trap to userspace should block on eBPF
at all.  It was just a coincidence that both patches showed up around
the same time, and if they actually work well together, then it could
make sense to combine them.  But if trap to userspace ends up working
perfectly without eBPF, that's fine too.
