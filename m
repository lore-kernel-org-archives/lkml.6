Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbeDKNji (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:39:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:55620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752335AbeDKNjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:39:35 -0400
Date: Wed, 11 Apr 2018 15:39:30 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Josh Poimboeuf <jpoimboe@redhat.com>
cc: Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
In-Reply-To: <20180411123214.mfpkbrirze32phrb@treble>
Message-ID: <alpine.LSU.2.21.1804111534080.28885@pobox.suse.cz>
References: <20180319214324.riyp233trtfxbeto@treble> <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz> <20180320201502.2skkk3ld4zk2dxwg@treble> <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz> <20180323224410.vuq5cabfprqhd6ej@treble>
 <20180326101107.bbloeh5l276on7uz@pathway.suse.cz> <20180406195049.dtfebzfdkbvv6yex@treble> <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz> <20180410174206.l3uk6lchhzxvn75x@treble> <alpine.LSU.2.21.1804110956430.28885@pobox.suse.cz>
 <20180411123214.mfpkbrirze32phrb@treble>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Apr 2018, Josh Poimboeuf wrote:

> On Wed, Apr 11, 2018 at 10:07:31AM +0200, Miroslav Benes wrote:
> > > > I was confused by wording "in the middle". It suggested that there
> > > > might had been enabled patches on the top and the bottom of the stack
> > > > and some disabled patches in between at the same time (or vice versa).
> > > > This was not true.
> > > 
> > > That *was* what I meant.  Consider the following sequence of events:
> > > 
> > > - Register patch 1
> > > - Enable patch 1
> > > - Register patch 2
> > > - Enable patch 2
> > > - Disable patch 2
> > > - Register patch 3
> > > - Enable patch 3
> > > 
> > > Notice that patch 2 (in the middle) is disabled, whereas patch 1 (on the
> > > bottom) and patch 3 (on the top) are enabled.
> > 
> > This should not be possible at all.
> > 
> > __klp_enable_patch:
> > 
> >         if (patch->list.prev != &klp_patches &&
> >             !list_prev_entry(patch, list)->enabled)
> >                 return -EBUSY;
> > 
> > When patch 3 is enabled, list_prev_entry() returns patch 2 and its 
> > ->enabled is false.
> 
> Hm, you're right.  I'm not sure how I got that idea...
> 
> I still agree with my original conclusion that enforcing stack order no
> longer makes sense though.

Frankly I cannot say. I have got no opinion on this, so if there is a 
patch to remove it, I won't oppose it (probably). I just think it is 
connected to the atomic replace patch set.
 
> > > > Another possibility would be to get rid of the enable/disable states.
> > > > I mean that the patch will be automatically enabled during
> > > > registration and removed during unregistration.
> > > 
> > > I don't see how disabling during unregistration would be possible, since
> > > the unregister is called from the patch module exit function, which
> > > can only be called *after* the patch is disabled.
> > > 
> > > However, we could unregister immediately after disabling (i.e., in
> > > enabled_store context).
> > 
> > I think this is what Petr meant. So there would be nothing in the patch 
> > module exit function. Well, not exactly. We'd need to remove sysfs dir and 
> > maybe something more.
> 
> Sounds good to me, though aren't the livepatch sysfs entries removed by
> klp during unregister?

Yes. I was thinking we may take something out of disable+unregister step 
and leave it in the exit function, but maybe there is nothing like that.

> > > > The question is what is acceptable to others
> > > 
> > > If there are any objections, this is their chance to speak up :-)
> > > 
> > > > and if it needs to be done as part of this patch set.
> > > 
> > > Maybe so, for at least a few reasons:
> > > 
> > > - This patch set makes the 'stack' obsolete, so it makes sense to remove
> > >   the 'stack' with it.
> > 
> > Not necessarily. I like Petr's rebase explanation here.
> 
> I'm not sure what you mean.  IIRC, his rebase explanation referred to
> how we handle 'replace' patches, for which there is no stacking (as I
> meant the term: enforcement of stack order for registration and
> enablement).

See above. I don't completely agree with the obsoleteness part. I don't 
see it that way. But it is moot. I'm not against the enforcement removal.

Regards,
Miroslav
