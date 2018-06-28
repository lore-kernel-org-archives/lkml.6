Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87FCC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98A66270DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 08:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A66270DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752841AbeF1Ifd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 04:35:33 -0400
Received: from mga02.intel.com ([134.134.136.20]:3430 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbeF1Ifb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 04:35:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2018 01:35:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,282,1526367600"; 
   d="scan'208";a="67988176"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga001.fm.intel.com with ESMTP; 28 Jun 2018 01:35:27 -0700
Message-ID: <5B349EC2.80207@intel.com>
Date:   Thu, 28 Jun 2018 16:39:30 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v33 1/4] mm: add a function to get free page blocks
References: <1529037793-35521-1-git-send-email-wei.w.wang@intel.com> <1529037793-35521-2-git-send-email-wei.w.wang@intel.com> <CA+55aFzhuGKinEq5udPsk_uYHShkQxJYqcPO=tLCkT-oxpsgPg@mail.gmail.com> <20180626045118-mutt-send-email-mst@kernel.org> <CA+55aFwFpDPvfL=KPdabO-x1r0FnwpfPk5oN8+e01TKqAPNYbw@mail.gmail.com> <20180627220402-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180627220402-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/2018 03:07 AM, Michael S. Tsirkin wrote:
> On Wed, Jun 27, 2018 at 09:05:39AM -0700, Linus Torvalds wrote:
>> [ Sorry for slow reply, my travels have made a mess of my inbox ]
>>
>> On Mon, Jun 25, 2018 at 6:55 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>>> Linus, do you think it would be ok to have get_from_free_page_list
>>> actually pop entries from the free list and use them as the buffer
>>> to store PAs?
>> Honestly, what I think the best option would be is to get rid of this
>> interface *entirely*, and just have the balloon code do
>>
>>      #define GFP_MINFLAGS (__GFP_NORETRY | __GFP_NOWARN |
>> __GFP_THISNODE | __GFP_NOMEMALLOC)
>>
>>      struct page *page =  alloc_pages(GFP_MINFLAGS, MAX_ORDER-1);
>>
>>   which is not a new interface, and simply removes the max-order page
>> from the list if at all possible.
>>
>> The above has the advantage of "just working", and not having any races.
>>
>> Now, because you don't want to necessarily *entirely* deplete the max
>> order, I'd suggest that the *one* new interface you add is just a "how
>> many max-order pages are there" interface. So then you can query
>> (either before or after getting the max-order page) just how many of
>> them there were and whether you want to give that page back.
>>
>> Notice? No need for any page lists or physical addresses. No races. No
>> complex new functions.
>>
>> The physical address you can just get from the "struct page" you got.
>>
>> And if you run out of memory because of getting a page, you get all
>> the usual "hey, we ran out of memory" responses..
>>
>> Wouldn't the above be sufficient?
>>
>>              Linus


Thanks for the elaboration.

> I think so, thanks!
>
> Wei, to put it in balloon terms, I think there's one thing we missed: if
> you do manage to allocate a page, and you don't have a use for it, then
> hey, you can just give it to the host because you know it's free - you
> are going to return it to the free list.
>

I'm not sure if this would be better than Linus' previous suggestion, 
because live migration is expected to be performed without disturbing 
the guest. If we do allocation to get all the free pages at all 
possible, then the guest applications would be seriously affected. For 
example, the network would become very slow as the allocation of sk_buf 
often triggers OOM during live migration. If live migration happens from 
time to time, and users try memory related tools like "free -h" on the 
guest, the reported statistics (e.g. the fee memory becomes very low 
abruptly due to the balloon allocation) would confuse them.

With the previous suggestion, we only get hints of the free pages (i.e. 
just report the address of free pages to host without taking them off 
the list).

Best,
Wei
