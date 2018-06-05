Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeFEHRz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 03:17:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:42030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751264AbeFEHRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 03:17:54 -0400
Date: Tue, 5 Jun 2018 09:17:52 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: jikos@kernel.org, jeyu@kernel.org, pmladek@suse.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Send a fake signal periodically
In-Reply-To: <20180604180325.yeewbafxpjkt6gi5@treble>
Message-ID: <alpine.LSU.2.21.1806050857060.27280@pobox.suse.cz>
References: <20180604141636.11523-1-mbenes@suse.cz> <20180604141636.11523-2-mbenes@suse.cz> <20180604180325.yeewbafxpjkt6gi5@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jun 2018, Josh Poimboeuf wrote:

> On Mon, Jun 04, 2018 at 04:16:35PM +0200, Miroslav Benes wrote:
> > An administrator may send a fake signal to all remaining blocking tasks
> > of a running transition by writing to
> > /sys/kernel/livepatch/<patch>/signal attribute. Let's do it
> > automatically after 10 seconds. The timeout is chosen deliberately. It
> > gives the tasks enough time to transition themselves.
> > 
> > Theoretically, sending it once should be more than enough. Better be safe
> > than sorry, so send it periodically.
> 
> This is the part I don't understand.  Why do it periodically?

I met (rare!) cases when doing it once was not enough due to a race and 
the signal was missed. However involved testcases were really artificial.
 
> Instead, might it make sense to just send the signals once, and if that
> doesn't work, reverse the transition?  Then we could make patching a
> synchronous operation.  But then, it might be remotely possible that the
> reverse operation also stalls (e.g., on a kthread).  So, maybe it's best
> to just leave all these controls in the hands of the user.

And there is 'force' option...

So given all this, I'd call klp_send_signals() once and then leave it up 
to the user. Would that work for you?

> All that said, a few code review comments:
> 
> - AFAICT, it does an 8 second delay instead of a 10 second delay,
>   because

Not that it matters, because it is still wrong, but it is a 9 second 
delay (or I miscounted again).

>   a) try_complete_transition() is first called before there's any delay;
> 
>   b) the preincrement operator used on signals_cnt.
> 
> - I think 15 seconds might be a better default.  I've seen longer
>   patching delays on a system with 100+ CPUs.

Ok, why not. 

> - If a kthread or idle task is sleeping on a patched function, the
>   pr_notice("signaling remaining tasks\n") will be repeated continously.

True.

> - It might be cleaner to do it from the delayed work function
>   (klp_transition_work_fn).

I considered it but then decided to do it in klp_try_complete_transition() 
under 'if (!complete)'. It belongs right there in my opinion.

Thanks,
Miroslav
