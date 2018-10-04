Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C2FC00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C50420856
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 00:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FHyamu8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C50420856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeJDHbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 03:31:33 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43420 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeJDHbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 03:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Icl82YOycJIO0qogyGiGAD3vwWNfJr/Na0Ce1I31+7Y=; b=FHyamu8Rn+IQm9hYYFpTni4Kc
        eruf9u0Rzd4tC9xrOwPqGH7x9MQIEkX7SQNnWGrLe8t3MpJifG2WAifzG77K9PsMvJGTQKKig2E7c
        xeSGZDmFP6KCp19EA/bgsuhgS0Ok5llShxcurmxzHCw/rG7BDl3uta4kwJx2qmIHxv6o0LZirOQij
        EyRR0ctSdRLSAU/4m47neuvIZ7iekOpJue8gMocilHnp0OtUeZeqfUTijY6yGZeytgQ/SlxpA/Txk
        XhHrIyE6Sgi+7gKCdhXqgxnsqeIA+GPrmO4jxdb9UGrQavtgjdI9YWky9Sn97DAE/4LlHk3iw9e/c
        e8xPH3Ncw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g7rgK-0001Ys-Hf; Thu, 04 Oct 2018 00:39:56 +0000
Date:   Wed, 3 Oct 2018 17:39:56 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
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
Message-ID: <20181004003956.GA31522@bombadil.infradead.org>
References: <20181003185854.GA1174@jordon-HP-15-Notebook-PC>
 <20181003200003.GA9965@bombadil.infradead.org>
 <20181003221444.GZ30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003221444.GZ30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 11:14:45PM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 03, 2018 at 01:00:03PM -0700, Matthew Wilcox wrote:
> > On Thu, Oct 04, 2018 at 12:28:54AM +0530, Souptick Joarder wrote:
> > > These are the approaches which could have been taken to handle
> > > this scenario -
> > > 
> > > *  Replace vm_insert_page with vmf_insert_page and then write few
> > >    extra lines of code to convert VM_FAULT_CODE to errno which
> > >    makes driver users more complex ( also the reverse mapping errno to
> > >    VM_FAULT_CODE have been cleaned up as part of vm_fault_t migration ,
> > >    not preferred to introduce anything similar again)
> > > 
> > > *  Maintain both vm_insert_page and vmf_insert_page and use it in
> > >    respective places. But it won't gurantee that vm_insert_page will
> > >    never be used in #PF context.
> > > 
> > > *  Introduce a similar API like vm_insert_page, convert all non #PF
> > >    consumer to use it and finally remove vm_insert_page by converting
> > >    it to vmf_insert_page.
> > > 
> > > And the 3rd approach was taken by introducing vm_insert_kmem_page().
> > > 
> > > In short, vmf_insert_page will be used in page fault handlers
> > > context and vm_insert_kmem_page will be used to map kernel
> > > memory to user vma outside page fault handlers context.
> > 
> > As far as I can tell, vm_insert_kmem_page() is line-for-line identical
> > with vm_insert_page().  Seriously, here's a diff I just did:
[...]
> > What on earth are you trying to do?
> 
> Reading the commit log, it seems that the intention is to split out
> vm_insert_page() used outside of page-fault handling with the use
> within page-fault handling, so that different return codes can be
> used.

Right, but we already did that.  We now have vmf_insert_page() which
returns a VM_FAULT_* code and vm_insert_page() which returns an errno.
