Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753296AbeDJNVu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 09:21:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:48904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752857AbeDJNVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 09:21:49 -0400
Date: Tue, 10 Apr 2018 15:21:45 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
To: Petr Mladek <pmladek@suse.com>
cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
In-Reply-To: <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1804101355050.8026@pobox.suse.cz>
References: <20180307082039.10196-6-pmladek@suse.com> <20180313224613.sdkdkcvhpqv54s6c@treble> <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz> <20180319214324.riyp233trtfxbeto@treble> <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz> <20180320201502.2skkk3ld4zk2dxwg@treble>
 <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz> <20180323224410.vuq5cabfprqhd6ej@treble> <20180326101107.bbloeh5l276on7uz@pathway.suse.cz> <20180406195049.dtfebzfdkbvv6yex@treble> <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > > I think you're missing my point.  This isn't about your patch set, per
> > > > se.  It's really about our existing code.  Today, our patch stack
> > > > doesn't follow real stack semantics, because patches in the middle might
> > > > be disabled.  I see that as a problem.
> > 
> > No, please read it again.  I wasn't talking about replaced patches.
> 
> I was confused by wording "in the middle". It suggested that there
> might had been enabled patches on the top and the bottom of the stack
> and some disabled patches in between at the same time (or vice versa).
> This was not true.
> 
> Do I understand it correctly that you do not like that the patches
> on the stack might be in two states (disabled/enabled). This might
> be translated that you do not like the state when the patch is
> registered and disabled.
> 
> I wonder if the problem is in the "stack" abstraction. Would it help
> if we call it "sorted list" or whatever more suitable?
> 
> Another possibility would be to get rid of the enable/disable states.
> I mean that the patch will be automatically enabled during
> registration and removed during unregistration. Or we could rename
> the operation do add/remove or anything else. In fact, this is how
> it worked in kGraft.

I've already wondered couple of times why we had separate enable/disable. 
If there is someone who knows, remind me, please. I wouldn't be against a 
simplification here.

On the other hand, it is kind of nice to keep the registration and 
enablement separate. It is more flexible if someone needs it.

Anyway, we should solve it together with the stacking. It is tightly 
connected.
 
> AFAIK, the enable/disabled state made more sense for immediate
> patches that could not be unloaded. We still need to keep the patches
> when the transaction is forced. The question is if we need to keep
> the sysfs entries for loaded but unused patches.
> 
> 
> > > > If 'replace' were the only mode, then we wouldn't even need a patch
> > > > stack because it wouldn't really matter much whether the previous patch
> > > > is enabled or disabled.  I think this is in agreement with the point
> > > > you're making.
> > > > 
> > > > But we still support non-replace patches.  My feeling is that we should
> > > > either do a true stack, or no stack at all.  The in-between thing is
> > > > going to be confusing, not only for us, but for patch authors and end
> > > > users.
> > > 
> > > I see it like two different modes. We either have a stack of patches
> > > that depend on each other.
> > 
> > But if they depend on each other, they can use 'replace' and a stack
> > isn't needed.
> 
> Yes but see below.
> 
> 
> > And If they *don't* depend on each other, then the stack is overly
> > restrictive, for no good reason.
> > 
> > Either way, why do we still need a stack?
> 
> Good question. I suggest to agree on some terms first:
> 
>    + Independent patches make unrelated changes. Any new function
>      must not rely on changes done by any other patch.
> 
>    + Dependent patches mean that a later patch depend on changes
>      done by an earlier patch. For example, a new function might
>      use function added by an earlier patch.
> 
>    + Each cumulative patch include all necessary changes. I would say
>      that it is self-containing and independent. Except that they should
>      be able to continue using changes made by earlier patches (shadow
>      variables, callbacks).
> 
> 
> Then we could say:
> 
>    + The stack helps to enforce dependencies between dependent
>      patches. But there is needed also some external solution
>      that forces loading the patches in the right order.
> 
>    + The "replace" feature is useful for cumulative patches.
>      It allows to remove existing changes and remove unused stuff.
>      But cumulative patches might be done even _without_ the atomic
>      replace.
> 
>    + Cumulative patches _with_ "replace" flag might be in theory
>      installed in random order because they handle not-longer patched
>      functions. Well, some incompatibility might be caused by shadow
>      variables and callbacks. Therefore it still might make sense
>      to install them in the right order.
> 
>      Cumulative patches _without_ "replace" flag must be installed
>      in the right order because they do not handle not-longer patched
>      functions.
> 
>      Anyway, for cumulative patches is important the external
>      ordering (loading modules) and not the stack.
> 
> 
> Back to your question:
> 
> The stack is needed for dependent non-cumulative patches.
> 
> The cumulative patches with "replace" flag seems the be
> the most safe and most flexible solution. The question is
> if we want to force all users to use this mode.
> 
> 
> > > Or we have replace patches that are
> > > standalone and we allow a smooth transfer from one to another one.
> > > 
> > > Anyway, for us, it is much more important the removal of replaced
> > > patches. We could probably live without the possibility to replace
> > > disabled patches.
> > 
> > I think replacing disabled patches is ok, *if* we get rid of the
> > illusion of a stack.  The current stack isn't really a stack, it's just
> > awkward.
> 
> I personally do not have problems with it. As I said, I see this as
> two different modes how the life patches are distributed. The stack
> is needed for dependent patches. The cumulative patches with
> "replace" flag are self-contained and independent. They might
> replace anything.

I agree here. Practically we use only cumulative replacement patches at 
SUSE. So with that in mind I don't care about the stacking much. But, it 
may make sense for someone else. Evgenii mentioned they used it for 
hotfixes. Therefore I'm reluctant to remove it completely.
 
> Well, it would make sense to reduce the amount of possible
> situations and use cases. The question is what is acceptable
> to others and if it needs to be done as part of this patch set.

Yes. Input from actual users would be tremendously useful here.

Miroslav
