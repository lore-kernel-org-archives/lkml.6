Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeCORf2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:35:28 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:38135 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCORf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:35:26 -0400
X-Google-Smtp-Source: AG47ELsl2+H57sAEYoi+rTI9kOW6RDZkDibRyaceM2/nOlTdhgrvNTu1XCrIrWak/fMDTUq4eJ2wPw==
Date: Thu, 15 Mar 2018 11:35:24 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: Andy Lutomirski <luto@kernel.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [RFC 0/3] seccomp trap to userspace
Message-ID: <20180315173524.k7vwnvnhomg2j5yv@smitten>
References: <20180204104946.25559-1-tycho@tycho.ws>
 <20180315160924.GA12744@gmail.com>
 <CALCETrVnvbZLx5v=DMu2N1JtR+ys507X5CYBi-qQnus3VMQdwg@mail.gmail.com>
 <20180315170509.GA32766@mail.hallyn.com>
 <CALCETrXPcCNbpFJhXktkVS9gOPpmnU_bbY6Z8RrsBarq0dP4Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXPcCNbpFJhXktkVS9gOPpmnU_bbY6Z8RrsBarq0dP4Lg@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Thu, Mar 15, 2018 at 05:11:32PM +0000, Andy Lutomirski wrote:
> On Thu, Mar 15, 2018 at 5:05 PM, Serge E. Hallyn <serge@hallyn.com> wrote:
> > Hm, synchronously - that brings to mind a thought...  I should re-look at
> > Tycho's patches first, but, if I'm in a container, start some syscall that
> > gets trapped to userspace, then I hit ctrl-c.  I'd like to be able to have
> > the handler be interrupted and have it return -EINTR.  Is that going to
> > be possible with the synchronous approach?
> 
> I think so, but it should be possible with the classic async approach
> too.  The main issue is the difference between a classic filter like
> this (pseudocode):
> 
> if (nr == SYS_mount) return TRAP_TO_USERSPACE;
> 
> and the eBPF variant:
> 
> if (nr == SYS_mount) trap_to_userspace();

Sargun started a private design discussion thread that I don't think
you were on, but Alexei said something to the effect of "eBPF programs
will never wait on userspace", so I'm not sure we can do something
like this in an eBPF program. I'm cc-ing him here again to confirm,
but I doubt things have changed.

> I admit that it's still not 100% clear to me that the latter is
> genuinely more useful than the former.
> 
> The case where I think the synchronous function call is a huge win is this one:
> 
> if (nr  == SYS_mount) {
>   log("Someone called mount with args %lx\n", ...);
>   return RET_KILL;
> }
> 
> The idea being that the log message wouldn't show up in the kernel log
> -- it would get sent to the listener socket belonging to whoever
> created the filter, and that process could then go and log it
> properly.  This would work perfectly in containers and in totally
> unprivileged applications like Chromium.

The current implementation can't do exactly this, but you could do:

if (nr == SYS_mount) {
    log(...);
    kill(pid, SIGKILL);
}

from the handler instead.

I guess Serge is asking a slightly different question: what if the
task gets e.g. SIGINT from the user doing a ^C or SIGALARM or
something, we should probably send the handler some sort of message or
interrupt to let it know that the syscall was cancelled. Right now the
current set doesn't behave that way, and the handler will just
continue on its merry way and get an EINVAL when it tries to respond
with the cancelled cookie.

Anyway, I think these last two points can be addressed with the
approach from this series. The notification to the handler about a
cancelled syscall might be slightly awkward, but I'll take a look.

Cheers,

Tycho
