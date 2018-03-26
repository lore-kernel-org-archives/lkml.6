Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbeCZKLL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 06:11:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:54113 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751010AbeCZKLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 06:11:09 -0400
Date: Mon, 26 Mar 2018 12:11:07 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180326101107.bbloeh5l276on7uz@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-6-pmladek@suse.com>
 <20180313224613.sdkdkcvhpqv54s6c@treble>
 <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz>
 <20180319214324.riyp233trtfxbeto@treble>
 <20180320122538.t75rplwhmhtap5q2@pathway.suse.cz>
 <20180320201502.2skkk3ld4zk2dxwg@treble>
 <20180323094507.smsqc5ft3yajnwqt@pathway.suse.cz>
 <20180323224410.vuq5cabfprqhd6ej@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323224410.vuq5cabfprqhd6ej@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-03-23 17:44:10, Josh Poimboeuf wrote:
> On Fri, Mar 23, 2018 at 10:45:07AM +0100, Petr Mladek wrote:
> > On Tue 2018-03-20 15:15:02, Josh Poimboeuf wrote:
> > > On Tue, Mar 20, 2018 at 01:25:38PM +0100, Petr Mladek wrote:
> > > > On Mon 2018-03-19 16:43:24, Josh Poimboeuf wrote:
> > > > > On Mon, Mar 19, 2018 at 04:02:07PM +0100, Petr Mladek wrote:
> > > > > > > Along those lines, I'd also propose that we constrain our existing patch
> > > > > > > stacking even further.  Right now we allow a new patch to be registered
> > > > > > > on top of a disabled patch, though we don't allow the new patch to be
> > > > > > > enabled until the previous patch gets enabled.  I'd propose we no longer
> > > > > > > allow that condition.  We should instead enforce that all existing
> > > > > > > patches are *enabled* before allowing a new patch to be registered on
> > > > > > > top.  That way the patch stacking is even more sane, and there are less
> > > > > > > "unusual" conditions to worry about.  We have enough of those already.
> > > > > > > Each additional bit of flexibility has a maintenance cost, and this one
> > > > > > > isn't worth it IMO.
> > > > > > 
> > > > > > Again, this might make some things easier but it might also bring
> > > > > > problems.
> > > > > > 
> > > > > > For example, we would need to solve the situation when the last
> > > > > > patch is disabled and cannot be removed because the transition
> > > > > > was forced. This might be more common after removing the immediate
> > > > > > feature.
> > > > > 
> > > > > I would stop worrying about forced patches so much :-)
> > > > 
> > > > I have already seen blocked transition several times. It is true that
> > > > it was with kGraft. But we just do not have enough real life experience
> > > > with the upstream livepatch code.
> > > 
> > > But we're talking about patching on top of a *disabled* patch.  Forced
> > > or not, why would the patch be disabled in the first place?
> > 
> > For example, it might be disabled because the transition stalled for
> > too long and the user reverted it. Or just because it is possible
> > to disable it.
> 
> If they haven't previously forced any patches, and they reverted the
> topmost patch because it stalled, they can easily unload the patch.
> 
> If they *have* previously forced a patch, they can force enable the
> topmost patch as well, or if that's not safe they can reboot (that's
> what you get for forcing a patch...)

IMHO, the reboot is the very last option for people that are using
livepatching.


> > > We were just recently discussing the possibility of not allowing the
> > > disabling of patches at all.  If we're not going that far, let's at
> > > least further restrict it, for the sanity of our code, so we don't have
> > > to worry about a nasty mismatched stack of enabled/disabled/enabled/etc,
> > > at least for the cases where 'replace' patches aren't used.
> > 
> > I am not completely sure where all these fears come from. From my
> > point of view, this change is pretty safe and trivial thanks to NOPs
> > and overall design. It would be a shame to do not have it. But I
> > might be blind after spending so much time with the feature.
> 
> I think you're missing my point.  This isn't about your patch set, per
> se.  It's really about our existing code.  Today, our patch stack
> doesn't follow real stack semantics, because patches in the middle might
> be disabled.  I see that as a problem.

This would be true if we keep the replaced patches on the stack. But
if we remove the replaced patches then there never will be disabled
patches in the middle.

OK, there might be disabled patches in the middle during the
transition. But this is the situation where we basically could
not manipulate the stack.


> If 'replace' were the only mode, then we wouldn't even need a patch
> stack because it wouldn't really matter much whether the previous patch
> is enabled or disabled.  I think this is in agreement with the point
> you're making.
> 
> But we still support non-replace patches.  My feeling is that we should
> either do a true stack, or no stack at all.  The in-between thing is
> going to be confusing, not only for us, but for patch authors and end
> users.

I see it like two different modes. We either have a stack of patches
that depend on each other. Or we have replace patches that are
standalone and we allow a smooth transfer from one to another one.

Anyway, for us, it is much more important the removal of replaced
patches. We could probably live without the possibility to replace
disabled patches.


> > Anyway, I am getting close to send v11. This change is done by a separate
> > and last code-related patch. So, it can be omitted rather easily.
> 
> Thanks a lot for splitting it up.  It looks much easier to review now.
>
> I still would really like to see the selftests merged first (or at the
> same time).

The selftest passes with the patchset. I think that it is more or
less ready to be merged. It is possible that it might need some
improvements in the future but it looks like a good start.


> Unfortunately I'll be out next week, so I won't be able to give it a
> proper review until I get back.  Maybe I will come back in a more
> ACK-conducive mood ;-)

Thanks for review and info.

Best Regards,
Petr
