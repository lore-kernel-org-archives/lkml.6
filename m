Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E063C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 436D0208EC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436D0208EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732397AbeGKB00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:26:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:65096 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732278AbeGKB0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:26:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 18:24:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,336,1526367600"; 
   d="scan'208";a="71285064"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2018 18:24:38 -0700
Message-ID: <5B455D50.90902@intel.com>
Date:   Wed, 11 Jul 2018 09:28:48 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com> <1531215067-35472-2-git-send-email-wei.w.wang@intel.com> <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
In-Reply-To: <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2018 01:33 AM, Linus Torvalds wrote:
> NAK.
>
> On Tue, Jul 10, 2018 at 2:56 AM Wei Wang <wei.w.wang@intel.com> wrote:
>> +
>> +       buf_page = list_first_entry_or_null(pages, struct page, lru);
>> +       if (!buf_page)
>> +               return -EINVAL;
>> +       buf = (__le64 *)page_address(buf_page);
> Stop this garbage.
>
> Why the hell would you pass in some crazy "liost of pages" that uses
> that lru list?
>
> That's just insane shit.
>
> Just pass in a an array to fill in. No idiotic games like this with
> odd list entries (what's the locking?) and crazy casting to
>
> So if you want an array of page addresses, pass that in as such. If
> you want to do it in a page, do it with
>
>      u64 *array = page_address(page);
>      int nr = PAGE_SIZE / sizeof(u64);
>
> and now you pass that array in to the thing. None of this completely
> insane crazy crap interfaces.
>
> Plus, I still haven't heard an explanation for why you want so many
> pages in the first place, and why you want anything but MAX_ORDER-1.

Sorry for missing that explanation.
We only get addresses of the "MAX_ORDER-1" blocks into the array. The 
max size of the array that could be allocated by kmalloc is 
KMALLOC_MAX_SIZE (i.e. 4MB on x86). With that max array, we could load 
"4MB / sizeof(u64)" addresses of "MAX_ORDER-1" blocks, that is, 2TB free 
memory at most. We thought about removing that 2TB limitation by passing 
in multiple such max arrays (a list of them).

But 2TB has been enough for our use cases so far, and agree it would be 
better to have a simpler API in the first place. So I plan to go back to 
the previous version of just passing in one simple array 
(https://lkml.org/lkml/2018/6/15/21) if no objections.

Best,
Wei
