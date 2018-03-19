Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965131AbeCSVnk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:43:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965048AbeCSVn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 17:43:28 -0400
Date: Mon, 19 Mar 2018 16:43:24 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Petr Mladek <pmladek@suse.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180319214324.riyp233trtfxbeto@treble>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-6-pmladek@suse.com>
 <20180313224613.sdkdkcvhpqv54s6c@treble>
 <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 04:02:07PM +0100, Petr Mladek wrote:
> > Can someone remind me why we're permanently disabling replaced patches?
> > I seem to remember being involved in that decision, but at least with
> > this latest version of the patches, it seems like it would be simpler to
> > just let 'replace' patches be rolled back to the previous state when
> > they're unpatched.  Then we don't need two lists of patches, the nops
> > can become more permanent, the replaced patches remain "enabled" but
> > inert, and the unpatching behavior is less surprising to the user, more
> > like a normal rollback.
> 
> Yes, keeping the patches might make some things easier. But it might
> also bring some problems and it would make the feature less useful.
> The following arguments come to my mind:
> 
> 1. The feature should help to keep the system in a consistent and
>    well defined state. It should not depend on what patches were
>    installed before.

But the nops already accomplish that.  If they didn't, then this patch
set has a major problem.

>    We do not want to force people to install every single livepatch
>    before. It should be enough to install the last one.

Of course...

>    But then we might get different amount of NOPs depending on what
>    was installed before.

The same is true of this patch set as it is today.  The number of NOPs
used in the patching process will differ based on what patches were
previously applied.  This is unavoidable.  My proposal is to let the
NOPs hang around after the patching process.  Either way we must rely on
them *during* the patching process as well.

> 2. The feature should allow to unpatch some functions while keeping
>    the others patched.
> 
>    The ftrace handler might cause some unwanted slowdown or other
>    problems. The performance might get restored only when we remove
>    the NOPs when they are not longer necessary.

I'd say simplicity and maintainability of the code is more important
than an (imagined) performance issue.  The NOPs should be pretty fast
anyway.

Not to mention that my proposal would make the behavior less surprising
and more user friendly (reverting a 'replace' patch restores it to its
previous state).

> 3. The handling of callbacks is already problematic. We run only
>    the ones from the last patch to make things easier.
> 
>    We would need to come with something more complicated if we
>    want to support rollback to "random" patches on the stack.
>    And support for random patches is fundamental at least
>    from my point of view.

Can you elaborate on what you mean by random patches and why it would
require something more complicated from the callbacks?

> > Along those lines, I'd also propose that we constrain our existing patch
> > stacking even further.  Right now we allow a new patch to be registered
> > on top of a disabled patch, though we don't allow the new patch to be
> > enabled until the previous patch gets enabled.  I'd propose we no longer
> > allow that condition.  We should instead enforce that all existing
> > patches are *enabled* before allowing a new patch to be registered on
> > top.  That way the patch stacking is even more sane, and there are less
> > "unusual" conditions to worry about.  We have enough of those already.
> > Each additional bit of flexibility has a maintenance cost, and this one
> > isn't worth it IMO.
> 
> Again, this might make some things easier but it might also bring
> problems.
> 
> For example, we would need to solve the situation when the last
> patch is disabled and cannot be removed because the transition
> was forced. This might be more common after removing the immediate
> feature.

I would stop worrying about forced patches so much :-)

Forced patches already come with a disclaimer, and we can't bend over
backwards for them.  In such a rare case, the admin can just re-enable
the forced patch before loading the 'replace' patch.

> Also it might be less user friendly.

I don't know, does anybody really care about this case (patching on top
of a disabled patch)?  It just adds to the crazy matrix of possible
scenarios we have to keep in our heads, which means more bugs, for very
little (hypothetical) gain.

> White the atomic replace could make things easier for both developers
> and users.

I agree that atomic replace is a useful feature and I'm not arguing
against it, so maybe I missed your point?

> > The downside of the above proposals is that now you can't remove an old
> > patch after it's been replaced, but IMO that's a small price to pay for
> > code sanity.  Every additional bit of flexibility has a maintenance
> > cost, and this one isn't worth it IMO.  Just force the user to leave the
> > old inert patches loaded.  They shouldn't take up much memory anyway,
> > and they might come in handy should a revert be needed.
> 
> I actually think about exactly the opposite way. IMHO, the atomic replace
> and cumulative patches allow to handle livepatches more securely.
> Also most situations might be solved by just going forward. If we support
> only replace mode, we could get rid of the stack, disable feature,
> and possibly make the code more straightforward.
> 
> To make it clear. I do not have any plans to work on this. It is
> just an idea.

I'm all for simplifying, and I would be strongly tempted to ACK such a
proposal in a heartbeat, though I'm not sure whether it would support
everybody else's use cases.

(But, with today's code, we *do* support the disabling of patches.  So
given that constraint, my proposal results in simpler code.)

-- 
Josh
