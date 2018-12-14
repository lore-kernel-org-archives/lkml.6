Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF707C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD312086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbeLNVvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:51:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56018 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbeLNVvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:51:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D55421B9C;
        Fri, 14 Dec 2018 21:51:34 +0000 (UTC)
Received: from treble (ovpn-125-218.rdu2.redhat.com [10.10.125.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2D34600C0;
        Fri, 14 Dec 2018 21:51:31 +0000 (UTC)
Date:   Fri, 14 Dec 2018 15:51:29 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Nicholas Mc Guire <hofrat@osadl.org>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] livepatch: fix non-static warnings
Message-ID: <20181214215129.mshuswyuqlcx76wz@treble>
References: <1544806570-21299-1-git-send-email-hofrat@osadl.org>
 <72b8f2a4-9070-23d3-4e75-66e10b2d94b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <72b8f2a4-9070-23d3-4e75-66e10b2d94b5@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Fri, 14 Dec 2018 21:51:34 +0000 (UTC)
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
> 
> > suggested by Joe Lawrence <joe.lawrence@redhat.com>) is used
> > for the statically declared functions.
> > 
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > Link: https://lkml.org/lkml/2018/12/13/827

Needs a:

  Suggested-by: Joe Lawrence <joe.lawrence@redhat.com>


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

Agreed, IMO the comment isn't needed.

> BTW, Petr/Miroslav/Josh, should we be annotating the selftests in
> similar fashion?

Probably so.

-- 
Josh
