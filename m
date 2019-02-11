Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71832C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B924218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfBKUse (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:48:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38314 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbfBKUse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:48:34 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6F14C80F82;
        Mon, 11 Feb 2019 20:48:33 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-81.pek2.redhat.com [10.72.12.81])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F05977C82D;
        Mon, 11 Feb 2019 20:48:23 +0000 (UTC)
Date:   Tue, 12 Feb 2019 04:48:16 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>, bhe@redhat.com
Cc:     Jerry Hoemann <jerry.hoemann@hpe.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pingfan Liu <kernelfans@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
Message-ID: <20190211204816.GB21473@dhcp-128-65.nay.redhat.com>
References: <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic>
 <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic>
 <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
 <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 11 Feb 2019 20:48:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/19 at 08:08pm, Dave Young wrote:
> On 02/05/19 at 09:15am, Borislav Petkov wrote:
> > On Mon, Feb 04, 2019 at 03:30:16PM -0700, Jerry Hoemann wrote:
> > > Is your objection only to the second fallback of allocating
> > > memory above >= 4GB?   Or are you objecting to allocating from
> > > (896 .. 4GB) as well?
> > 
> > My problem is why should the user need to specify high or low allocation
> > explicitly when we can handle all that in the kernel automatically.
> > 
> > The presence of crashkernel= on the cmdline sure means that the user
> > wants to allocate memory for a second kernel.
> > 
> > Now, if the requested allocation fails, we say:
> > 
> >   Error reserving crashkernel
> > 
> > So, instead of saying that, we can *try* *again* and say
> > 
> >   Error reserving requested crashkernel at @..., attempting a high range.
> > 
> > and run memblock_find_in_range() on the other regions which we deemed
> > are ok to allocate from.
> > 
> > Why aren't we doing that by default instead of placing all those
> > different options in front of the user and expecting her/him to know
> > something about all those magic ranges?
> 
> As we talked in another reply, for the >4G allocation we can not avoid
> the swiotlb issue,  but if one request for 256M in high region and we
> allocate the low part automatically, it will eat more memory eg. 512M.
> 
> But probably in case allacation failed in low region ,high is a must for kdump
> reservation, since no other choices perhaps we can make that as you said

That is exactly what Pingfan is doing in this patch.

Even we make it automatic in kernel, but we have to have some default
value for swiotlb in case crashkernel can not find a free region under 4G.
So this default value can not work for every use cases, people need 
manually use crashkernel=,low and crashkernel=,high in case
crashkernel=X does not work.  One can tune it for their use:

1) crashkernel=X reservation fails, likely the ,low default value is
still too big, one can shrink the value and manually try other value
2) crashkernel=X reserve successfully on high memory and along with some
default low memory region. But the low region is not enough.  In this
case one can increase the 

This should answer the question why ,high and ,low is still needed.

But for above consumption 1),  KASLR can still cause default ,low memory
failed to reserve.  So I wonder if KASLR can skip the 0-896M if the
system memory is big enough.

Thanks
Dave
