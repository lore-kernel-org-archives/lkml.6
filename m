Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8264DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 415FA27E6E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:27:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 415FA27E6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935972AbeF2L1o (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:27:44 -0400
Received: from mga14.intel.com ([192.55.52.115]:2039 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753805AbeF2L1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:27:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jun 2018 04:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="241335302"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2018 04:27:39 -0700
Message-ID: <5B36189E.5050204@intel.com>
Date:   Fri, 29 Jun 2018 19:31:42 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     David Hildenbrand <david@redhat.com>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org,
        akpm@linux-foundation.org
CC:     torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com, Andrea Arcangeli <aarcange@redhat.com>,
        Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com> <c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com> <5B35ACD5.4090800@intel.com> <4840cbb7-dd3f-7540-6a7c-13427de2f0d1@redhat.com>
In-Reply-To: <4840cbb7-dd3f-7540-6a7c-13427de2f0d1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 03:46 PM, David Hildenbrand wrote:
>>
>> I'm afraid it can't. For example, when we have a guest booted, without
>> too many memory activities. Assume the guest has 8GB free memory. The
>> arch_free_page there won't be able to capture the 8GB free pages since
>> there is no free() called. This results in no free pages reported to host.
>
> So, it takes some time from when the guest boots up until the balloon
> device was initialized and therefore page hinting can start. For that
> period, you won't get any arch_free_page()/page hinting callbacks, correct.
>
> However in the hypervisor, you can theoretically track which pages the
> guest actually touched ("dirty"), so you already know "which pages were
> never touched while booting up until virtio-balloon was brought to
> life". These, you can directly exclude from migration. No interface
> required.
>
> The remaining problem is pages that were touched ("allocated") by the
> guest during bootup but freed again, before virtio-balloon came up. One
> would have to measure how many pages these usually are, I would say it
> would not be that many (because recently freed pages are likely to be
> used again next for allocation). However, there are some pages not being
> reported.
>
> During the lifetime of the guest, this should not be a problem,
> eventually one of these pages would get allocated/freed again, so the
> problem "solves itself over time". You are looking into the special case
> of migrating the VM just after it has been started. But we have the
> exact same problem also for ordinary free page hinting, so we should
> rather solve that problem. It is not migration specific.
>
> If we are looking for an alternative to "problem solves itself",
> something like "if virtio-balloon comes up, it will report all free
> pages step by step using free page hinting, just like we would have from
> "arch_free_pages()"". This would be the same interface we are using for
> free page hinting - and it could even be made configurable in the guest.
>
> The current approach we are discussing internally for details about
> Nitesh's work ("how the magic inside arch_fee_pages() will work
> efficiently) would allow this as far as I can see just fine.
>
> There would be a tiny little window between virtio-balloon comes up and
> it has reported all free pages step by step, but that can be considered
> a very special corner case that I would argue is not worth it to be
> optimized.
>
> If I am missing something important here, sorry in advance :)
>

Probably I didn't explain that well. Please see my re-try:

That work is to monitor page allocation and free activities via 
arch_alloc_pages and arch_free_pages. It has per-CPU lists to record the 
pages that are freed to the mm free list, and the per-CPU lists dump the 
recorded pages to a global list when any of them is full.
So its own per-CPU list will only be able to get free pages when there 
is an mm free() function gets called. If we have 8GB free memory on the 
mm free list, but no application uses them and thus no mm free() calls 
are made. In that case, the arch_free_pages isn't called, and no free 
pages added to the per-CPU list, but we have 8G free memory right on the 
mm free list.
How would you guarantee the per-CPU lists have got all the free pages 
that the mm free lists have?

- I'm also worried about the overhead of maintaining so many per-CPU 
lists and the global list. For example, if we have applications 
frequently allocate and free 4KB pages, and each per-CPU list needs to 
implement the buddy algorithm to sort and merge neighbor pages. Today a 
server can have more than 100 CPUs, then there will be more than 100 
per-CPU lists which need to sync to a global list under a lock, I'm not 
sure if this would scale well.

- This seems to be a burden imposed on the core mm memory 
allocation/free path. The whole overhead needs to be carried during the 
whole system life cycle. What we actually expected is to just make one 
call to get the free page hints only when live migration happens.

Best,
Wei










