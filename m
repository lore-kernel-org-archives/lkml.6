Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeCWJpL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:42826 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751964AbeCWJpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:45:09 -0400
Date: Fri, 23 Mar 2018 10:45:07 +0100
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-6-pmladek@suse.com>
 <20180313224613.sdkdkcvhpqv54s6c@treble>
 <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz>
 <20180319214324.riyp233trtfxbeto@treble>
 <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
 <20180320201502.2skkk3ld4zk2dxwg@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320201502.2skkk3ld4zk2dxwg@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-03-20 15:15:02, Josh Poimboeuf wrote:
> On Tue, Mar 20, 2018 at 01:25:38PM +0100, Petr Mladek wrote:
> > On Mon 2018-03-19 16:43:24, Josh Poimboeuf wrote:
> > > On Mon, Mar 19, 2018 at 04:02:07PM +0100, Petr Mladek wrote:
> > > > > Along those lines, I'd also propose that we constrain our existing patch
> > > > > stacking even further.  Right now we allow a new patch to be registered
> > > > > on top of a disabled patch, though we don't allow the new patch to be
> > > > > enabled until the previous patch gets enabled.  I'd propose we no longer
> > > > > allow that condition.  We should instead enforce that all existing
> > > > > patches are *enabled* before allowing a new patch to be registered on
> > > > > top.  That way the patch stacking is even more sane, and there are less
> > > > > "unusual" conditions to worry about.  We have enough of those already.
> > > > > Each additional bit of flexibility has a maintenance cost, and this one
> > > > > isn't worth it IMO.
> > > > 
> > > > Again, this might make some things easier but it might also bring
> > > > problems.
> > > > 
> > > > For example, we would need to solve the situation when the last
> > > > patch is disabled and cannot be removed because the transition
> > > > was forced. This might be more common after removing the immediate
> > > > feature.
> > > 
> > > I would stop worrying about forced patches so much :-)
> > 
> > I have already seen blocked transition several times. It is true that
> > it was with kGraft. But we just do not have enough real life experience
> > with the upstream livepatch code.
> 
> But we're talking about patching on top of a *disabled* patch.  Forced
> or not, why would the patch be disabled in the first place?

For example, it might be disabled because the transition stalled for
too long and the user reverted it. Or just because it is possible
to disable it.


> We were just recently discussing the possibility of not allowing the
> disabling of patches at all.  If we're not going that far, let's at
> least further restrict it, for the sanity of our code, so we don't have
> to worry about a nasty mismatched stack of enabled/disabled/enabled/etc,
> at least for the cases where 'replace' patches aren't used.

I am not completely sure where all these fears come from. From my
point of view, this change is pretty safe and trivial thanks to NOPs
and overall design. It would be a shame to do not have it. But I
might be blind after spending so much time with the feature.

BTW: It seems that I am more paranoid when being in the reviewer role.

Anyway, I am getting close to send v11. This change is done by a separate
and last code-related patch. So, it can be omitted rather easily.


> After these discussions I realize that there are several motivations for
> this patch set:
> 
> 1) Atomically reverting some functions in a previous patch while
>    upgrading other functions: accomplished by inserting nops for
>    reverted functions.  Could also be accomplished by tooling which
>    patches functions with duplicates of the originals.
> 
> 2) Improving performance implications of #1: accomplished by removing
>    the nops and old patch modules.
> 
> 3) Decreasing user confusion about stacking order and what patches are
>    currently in effect: accomplished by permanently disabling and
>    removing the replaced patches.  Could also be accomplished by a
>    better sysfs interface and tooling.
> 
> 4) Improving debugging?  How?  (It seems to me that removing the
>    replaced patches could make debugging more difficult, as it erases
>    the patching history (similar to a git rebase))

This explains why you might be against replacing disabled patches. It could
confuse the history.

On the other hand, it might also hide bugs and create mysterious ones.
If we remove code that should not longer be used, the system should
crash immediately if the removed code/data is accessed by mistake.
IMHO, this should help to catch bugs early and in more clear situation.

The history can be seen in the logs or in users reports. I know
that both sources are not 100% reliable but...

IMHO, it is case by case. I could imagine situations where the clean
up might help and situations where it might cause loosing information.
It is hard to judge. I still vote for the clean up ;-)


> It would be good to document all those.
> 
> Anyway, I need to think about it some more, but I may be warming up to
> the idea of permanently disabling the replaced patches.  Your package
> management analogy helped me to understand it better.  Especially since
> we'll be delivering these patches in packages, so the patch state would
> mirror the patch state.  It might be good to describe that analogy in
> the documentation as well.

I have updated the documentation a bit. I did not have the energy
to completely rewrite it though. Anyway, we still have to agree
on the code first.

Best Regards,
Petr
