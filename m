Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394CCC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4B22087E
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbfAYNpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:45:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48712 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbfAYNpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:45:40 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 28A08C0C8CD9;
        Fri, 25 Jan 2019 13:45:39 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1470A177FE;
        Fri, 25 Jan 2019 13:45:23 +0000 (UTC)
Date:   Fri, 25 Jan 2019 21:45:18 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Pingfan Liu <kernelfans@gmail.com>, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, yinghai@kernel.org,
        vgoyal@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125103924.GB27998@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 25 Jan 2019 13:45:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Dave Young sent the original post, and I just re-post it with commit log
> 
> If he sent it, he should be the author I guess.

Just drop the line, but can change the credit to Chao Wang since he did
it initially.

But Chao does not work on kexec/kdump any more, and the email address is
outdated as well.

> 
> > improvement as his requirement.
> > http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > There was an old discussion below (previously posted by Chao Wang):
> > https://lkml.org/lkml/2013/10/15/601
> 
> All that changelog info doesn't belong in the commit message ...
> 
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> 
> .... but here.
> 
> > v6 -> v7: commit log improvement
> >  arch/x86/kernel/setup.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 3d872a5..fa62c81 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -551,6 +551,22 @@ static void __init reserve_crashkernel(void)
> >  						    high ? CRASH_ADDR_HIGH_MAX
> >  							 : CRASH_ADDR_LOW_MAX,
> >  						    crash_size, CRASH_ALIGN);
> > +#ifdef CONFIG_X86_64
> > +		/*
> > +		 * crashkernel=X reserve below 896M fails? Try below 4G
> > +		 */
> > +		if (!high && !crash_base)
> > +			crash_base = memblock_find_in_range(CRASH_ALIGN,
> > +						(1ULL << 32),
> > +						crash_size, CRASH_ALIGN);
> > +		/*
> > +		 * crashkernel=X reserve below 4G fails? Try MAXMEM
> > +		 */
> > +		if (!high && !crash_base)
> > +			crash_base = memblock_find_in_range(CRASH_ALIGN,
> > +						CRASH_ADDR_HIGH_MAX,
> > +						crash_size, CRASH_ALIGN);
> > +#endif
> 
> Ok, so this is silly: we know at which physical address KASLR allocated
> the kernel so why aren't we querying that and seeing if there's enough
> room before it or after it to call memblock_find_in_range() on the
> bigger range?

Baoquan may have comments?

> 
> Also, why is "high" dealt with separately and why isn't the code
> enforcing "high" if the normal reservation fails?
> 

AFAIK, some people prefer to explictly reserve crash memory at high
region even if it is possible to reserve at low area.  May because
<4G memory is limited on large server, they want to leave this for other
use. 

Yinghai or Vivek should know more about the history, probably they can
recall some initial reason.

> The presence of high is requiring from our users to pay attention what
> to use when the kernel can do all that automatically. Looks like a UI
> fail to me.
> 
> And look at all the flavors of crashkernel= :
> 
>         crashkernel=size[KMG][@offset[KMG]]
>         crashkernel=range1:size1[,range2:size2,...][@offset]
>         crashkernel=size[KMG],high
>         crashkernel=size[KMG],low
> 
> We couldn't do one so we made 4?!?!
> 
> What for?
> 
> Nowhere in that help text does it explain why a user would care about
> high or low or range or offset or the planets alignment...
> 
> So what's up?

Good question, still it may be some historical reason, but it is good to
make them clear and rethink about it after long time.

I also want to understand, need dig the log more.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

Thanks
Dave
