Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934790AbeE2NzQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:55:16 -0400
Received: from mx1.mailbox.org ([80.241.60.212]:45468 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933755AbeE2NzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:55:14 -0400
Date: Tue, 29 May 2018 15:55:08 +0200
From: Christian Brauner <christian@brauner.io>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        mingo@kernel.org, james.morris@microsoft.com, keescook@chromium.org,
        peterz@infradead.org, sds@tycho.nsa.gov, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, oleg@redhat.com
Subject: Re: [PATCH v1 04/20] signal: add copy_pending() helper
Message-ID: <20180529135508.GA20444@mailbox.org>
References: <20180528215355.16119-1-christian@brauner.io>
 <20180528215355.16119-5-christian@brauner.io>
 <87r2lusl8l.fsf@xmission.com>
 <20180529124159.GB11221@mailbox.org>
 <87fu2apoeh.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fu2apoeh.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 08:44:22AM -0500, Eric W. Biederman wrote:
> Christian Brauner <christian@brauner.io> writes:
> 
> > On Tue, May 29, 2018 at 07:24:26AM -0500, Eric W. Biederman wrote:
> >> Christian Brauner <christian@brauner.io> writes:
> >> 
> >> > Instead of using a goto for this let's add a simple helper copy_pending()
> >> > which can be called in both places.
> >> 
> >> Ick no.  As far as I can see this just confuses the logic of the
> >> collect_signal function.
> >> 
> >> Instead of having two cases with an optional
> >> "sigdelset(&list->signal, sig)" if the signal is no longer in the queue,
> >> you are moving the core work of collect_signal into another function.
> >> 
> >> At the very least this is going to make maintenance more difficult
> >> as now the work of this function is split into two functions.
> >
> > I do disagree here tbh. The goto jump into it the if part of an if-else
> > seems pretty nasty.
> > I also don't know why this should be confusing the logic. There's a
> > single function that is called in two places and it is declared directly
> > atop it's only caller. Additionally, recognizing a single name of a
> > function as being the same in two places is way easier then recognizing
> > that a multi-line pattern is the same in two places.
> 
> But there are not two places.  There is only one place.

Which is reachable from two different places and the goal was to avoid
having to jump into the second location with a goto in an if-else
construct.

> The logic might be cleaned up reorganizing the tests a little bit.
> Something like this perhaps.
> 
> 	/*
> 	 * Collect the siginfo appropriate to this signal.  Check if
> 	 * there is another siginfo for the same signal.
> 	*/
> 	list_for_each_entry(q, &list->list, list) {
> 		if (q->info.si_signo == sig) {
> 			if (first)
>                         	break;
> 			first = q;
> 		}
> 	}
> 
> 	/* Not still pending? */
> 	if (!first || (&q->list != &list->list))
>         	sigdelset(&list->signal, sig);
> 	if (first) {
> 		...
> 
> 
> The logic at a high level is:
> 	Is there another instance of this signal pending?
>              yes?  Then don't "sigdelset"
>         Do we have siginfo?
>            yes? return it.
>            no?  dummy up a siginfo.
> 
> Making that logic clearer would be nice.  Obscuring it with

I'm happy to change this in v2. But there's nothing obscure about
calling a helper function in two places while I can keep the definiton
of the helper function and the two places that it is called in on the
same 80x43 terminal.

Christian

> an extra function just obstructs maintenance.
> 
> Eric
