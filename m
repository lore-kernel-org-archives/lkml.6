Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeCPQk6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 12:40:58 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:9228 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751630AbeCPQky (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 12:40:54 -0400
Date: Fri, 16 Mar 2018 17:40:48 +0100
From: Christian Brauner <christian.brauner@mailbox.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andy Lutomirski <luto@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        LKML <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian.brauner@canonical.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [RFC 0/3] seccomp trap to userspace
Message-ID: <20180316164048.GA30454@mailbox.org>
References: <20180204104946.25559-1-tycho@tycho.ws>
 <20180315160924.GA12744@gmail.com>
 <CALCETrVnvbZLx5v=DMu2N1JtR+ys507X5CYBi-qQnus3VMQdwg@mail.gmail.com>
 <20180315170509.GA32766@mail.hallyn.com>
 <CALCETrXPcCNbpFJhXktkVS9gOPpmnU_bbY6Z8RrsBarq0dP4Lg@mail.gmail.com>
 <20180315173524.k7vwnvnhomg2j5yv@smitten>
 <CALCETrWH7HbY2gS6O_cYKfp9QqqWBWVcHb++GaP3uUiSO9oo6g@mail.gmail.com>
 <20180316144751.GA3304@mailbox.org>
 <D73E5C37-DC92-4D58-A163-0B20143AAEEB@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D73E5C37-DC92-4D58-A163-0B20143AAEEB@amacapital.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 09:01:47AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Mar 16, 2018, at 7:47 AM, Christian Brauner <christian.brauner@mailbox.org> wrote:
> > 
> >> On Fri, Mar 16, 2018 at 12:46:55AM +0000, Andy Lutomirski wrote:
> 
> 
> I bet I confused everyone with a blatant typo:
> 
> >> 
> >> Hmm, I think we have to be very careful to avoid nasty races.  I think
> >> the correct approach is to notice the signal and send a message to the
> >> listener that a signal is pending but to take no additional action.
> >> If the handler ends up completing the syscall with a successful
> >> return, we don't want to replace it with -EINTR.  IOW the code looks
> >> kind of like:
> >> 
> >> send_to_listener("hey I got a signal");
> 
> That should be “hey I got a syscall”.   D’oh!

Ha ok, that's what led me to believe that listener != handler and I was
trying to make sense of thise. :)

Thanks!
Christian

> 
> >> wait_ret = wait_interruptible for the listener to reply;
> >> if (wait_ret == -EINTR) {
> > 
> > Hm, so from the pseudo-code it looks like: The handler would inform the
> > listener that it received a signal (either from the syscall requester or
> > from somewhere else) and then wait for the listener to reply to that
> > message.  This would allow the listener to decide what action it wants
> > the handler to take based on the signal, i.e. either cancel the request
> > or retry?  The comment makes it sound like that the handler doesn't
> > really wait on the listener when it receives a signal it simply moves
> > on.
> 
> It keeps waiting killably but not interruptibly. 
> 
> > So no "taking no additional action" here means not have the handler
> > decide to abort but the listener?
> 
> If by “handler” you mean kernel, then yes. 
> 
> There’s no userspace syscall handler involved. From the kernel’s perspective, a syscall is never still in progress when a signal handler is invoked — we only actually invoke syscall handlers in prepare_exit_to_usermode() or the non-x86 equivalent and the functions it calls. While a syscall is running, the kernel might notice that a signal is pending and do one of a few things:
> 
> 1. Just keep going. Not all syscalls can be interrupted. 
> 
> 2. Try to finish early. If a send() call has already sent some but not all data, it can stop waiting and return the number of bytes sent.
> 
> 3. Abort with -EINTR.
> 
> 4. Abort with -ERESTARTSYS or one of its relatives. These fiddle with user registers in a somewhat unpleasant way to pretend that the syscall never actually happened.  This works for syscalls that wait with an absolute timeout, for example. 
> 
> 5. Set up restart_syscall() magic, rewrite regs so it looks like the user was about to call restart_syscall() when the signal happened, and abort. 
> 
> In all cases, the signal is dealt with afterwards. This could result in changing regs to call the handler or in simply returning. 
> 
> 1-3 should work fully in seccomp. The only issue is that the kernel doesn’t know *which* to do, nor can the kernel force the listener to abort cleanly, so I think we have  no real choice but to let the listener decide. 
> 
> 4 could be supported just like 1-3. 5 is awful, and I don’t think we should support it for user listeners. 
