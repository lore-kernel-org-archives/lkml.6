Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936881AbeE2PHH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 11:07:07 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46162 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936865AbeE2PHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 11:07:02 -0400
X-Google-Smtp-Source: AB8JxZqS4LxGC85oiLZVFWU1Lc0QLfvrCBLRBldp6zQ3hKQxinEzbTHoxwbcBbXbb80nwGSPGEqAJw==
Date: Tue, 29 May 2018 17:06:59 +0200
From: Christian Brauner <christian@brauner.io>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com,
        gregkh@linuxfoundation.org, mingo@kernel.org,
        james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org
Subject: Re: [PATCH v1 06/20] signal: drop else branch in do_signal_stop()
Message-ID: <20180529150658.GA28029@gmail.com>
References: <20180528215355.16119-1-christian@brauner.io>
 <20180528215355.16119-7-christian@brauner.io>
 <20180529143039.GA1802@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180529143039.GA1802@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 04:30:40PM +0200, Oleg Nesterov wrote:
> I am busy now, can't review, just picked a random patch from this series...
> 
> On 05/28, Christian Brauner wrote:
> > do_signal_stop() already returns in the if branch so there's no need to
> > keep the else branch around.
> 
> OK, but for what???

Yes to both.

> 
> Do you think this change makes the code more readable? more clean? or what?
> 
> I do not really care but to me these "if/else" branches make this code more
> symmetrical, so I don't understand the purpose.

The pattern where both the if and the else branch return is fairly
uncommon even in this file. Otherwise you would need to also argue that
functions like:

int send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
{
        /*
         * Make sure legacy kernel users don't send in bad values
         * (normal paths check this in check_kill_permission).
         */
        if (!valid_signal(sig))
                return -EINVAL;

        return do_send_sig_info(sig, info, p, false);
}

should really be:

int send_sig_info(int sig, struct siginfo *info, struct task_struct *p)
{
        /*
         * Make sure legacy kernel users don't send in bad values
         * (normal paths check this in check_kill_permission).
         */
        if (!valid_signal(sig))
                return -EINVAL;
        else
                return do_send_sig_info(sig, info, p, false);
}

Which I find very uneasy on the eye. Even more so when there are
multiple lines in the else that returns.

Christian

> 
> 
> 
> > Signed-off-by: Christian Brauner <christian@brauner.io>
> > ---
> > v0->v1:
> > * patch unchanged
> > ---
> >  kernel/signal.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index a628b56415e6..d1914439f144 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -2214,14 +2214,14 @@ static bool do_signal_stop(int signr)
> >  		/* Now we don't run again until woken by SIGCONT or SIGKILL */
> >  		freezable_schedule();
> >  		return true;
> > -	} else {
> > -		/*
> > -		 * While ptraced, group stop is handled by STOP trap.
> > -		 * Schedule it and let the caller deal with it.
> > -		 */
> > -		task_set_jobctl_pending(current, JOBCTL_TRAP_STOP);
> > -		return false;
> >  	}
> > +
> > +	/*
> > +	 * While ptraced, group stop is handled by STOP trap.
> > +	 * Schedule it and let the caller deal with it.
> > +	 */
> > +	task_set_jobctl_pending(current, JOBCTL_TRAP_STOP);
> > +	return false;
> >  }
> >  
> >  /**
> > -- 
> > 2.17.0
> > 
> 
