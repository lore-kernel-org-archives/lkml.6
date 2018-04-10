Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeDJRmK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 13:42:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41222 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751770AbeDJRmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 13:42:08 -0400
Date: Tue, 10 Apr 2018 12:42:06 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180410174206.l3uk6lchhzxvn75x@treble>
References: <20180313224613.sdkdkcvhpqv54s6c@treble>
 <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz>
 <20180319214324.riyp233trtfxbeto@treble>
 <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
 <20180320201502.2skkk3ld4zk2dxwg@treble>
 <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz>
 <20180323224410.vuq5cabfprqhd6ej@treble>
 <20180326101107.bbloeh5l276on7uz@pathway.suse.cz>
 <20180406195049.dtfebzfdkbvv6yex@treble>
 <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 10:34:55AM +0200, Petr Mladek wrote:
> > > > > > We were just recently discussing the possibility of not allowing the
> > > > > > disabling of patches at all.  If we're not going that far, let's at
> > > > > > least further restrict it, for the sanity of our code, so we don't have
> > > > > > to worry about a nasty mismatched stack of enabled/disabled/enabled/etc,
> > > > > > at least for the cases where 'replace' patches aren't used.
> > > > > 
> > > > > I am not completely sure where all these fears come from. From my
> > > > > point of view, this change is pretty safe and trivial thanks to NOPs
> > > > > and overall design. It would be a shame to do not have it. But I
> > > > > might be blind after spending so much time with the feature.
> > > > 
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

That *was* what I meant.  Consider the following sequence of events:

- Register patch 1
- Enable patch 1
- Register patch 2
- Enable patch 2
- Disable patch 2
- Register patch 3
- Enable patch 3

Notice that patch 2 (in the middle) is disabled, whereas patch 1 (on the
bottom) and patch 3 (on the top) are enabled.

> Do I understand it correctly that you do not like that the patches
> on the stack might be in two states (disabled/enabled). This might
> be translated that you do not like the state when the patch is
> registered and disabled.

No, that wasn't really what I meant, but I have often wondered whether
we need such a distinction.

> I wonder if the problem is in the "stack" abstraction. Would it help
> if we call it "sorted list" or whatever more suitable?

But I don't even see a reason to have a sorted list (more on that
below).

> Another possibility would be to get rid of the enable/disable states.
> I mean that the patch will be automatically enabled during
> registration and removed during unregistration.

I don't see how disabling during unregistration would be possible, since
the unregister is called from the patch module exit function, which
can only be called *after* the patch is disabled.

However, we could unregister immediately after disabling (i.e., in
enabled_store context).

> Or we could rename the operation do add/remove or anything else. In
> fact, this is how it worked in kGraft.

I'm not sure what renaming would solve, unless you mean to combine
registration and enablement into a single concept?  Sounds good to me.

> AFAIK, the enable/disabled state made more sense for immediate
> patches that could not be unloaded. We still need to keep the patches
> when the transaction is forced. The question is if we need to keep
> the sysfs entries for loaded but unused patches.

I think we wouldn't need the sysfs entries.  Just disable/unregister
forced patches like normal, except skipping the module_put().

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

If they have dependencies between modules, they can either a) enforce it
with tooling, or they can instead b) use 'replace'.

But let's get the module load order enforcement out of the kernel.
There's no real need for the kernel to do it, and we're not even doing a
good job at it.

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
> 
> Well, it would make sense to reduce the amount of possible
> situations and use cases.

A big +1.

> The question is what is acceptable to others

If there are any objections, this is their chance to speak up :-)

> and if it needs to be done as part of this patch set.

Maybe so, for at least a few reasons:

- This patch set makes the 'stack' obsolete, so it makes sense to remove
  the 'stack' with it.

- This patch set will already affect tooling, let's make tooling's life
  easier by making all the related changes at the same time.
  
  (Though I'm not quite convinced on this point, would removing the
  stack affect tooling at all?  If we also combined registration and
  enablement into a single concept, then it definitely would.)

-- 
Josh
