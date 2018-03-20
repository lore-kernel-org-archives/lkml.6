Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeCTMZo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 08:25:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:54112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752977AbeCTMZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 08:25:41 -0400
Date: Tue, 20 Mar 2018 13:25:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-6-pmladek@suse.com>
 <20180313224613.sdkdkcvhpqv54s6c@treble>
 <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz>
 <20180319214324.riyp233trtfxbeto@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319214324.riyp233trtfxbeto@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-03-19 16:43:24, Josh Poimboeuf wrote:
> On Mon, Mar 19, 2018 at 04:02:07PM +0100, Petr Mladek wrote:
> > > Can someone remind me why we're permanently disabling replaced patches?
> > > I seem to remember being involved in that decision, but at least with
> > > this latest version of the patches, it seems like it would be simpler to
> > > just let 'replace' patches be rolled back to the previous state when
> > > they're unpatched.  Then we don't need two lists of patches, the nops
> > > can become more permanent, the replaced patches remain "enabled" but
> > > inert, and the unpatching behavior is less surprising to the user, more
> > > like a normal rollback.
> > 
> > Yes, keeping the patches might make some things easier. But it might
> > also bring some problems and it would make the feature less useful.
> > The following arguments come to my mind:
> > 
> > 1. The feature should help to keep the system in a consistent and
> >    well defined state. It should not depend on what patches were
> >    installed before.
> 
> But the nops already accomplish that.  If they didn't, then this patch
> set has a major problem.

The nops are enough to keep the functionality but they might harm
the performance.

Livepatching is about preventing bugs without reboot. I could simply
imagine that ftrace on a hot patch might cause performance
problems on some workloads. And I would like to have a way out in
this case.

Anyway, I am reworking the patchset so that it implements your
approach first. The possibility to remove NOPs and replaced
livepatches is done via a followup patch. This might help
to discuss if the changes are worth it or not.


> > 2. The feature should allow to unpatch some functions while keeping
> >    the others patched.
> > 
> >    The ftrace handler might cause some unwanted slowdown or other
> >    problems. The performance might get restored only when we remove
> >    the NOPs when they are not longer necessary.
> 
> I'd say simplicity and maintainability of the code is more important
> than an (imagined) performance issue.  The NOPs should be pretty fast
> anyway.
> 
> Not to mention that my proposal would make the behavior less surprising
> and more user friendly (reverting a 'replace' patch restores it to its
> previous state).

If the "disable" way works as expected, see below.

Also it is less surprising only if people understand the stack of
patches. If they are familiar only with replace patches then it is
normal for them that the patches get replaced. It is then like
a package version update.


> > 3. The handling of callbacks is already problematic. We run only
> >    the ones from the last patch to make things easier.
> > 
> >    We would need to come with something more complicated if we
> >    want to support rollback to "random" patches on the stack.
> >    And support for random patches is fundamental at least
> >    from my point of view.
> 
> Can you elaborate on what you mean by random patches and why it would
> require something more complicated from the callbacks?

Let's say that we will use atomic replace for cumulative
patches. Then every new patch knows what earlier patches did.
It just did not know which of them was already installed. Therefore
it needs to detect what callbacks were already called. The callbacks
usually create or change something. So there should be something to check.
Therefore the way forward should be rather straightforward.

The way back is more problematic. The callbacks in the new cumulative
patch would need to store information about the previous state and
be able to restore it when the patch gets disabled. It might more
or less double the callbacks code and testing scenarios.


> > > Along those lines, I'd also propose that we constrain our existing patch
> > > stacking even further.  Right now we allow a new patch to be registered
> > > on top of a disabled patch, though we don't allow the new patch to be
> > > enabled until the previous patch gets enabled.  I'd propose we no longer
> > > allow that condition.  We should instead enforce that all existing
> > > patches are *enabled* before allowing a new patch to be registered on
> > > top.  That way the patch stacking is even more sane, and there are less
> > > "unusual" conditions to worry about.  We have enough of those already.
> > > Each additional bit of flexibility has a maintenance cost, and this one
> > > isn't worth it IMO.
> > 
> > Again, this might make some things easier but it might also bring
> > problems.
> > 
> > For example, we would need to solve the situation when the last
> > patch is disabled and cannot be removed because the transition
> > was forced. This might be more common after removing the immediate
> > feature.
> 
> I would stop worrying about forced patches so much :-)

I have already seen blocked transition several times. It is true that
it was with kGraft. But we just do not have enough real life experience
with the upstream livepatch code.


> Forced patches already come with a disclaimer, and we can't bend over
> backwards for them.  In such a rare case, the admin can just re-enable
> the forced patch before loading the 'replace' patch.


> > Also it might be less user friendly.
> 
> I don't know, does anybody really care about this case (patching on top
> of a disabled patch)?  It just adds to the crazy matrix of possible
> scenarios we have to keep in our heads, which means more bugs, for very
> little (hypothetical) gain.

It depends if the we remove the replaced patches or not. If they are
removed then replacing disabled patches is rather trivial from both
coding and understanding side.

I am going to add this as a separate patch as well. Let's discuss
it with the code.


> > White the atomic replace could make things easier for both developers
> > and users.
> 
> I agree that atomic replace is a useful feature and I'm not arguing
> against it, so maybe I missed your point?

Your suggestion allows easier code but it reduces the advantages of
the atomic replace feature. We would achieve almost the same results
with a normal livepatch where the functions behave like in
the original code.

Also removing replaced patches can be seen as a clean up after
each patch. It might be more code but the target system might be
easier to debug. Also we do not need to mind about various
disable scenarios.

Best Regards,
Petr
