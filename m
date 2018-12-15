Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAA4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4233A21734
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbeLOIvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:51:00 -0500
Received: from 178.115.242.59.static.drei.at ([178.115.242.59]:53927 "EHLO
        mail.osadl.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbeLOIu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:50:59 -0500
Received: by mail.osadl.at (Postfix, from userid 1001)
        id 016F25C0D8B; Sat, 15 Dec 2018 09:50:52 +0100 (CET)
Date:   Sat, 15 Dec 2018 09:50:52 +0100
From:   Nicholas Mc Guire <der.herr@hofr.at>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: fix non-static warnings
Message-ID: <20181215085052.GA3426@osadl.at>
References: <1544806570-21299-1-git-send-email-hofrat@osadl.org>
 <72b8f2a4-9070-23d3-4e75-66e10b2d94b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72b8f2a4-9070-23d3-4e75-66e10b2d94b5@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 04:34:23PM -0500, Joe Lawrence wrote:
> On 12/14/2018 11:56 AM, Nicholas Mc Guire wrote:
> > Sparse reported warnings about non-static symbols. For the variables a
> > simple static attribute is fine - for those symbols referenced by
> > livepatch via klp_func the symbol-names must be unmodified in the
> > relocation table - to resolve this the __noclone attribute (as 
>   ^^^^^^^^^^
> nit: symbol table

that should have been  relocation section  as described in
Documentation/livepatch/module-elf-format.txt - atleast that is how
I currently undderstand the livepatch mechanism and its seperate
relocation section.

> 
> > suggested by Joe Lawrence <joe.lawrence@redhat.com>) is used
> > for the statically declared functions.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Link: https://lkml.org/lkml/2018/12/13/827
> > ---
> > 
> > sparse reported the following warnings:
> > 
> >   CHECK   samples/livepatch/livepatch-shadow-fix1.c
> > samples/livepatch/livepatch-shadow-fix1.c:74:14: warning: symbol
> >  'livepatch_fix1_dummy alloc' was not declared. Should it be static?
> > samples/livepatch/livepatch-shadow-fix1.c:116:6: warning: symbol
> >  'livepatch_fix1_dummy free' was not declared. Should it be static?
> > 
> >   CHECK   samples/livepatch/livepatch-shadow-mod.c
> > samples/livepatch/livepatch-shadow-mod.c:99:1: warning: symbol
> >  'dummy_list' was not declared. Should it be static?
> > samples/livepatch/livepatch-shadow-mod.c:100:1: warning: symbol
> >  'dummy_list_mutex' was not declared. Should it be static?
> > samples/livepatch/livepatch-shadow-mod.c:107:23: warning: symbol
> >  'dummy_alloc' was not declared. Should it be static?
> > samples/livepatch/livepatch-shadow-mod.c:132:15: warning: symbol
> >  'dummy_free' was not declared. Should it be static?
> > samples/livepatch/livepatch-shadow-mod.c:140:15: warning: symbol
> >  'dummy_check' was not declared. Should it be static?
> > 
> > Patch was compile tested with: x86_64_defconfig + FTRACE=y
> > FUNCTION_TRACER=y, EXPERT=y, LATENCYTOP=y, SAMPLES=y,
> > SAMPLE_LIVEPATCH=y
> > 
> > Patch was runtested on an Intel i3 with:
> >    insmod samples/livepatch/livepatch-shadow-mod.ko
> >    insmod samples/livepatch/livepatch-shadow-fix1.ko
> >    insmod samples/livepatch/livepatch-shadow-fix2.ko
> >    echo 0 > /sys/kernel/livepatch/livepatch_shadow_fix2/enabled
> >    echo 0 > /sys/kernel/livepatch/livepatch_shadow_fix1/enabled
> >    rmmod livepatch-shadow-fix2
> >    rmmod livepatch-shadow-fix1
> >    rmmod livepatch-shadow-mod
> > and dmesg output checked.
> > 
> > Patch is against 4.20-rc6 (localversion-next is next-20181214)
> 
> Great testing notes, thanks for including these!
> 
> >  samples/livepatch/livepatch-shadow-fix1.c |  4 ++--
> >  samples/livepatch/livepatch-shadow-mod.c  | 16 +++++++++++-----
> >  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> Almost.  We should only need to annotate with __noclone for those
> function definitions which the samples will be patching.  As the commit
> message says, these correlate to klp_func.old_name functions found in
> klp_object.name objects (.ko modules or NULL for vmlinux).
> 
> For the functions defined in samples/livepatch/*.c those would be:
> 
>   livepatch-callbacks-busymod.c :: busymod_work_func()
>   livepatch-shadow-mod.c :: dummy_alloc()
>   livepatch-shadow-mod.c :: dummy_free()
>   livepatch-shadow-mod.c :: dummy_check()
> 
> So even though livepatch-shadow-fix2 further refines
> livepatch-shadow-fix1, the livepatch core is going to redirect the
> original dummy_*() calls defined by livepatch-shadow-mod.c in both fix1
> and fix2 cases.  Ie, the fixes modules aren't patched, only the original.
>

thanks for your patience - so I did not yet understand how this really
works together - will give it a rerun and repost a hopefully proper
solution. 

thx!
hofrat
 
> > 
> > diff --git a/samples/livepatch/livepatch-shadow-fix1.c b/samples/livepatch/livepatch-shadow-fix1.c
> > index 49b1355..eaab10f 100644
> > --- a/samples/livepatch/livepatch-shadow-fix1.c
> > +++ b/samples/livepatch/livepatch-shadow-fix1.c
> > @@ -71,7 +71,7 @@ static int shadow_leak_ctor(void *obj, void *shadow_data, void *ctor_data)
> >  	return 0;
> >  }
> >  
> > -struct dummy *livepatch_fix1_dummy_alloc(void)
> > +static __noclone struct dummy *livepatch_fix1_dummy_alloc(void)
> >  {
> >  	struct dummy *d;
> >  	void *leak;
> > @@ -108,7 +108,7 @@ static void livepatch_fix1_dummy_leak_dtor(void *obj, void *shadow_data)
> >  			 __func__, d, *shadow_leak);
> >  }
> >  
> > -void livepatch_fix1_dummy_free(struct dummy *d)
> > +static __noclone void livepatch_fix1_dummy_free(struct dummy *d)
> >  {
> >  	void **shadow_leak;
> >  
> > diff --git a/samples/livepatch/livepatch-shadow-mod.c b/samples/livepatch/livepatch-shadow-mod.c
> > index 4c54b25..0a72bc2 100644
> > --- a/samples/livepatch/livepatch-shadow-mod.c
> > +++ b/samples/livepatch/livepatch-shadow-mod.c
> > @@ -30,6 +30,11 @@
> >   * memory leak, please load these modules at your own risk -- some
> >   * amount of memory may leaked before the bug is patched.
> >   *
> > + * NOTE - the __noclone attribute to those functions that are to be
> > + * shared with other modules while being declared static. As livepatch
> > + * needs the unmodified symbol names and the usual "static" would
> > + * invoke gccs cloning mechanism that renames the functions this
> > + * needs to be suppressed with the additional __noclone attribute.
> 
> I like the idea of providing the sample code reader this information,
> but since the compiler might also optimize livepatch-callbacks-busymod.c
> :: busymod_work_func(), it too should be annotated __noclone.  Would
> that file deserve a similar comment?
> 
> I don't have a strong opinion, but would throw my vote at leaving this
> in the commit message only.
> 
> 
> BTW, Petr/Miroslav/Josh, should we be annotating the selftests in
> similar fashion?
> 
> > [ ... snip ... ]
> 
> Thanks for working on this,
> 
> -- Joe
