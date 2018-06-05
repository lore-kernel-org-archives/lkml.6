Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752036AbeFEOBo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:01:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36890 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751866AbeFEOBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:01:43 -0400
Date: Tue, 5 Jun 2018 09:01:41 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: jikos@kernel.org, jeyu@kernel.org, pmladek@suse.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Send a fake signal periodically
Message-ID: <20180605140040.in2ndsb34o42hert@treble>
References: <20180604141636.11523-1-mbenes@suse.cz>
 <20180604141636.11523-2-mbenes@suse.cz>
 <20180604180325.yeewbafxpjkt6gi5@treble>
 <alpine.LSU.2.21.1806050857060.27280@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1806050857060.27280@pobox.suse.cz>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 09:17:52AM +0200, Miroslav Benes wrote:
> On Mon, 4 Jun 2018, Josh Poimboeuf wrote:
> 
> > On Mon, Jun 04, 2018 at 04:16:35PM +0200, Miroslav Benes wrote:
> > > An administrator may send a fake signal to all remaining blocking tasks
> > > of a running transition by writing to
> > > /sys/kernel/livepatch/<patch>/signal attribute. Let's do it
> > > automatically after 10 seconds. The timeout is chosen deliberately. It
> > > gives the tasks enough time to transition themselves.
> > > 
> > > Theoretically, sending it once should be more than enough. Better be safe
> > > than sorry, so send it periodically.
> > 
> > This is the part I don't understand.  Why do it periodically?
> 
> I met (rare!) cases when doing it once was not enough due to a race and 
> the signal was missed. However involved testcases were really artificial.
>  
> > Instead, might it make sense to just send the signals once, and if that
> > doesn't work, reverse the transition?  Then we could make patching a
> > synchronous operation.  But then, it might be remotely possible that the
> > reverse operation also stalls (e.g., on a kthread).  So, maybe it's best
> > to just leave all these controls in the hands of the user.
> 
> And there is 'force' option...
> 
> So given all this, I'd call klp_send_signals() once and then leave it up 
> to the user. Would that work for you?

Well, I don't know.  Since the patching process will already need to be
managed by user space, what's the benefit of having the kernel doing
only this part of it?

-- 
Josh
