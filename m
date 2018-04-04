Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeDDIL1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:11:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58726 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751247AbeDDILZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:11:25 -0400
From: David Hildenbrand <david@redhat.com>
Subject: KVM: Questions regarding page_track and memory slots
Organization: Red Hat GmbH
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        David Airlie <airlied@linux.ie>, intel-gvt-dev@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: KVM <kvm@vger.kernel.org>
Message-ID: <00af67c0-ee62-7925-0ba4-63c31c4334f3@redhat.com>
Date: Wed, 4 Apr 2018 10:10:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can see that we allocate under x86 for each KVM memslot
"sizeof(unsigned short) * npages" for page_track.

So 1 byte for each 4096 bytes of memory slot size. This doesn't sound a
lot, but if we have very big memory slots (e.g. for NVDIMM), this can
quickly get out of hand. E.g. for 4TB, we would need 1GB. And this just
means somebody created a big memory slot, not even memory would have to
be populated in that slot.

I can see that the only user is right now kvmgt. My assumption is, that
only a fraction of all memory will be tracked.


1. Do we actually need to track on a per-page level, how many trackers
we have? Is it a valid use case that multiple users track the same page?
(e.g. can't we simply use a bitmap)

2. Is my assumption, that this is actually a sparse "bitmap" true?
Wouldn't something like a radix tree, that grows with the number of
tracked pages, be a better fit?


I am looking right now into creating big memory slots and only assigning
a portion at a time to the guest. So initially, most parts of the big
memory slot would not be accessible by the guest and would not have
backing pages. Of course, I want to minimize the involved size of the
memory slot. An alternative is growing a memory slot atomically. Of
course, the current state of page-track is also a problem for growing a
memory slot atomically (having to copy/grow the array).

Thanks or any insight.

-- 

Thanks,

David / dhildenb
