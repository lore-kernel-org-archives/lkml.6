Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6E4C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B95520895
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:25:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B95520895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbeJVVnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:43:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:46280 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727587AbeJVVnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:43:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8FD09AFF5;
        Mon, 22 Oct 2018 13:25:10 +0000 (UTC)
Date:   Mon, 22 Oct 2018 15:25:10 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Miroslav Benes <mbenes@suse.cz>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 06/12] livepatch: Simplify API by removing
 registration step
Message-ID: <20181022132509.6vxrdvq42e5j2bpx@pathway.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com>
 <20180828143603.4442-7-pmladek@suse.com>
 <alpine.LSU.2.21.1809051108440.7768@pobox.suse.cz>
 <20181012130120.f5berowklyccd7lj@pathway.suse.cz>
 <alpine.LSU.2.21.1810151756290.11383@pobox.suse.cz>
 <20181018145456.nrekm2iuyf5ztw3n@pathway.suse.cz>
 <20181018153027.x4nk2ihgs5ehsln2@treble>
 <alpine.LSU.2.21.1810191400320.4692@pobox.suse.cz>
 <20181019143604.35zgwus4arkolbwr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019143604.35zgwus4arkolbwr@treble>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-10-19 09:36:04, Josh Poimboeuf wrote:
> On Fri, Oct 19, 2018 at 02:16:19PM +0200, Miroslav Benes wrote:
> > On Thu, 18 Oct 2018, Josh Poimboeuf wrote:
> > 
> > > On Thu, Oct 18, 2018 at 04:54:56PM +0200, Petr Mladek wrote:
> > > > OK, what about having just "disable" in sysfs. I agree that it makes
> > > > much more sense than "enable" now.
> > > > 
> > > > It might be used also for the reverse operation the same way as
> > > > "enable" was used before. I think that standalone "reverse" might
> > > > be confusing when we allow to reverse the operation in both
> > > > directions.
> > > 
> > > As long as we're talking about radical changes... how about we just
> > > don't allow disabling patches at all?  Instead a patch can be replaced
> > > with a 'revert' patch, or an empty 'nop' patch.  That would make our
> > > code simpler and also ensure there's an audit trail.
> > > 
> > > (Apologies if we've already talked about this.  My brain is still mushy
> > > thanks to Spectre and friends.)
> > 
> > I think we talked about it last year in Prague and I think we convinced 
> > you that it was not a good idea (...not to allow disabling patches at 
> > all).
> > 
> > BUT! Empty 'nop' patch is a new idea and we may certainly discuss it.
> 
> I definitely remember talking about it in Prague, but I don't remember
> any conclusions.

The revert operation allows to remove a livepatch stuck in the
transition without forcing.

Also implementing empty cumulative patch might be tricky because
of the callbacks. The current proposal is to call callbacks only
from the new livepatch. It helps tp keep the interactions easy
and under control. The way how to take over some change between
an old and new patch depends on the particular functionality.

It would mean that the empty patch might need to be custom.
Users probably would need to ask and wait for it.


> My livepatch-related brain cache lines have been
> flushed thanks to the aforementioned CVEs and my rapidly advancing
> senility.

Uff, I am not the only one.


> > > The amount of flexibility we allow is kind of crazy, considering how
> > > delicate of an operation live patching is.  That reminds me that I
> > > should bring up my other favorite idea at LPC: require modules to be
> > > loaded before we "patch" them.
> > 
> > We talked about this as well and if I remember correctly we came to a 
> > conclusion that it is all about a distribution and maintenance. We cannot 
> > ask customers to load modules they do not need just because we need to 
> > patch them.
> 
> Fair enough.
> 
> > One cumulative patch is not that great in this case. I remember you
> > had a crazy idea how to solve it, but I don't remember details. My
> > notes from the event say...
> > 
> > 	- livepatch code complexity
> > 		- make it synchronous with respect to modules loading
> > 		- Josh's crazy idea
> > 
> > That's not much :D
> > 
> > So yes, we can talk about it and hopefully make proper notes this time.
> 
> Heh, better notes would be good, otherwise I'll just keep complaining
> about the same things every year :-)  I'll try to remember what my crazy
> idea was, or maybe come up with some new ones to keep it fresh.

If we do not want to force users to load all patched modules then
we would need to create a livepatch-per-module. This just moves
the complexity somewhere else.

One big problem would be how to keep the system consistent. You
would need to solve races between loading modules and livepatches
anyway.

For example, you could not load fixed/patched modules when the system
is not fully patched yet. You would need to load the module and
the related livepatch at the same time and follow the consistency
model as we do now.

OK, there was the idea to refuse loading modules when livepatch
transition is in progress. But it might not be acceptable,
especially when the transition gets blocked infinitely
and manual intervention would be needed.

I agree that the current solution adds complexity to
the livepatching code but it is not that complicated.
Races with loading modules and livepatches in parallel
are solved by mod->klp_active flag. There are no other
races because all other operations are done on code
that is not actively used. One good thing is that
everything is in one place and kernel has it under
control.

I am open to discuss it. But we would need to come up with
some clever solution.

Best Regards,
Petr
