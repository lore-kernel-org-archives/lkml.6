Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5F4C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2670254FB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 01:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2670254FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934692AbeF0BUU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 21:20:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:60837 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933940AbeF0BUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 21:20:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 18:20:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,277,1526367600"; 
   d="scan'208";a="66619754"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga004.fm.intel.com with ESMTP; 26 Jun 2018 18:20:16 -0700
Message-ID: <5B32E742.8080902@intel.com>
Date:   Wed, 27 Jun 2018 09:24:18 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com,
        peterx@redhat.com
Subject: Re: [PATCH v34 2/4] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com> <1529928312-30500-3-git-send-email-wei.w.wang@intel.com> <20180626002822-mutt-send-email-mst@kernel.org> <5B31B71B.6080709@intel.com> <20180626064338-mutt-send-email-mst@kernel.org> <5B323140.1000306@intel.com> <20180626163139-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180626163139-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 09:34 PM, Michael S. Tsirkin wrote:
> On Tue, Jun 26, 2018 at 08:27:44PM +0800, Wei Wang wrote:
>> On 06/26/2018 11:56 AM, Michael S. Tsirkin wrote:
>>> On Tue, Jun 26, 2018 at 11:46:35AM +0800, Wei Wang wrote:
>>>
>>>>>> +	if (!arrays)
>>>>>> +		return NULL;
>>>>>> +
>>>>>> +	for (i = 0; i < max_array_num; i++) {
>>>>> So we are getting a ton of memory here just to free it up a bit later.
>>>>> Why doesn't get_from_free_page_list get the pages from free list for us?
>>>>> We could also avoid the 1st allocation then - just build a list
>>>>> of these.
>>>> That wouldn't be a good choice for us. If we check how the regular
>>>> allocation works, there are many many things we need to consider when pages
>>>> are allocated to users.
>>>> For example, we need to take care of the nr_free
>>>> counter, we need to check the watermark and perform the related actions.
>>>> Also the folks working on arch_alloc_page to monitor page allocation
>>>> activities would get a surprise..if page allocation is allowed to work in
>>>> this way.
>>>>
>>> mm/ code is well positioned to handle all this correctly.
>> I'm afraid that would be a re-implementation of the alloc functions,
> A re-factoring - you can share code. The main difference is locking.
>
>> and
>> that would be much more complex than what we have. I think your idea of
>> passing a list of pages is better.
>>
>> Best,
>> Wei
> How much memory is this allocating anyway?
>

For every 2TB memory that the guest has, we allocate 4MB. This is the 
same for both cases.
For today's guests, usually there will be only one 4MB allocated and 
passed to get_from_free_page_list.

Best,
Wei



