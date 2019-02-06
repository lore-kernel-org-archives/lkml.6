Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45CCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D05A2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbfBFMIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:08:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfBFMIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:08:20 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 97D9F3DFCD;
        Wed,  6 Feb 2019 12:08:19 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-18.pek2.redhat.com [10.72.12.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D05E363BB6;
        Wed,  6 Feb 2019 12:08:10 +0000 (UTC)
Date:   Wed, 6 Feb 2019 20:08:04 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
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
Message-ID: <20190206120804.GC10062@dhcp-128-65.nay.redhat.com>
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com>
 <20190125103924.GB27998@zn.tnic>
 <20190125134518.GA23595@dhcp-128-65.nay.redhat.com>
 <20190125140823.GC27998@zn.tnic>
 <20190131075907.GB19091@dhcp-128-65.nay.redhat.com>
 <20190131105732.GC6749@zn.tnic>
 <20190131222732.GA946@anatevka>
 <20190131234740.GO6749@zn.tnic>
 <20190204223016.GB11986@anatevka>
 <20190205081552.GG21801@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205081552.GG21801@zn.tnic>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 06 Feb 2019 12:08:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/19 at 09:15am, Borislav Petkov wrote:
> On Mon, Feb 04, 2019 at 03:30:16PM -0700, Jerry Hoemann wrote:
> > Is your objection only to the second fallback of allocating
> > memory above >= 4GB?   Or are you objecting to allocating from
> > (896 .. 4GB) as well?
> 
> My problem is why should the user need to specify high or low allocation
> explicitly when we can handle all that in the kernel automatically.
> 
> The presence of crashkernel= on the cmdline sure means that the user
> wants to allocate memory for a second kernel.
> 
> Now, if the requested allocation fails, we say:
> 
>   Error reserving crashkernel
> 
> So, instead of saying that, we can *try* *again* and say
> 
>   Error reserving requested crashkernel at @..., attempting a high range.
> 
> and run memblock_find_in_range() on the other regions which we deemed
> are ok to allocate from.
> 
> Why aren't we doing that by default instead of placing all those
> different options in front of the user and expecting her/him to know
> something about all those magic ranges?

As we talked in another reply, for the >4G allocation we can not avoid
the swiotlb issue,  but if one request for 256M in high region and we
allocate the low part automatically, it will eat more memory eg. 512M.

But probably in case allacation failed in low region ,high is a must for kdump
reservation, since no other choices perhaps we can make that as you said

> 
> I don't think most of the users care about where the kernel gets
> allocated - all they want is a working kdump setup.
> 
> > Falling back to allocating < 4GB probably satisfes most of the cases
> > where the original allocation fails.
> 
> Yes. Now make that automatic.

For the time being, this should be good enough.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

Thanks
Dave
