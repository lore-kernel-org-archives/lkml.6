Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752334AbeDJIfA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:35:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:44041 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751914AbeDJIe6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:34:58 -0400
Date: Tue, 10 Apr 2018 10:34:55 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz>
References: <20180307082039.10196-6-pmladek@suse.com>
 <20180313224613.sdkdkcvhpqv54s6c@treble>
 <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz>
 <20180319214324.riyp233trtfxbeto@treble>
 <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
 <20180320201502.2skkk3ld4zk2dxwg@treble>
 <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz>
 <20180323224410.vuq5cabfprqhd6ej@treble>
 <20180326101107.bbloeh5l276on7uz@pathway.suse.cz>
 <20180406195049.dtfebzfdkbvv6yex@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406195049.dtfebzfdkbvv6yex@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-04-06 14:50:49, Josh Poimboeuf wrote:
> On Mon, Mar 26, 2018 at 12:11:07PM +0200, Petr Mladek wrote:
> > On Fri 2018-03-23 17:44:10, Josh Poimboeuf wrote:
> > > On Fri, Mar 23, 2018 at 10:45:07AM +0100, Petr Mladek wrote:
> > > > On Tue 2018-03-20 15:15:02, Josh Poimboeuf wrote:
> > > > > On Tue, Mar 20, 2018 at 01:25:38PM +0100, Petr Mladek wrote:
> > > > > > On Mon 2018-03-19 16:43:24, Josh Poimboeuf wrote:
> > > > > > > On Mon, Mar 19, 2018 at 04:02:07PM +0100, Petr Mladek wrote:
> > > > > > > > > Along those lines, I'd also propose that we constrain our existing patch
> > > > > > > > > stacking even further.  Right now we allow a new patch to be registered
> > > > > > > > > on top of a disabled patch, though we don't allow the new patch to be
> > > > > > > > > enabled until the previous patch gets enabled.  I'd propose we no longer
> > > > > > > > > allow that condition.  We should instead enforce that all existing
> > > > > > > > > patches are *enabled* before allowing a new patch to be registered on
> > > > > > > > > top.  That way the patch stacking is even more sane, and there are less
> > > > > > > > > "unusual" conditions to worry about.  We have enough of those already.
> > > > > > > > > Each additional bit of flexibility has a maintenance cost, and this one
> > > > > > > > > isn't worth it IMO.
> > > > > > > > 
> > > > > > > > Again, this might make some things easier but it might also bring
> > > > > > > > problems.
> > > > > > > > 
> > > > > > > > For example, we would need to solve the situation when the last
> > > > > > > > patch is disabled and cannot be removed because the transition
> > > > > > > > was forced. This might be more common after removing the immediate
> > > > > > > > feature.
> > > > > > > 
> > > > > > > I would stop worrying about forced patches so much :-)
> > > > > > 
> > > > > > I have already seen blocked transition several times. It is true that
> > > > > > it was with kGraft. But we just do not have enough real life experience
> > > > > > with the upstream livepatch code.
> > > > > 
> > > > > But we're talking about patching on top of a *disabled* patch.  Forced
> > > > > or not, why would the patch be disabled in the first place?
> > > > 
> > > > For example, it might be disabled because the transition stalled for
> > > > too long and the user reverted it. Or just because it is possible
> > > > to disable it.
> > > 
> > > If they haven't previously forced any patches, and they reverted the
> > > topmost patch because it stalled, they can easily unload the patch.
> > > 
> > > If they *have* previously forced a patch, they can force enable the
> > > topmost patch as well, or if that's not safe they can reboot (that's
> > > what you get for forcing a patch...)
> > 
> > IMHO, the reboot is the very last option for people that are using
> > livepatching.
> 
> ... but it may be a natural consequence of forcing a patch.
> 
> > > > > We were just recently discussing the possibility of not allowing the
> > > > > disabling of patches at all.  If we're not going that far, let's at
> > > > > least further restrict it, for the sanity of our code, so we don't have
> > > > > to worry about a nasty mismatched stack of enabled/disabled/enabled/etc,
> > > > > at least for the cases where 'replace' patches aren't used.
> > > > 
> > > > I am not completely sure where all these fears come from. From my
> > > > point of view, this change is pretty safe and trivial thanks to NOPs
> > > > and overall design. It would be a shame to do not have it. But I
> > > > might be blind after spending so much time with the feature.
> > > 
> > > I think you're missing my point.  This isn't about your patch set, per
> > > se.  It's really about our existing code.  Today, our patch stack
> > > doesn't follow real stack semantics, because patches in the middle might
> > > be disabled.  I see that as a problem.
> 
> No, please read it again.  I wasn't talking about replaced patches.

