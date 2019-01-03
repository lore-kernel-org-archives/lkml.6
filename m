Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF13DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B9321479
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730703AbfACLrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:47:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:60198 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726345AbfACLrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:47:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4D513ACAE;
        Thu,  3 Jan 2019 11:47:33 +0000 (UTC)
Date:   Thu, 3 Jan 2019 12:47:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 05/11] livepatch: Simplify API by removing
 registration step
Message-ID: <20190103114732.f52qioxi6osl3ett@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-6-pmladek@suse.com>
 <20181205193253.mhlqj37r4o6ukkhp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205193253.mhlqj37r4o6ukkhp@redhat.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2018-12-05 14:32:53, Joe Lawrence wrote:
> On Thu, Nov 29, 2018 at 10:44:25AM +0100, Petr Mladek wrote:
> > The possibility to re-enable a registered patch was useful for immediate
> > patches where the livepatch module had to stay until the system reboot.
> > The improved consistency model allows to achieve the same result by
> > unloading and loading the livepatch module again.
> > 
> > Also we are going to add a feature called atomic replace. It will allow
> > to create a patch that would replace all already registered patches.
> > The aim is to handle dependent patches more securely. It will obsolete
> > the stack of patches that helped to handle the dependencies so far.
> > Then it might be unclear when a cumulative patch re-enabling is safe.
> > 
> > It would be complicated to support the many modes. Instead we could
> > actually make the API and code easier to understand.
> > 
> > This patch removes the two step public API. All the checks and init calls
> > are moved from klp_register_patch() to klp_enabled_patch(). Also the patch
> > is automatically freed, including the sysfs interface when the transition
> > to the disabled state is completed.
> > 
> > diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> > index 2d7ed09dbd59..d849af312576 100644
> > --- a/Documentation/livepatch/livepatch.txt
> > +++ b/Documentation/livepatch/livepatch.txt
> >
> > +5.4. Removing
> > +-------------
> >  
> > -At this stage, all the relevant sys-fs entries are removed and the patch
> > -is removed from the list of known patches.
> > +Module removal is only safe when there are no users of the underlying
>                                                               ^^^^^^^^^^
> Could a reader confuse "underlying functions" for functions in the
> livepatching-core?  Would "modified functions" or adding "(struct
> klp_func) " make this more specific?
> 
> > +functions. This is the reason why the force feature permanently disables
> > +the removal. The forced tasks entered the functions but we cannot say
>                                          ^^^^^^^^^^^^^
> Same ambiguity here.

I am going to simplify the entire paragraph and replace:

"Module removal is only safe when there are no users of the underlying
functions. This is the reason why the force feature permanently disables
the removal. The forced tasks entered the functions but we cannot say
that they returned back.  Therefore it cannot be decided when the
livepatch module can be safely removed. When the system is successfully
transitioned to a new patch state (patched/unpatched) without being
forced it is guaranteed that no task sleeps or runs in the old code."

with

"Module removal is only safe when there are no users of functions provided
by the module. This is the reason why the force feature permanently
disables the removal. Only when the system is successfully transitioned
to a new patch state (patched/unpatched) without being forced it is
guaranteed that no task sleeps or runs in the old code."

Best Regards,
Petr

PS: Note that the text was there even before this patch. I just moved it
from the section 4.3.
