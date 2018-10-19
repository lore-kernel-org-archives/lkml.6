Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBB4C67863
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0930721477
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 02:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0930721477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbeJSKWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 06:22:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeJSKWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 06:22:24 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 22097C49;
        Fri, 19 Oct 2018 02:18:27 +0000 (UTC)
Date:   Thu, 18 Oct 2018 19:18:25 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Arun KS <arunks@codeaurora.org>, Vlastimil Babka <vbabka@suse.cz>,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        dan.j.williams@intel.com, iamjoonsoo.kim@lge.com,
        gregkh@linuxfoundation.org, osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
Message-Id: <20181018191825.fcad6e28f32a3686f201acdf@linux-foundation.org>
In-Reply-To: <20181011075503.GQ5873@dhcp22.suse.cz>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
        <72215e75-6c7e-0aef-c06e-e3aba47cf806@suse.cz>
        <efb65160af41d0e18cb2dcb30c2fb86a@codeaurora.org>
        <20181010173334.GL5873@dhcp22.suse.cz>
        <a2d576a5fc82cdf54fc89409686e58f5@codeaurora.org>
        <20181011075503.GQ5873@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 09:55:03 +0200 Michal Hocko <mhocko@kernel.org> wrote:

> > > > > This is now not called anymore, although the xen/hv variants still do
> > > > > it. The function seems empty these days, maybe remove it as a followup
> > > > > cleanup?
> > > > >
> > > > > > -	__online_page_increment_counters(page);
> > > > > > -	__online_page_free(page);
> > > > > > +	__free_pages_core(page, order);
> > > > > > +	totalram_pages += (1UL << order);
> > > > > > +#ifdef CONFIG_HIGHMEM
> > > > > > +	if (PageHighMem(page))
> > > > > > +		totalhigh_pages += (1UL << order);
> > > > > > +#endif
> > > > >
> > > > > __online_page_increment_counters() would have used
> > > > > adjust_managed_page_count() which would do the changes under
> > > > > managed_page_count_lock. Are we safe without the lock? If yes, there
> > > > > should perhaps be a comment explaining why.
> > > > 
> > > > Looks unsafe without managed_page_count_lock.
> > > 
> > > Why does it matter actually? We cannot online/offline memory in
> > > parallel. This is not the case for the boot where we initialize memory
> > > in parallel on multiple nodes. So this seems to be safe currently unless
> > > I am missing something. A comment explaining that would be helpful
> > > though.
> > 
> > Other main callers of adjust_manage_page_count(),
> > 
> > static inline void free_reserved_page(struct page *page)
> > {
> >         __free_reserved_page(page);
> >         adjust_managed_page_count(page, 1);
> > }
> > 
> > static inline void mark_page_reserved(struct page *page)
> > {
> >         SetPageReserved(page);
> >         adjust_managed_page_count(page, -1);
> > }
> > 
> > Won't they race with memory hotplug?
> > 
> > Few more,
> > ./drivers/xen/balloon.c:519:            adjust_managed_page_count(page, -1);
> > ./drivers/virtio/virtio_balloon.c:175:  adjust_managed_page_count(page, -1);
> > ./drivers/virtio/virtio_balloon.c:196:  adjust_managed_page_count(page, 1);
> > ./mm/hugetlb.c:2158:                    adjust_managed_page_count(page, 1 <<
> > h->order);
> 
> They can, and I have missed those.

So this patch needs more work, yes?
