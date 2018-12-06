Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6042C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A816C214DA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 10:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A816C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeLFKO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 05:14:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:36778 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727832AbeLFKOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 05:14:25 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C35D6AD22;
        Thu,  6 Dec 2018 10:14:23 +0000 (UTC)
Date:   Thu, 6 Dec 2018 11:14:23 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 05/11] livepatch: Simplify API by removing
 registration step
Message-ID: <20181206101423.3nps4tgyg45jwofj@pathway.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-6-pmladek@suse.com>
 <20181205193253.mhlqj37r4o6ukkhp@redhat.com>
 <20181206082814.uyzjw2q4avknhswd@pathway.suse.cz>
 <alpine.LSU.2.21.1812061019500.17628@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1812061019500.17628@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2018-12-06 10:23:40, Miroslav Benes wrote:
> On Thu, 6 Dec 2018, Petr Mladek wrote:
> 
> > On Wed 2018-12-05 14:32:53, Joe Lawrence wrote:
> > > > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > > > index 972520144713..e01dfa3b58d2 100644
> > > > --- a/kernel/livepatch/core.c
> > > > +++ b/kernel/livepatch/core.c
> > > > @@ -45,7 +45,7 @@
> > > >   */
> > > >  DEFINE_MUTEX(klp_mutex);
> > > >  
> > > > -/* Registered patches */
> > > > +/* Actively used patches. */
> > > >  LIST_HEAD(klp_patches);
> > > 
> > > By itself, this comment makes me wonder if there are un-active and/or
> > > un-used patches that I need to worry about.  After this patchset,
> > > klp_patches will include patches that have been enabled and those that
> > > have been replaced, but the replacement transition is still in progress.  
> > > 
> > > If that sounds accurate, how about adding to the comment:
> > > 
> > > /* Actively used patches: enabled or replaced and awaiting transition */
> > 
> > The replaced patches are not in the list. This is why I used the word
> > "actively".
> 
> The replaced patches are removed in klp_discard_replaced_patches(), which 
> is called from klp_complete_transition(). Joe is right. The patches are in 
> the list if a transition is still in progress.

These are patches that are being replaced. The replaced (after the
 transition finishes) are not in the list.

By other word, Joe's text could be understand that replaced patches
will never get removed from the list.

So, is the text below acceptable?

/*
 * Actively used patches: enabled or in transition. Note that replaced
 * or disabled patches are not listed even though the related kernel
 * module still can be loaded.
 */

Or anyone has a better one?

Best Regards,
Petr
