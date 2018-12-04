Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29DFC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1D9E2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 15:32:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D9E2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbeLDPcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 10:32:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:34858 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbeLDPcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 10:32:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4CF0AF84;
        Tue,  4 Dec 2018 15:32:03 +0000 (UTC)
Date:   Tue, 4 Dec 2018 16:32:03 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 05/11] livepatch: Simplify API by removing registration
 step
In-Reply-To: <20181204144755.4hjextvlw6fqr4ee@pathway.suse.cz>
Message-ID: <alpine.LSU.2.21.1812041628330.2327@pobox.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com> <20181129094431.7801-6-pmladek@suse.com> <alpine.LSU.2.21.1812031643120.22317@pobox.suse.cz> <20181204144755.4hjextvlw6fqr4ee@pathway.suse.cz>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2018, Petr Mladek wrote:

> On Tue 2018-12-04 13:54:55, Miroslav Benes wrote:
> > > diff --git a/Documentation/livepatch/livepatch.txt b/Documentation/livepatch/livepatch.txt
> > > index 2d7ed09dbd59..d849af312576 100644
> > > --- a/Documentation/livepatch/livepatch.txt
> > > +++ b/Documentation/livepatch/livepatch.txt
> > > @@ -12,12 +12,11 @@ Table of Contents:
> > >  4. Livepatch module
> > >     4.1. New functions
> > >     4.2. Metadata
> > > -   4.3. Livepatch module handling
> > >  5. Livepatch life-cycle
> > > -   5.1. Registration
> > > +   5.1. Loading
> > >     5.2. Enabling
> > >     5.3. Disabling
> > > -   5.4. Unregistration
> > > +   5.4. Removing
> > >  6. Sysfs
> > >  7. Limitations
> > >  
> > > @@ -298,117 +297,91 @@ into three levels:
> > >      see the "Consistency model" section.
> > >  
> > >  
> > > -4.3. Livepatch module handling
> > > -------------------------------
> > > -
> > > -The usual behavior is that the new functions will get used when
> > > -the livepatch module is loaded. For this, the module init() function
> > > -has to register the patch (struct klp_patch) and enable it. See the
> > > -section "Livepatch life-cycle" below for more details about these
> > > -two operations.
> > > -
> > > -Module removal is only safe when there are no users of the underlying
> > > -functions. This is the reason why the force feature permanently disables
> > > -the removal. The forced tasks entered the functions but we cannot say
> > > -that they returned back.  Therefore it cannot be decided when the
> > > -livepatch module can be safely removed. When the system is successfully
> > > -transitioned to a new patch state (patched/unpatched) without being
> > > -forced it is guaranteed that no task sleeps or runs in the old code.
> > 
> > Is the change necessary? The documentation in v13 looked ok and I am not 
> > sure if it is better now. Only my opinion though and I understand why you 
> > changed it.
> 
> The huge rewrite was triggered by an innocent Josh's comment, see
> https://lkml.kernel.org/r/20181017190657.dv3kwx467brzhdnz@treble
> 
> I made a big effort to rework the text. I wanted to explain the
> difference between the module loading/unloading and the livepatch
> enabling/disabling in a better structured and hopefully easier to
> understand way.
> 
> It is possible that I failed. But let's put it the following way.
> I refuse to do any other big rework of the documentation in this
> patchset. If anyone has a better idea, please provide alternative
> text or a patch.

I let the others to judge if you failed or not, but I guess no one asked 
for the huge rewrite. I'm not asking for another one now. I only noticed a 
few things and I mentioned them.

Regards,
Miroslav
