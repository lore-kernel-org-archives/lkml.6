Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0491DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A49C21473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A49C21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJRW4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:56:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:50074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbeJRW4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:56:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E219BAD77;
        Thu, 18 Oct 2018 14:54:57 +0000 (UTC)
Date:   Thu, 18 Oct 2018 16:54:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 06/12] livepatch: Simplify API by removing
 registration step
Message-ID: <20181018145456.nrekm2iuyf5ztw3n@pathway.suse.cz>
References: <20180828143603.4442-1-pmladek@suse.com>
 <20180828143603.4442-7-pmladek@suse.com>
 <alpine.LSU.2.21.1809051108440.7768@pobox.suse.cz>
 <20181012130120.f5berowklyccd7lj@pathway.suse.cz>
 <alpine.LSU.2.21.1810151756290.11383@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.1810151756290.11383@pobox.suse.cz>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-10-15 18:01:43, Miroslav Benes wrote:
> On Fri, 12 Oct 2018, Petr Mladek wrote:
> 
> > On Wed 2018-09-05 11:34:06, Miroslav Benes wrote:
> > > On Tue, 28 Aug 2018, Petr Mladek wrote:
> > > > Also the API and logic is much easier. It is enough to call
> > > > klp_enable_patch() in module_init() call. The patch patch can be disabled
> > > > by writing '0' into /sys/kernel/livepatch/<patch>/enabled. Then the module
> > > > can be removed once the transition finishes and sysfs interface is freed.
> > > 
> > > I think it would be good to discuss our sysfs interface here as well.
> > > 
> > > Writing '1' to enabled attribute now makes sense only when you need to 
> > > reverse an unpatching transition. Writing '0' means "disable" or a 
> > > reversion again.
> > > 
> > > Wouldn't be better to split it to two different attributes? Something like 
> > > "disable" and "reverse"? It could be more intuitive.
> > > 
> > > Maybe we'd also find out that even patch->enabled member is not useful 
> > > anymore in such case.
> > 
> > I though about this as well. I kept "enabled" because:
> > 
> >   + It keeps the public interface the same as before. Most people
> >     would not notice any change in the behavior except maybe that
> >     the interface disappears when the patch gets disabled.
> 
> Well our sysfs interface is still in a testing phase as far as ABI is 
> involved. Moreover, each live patch is bound to its base kernel by 
> definition anyway. So we can change this without remorse, I think.
>  
> >   + The reverse operation makes most sense when the transition
> >     cannot get finished. In theory, it might be problem to
> >     finish even the reversed one. People might want to
> >     reverse once again and force it. Then "reverse" file
> >     might be confusing. They might not know in which direction
> >     they do the reverse.
> 
> I still think it would be better to have a less confusing interface and it 
> would outweigh the second remark.

OK, what about having just "disable" in sysfs. I agree that it makes
much more sense than "enable" now.

It might be used also for the reverse operation the same way as
"enable" was used before. I think that standalone "reverse" might
be confusing when we allow to reverse the operation in both
directions.

Best Regards,
Petr
