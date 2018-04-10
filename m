Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeDJK4b (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:56:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:59629 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752927AbeDJK41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:56:27 -0400
Date: Tue, 10 Apr 2018 12:56:25 +0200
From: Petr Mladek <pmladek@suse.com>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Jiri Kosina <jikos@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] livepatch: Add an extra flag to distinguish
 registered patches
Message-ID: <20180410105625.4o4ozkpmanevytnh@pathway.suse.cz>
References: <20180323120028.31451-1-pmladek@suse.com>
 <20180323120028.31451-5-pmladek@suse.com>
 <alpine.LSU.2.21.1804091556110.20943@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1804091556110.20943@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-04-09 16:02:15, Miroslav Benes wrote:
> On Fri, 23 Mar 2018, Petr Mladek wrote:
> 
> > The initial implementation of the atomic replace feature keeps the replaced
> > patches on the stack. But people would like to remove the replaced patches
> > from different reasons that will be described in the following patch.
> > 
> > This patch is just a small preparation step. We will need to keep
> > the replaced patches registered even when they are not longer on the stack.
> 
> In my opinion it could be easier for a review to squash the patch into the 
> next one.

OK, I'll squash them.


> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index f28af280f9e0..d6e6d8176995 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -378,7 +383,7 @@ int klp_disable_patch(struct klp_patch *patch)
> >  
> >  	mutex_lock(&klp_mutex);
> >  
> > -	if (!klp_is_patch_registered(patch)) {
> > +	if (!patch->registered) {
> 
> I don't see any actual problem, but I'd feel safer if we preserve 
> klp_is_patch_on_stack() even somewhere in disable path.

It is strictly needed in klp_enable_patch() which will be better
visible if I squash it with the next patch.

The use in klp_disable_patch() is optional. I do not have problems
to add it there though. If Josh does not see it as too paranoid,
I'll add it.

Best Regards,
Petr
