Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751768AbeDKEbB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 00:31:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeDKEa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 00:30:59 -0400
Date: Tue, 10 Apr 2018 21:30:52 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>,
        jikos@suse.cz, raven@themaw.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: update-binfmts breaking suspend
Message-ID: <20180411043052.GA15171@bombadil.infradead.org>
References: <20180404165559.4cd0c12c@canb.auug.org.au>
 <20180404075047.GB9342@amd>
 <CAJZ5v0hxyXtyKacJufivL9HWbQBsxTBYVipnHK4+QquTYjpc+A@mail.gmail.com>
 <20180404084905.GA12303@amd>
 <20180405122503.GA28446@amd>
 <20180405203045.GA23313@amd>
 <SN4PR2101MB073673B12998428D48DA62E5CBBA0@SN4PR2101MB0736.namprd21.prod.outlook.com>
 <20180406144355.GA20605@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406144355.GA20605@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ping?

On Fri, Apr 06, 2018 at 07:43:55AM -0700, Matthew Wilcox wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> > > Failure is not a hang, as they expect, but... machine locks up, but
> > > does not suspend, and then continues running after a delay..
> > > 
> > > [   35.038766] PM: Syncing filesystems ... done.
> > > [   35.051246] Freezing user space processes ...
> > > [   55.060528] Freezing of tasks failed after 20.009 seconds (1 tasks
> > > refusing to freeze, wq_busy
> > > =0):
> > > [   55.060552] update-binfmts  D    0  2727      1 0x80000004
> > > [   55.060576] Call Trace:
> > > [   55.060600]  __schedule+0x37a/0x7e0
> > > [   55.060618]  schedule+0x29/0x70
> > > [   55.060635]  autofs4_wait+0x359/0x7a0
> > > [   55.060653]  ? wait_woken+0x70/0x70
> > > [   55.060668]  autofs4_mount_wait+0x4a/0xe0
> > > [   55.060684]  ? autofs4_mount_wait+0x4a/0xe0
> > > [   55.060699]  autofs4_d_automount+0xe0/0x200
> > > [   55.060715]  ? autofs4_d_automount+0xe0/0x200
> > > 
> > > Did the rework of freezing start already in -next?
> > 
> > Hmm, so I did git bisect, and it pointed to:
> > 
> > commit 7cb03edf112fea6ead2fcd3c5fd639756d6d114b
> > Author: Matthew Wilcox <mawilcox@microsoft.com>
> > Date:   Thu Mar 29 10:15:17 2018 +1100
> > 
> >     autofs4: use wait_event_killable
> > 
> >     This playing with signals to allow only fatal signals appears to
> >     predate
> >         the introduction of wait_event_killable(), and I'm fairly sure
> >     that
> >         wait_event_killable is what was meant to happen here.
> 
> Umm.  I'm not familiar with the freezer.  Help me out here ...
> 
> I see the message coming from here:
> 
>                 pr_err("Freezing of tasks %s after %d.%03d seconds "
>                        "(%d tasks refusing to freeze, wq_busy=%d):\n",
>                        wakeup ? "aborted" : "failed",
>                        elapsed_msecs / 1000, elapsed_msecs % 1000,
>                        todo - wq_busy, wq_busy);
> 
> and then backtracking in that function, I see this:
> 
>                 for_each_process_thread(g, p) {
>                         if (p == current || !freeze_task(p))
>                                 continue;
> 
> in freeze_task(), I see this:
> 
>         if (!(p->flags & PF_KTHREAD))
>                 fake_signal_wake_up(p);
>         else
>                 wake_up_state(p, TASK_INTERRUPTIBLE);
> 
> which does this:
> 
>         if (lock_task_sighand(p, &flags)) {
>                 signal_wake_up(p, 0);
>                 unlock_task_sighand(p, &flags);
>         }
> 
> which does this:
> 
> static inline void signal_wake_up(struct task_struct *t, bool resume)
> {
>         signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
> }
> 
> which does this:
> 
> void signal_wake_up_state(struct task_struct *t, unsigned int state)
> {
>         set_tsk_thread_flag(t, TIF_SIGPENDING);
>         /*
>          * TASK_WAKEKILL also means wake it up in the stopped/traced/killable
>          * case. We don't check t->state here because there is a race with it
>          * executing another processor and just now entering stopped state.
>          * By using wake_up_state, we ensure the process will wake up and
>          * handle its death signal.
>          */
>         if (!wake_up_state(t, state | TASK_INTERRUPTIBLE))
>                 kick_process(t);
> }
> 
> Now I don't know why we only wake interruptible tasks here and not killable
> tasks.  I've trawled git history all the way back to 2.6.12-rc2, and the
> reasoning behind signal_wake_up() (as it originally was) is lost to pre-git
> history.
> 
> So ... why do we only wake interruptible tasks on suspend?  Why not wake
> uninterruptible tasks too?
> 
>         if (lock_task_sighand(p, &flags)) {
> -               signal_wake_up(p, 0);
> +               signal_wake_up_state(p, TASK_WAKEKILL);
>                 unlock_task_sighand(p, &flags);
>         }
> 
> or why do we consider tasks waiting uninterruptibly to block freezing?
> Is it because they're (probably) waiting for I/O and we want the I/O
> to complete?
