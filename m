Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB55C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC66C20658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Li+CBxcG";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="T+ZpZ34f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC66C20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbeJKJyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 05:54:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59896 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbeJKJyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 05:54:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6C31860C86; Thu, 11 Oct 2018 02:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539224974;
        bh=24QEhOa6b6pADby9FH9M7zyM17kAfwnL7p3AeNWQ2Do=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Li+CBxcGjseQzmCMj88IZKYZhL53E5OiVnrJJkCIej9Ai1j6hvGDV+neOXPXhDFcP
         kIiT0YLRBOyTNOB7hz9L+biTEmrTArSjcwvJYtsoQozvuls8lMJa7oeBhZf6ZquUat
         fGkLhHsOreqgZvngy8N43hYJPuDv4UxjdCTE7LBQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 49E3960C64;
        Thu, 11 Oct 2018 02:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539224972;
        bh=24QEhOa6b6pADby9FH9M7zyM17kAfwnL7p3AeNWQ2Do=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T+ZpZ34f3qOEaokTvoxoMTF88l6DJfHiEQsQztiKuQKQau+4qyzDTIRZx2XnXhhO0
         oOHj6mPHsWfWqy+lVk+GYxIDxo5PrOWrQR79YyvzOAt87wy/E8OwF1ylbIXm4buIci
         i5rR1EvzGPs1fiB7CuRVyRbkD06PMtv5tR3cz/6g=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 11 Oct 2018 07:59:32 +0530
From:   Arun KS <arunks@codeaurora.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        akpm@linux-foundation.org, dan.j.williams@intel.com,
        iamjoonsoo.kim@lge.com, gregkh@linuxfoundation.org,
        osalvador@suse.de, malat@debian.org,
        kirill.shutemov@linux.intel.com, jrdr.linux@gmail.com,
        yasu.isimatu@gmail.com, mgorman@techsingularity.net,
        aaron.lu@intel.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, vatsa@codeaurora.org,
        vinmenon@codeaurora.org, getarunks@gmail.com
Subject: Re: [PATCH v5 1/2] memory_hotplug: Free pages as higher order
In-Reply-To: <20181010173334.GL5873@dhcp22.suse.cz>
References: <1538727006-5727-1-git-send-email-arunks@codeaurora.org>
 <72215e75-6c7e-0aef-c06e-e3aba47cf806@suse.cz>
 <efb65160af41d0e18cb2dcb30c2fb86a@codeaurora.org>
 <20181010173334.GL5873@dhcp22.suse.cz>
Message-ID: <a2d576a5fc82cdf54fc89409686e58f5@codeaurora.org>
X-Sender: arunks@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-10 23:03, Michal Hocko wrote:
> On Wed 10-10-18 22:26:41, Arun KS wrote:
>> On 2018-10-10 21:00, Vlastimil Babka wrote:
>> > On 10/5/18 10:10 AM, Arun KS wrote:
>> > > When free pages are done with higher order, time spend on
>> > > coalescing pages by buddy allocator can be reduced. With
>> > > section size of 256MB, hot add latency of a single section
>> > > shows improvement from 50-60 ms to less than 1 ms, hence
>> > > improving the hot add latency by 60%. Modify external
>> > > providers of online callback to align with the change.
>> > >
>> > > Signed-off-by: Arun KS <arunks@codeaurora.org>
>> >
>> > [...]
>> >
>> > > @@ -655,26 +655,44 @@ void __online_page_free(struct page *page)
>> > >  }
>> > >  EXPORT_SYMBOL_GPL(__online_page_free);
>> > >
>> > > -static void generic_online_page(struct page *page)
>> > > +static int generic_online_page(struct page *page, unsigned int order)
>> > >  {
>> > > -	__online_page_set_limits(page);
>> >
>> > This is now not called anymore, although the xen/hv variants still do
>> > it. The function seems empty these days, maybe remove it as a followup
>> > cleanup?
>> >
>> > > -	__online_page_increment_counters(page);
>> > > -	__online_page_free(page);
>> > > +	__free_pages_core(page, order);
>> > > +	totalram_pages += (1UL << order);
>> > > +#ifdef CONFIG_HIGHMEM
>> > > +	if (PageHighMem(page))
>> > > +		totalhigh_pages += (1UL << order);
>> > > +#endif
>> >
>> > __online_page_increment_counters() would have used
>> > adjust_managed_page_count() which would do the changes under
>> > managed_page_count_lock. Are we safe without the lock? If yes, there
>> > should perhaps be a comment explaining why.
>> 
>> Looks unsafe without managed_page_count_lock.
> 
> Why does it matter actually? We cannot online/offline memory in
> parallel. This is not the case for the boot where we initialize memory
> in parallel on multiple nodes. So this seems to be safe currently 
> unless
> I am missing something. A comment explaining that would be helpful
> though.

Other main callers of adjust_manage_page_count(),

static inline void free_reserved_page(struct page *page)
{
         __free_reserved_page(page);
         adjust_managed_page_count(page, 1);
}

static inline void mark_page_reserved(struct page *page)
{
         SetPageReserved(page);
         adjust_managed_page_count(page, -1);
}

Won't they race with memory hotplug?

Few more,
./drivers/xen/balloon.c:519:            adjust_managed_page_count(page, 
-1);
./drivers/virtio/virtio_balloon.c:175:  adjust_managed_page_count(page, 
-1);
./drivers/virtio/virtio_balloon.c:196:  adjust_managed_page_count(page, 
1);
./mm/hugetlb.c:2158:                    adjust_managed_page_count(page, 
1 << h->order);

Regards,
Arun
