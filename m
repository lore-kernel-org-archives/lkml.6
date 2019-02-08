Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BEFC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07C920844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfBHPfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:35:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:33520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbfBHPfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:35:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A601BABE4;
        Fri,  8 Feb 2019 15:35:18 +0000 (UTC)
Date:   Fri, 8 Feb 2019 16:35:17 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
cc:     Petr Mladek <pmladek@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alice Ferrazzi <alicef@alicef.me>, jeyu@kernel.org,
        jikos@kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH v2] livepatch: core: Return EOPNOTSUPP instead of
 ENOSYS
In-Reply-To: <20190208132238.GA32656@JAVRIS.in.ibm.com>
Message-ID: <alpine.LSU.2.21.1902081632590.24868@pobox.suse.cz>
References: <20190204183324.30775-1-alicef@alicef.me> <20190205155933.r6ey474lq4m5nlmp@treble> <20190206102832.apa7sekkwljo4ejg@pathway.suse.cz> <20190208062005.GA21436@JAVRIS.in.ibm.com> <alpine.LSU.2.21.1902081013100.24868@pobox.suse.cz>
 <20190208132238.GA32656@JAVRIS.in.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2019, Kamalesh Babulal wrote:

> Hi Miroslav,
> 
> On Fri, Feb 08, 2019 at 10:24:21AM +0100, Miroslav Benes wrote:
> > Hi Kamalesh,
> > 
> > On Fri, 8 Feb 2019, Kamalesh Babulal wrote:
> > 
> > > On Wed, Feb 06, 2019 at 11:28:32AM +0100, Petr Mladek wrote:
> > > > On Tue 2019-02-05 09:59:33, Josh Poimboeuf wrote:
> > > > > On Tue, Feb 05, 2019 at 03:33:28AM +0900, Alice Ferrazzi wrote:
> > > > > > From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> > > > > > 
> > > > > > As a result of an unsupported operation is better to use EOPNOTSUPP
> > > > > > as error code.
> > > > > > ENOSYS is only used for 'invalid syscall nr' and nothing else.
> 
> [...]
> 
> > > After removal of the immediate flag by
> > > commit d0807da78e11 ("livepatch: Remove immediate feature"), every
> > > architecture enabling livepatching is required to have implemented
> > > reliable stack trace.  Is it a better idea to make
> > > HAVE_RELIABLE_STACKTRACE a config dependency, which will disable
> > > livepatching support for architectures without reliable stack trace
> > > function during kernel build?
> > 
> > if I am not mistaken, s390x is currently the only one which is supported 
> > (the redirection works) but has no reliable stacktraces (so far, it is my 
> > plan to take a look soon).
> > 
> > Theoretically, it could still work. We have the fake signal and we can 
> > force the remaining tasks (kthreads). It is not something to be used in 
> > production but it could make sense for a limited testing.
> 
> That was my understanding too, s390 doesn't set HAVE_RELIABLE_STACKTRACE.
> 
> (below output is right trimmed for readability)
> 
> arch $ find . -name 'Kconfig'|xargs egrep -an "HAVE_LIVEPATCH"                                                                                                                                                                               
> ./powerpc/Kconfig:209:  select HAVE_LIVEPATCH ...
> ./x86/Kconfig:171:      select HAVE_LIVEPATCH ...
> ./s390/Kconfig:161:     select HAVE_LIVEPATCH
> 
> arch $ find . -name 'Kconfig'|xargs egrep -an "HAVE_RELIABLE_STACKTRACE"                                                                                                                                                                     
> ./powerpc/Kconfig:223:  select HAVE_RELIABLE_STACKTRACE ...
> ./x86/Kconfig:189:      select HAVE_RELIABLE_STACKTRACE ...
> ./Kconfig:690:config HAVE_RELIABLE_STACKTRACE
> 
> klp_have_reliable_stack() will guard against loading of livepatching
> module on s390, for the same reason being that HAVE_RELIABLE_STACKTRACE
> is not set. My explanation is purely based on the above grep output
> on Kconfig files, which might be partial. Am I missing something here?

No, I don't think so.

I think I mentioned the theoretical possibility at the time the check was 
introduced and we came to the conclusion that it is worth it and we should 
enforce the reliable stacktraces.
 
> > > The idea is to remove klp_have_reliable_stack() by moving
> > > CONFIG_HAVE_RELIABLE_STACKTRACE as a config dependency to Kconfig file
> > > and adding the other CONFIG_STACKTRACE as a config dependency is not
> > > required, as it's selected via CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > dependency chain. With the patch on architecture without
> > > HAVE_RELIABLE_STACKTRACE, the user should see:
> 
> [...]
> 
> > > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > > index fe1993399823..9a80f7574d75 100644
> > > --- a/kernel/livepatch/core.c
> > > +++ b/kernel/livepatch/core.c
> > > @@ -1002,12 +1002,6 @@ int klp_enable_patch(struct klp_patch *patch)
> > >         if (!klp_initialized())
> > >                 return -ENODEV;
> > >  
> > > -       if (!klp_have_reliable_stack()) {
> > > -               pr_err("This architecture doesn't have support for the livepatch consistency model.\n");
> > > -               return -ENOSYS;
> > > -       }
> > > -
> > > -
> > >         mutex_lock(&klp_mutex);
> > >  
> > >         ret = klp_init_patch_early(patch);
> > 
> > On the other hand, I like this change. So we have two options, I think. 
> > We can apply this and wait if someone complains (because of s390x 
> > testing), or we can wait for the full support of s390x and then enforce 
> > it.

Scratch this. It is enforced even now.
 
> Thanks, I am ok with either of the options.  We could enforce the config
> dependency, in case the above assumption in regard to s390 is correct.

Yes, I think it is a nice cleanup.

Miroslav
