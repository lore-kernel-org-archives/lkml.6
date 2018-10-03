Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27409C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCADB213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 22:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="mjEXRqO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCADB213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeJDFIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:08:14 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:55680 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbeJDFIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:08:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sGu0u82Lw+zJRWbWiiG1m9J/ZfzMgwo0L4WjqTl8JKw=; b=mjEXRqO0McIQgv3qT3NWqXf2F
        kBfCOGM8TdYFDSr5TKaNUC69XjWY3U1am30lx3IuVeobW6XQizPxz3xiMCmTattRuxUaexRN44d8N
        Q2oYVbFgdQcD/dqMYm8KZDKGtYwTmWj0no3BEpbTFnxbASvbF1fLjWfBVkv/UU2sEwAR4=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:49770)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1g7pPu-0003DW-29; Wed, 03 Oct 2018 23:14:50 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1g7pPq-00043u-Vl; Wed, 03 Oct 2018 23:14:47 +0100
Date:   Wed, 3 Oct 2018 23:14:45 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Souptick Joarder <jrdr.linux@gmail.com>,
        miguel.ojeda.sandonis@gmail.com, robin@protonic.nl,
        stefanr@s5r6.in-berlin.de, hjc@rock-chips.com, heiko@sntech.de,
        airlied@linux.ie, robin.murphy@arm.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, m.szyprowski@samsung.com,
        keescook@chromium.org, treding@nvidia.com, mhocko@suse.com,
        dan.j.williams@intel.com, kirill.shutemov@linux.intel.com,
        mark.rutland@arm.com, aryabinin@virtuozzo.com, dvyukov@google.com,
        kstewart@linuxfoundation.org, tchibo@google.com, riel@redhat.com,
        minchan@kernel.org, peterz@infradead.org, ying.huang@intel.com,
        ak@linux.intel.com, rppt@linux.vnet.ibm.com,
        linux@dominikbrodowski.net, arnd@arndb.de, cpandya@codeaurora.org,
        hannes@cmpxchg.org, joe@perches.com, mcgrof@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux1394-devel@lists.sourceforge.net,
        dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: Introduce new function vm_insert_kmem_page
Message-ID: <20181003221444.GZ30658@n2100.armlinux.org.uk>
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003200003.GA9965@bombadil.infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 01:00:03PM -0700, Matthew Wilcox wrote:
> On Thu, Oct 04, 2018 at 12:28:54AM +0530, Souptick Joarder wrote:
> > These are the approaches which could have been taken to handle
> > this scenario -
> > 
> > *  Replace vm_insert_page with vmf_insert_page and then write few
> >    extra lines of code to convert VM_FAULT_CODE to errno which
> >    makes driver users more complex ( also the reverse mapping errno to
> >    VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
> >    not preferred to introduce anything similar again)
> > 
> > *  Maintain both vm_insert_page and vmf_insert_page and use it in
> >    respective places. But it won't gurantee that vm_insert_page will
> >    never be used in #PF context.
> > 
> > *  Introduce a similar API like vm_insert_page, convert all non #PF
> >    consumer to use it and finally remove vm_insert_page by converting
> >    it to vmf_insert_page.
> > 
> > And the 3rd approach was taken by introducing vm_insert_kmem_page().
> > 
> > In short, vmf_insert_page will be used in page fault handlers
> > context and vm_insert_kmem_page will be used to map kernel
> > memory to user vma outside page fault handlers context.
> 
> As far as I can tell, vm_insert_kmem_page() is line-for-line identical
> with vm_insert_page().  Seriously, here's a diff I just did:
> 
> -static int insert_page(struct vm_area_struct *vma, unsigned long addr,
> -                       struct page *page, pgprot_t prot)
> +static int insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> +               struct page *page, pgprot_t prot)
> -       /* Ok, finally just insert the thing.. */
> -int vm_insert_page(struct vm_area_struct *vma, unsigned long addr,
> +int vm_insert_kmem_page(struct vm_area_struct *vma, unsigned long addr,
> -       return insert_page(vma, addr, page, vma->vm_page_prot);
> +       return insert_kmem_page(vma, addr, page, vma->vm_page_prot);
> -EXPORT_SYMBOL(vm_insert_page);
> +EXPORT_SYMBOL(vm_insert_kmem_page);
> 
> What on earth are you trying to do?

Reading the commit log, it seems that the intention is to split out
vm_insert_page() used outside of page-fault handling with the use
within page-fault handling, so that different return codes can be
used.

I don't see that justifies the code duplication - can't
vm_insert_page() and vm_insert_kmem_page() use the same mechanics
to do their job, and just translate the error code from the most-
specific to the least-specific error code?  Do we really need two
copies of the same code just to return different error codes.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
