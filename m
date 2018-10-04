Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABECCC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8AF205C9
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 12:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pLIY8duN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8AF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbeJDT2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 15:28:36 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37068 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJDT2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 15:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Kl8EIai6DfQlBGhaCshHzgTYL1dTRWMVmkzj3lEPAzQ=; b=pLIY8duNDh4hBwK880cxpsQ0A
        tCawaZSUDjrTwY4tSl/CsG7B7k6QqlEFT+09DlMDkIeqSUjSlICFThX6F8m1Kr7hysJX+3O63a6zY
        gnx++BrtMxoit8dOD8CpfgIQs6zHrbUwQpieHUq7kmDsGFmB6tsNDBtvU9APK2C5Cr9SM=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:36209)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g82pd-0006ay-BD; Thu, 04 Oct 2018 13:34:17 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g82pR-0003ZD-LL; Thu, 04 Oct 2018 13:34:05 +0100
Date:   Thu, 4 Oct 2018 13:34:01 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        robin@protonic.nl, stefanr@s5r6.in-berlin.de, hjc@rock-chips.com,
        Heiko Stuebner <heiko@sntech.de>, airlied@linux.ie,
        robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kees Cook <keescook@chromium.org>, treding@nvidia.com,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, aryabinin@virtuozzo.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Kate Stewart <kstewart@linuxfoundation.org>, tchibo@google.com,
        riel@redhat.com, Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, ak@linux.intel.com,
        rppt@linux.vnet.ibm.com, linux@dominikbrodowski.net,
        Arnd Bergmann <arnd@arndb.de>, cpandya@codeaurora.org,
        hannes@cmpxchg.org, Joe Perches <joe@perches.com>,
        mcgrof@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
Message-ID: <20181004123400.GC30658@n2100.armlinux.org.uk>
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org>
 <20181003221444.GZ30658@n2100.armlinux.org.uk>
 <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFqt6zYHhmPwUdaCZX-BuAvaVwA-x1W39tz+Q50-nbEaW2cYVg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 05:45:13PM +0530, Souptick Joarder wrote:
> On Thu, Oct 4, 2018 at 3:45 AM Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> >
> > On Wed, Oct 03, 2018 at 01:00:03PM -0700, Matthew Wilcox wrote:
> > > On Thu, Oct 04, 2018 at 12:28:54AM +0530, Souptick Joarder wrote:
> > > > These are the approaches which could have been taken to handle
> > > > this scenario -
> > > >
> > > > *  Replace vm_insert_page with vmf_insert_page and then write few
> > > >    extra lines of code to convert VM_FAULT_CODE to errno which
> > > >    makes driver users more complex ( also the reverse mapping errno to
> > > >    VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
> > > >    not preferred to introduce anything similar again)
> > > >
> > > > *  Maintain both vm_insert_page and vmf_insert_page and use it in
> > > >    respective places. But it won't gurantee that vm_insert_page will
> > > >    never be used in #PF context.
> > > >
> > > > *  Introduce a similar API like vm_insert_page, convert all non #PF
> > > >    consumer to use it and finally remove vm_insert_page by converting
> > > >    it to vmf_insert_page.
> > > >
> > > > And the 3rd approach was taken by introducing vm_insert_kmem_page().
> > > >
> > > > In short, vmf_insert_page will be used in page fault handlers
> > > > context and vm_insert_kmem_page will be used to map kernel
> > > > memory to user vma outside page fault handlers context.
> > >
> > > As far as I can tell, vm_insert_kmem_page() is line-for-line identical
> > > with vm_insert_page().  Seriously, here's a diff I just did:
> > >
> > > -static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> > > -                       struct page *page, pgprot_t prot)
> > > +static int insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> > > +               struct page *page, pgprot_t prot)
> > > -       /* Ok, finally just insert the thing.. */
> > > -int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> > > +int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> > > -       return insert_page(vma, addr, page, vma->vm_page_prot);
> > > +       return insert_kmem_page(vma, addr, page, vma->vm_page_prot);
> > > -EXPORT_SYMBOL(vm_insert_page);
> > > +EXPORT_SYMBOL(vm_insert_kmem_page);
> > >
> > > What on earth are you trying to do?
> 
> >
> > Reading the commit log, it seems that the intention is to split out
> > vm_insert_page() used outside of page-fault handling with the use
> > within page-fault handling, so that different return codes can be
> > used.
> >
> > I don't see that justifies the code duplication - can't
> > vm_insert_page() and vm_insert_kmem_page() use the same mechanics
> > to do their job, and just translate the error code from the most-
> > specific to the least-specific error code?  Do we really need two
> > copies of the same code just to return different error codes.
> 
> Sorry about it.
> can I take below approach in a patch series ->
> 
> create a wrapper function vm_insert_kmem_page using vm_insert_page.
> Convert all the non #PF users to use it.
> Then make vm_insert_page static and convert inline vmf_insert_page to caller.

I'm confused, what are you trying to do?

It seems that we already have:

vm_insert_page() - returns an errno
vmf_insert_page() - returns a VM_FAULT_* code

From what I _think_ you're saying, you're trying to provide
vm_insert_kmem_page() as a direct replacement for the existing
vm_insert_page(), and then make vm_insert_page() behave as per
vmf_insert_page(), so we end up with:

vm_insert_kmem_page() - returns an errno
vm_insert_page() - returns a VM_FAULT_* code
vmf_insert_page() - returns a VM_FAULT_* code and is identical to
      vm_insert_page()

Given that the documentation for vm_insert_page() says:

 * Usually this function is called from f_op->mmap() handler
 * under mm->mmap_sem write-lock, so it can change vma->vm_flags.
 * Caller must set VM_MIXEDMAP on vma if it wants to call this
 * function from other places, for example from page-fault handler.

this says that the "usual" use method for vm_insert_page() is
_outside_ of page fault handling - if it is used _inside_ page fault
handling, then it states that additional fixups are required on the
VMA.  So I don't get why your patch commentry seems to be saying that
users of vm_insert_page() outside of page fault handling all need to
be patched - isn't this the use case that this function is defined
to be handling?

If you're going to be changing the semantics, doesn't this create a
flag day where we could get new users of vm_insert_page() using the
_existing_ semantics merged after you've changed its semantics (eg,
the return code)?

Maybe I don't understand fully what you're trying to achieve here.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
