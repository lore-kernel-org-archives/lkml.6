Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 0IlcAo82HlvKIAAAmS7hNA
	; Mon, 11 Jun 2018 08:45:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 25AB060792; Mon, 11 Jun 2018 08:45:28 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 99F48602FC;
	Mon, 11 Jun 2018 08:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 99F48602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932651AbeFKIp0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:45:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:45828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932247AbeFKIpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:45:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E088DACCA;
        Mon, 11 Jun 2018 08:45:21 +0000 (UTC)
Date: Mon, 11 Jun 2018 10:45:21 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, jikos@kernel.org,
        jeyu@kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: Send a fake signal periodically
Message-ID: <20180611084521.3lq7bjwnj3zpenjw@pathway.suse.cz>
References: <20180604141636.11523-1-mbenes@suse.cz>
 <20180604141636.11523-2-mbenes@suse.cz>
 <20180604180325.yeewbafxpjkt6gi5@treble>
 <alpine.LSU.2.21.1806050857060.27280@pobox.suse.cz>
 <20180605140040.in2ndsb34o42hert@treble>
 <alpine.LSU.2.21.1806060945350.19628@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1806060945350.19628@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-06-06 09:49:50, Miroslav Benes wrote:
> On Tue, 5 Jun 2018, Josh Poimboeuf wrote:
> 
> > On Tue, Jun 05, 2018 at 09:17:52AM +0200, Miroslav Benes wrote:
> > > On Mon, 4 Jun 2018, Josh Poimboeuf wrote:
> > > 
> > > > On Mon, Jun 04, 2018 at 04:16:35PM +0200, Miroslav Benes wrote:
> > > > > An administrator may send a fake signal to all remaining blocking tasks
> > > > > of a running transition by writing to
> > > > > /sys/kernel/livepatch/<patch>/signal attribute. Let's do it
> > > > > automatically after 10 seconds. The timeout is chosen deliberately. It
> > > > > gives the tasks enough time to transition themselves.
> > > > > 
> > > > > Theoretically, sending it once should be more than enough. Better be safe
> > > > > than sorry, so send it periodically.
> > > > 
> > > > This is the part I don't understand.  Why do it periodically?
> > > 
> > > I met (rare!) cases when doing it once was not enough due to a race and 
> > > the signal was missed. However involved testcases were really artificial.
> > >  
> > > > Instead, might it make sense to just send the signals once, and if that
> > > > doesn't work, reverse the transition?  Then we could make patching a
> > > > synchronous operation.  But then, it might be remotely possible that the
> > > > reverse operation also stalls (e.g., on a kthread).  So, maybe it's best
> > > > to just leave all these controls in the hands of the user.
> > > 
> > > And there is 'force' option...
> > > 
> > > So given all this, I'd call klp_send_signals() once and then leave it up 
> > > to the user. Would that work for you?
> > 
> > Well, I don't know.  Since the patching process will already need to be
> > managed by user space, what's the benefit of having the kernel doing
> > only this part of it?
> 
> I'm not sure about 'will already need to be managed by user space' part. 
> Sending the fake signal would unblock transition in certain cases "for 
> free". No user interaction is really needed and we can do it 
> automatically. That's why I find it beneficial.

I wonder if several kicks might be necessary to get a kthread patched.

BTW: This approach has a bit different effect in compare with kGraft.
In kGraft, it was enough to force kthread going over an explicitly
defined safe point where it migrated itself. In upstream, the kthread
must get scheduled outside any patched function. The chance might
be a bit random.

To make it clear. I believe that sending signal once makes sense for
sure. And it would make sense to even repeat it.

BTW: If we allow to repeat it, we should reset the counter in
klp_reverse_transition().

Best Regards,
Petr