I was confused by wording "in the middle". It suggested that there
might had been enabled patches on the top and the bottom of the stack
and some disabled patches in between at the same time (or vice versa).
This was not true.

Do I understand it correctly that you do not like that the patches
on the stack might be in two states (disabled/enabled). This might
be translated that you do not like the state when the patch is
registered and disabled.

I wonder if the problem is in the "stack" abstraction. Would it help
if we call it "sorted list" or whatever more suitable?

Another possibility would be to get rid of the enable/disable states.
I mean that the patch will be automatically enabled during
registration and removed during unregistration. Or we could rename
the operation do add/remove or anything else. In fact, this is how
it worked in kGraft.

AFAIK, the enable/disabled state made more sense for immediate
patches that could not be unloaded. We still need to keep the patches
when the transaction is forced. The question is if we need to keep
the sysfs entries for loaded but unused patches.


> > > If 'replace' were the only mode, then we wouldn't even need a patch
> > > stack because it wouldn't really matter much whether the previous patch
> > > is enabled or disabled.  I think this is in agreement with the point
> > > you're making.
> > > 
> > > But we still support non-replace patches.  My feeling is that we should
> > > either do a true stack, or no stack at all.  The in-between thing is
> > > going to be confusing, not only for us, but for patch authors and end
> > > users.
> > 
> > I see it like two different modes. We either have a stack of patches
> > that depend on each other.
> 
> But if they depend on each other, they can use 'replace' and a stack
> isn't needed.

Yes but see below.


> And If they *don't* depend on each other, then the stack is overly
> restrictive, for no good reason.
> 
> Either way, why do we still need a stack?

Good question. I suggest to agree on some terms first:

   + Independent patches make unrelated changes. Any new function
     must not rely on changes done by any other patch.

   + Dependent patches mean that a later patch depend on changes
     done by an earlier patch. For example, a new function might
     use function added by an earlier patch.

   + Each cumulative patch include all necessary changes. I would say
     that it is self-containing and independent. Except that they should
     be able to continue using changes made by earlier patches (shadow
     variables, callbacks).


Then we could say:

   + The stack helps to enforce dependencies between dependent
     patches. But there is needed also some external solution
     that forces loading the patches in the right order.

   + The "replace" feature is useful for cumulative patches.
     It allows to remove existing changes and remove unused stuff.
     But cumulative patches might be done even _without_ the atomic
     replace.

   + Cumulative patches _with_ "replace" flag might be in theory
     installed in random order because they handle not-longer patched
     functions. Well, some incompatibility might be caused by shadow
     variables and callbacks. Therefore it still might make sense
     to install them in the right order.

     Cumulative patches _without_ "replace" flag must be installed
     in the right order because they do not handle not-longer patched
     functions.

     Anyway, for cumulative patches is important the external
     ordering (loading modules) and not the stack.


Back to your question:

The stack is needed for dependent non-cumulative patches.

The cumulative patches with "replace" flag seems the be
the most safe and most flexible solution. The question is
if we want to force all users to use this mode.


> > Or we have replace patches that are
> > standalone and we allow a smooth transfer from one to another one.
> > 
> > Anyway, for us, it is much more important the removal of replaced
> > patches. We could probably live without the possibility to replace
> > disabled patches.
> 
> I think replacing disabled patches is ok, *if* we get rid of the
> illusion of a stack.  The current stack isn't really a stack, it's just
> awkward.

I personally do not have problems with it. As I said, I see this as
two different modes how the life patches are distributed. The stack
is needed for dependent patches. The cumulative patches with
"replace" flag are self-contained and independent. They might
replace anything.

Well, it would make sense to reduce the amount of possible
situations and use cases. The question is what is acceptable
to others and if it needs to be done as part of this patch set.

Best Regards,
Petr
