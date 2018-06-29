Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42EAC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8866727AB2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 03:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8866727AB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965595AbeF2Drv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 23:47:51 -0400
Received: from mga07.intel.com ([134.134.136.100]:37829 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935137AbeF2Drt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 23:47:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 20:47:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,285,1526367600"; 
   d="scan'208";a="52766273"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by orsmga007.jf.intel.com with ESMTP; 28 Jun 2018 20:47:46 -0700
Message-ID: <5B35ACD5.4090800@intel.com>
Date:   Fri, 29 Jun 2018 11:51:49 +0800
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
        peterx@redhat.com
Subject: Re: [PATCH v34 0/4] Virtio-balloon: support free page reporting
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com> <c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com>
In-Reply-To: <c4dd0a13-91fb-c0f5-b41f-54421fdacca9@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/27/2018 07:06 PM, David Hildenbrand wrote:
> On 25.06.2018 14:05, Wei Wang wrote:
>> This patch series is separated from the previous "Virtio-balloon
>> Enhancement" series. The new feature, VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>> implemented by this series enables the virtio-balloon driver to report
>> hints of guest free pages to the host. It can be used to accelerate live
>> migration of VMs. Here is an introduction of this usage:
>>
>> Live migration needs to transfer the VM's memory from the source machine
>> to the destination round by round. For the 1st round, all the VM's memory
>> is transferred. From the 2nd round, only the pieces of memory that were
>> written by the guest (after the 1st round) are transferred. One method
>> that is popularly used by the hypervisor to track which part of memory is
>> written is to write-protect all the guest memory.
>>
>> This feature enables the optimization by skipping the transfer of guest
>> free pages during VM live migration. It is not concerned that the memory
>> pages are used after they are given to the hypervisor as a hint of the
>> free pages, because they will be tracked by the hypervisor and transferred
>> in the subsequent round if they are used and written.
>>
>> * Tests
>> - Test Environment
>>      Host: Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz
>>      Guest: 8G RAM, 4 vCPU
>>      Migration setup: migrate_set_speed 100G, migrate_set_downtime 2 second
>>
>> - Test Results
>>      - Idle Guest Live Migration Time (results are averaged over 10 runs):
>>          - Optimization v.s. Legacy = 284ms vs 1757ms --> ~84% reduction
>>      - Guest with Linux Compilation Workload (make bzImage -j4):
>>          - Live Migration Time (average)
>>            Optimization v.s. Legacy = 1402ms v.s. 2528ms --> ~44% reduction
>>          - Linux Compilation Time
>>            Optimization v.s. Legacy = 5min6s v.s. 5min12s
>>            --> no obvious difference
>>
> Being in version 34 already, this whole thing still looks and feels like
> a big hack to me. It might just be me, but especially if I read about
> assumptions like "QEMU will not hotplug memory during migration". This
> does not feel like a clean solution.
>
> I am still not sure if we really need this interface, especially as real
> free page hinting might be on its way.
>
> a) we perform free page hinting by setting all free pages
> (arch_free_page()) to zero. Migration will detect zero pages and
> minimize #pages to migrate. I don't think this is a good idea but Michel
> suggested to do a performance evaluation and Nitesh is looking into that
> right now.

The hypervisor doesn't get the zero pages for free. It pays lots of CPU 
utilization and memory bandwidth (there are some guys complaining abut 
this on the QEMU mailinglist)
In the above results, the legacy part already has the zero page feature 
in use.

>
> b) we perform free page hinting using something that Nitesh proposed. We
> get in QEMU blocks of free pages that we can MADV_FREE. In addition we
> could e.g. clear the dirty bit of these pages in the dirty bitmap, to
> hinder them from getting migrated. Right now the hinting mechanism is
> synchronous (called from arch_free_page()) but we might be able to
> convert it into something asynchronous.
>
> So we might be able to completely get rid of this interface. And looking
> at all the discussions and problems that already happened during the
> development of this series, I think we should rather look into how clean
> free page hinting might solve the same problem.
>
> If it can't be solved using free page hinting, fair enough.
>

I'm afraid it can't. For example, when we have a guest booted, without 
too many memory activities. Assume the guest has 8GB free memory. The 
arch_free_page there won't be able to capture the 8GB free pages since 
there is no free() called. This results in no free pages reported to host.

Best,
Wei
