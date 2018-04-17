Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeDQPhu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:37:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:34065 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751863AbeDQPhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:37:48 -0400
Date: Tue, 17 Apr 2018 17:37:46 +0200
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180417153746.fkgcruyxvmyrbynt@pathway.suse.cz>
References: <20180326101107.bbloeh5l276on7uz@pathway.suse.cz>
 <20180406195049.dtfebzfdkbvv6yex@treble>
 <20180410083455.l26dgo5kx4cy7bc7@pathway.suse.cz>
 <20180410174206.l3uk6lchhzxvn75x@treble>
 <alpine.LSU.2.21.1804110956430.28885@pobox.suse.cz>
 <20180411123214.mfpkbrirze32phrb@treble>
 <20180411141711.cwceg7o5ttjgebii@pathway.suse.cz>
 <20180411154852.3yjab3ot76qicw6m@treble>
 <20180416145811.x4lvtm5kxyigbp56@pathway.suse.cz>
 <20180416190425.tk7nnbqbmaxeniud@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180416190425.tk7nnbqbmaxeniud@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-04-16 14:04:25, Josh Poimboeuf wrote:
> On Mon, Apr 16, 2018 at 04:58:11PM +0200, Petr Mladek wrote:
> > On Wed 2018-04-11 10:48:52, Josh Poimboeuf wrote:
> > > On Wed, Apr 11, 2018 at 04:17:11PM +0200, Petr Mladek wrote:
> > > > Second, unrelated patches must never patch the same functions.
> > > > Otherwise we would not be able to define which implementation
> > > > should be used. This is especially important when a patch is
> > > > removed and we need to fallback either to another patch or
> > > > original code. Yes, it makes perfect sense. But it needs code
> > > > that will check it, refuse loading the patch, ... It is not
> > > > complicated. But it is rather additional code than
> > > > simplification. I might make livepatching more safe
> > > > but probably not simplify the code.
> > > 
> > > We don't need to enforce that.  The func stack can stay.  If somebody
> > > wants to patch the same function multiple times (without using
> > > 'replace'), that's inadvisable, but it's also their business.  They're
> > > responsible for the tooling to ensure the patch stack order is sane.
> > 
> > 
> > While it might make sense to ignore the patch stack (ordering) for
> > the enable operation. Do we really want to ignore it when disabling
> > a patch.
> > 
> > By other words, do we want to allow disabling a patch that is in
> > the middle of the stack, only partly in use? Does not this allow
> > some other crazy scenarios? Is it really the user business?
> > Will it make our life easier?
> 
> If there's no longer a patch stack, then there's no concept of a middle.
> We would expect the patches to be independent of one another, and so
> disabling any of them independently would be harmless.
>
> If any of the patches share a func, and the user disables one in the
> "middle", it's not our job to support that.  The vendor / patch author
> should prevent such cases from occurring with tooling, packaging,
> documentation, etc.  Or they can just use 'replace'.
> 
> We can already have similar unexpected situations today.  For example,
> what if patch B is a cumulative superset of patch A, but the user
> mistakenly loads patch A (without replace) *after* loading patch B?
> Then some unforeseen craziness could ensue.
> 
> We can't control all such scenarios (and that's ok), but we shouldn't
> pretend that we support them.

I recall some earlier discussion. The aim was to make livepatching
more safe. AFAIK, it was more related to the helper tooling around,
like "automatic" generation of the special relocation entries, ...
Anyway, I feel that the above gets somehow against it.

The patch stack does not solve everything. But it makes it harder
to do wrong things.


> > This will not happen if we refuse to load non-replace patches
> > that touch an already patches fucntion. Then the patch stack
> > might become only implementation detail. It will not define
> > the ordering any longer.
> 
> I think this would only be a partial solution.  Patches can have
> implicit interdependencies, even if they don't patch the same function.
> Also it doesn't solve the problem when patches are loaded in the wrong
> order.  We have to trust vendors and admins to do the right thing.

I would still like to add this check if we remove the stack.
Is it too restrictive? Maybe. But it would help to prevent
creating some ugly mistakes. By other words, we will force
people using proper cumulative patches instead of
dangerous semi-cumulative Frankenstains.

At least, it would reduce the number of scenarios that
we might meet and eventually need to debug.


> > > > > > > > Another possibility would be to get rid of the enable/disable states.
> > > > > > > > I mean that the patch will be automatically enabled during
> > > > > > > > registration and removed during unregistration.
> > 
> > OK. What about the following solution?
> > 
> >    + Enable patch directly from klp_register_patch()
> >    + Unregister the patch directly from klp_complete_transition()
> >      when the patch is disabled.
> >    + Put the module later when all sysfs entries are removed
> >      in klp_unregister_patch().
> > 
> > As a result:
> > 
> >    + module_init() will need to call only klp_register_patch()
> >    + module_exit() will do nothing
> >    + the module can be removed only when it is not longer needed
> 
> Sounds good to me.

It should be consistent with sysfs interface, see below.


> > Some other ideas:
> > 
> >    + rename /sys/kernel/livepatch/<patch>/enable -> unregister
> >      allow to write into /sys/kernel/livepatch/<patch>/transition
> > 
> >      + echo 1 >unregistrer  to disable&unregister the patch
> >      + echo 0 >transition   to revert the running transition
> 
> Why not keep the existing sysfs interfaces?  So
> 
>   echo 0 > enable
> 
> would disable (and eventually unregister) the patch.

First, it would be a bit inconsistent. The patch would be added by calling
"register" function and removed by writing into "enabled" file.

Second, if we remove sysfs entries for disabled patches, it would
make the meaning of "enabled" file a bit useless. I mean that
the patch will always be enabled when the sysfs directory exists
(when ignoring transition states).


BTW: I have just today got a feedback that the user interface is not
ideal. In particular, it is not easy to detect what process is blocking
the transition. It is because the target value in
/proc/<pid>/patch_state depends on the value in
/sys/kernel/livepatch/<patch>/enable (direction of the transition).


Anyway, the first problem might be solved by doing patch registration
at the beginning of klp_enable_patch(). Then it will match the
"enabled" sysfs file.

I would actually feel more comfortable if we do not change the
sysfs interface.

Well, any better idea for a simplified interface is appreciated.


> > The question is what to do with the stack of patches. It will have
> > no meaning for the enable operation because it will be done
> > automatically. But what about the disable/unregistrer operation?
> 
> Assuming we got rid of the patch stack, would we even need to keep a
> global list of patches anymore?

As Mirek said, a list still might be useful in some situations
(nops generation, conflicts check). But it would become an
implementation detail. The ordering would not be important
any longer.


> > Anyway, this looks like a revolution. Do we want to do all these
> > changes, including atomic replace, in a single patchset?
> 
> At least for the bits which affect external tooling interfaces, it would
> be nice to group them all together.

OK, I'll try to cook up something once we settle on the above
questions.

Best Regards,
Petr
