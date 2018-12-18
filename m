Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E9FC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128DB21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="huVwdg5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeLRNCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:02:02 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:41756 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbeLRNCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:02:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ZSPtYofuOLJbbEzZt9KWJCLaMECNc3Sg0IjTDIcqrow=; b=huVwdg5hpf7Kdngv6UqAHWE8E
        dF5KT0mvbWHNEovvbpNV/5AFkspcBEc6Apf5qWaXTnCdTmD0RmkZyF3SvWc96Mh/Li9BBr2f72lzm
        1yjKGQyr2310MqNjOuPPvBzxE1TTOB76Sy4YSwoi+H6DWTu9MMQAO+ggYoMumncwVxSmg=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:39923)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gZF0Q-0006Dt-RI; Tue, 18 Dec 2018 13:01:50 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gZF0O-0007cq-CP; Tue, 18 Dec 2018 13:01:48 +0000
Date:   Tue, 18 Dec 2018 13:01:46 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>, Heiko Stuebner <heiko@sntech.de>,
        Linux-MM <linux-mm@kvack.org>, airlied@linux.ie,
        hjc@rock-chips.com, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/9] drm/rockchip/rockchip_drm_gem.c: Convert to use
 vm_insert_range
Message-ID: <20181218130146.GO26090@n2100.armlinux.org.uk>
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk>
 <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
 <20181218123318.GN26090@n2100.armlinux.org.uk>
 <CAFqt6zbqaS-pFETyjRR2-1V57MiJuX65xoMjgkr-DjUnrJYzSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zbqaS-pFETyjRR2-1V57MiJuX65xoMjgkr-DjUnrJYzSg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 06:24:29PM +0530, Souptick Joarder wrote:
> On Tue, Dec 18, 2018 at 6:03 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Dec 18, 2018 at 05:36:04PM +0530, Souptick Joarder wrote:
> > > On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
> > > <linux@armlinux.org.uk> wrote:
> > > > This looks like a change in behaviour.
> > > >
> > > > If user_count is zero, and offset is zero, then we pass into
> > > > vm_insert_range() a page_count of zero, and vm_insert_range() does
> > > > nothing and returns zero.
> > > >
> > > > However, as we can see from the above code, the original behaviour
> > > > was to return -ENXIO in that case.
> > >
> > > I think these checks are not necessary. I am not sure if we get into mmap
> > > handlers of driver with user_count = 0.
> >
> > I'm not sure either, I'm just pointing out the change of behaviour.
> 
> Ok. I think feedback from Heiko might be helpful here :)
> 
> >
> > > > The other thing that I'm wondering is that if (eg) count is 8 (the
> > > > object is 8 pages), offset is 2, and the user requests mapping 6
> > > > pages (user_count = 6), then we call vm_insert_range() with a
> > > > pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> > > > end up inserting four pages.
> > >
> > > Considering the scenario, user_count will remain 8 (user_count =
> > > vma_pages(vma) ). ? No ?
> > > Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
> > > a pages_count
> > > of 8 - 2 = 6. So we end up inserting 6 pages.
> > >
> > > Please correct me if I am wrong.
> >
> > vma_pages(vma) is the number of pages that the user requested, it is
> > the difference between vma->vm_end and vma->vm_start in pages.  As I
> > said above, "the user requests mapping 6 pages", so vma_pages() will
> > be 6, and so user_count will also be 6.  You are passing
> > user_count - offset into vm_insert_range(), which will be 6 - 2 = 4
> > in my example.  This is two pages short of what the user requested.
> >
> 
> So, this should be the correct behavior.
> 
>                  return vm_insert_range(vma, vma->vm_start,
> rk_obj->pages + offset,
>                                                           user_count);

... and by doing so, you're introducing another instance of the same
bug I pointed out in patch 2.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
