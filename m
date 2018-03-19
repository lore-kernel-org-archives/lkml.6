Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755550AbeCSPCN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:02:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:38834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754923AbeCSPCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:02:10 -0400
Date: Mon, 19 Mar 2018 16:02:07 +0100
From: Petr Mladek <pmladek@suse.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 05/10] livepatch: Support separate list for replaced
 patches.
Message-ID: <20180319150207.iz5ecbsogg5lpwac@pathway.suse.cz>
References: <20180307082039.10196-1-pmladek@suse.com>
 <20180307082039.10196-6-pmladek@suse.com>
 <20180313224613.sdkdkcvhpqv54s6c@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180313224613.sdkdkcvhpqv54s6c@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-03-13 17:46:13, Josh Poimboeuf wrote:
> On Wed, Mar 07, 2018 at 09:20:34AM +0100, Petr Mladek wrote:
> > From: Jason Baron <jbaron@akamai.com>
> > 
> > We are going to add a feature called atomic replace. It will allow to
> > create a patch that would replace all already registered patches.
> > 
> > The replaced patches will stay registered because they are typically
> > unregistered by some package uninstall scripts. But we will remove
> > these patches from @klp_patches list to keep the enabled patch
> > on the bottom of the stack. Otherwise, we would need to implement
> > rather complex logic for moving the patches on the stack. Also
> > it would complicate implementation of the atomic replace feature.
> > It is not worth it.
> > 
> > As a result, we will have patches that are registered but that
> > are no longer usable. Let's get prepared for this and use
> > a better descriptive name for klp_is_patch_registered() function.
> > 
> > Also create separate list for the replaced patches and allow to
> > unregister them. Alternative solution would be to add a flag
> > into struct klp_patch. Note that patch->kobj.state_initialized
> > is not safe because it can be cleared outside klp_mutex.
> > ---
> >  kernel/livepatch/core.c | 30 ++++++++++++++++++++++++------
> >  1 file changed, 24 insertions(+), 6 deletions(-)
> > 
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index ab1f6a371fc8..fd0296859ff4 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -47,6 +47,13 @@ DEFINE_MUTEX(klp_mutex);
> >  
> >  static LIST_HEAD(klp_patches);
> >  
> > +/*
> > + * List of 'replaced' patches that have been replaced by a patch that has the
> > + * 'replace' bit set. When they are added to this list, they are disabled and
> > + * can not be re-enabled, but they can be unregistered().
> > + */
> > +static LIST_HEAD(klp_replaced_patches);
> 
> Can someone remind me why we're permanently disabling replaced patches?
> I seem to remember being involved in that decision, but at least with
> this latest version of the patches, it seems like it would be simpler to
> just let 'replace' patches be rolled back to the previous state when
> they're unpatched.  Then we don't need two lists of patches, the nops
> can become more permanent, the replaced patches remain "enabled" but
> inert, and the unpatching behavior is less surprising to the user, more
> like a normal rollback.

Yes, keeping the patches might make some things easier. But it might
also bring some problems and it would make the feature less useful.
The following arguments come to my mind:

1. The feature should help to keep the system in a consistent and
   well defined state. It should not depend on what patches were
   installed before.

   We do not want to force people to install every single livepatch
   before. It should be enough to install the last one. But then
   we might get different amount of NOPs depending on what was
   installed before.


2. The feature should allow to unpatch some functions while keeping
   the others patched.

   The ftrace handler might cause some unwanted slowdown or other
   problems. The performance might get restored only when we remove
   the NOPs when they are not longer necessary.


3. The handling of callbacks is already problematic. We run only
   the ones from the last patch to make things easier.

   We would need to come with something more complicated if we
   want to support rollback to "random" patches on the stack.
   And support for random patches is fundamental at least
   from my point of view.


> Along those lines, I'd also propose that we constrain our existing patch
> stacking even further.  Right now we allow a new patch to be registered
> on top of a disabled patch, though we don't allow the new patch to be
> enabled until the previous patch gets enabled.  I'd propose we no longer
> allow that condition.  We should instead enforce that all existing
> patches are *enabled* before allowing a new patch to be registered on
> top.  That way the patch stacking is even more sane, and there are less
> "unusual" conditions to worry about.  We have enough of those already.
> Each additional bit of flexibility has a maintenance cost, and this one
> isn't worth it IMO.

Again, this might make some things easier but it might also bring
problems.

For example, we would need to solve the situation when the last
patch is disabled and cannot be removed because the transition
was forced. This might be more common after removing the immediate
feature.

Also it might be less user friendly. White the atomic replace could
make things easier for both developers and users.


> The downside of the above proposals is that now you can't remove an old
> patch after it's been replaced, but IMO that's a small price to pay for
> code sanity.  Every additional bit of flexibility has a maintenance
> cost, and this one isn't worth it IMO.  Just force the user to leave the
> old inert patches loaded.  They shouldn't take up much memory anyway,
> and they might come in handy should a revert be needed.

I actually think about exactly the opposite way. IMHO, the atomic replace
and cumulative patches allow to handle livepatches more securely.
Also most situations might be solved by just going forward. If we support
only replace mode, we could get rid of the stack, disable feature,
and possibly make the code more straightforward.

To make it clear. I do not have any plans to work on this. It is
just an idea.


> > +
> >  static struct kobject *klp_root_kobj;
> >  
> >  static void klp_init_func_list(struct klp_object *obj, struct klp_func *func)

[...]

> > @@ -375,7 +393,7 @@ int klp_disable_patch(struct klp_patch *patch)
> >  
> >  	mutex_lock(&klp_mutex);
> >  
> > -	if (!klp_is_patch_registered(patch)) {
> > +	if (!klp_is_patch_usable(patch)) {
> 
> This is another case where a wrapper function hurts readability.  What
> does "usable" even mean to the reader of this code?  Every time I see
> it, I have to do a double take.  I think getting rid of the wrapper in
> favor of just doing
>
> 	if (!klp_is_patch_in_list(patch, &klp_patches))

IMHO, this is only a matter of taste. In the long term, the name
"is_patch_usable" might be more descriptive than the information that
the patch is on some  list.

Anyway, I reworked this for v11. I removed klp_replaced_patches list.
Instead, I added "bool registered" into struct klp_patch. Also
I renamed klp_is_patch_registered() to klp_is_patch_on_stack().

Then you could check is_patch_on_stack() in the enable/disable
functions. And you could check patch->registered in
klp_unregister_patch(). I believe that it is more clear.


Best Regards,
Petr
