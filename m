Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC6AC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603EE21873
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:33:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="VoB8W+aN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbeLSJdC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:33:02 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55642 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeLSJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XEdwmYpb9V17qjkZSHR5XXHlUzVbPyMwKaT9zenZRtM=; b=VoB8W+aN2VBR/la4LUJaHP8xp
        trOSt566Jd5quXeoXhhLv1kDQ5seisInv09pFBgRLG66YmZbVjEeZsihCpTW8LaHR9Gp9/h2zb43+
        wMkbOWmn2vBWXk2HT8yRf/qQqY6K6ftTIZuMctLDOQwQdDJNW3APi9Rt3AcewA32ChKqk=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:53501)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gZYDR-0002ih-Th; Wed, 19 Dec 2018 09:32:34 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gZYDP-0002y2-Dd; Wed, 19 Dec 2018 09:32:31 +0000
Date:   Wed, 19 Dec 2018 09:32:30 +0000
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
Message-ID: <20181219093230.GS26090@n2100.armlinux.org.uk>
References: <20181217202334.GA11758@jordon-HP-15-Notebook-PC>
 <20181218095709.GJ26090@n2100.armlinux.org.uk>
 <CAFqt6zaVU-Fme6fErieBfBKwAm9xHUa7cXTOfqzwUJR__0JysQ@mail.gmail.com>
 <20181218123318.GN26090@n2100.armlinux.org.uk>
 <CAFqt6zbqaS-pFETyjRR2-1V57MiJuX65xoMjgkr-DjUnrJYzSg@mail.gmail.com>
 <20181218130146.GO26090@n2100.armlinux.org.uk>
 <CAFqt6zYnn76OdprSvA2Bj0v=xQqtJ6xJse6+iB+-=u3WsEv3pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYnn76OdprSvA2Bj0v=xQqtJ6xJse6+iB+-=u3WsEv3pA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 09:01:09AM +0530, Souptick Joarder wrote:
> On Tue, Dec 18, 2018 at 6:31 PM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > On Tue, Dec 18, 2018 at 06:24:29PM +0530, Souptick Joarder wrote:
> > > On Tue, Dec 18, 2018 at 6:03 PM Russell King - ARM Linux
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > On Tue, Dec 18, 2018 at 05:36:04PM +0530, Souptick Joarder wrote:
> > > > > On Tue, Dec 18, 2018 at 3:27 PM Russell King - ARM Linux
> > > > > <linux@armlinux.org.uk> wrote:
> > > > > > This looks like a change in behaviour.
> > > > > >
> > > > > > If user_count is zero, and offset is zero, then we pass into
> > > > > > vm_insert_range() a page_count of zero, and vm_insert_range() does
> > > > > > nothing and returns zero.
> > > > > >
> > > > > > However, as we can see from the above code, the original behaviour
> > > > > > was to return -ENXIO in that case.
> > > > >
> > > > > I think these checks are not necessary. I am not sure if we get into mmap
> > > > > handlers of driver with user_count = 0.
> > > >
> > > > I'm not sure either, I'm just pointing out the change of behaviour.
> > >
> > > Ok. I think feedback from Heiko might be helpful here :)
> > >
> > > >
> > > > > > The other thing that I'm wondering is that if (eg) count is 8 (the
> > > > > > object is 8 pages), offset is 2, and the user requests mapping 6
> > > > > > pages (user_count = 6), then we call vm_insert_range() with a
> > > > > > pages of rk_obj->pages + 2, and a pages_count of 6 - 2 = 4. So we
> > > > > > end up inserting four pages.
> > > > >
> > > > > Considering the scenario, user_count will remain 8 (user_count =
> > > > > vma_pages(vma) ). ? No ?
> > > > > Then we call vm_insert_range() with a pages of rk_obj->pages + 2, and
> > > > > a pages_count
> > > > > of 8 - 2 = 6. So we end up inserting 6 pages.
> > > > >
> > > > > Please correct me if I am wrong.
> > > >
> > > > vma_pages(vma) is the number of pages that the user requested, it is
> > > > the difference between vma->vm_end and vma->vm_start in pages.  As I
> > > > said above, "the user requests mapping 6 pages", so vma_pages() will
> > > > be 6, and so user_count will also be 6.  You are passing
> > > > user_count - offset into vm_insert_range(), which will be 6 - 2 = 4
> > > > in my example.  This is two pages short of what the user requested.
> > > >
> > >
> > > So, this should be the correct behavior.
> > >
> > >                  return vm_insert_range(vma, vma->vm_start,
> > > rk_obj->pages + offset,
> > >                                                           user_count);
> >
> > ... and by doing so, you're introducing another instance of the same
> > bug I pointed out in patch 2.
> 
> Sorry but didn't get it ? How it will be similar to the bug pointed
> out in patch 2 ?

Towards the top of this function, you have:

        unsigned long user_count = vma_pages(vma);

So what you are proposing does:

        return vm_insert_range(vma, vma->vm_start, rk_obj->pages + offset,
                               vma_pages(vma));

Now if we look inside vm_insert_range():

+int vm_insert_range(struct vm_area_struct *vma, unsigned long addr,
+                       struct page **pages, unsigned long page_count)
+{
+       unsigned long uaddr = addr;
+       int ret = 0, i;
+
+       if (page_count > vma_pages(vma))
+               return -ENXIO;
+
+       for (i = 0; i < page_count; i++) {
+               ret = vm_insert_page(vma, uaddr, pages[i]);
+               if (ret < 0)
+                       return ret;
+               uaddr += PAGE_SIZE;
+       }

So, page_count _is_ vma_pages(vma).  So this code does these operations:

	if (vma_pages(vma) > vma_pages(vma))
		return -ENXIO;

This will always be false.  I've already stated in my reply to patch 2
in paragraph 3 about the uselessness of this test.

	for (i = 0; i < vma_pages(vma); i++) {
		ret = vm_insert_page(vma, uaddr, pages[i]);

So the loop will iterate over the number of pages that the user requested.

Now, taking another example.  The object is again 8 pages long, so
indexes 0 through 7 in its page array are valid.  The user requests
8 pages at offset 2 into the object.  Also as already stated in
paragraph 3 of my reply to patch 2.

vma_pages(vma) is 8.  offset = 2.

So we end up _inside_ vm_insert_range() with:

	if (8 > 8)
		return -ENXIO;

As stated, always false.

	for (i = 0; i < 8; i++) {
		ret = vm_insert_page(vma, vaddr, rk_obj->pages[2 + i]);

Which means we iterate over rk_obj->pages indicies from 2 through 9
inclusive.

Since only 0 through 7 are valid, we have walked off the end of the
array, and attempted to map an invalid struct page pointer - we could
be lucky, and it could point at some struct page (potentially causing
us to map some sensitive page - maybe containing your bank details or
root password... Or it could oops the kernel.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
