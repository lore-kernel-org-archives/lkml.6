Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A7BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B4420878
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B4420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbeLDOsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:48:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:55384 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726064AbeLDOsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:48:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 855DAACCF;
        Tue,  4 Dec 2018 14:47:55 +0000 (UTC)
Date:   Tue, 4 Dec 2018 15:47:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 05/11] livepatch: Simplify API by removing
 registration step
Message-ID: <20181204144755.4hjextvlw6fqr4ee@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-6-pmladek@suse.com>
 <alpine.LSU.2.21.1812031643120.22317@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1812031643120.22317@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2018-12-04 13:54:55, Miroslav Benes wrote:
> > diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> > index 2d7ed09dbd59..d849af312576 100644
> > --- a/Documentation/livepatch/livepatch.txt
> > +++ b/Documentation/livepatch/livepatch.txt
> > @@ -12,12 +12,11 @@ Table of Contents:
> >  4. Livepatch module
> >     4.1. New functions
> >     4.2. Metadata
> > -   4.3. Livepatch module handling
> >  5. Livepatch life-cycle
> > -   5.1. Registration
> > +   5.1. Loading
> >     5.2. Enabling
> >     5.3. Disabling
> > -   5.4. Unregistration
> > +   5.4. Removing
> >  6. Sysfs
> >  7. Limitations
> >  
> > @@ -298,117 +297,91 @@ into three levels:
> >      see the "Consistency model" section.
> >  
> >  
> > -4.3. Livepatch module handling
> > -------------------------------
> > -
> > -The usual behavior is that the new functions will get used when
> > -the livepatch module is loaded. For this, the module init() function
> > -has to register the patch (struct klp_patch) and enable it. See the
> > -section "Livepatch life-cycle" below for more details about these
> > -two operations.
> > -
> > -Module removal is only safe when there are no users of the underlying
> > -functions. This is the reason why the force feature permanently disables
> > -the removal. The forced tasks entered the functions but we cannot say
> > -that they returned back.  Therefore it cannot be decided when the
> > -livepatch module can be safely removed. When the system is successfully
> > -transitioned to a new patch state (patched/unpatched) without being
> > -forced it is guaranteed that no task sleeps or runs in the old code.
> 
> Is the change necessary? The documentation in v13 looked ok and I am not 
> sure if it is better now. Only my opinion though and I understand why you 
> changed it.

The huge rewrite was triggered by an innocent Josh's comment, see
https://lkml.kernel.org/r/20181017190657.dv3kwx467brzhdnz@treble

I made a big effort to rework the text. I wanted to explain the
difference between the module loading/unloading and the livepatch
enabling/disabling in a better structured and hopefully easier to
understand way.

It is possible that I failed. But let's put it the following way.
I refuse to do any other big rework of the documentation in this
patchset. If anyone has a better idea, please provide alternative
text or a patch.

Please, do not take it wrong. I really appreciate your review and
feedback. I am just a bit frustrated that my English or documentation
capabilities are not good enough. I am scared that the patchset might
get ready on v135 in 2025. And I will get a visit from
Mudr. Chocholousek [1] in the meantime.

[1] I am sorry for mentioning a person from a famous Czech film.
    I was not able to find any good explanation in English.
    I just found the following scene of the main character
    that was later being chaised by Mudr. Chocholousek:
    https://www.youtube.com/watch?v=NGjBlwHvs0Y


Best Regards,
Petr
