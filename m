Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ACDECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A1D20843
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 14:36:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A1D20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJSWmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 18:42:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54346 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbeJSWmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 18:42:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF0CC7F6BB;
        Fri, 19 Oct 2018 14:36:13 +0000 (UTC)
Received: from treble (ovpn-122-14.rdu2.redhat.com [10.10.122.14])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 41708751CA;
        Fri, 19 Oct 2018 14:36:12 +0000 (UTC)
Date:   Fri, 19 Oct 2018 09:36:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Petr Mladek <pmladek@suse.com>, Jiri Kosina <jikos@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 06/12] livepatch: Simplify API by removing
 registration step
Message-ID: <20181019143604.35zgwus4arkolbwr@treble>
References: <20180828143603.4442-1-pmladek@suse.com>
 <20180828143603.4442-7-pmladek@suse.com>
 <alpine.LSU.2.21.1809051108440.7768@pobox.suse.cz>
 <20181012130120.f5berowklyccd7lj@pathway.suse.cz>
 <alpine.LSU.2.21.1810151756290.11383@pobox.suse.cz>
 <20181018145456.nrekm2iuyf5ztw3n@pathway.suse.cz>
 <20181018153027.x4nk2ihgs5ehsln2@treble>
 <alpine.LSU.2.21.1810191400320.4692@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1810191400320.4692@pobox.suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Fri, 19 Oct 2018 14:36:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 02:16:19PM +0200, Miroslav Benes wrote:
> On Thu, 18 Oct 2018, Josh Poimboeuf wrote:
> 
> > On Thu, Oct 18, 2018 at 04:54:56PM +0200, Petr Mladek wrote:
> > > On Mon 2018-10-15 18:01:43, Miroslav Benes wrote:
> > > > On Fri, 12 Oct 2018, Petr Mladek wrote:
> > > > 
> > > > > On Wed 2018-09-05 11:34:06, Miroslav Benes wrote:
> > > > > > On Tue, 28 Aug 2018, Petr Mladek wrote:
> > > > > > > Also the API and logic is much easier. It is enough to call
> > > > > > > klp_enable_patch() in module_init() call. The patch patch can be disabled
> > > > > > > by writing '0' into /sys/kernel/livepatch/<patch>/enabled. Then the module
> > > > > > > can be removed once the transition finishes and sysfs interface is freed.
> > > > > > 
> > > > > > I think it would be good to discuss our sysfs interface here as well.
> > > > > > 
> > > > > > Writing '1' to enabled attribute now makes sense only when you need to 
> > > > > > reverse an unpatching transition. Writing '0' means "disable" or a 
> > > > > > reversion again.
> > > > > > 
> > > > > > Wouldn't be better to split it to two different attributes? Something like 
> > > > > > "disable" and "reverse"? It could be more intuitive.
> > > > > > 
> > > > > > Maybe we'd also find out that even patch->enabled member is not useful 
> > > > > > anymore in such case.
> > > > > 
> > > > > I though about this as well. I kept "enabled" because:
> > > > > 
> > > > >   + It keeps the public interface the same as before. Most people
> > > > >     would not notice any change in the behavior except maybe that
> > > > >     the interface disappears when the patch gets disabled.
> > > > 
> > > > Well our sysfs interface is still in a testing phase as far as ABI is 
> > > > involved. Moreover, each live patch is bound to its base kernel by 
> > > > definition anyway. So we can change this without remorse, I think.
> > 
> > But it would break tooling, which is not kernel specific.  I'm not sure
> > whether it would be worth the headache.  After all I think the livepatch
> > sysfs interface is designed for tools, not humans.
> 
> You're right. It's probably not worth it. Oh well.
>  
> > > > >   + The reverse operation makes most sense when the transition
> > > > >     cannot get finished. In theory, it might be problem to
> > > > >     finish even the reversed one. People might want to
> > > > >     reverse once again and force it. Then "reverse" file
> > > > >     might be confusing. They might not know in which direction
> > > > >     they do the reverse.
> > > > 
> > > > I still think it would be better to have a less confusing interface and it 
> > > > would outweigh the second remark.
> > > 
> > > OK, what about having just "disable" in sysfs. I agree that it makes
> > > much more sense than "enable" now.
> > > 
> > > It might be used also for the reverse operation the same way as
> > > "enable" was used before. I think that standalone "reverse" might
> > > be confusing when we allow to reverse the operation in both
> > > directions.
> > 
> > As long as we're talking about radical changes... how about we just
> > don't allow disabling patches at all?  Instead a patch can be replaced
> > with a 'revert' patch, or an empty 'nop' patch.  That would make our
> > code simpler and also ensure there's an audit trail.
> > 
> > (Apologies if we've already talked about this.  My brain is still mushy
> > thanks to Spectre and friends.)
> 
> I think we talked about it last year in Prague and I think we convinced 
> you that it was not a good idea (...not to allow disabling patches at 
> all).
> 
> BUT! Empty 'nop' patch is a new idea and we may certainly discuss it.

I definitely remember talking about it in Prague, but I don't remember
any conclusions.  My livepatch-related brain cache lines have been
flushed thanks to the aforementioned CVEs and my rapidly advancing
senility.

> > The amount of flexibility we allow is kind of crazy, considering how
> > delicate of an operation live patching is.  That reminds me that I
> > should bring up my other favorite idea at LPC: require modules to be
> > loaded before we "patch" them.
> 
> We talked about this as well and if I remember correctly we came to a 
> conclusion that it is all about a distribution and maintenance. We cannot 
> ask customers to load modules they do not need just because we need to 
> patch them.

Fair enough.

> One cumulative patch is not that great in this case. I remember you
> had a crazy idea how to solve it, but I don't remember details. My
> notes from the event say...
> 
> 	- livepatch code complexity
> 		- make it synchronous with respect to modules loading
> 		- Josh's crazy idea
> 
> That's not much :D
> 
> So yes, we can talk about it and hopefully make proper notes this time.

Heh, better notes would be good, otherwise I'll just keep complaining
about the same things every year :-)  I'll try to remember what my crazy
idea was, or maybe come up with some new ones to keep it fresh.

-- 
Josh
