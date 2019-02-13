Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F890C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BEC20811
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:49:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394014AbfBMSoz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:44:55 -0500
Received: from verein.lst.de ([213.95.11.211]:44788 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406160AbfBMSot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:44:49 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 238DF68C8E; Wed, 13 Feb 2019 19:44:48 +0100 (CET)
Date:   Wed, 13 Feb 2019 19:44:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] initramfs: proide a generic free_initrd_mem
 implementation
Message-ID: <20190213184448.GB20399@lst.de>
References: <20190213174621.29297-1-hch@lst.de> <20190213174621.29297-8-hch@lst.de> <20190213184139.GC15270@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213184139.GC15270@rapoport-lnx>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 08:41:40PM +0200, Mike Rapoport wrote:
> csky seems to open-code free_reserved_page with the only
> difference that it's also increments totalram_pages for the freed pages,
> which doesn't seem correct anyway...
> 
> That said, I suppose arch/csky can be also added to the party.

Yes, I noticed that.  But I'd rather move it over manually in
another patch post rc1 or for the next merge window.

> > +void __weak free_initrd_mem(unsigned long start, unsigned long end)
> > +{
> > +	free_reserved_area((void *)start, (void *)end, -1, "initrd");
> 
> Some architectures have pr_info("Freeing initrd memory..."), I'd add it for
> the generic version as well.

Well, if we think such a printk is useful it should probably be
moved to the caller in init/initramfs.c instead.  I can include a
patch for that in the next iteration of the series.

> Another thing that I was thinking of is that x86 has all those memory
> protection calls in its free_initrd_mem, maybe it'd make sense to have them
> in the generic version as well?

Maybe.  But I'd rather keep it out of the initial series as it looks
a little more complicated.  Having a single implementation
of free_initrd_mem would be great, though.
