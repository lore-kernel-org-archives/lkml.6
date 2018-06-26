Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B41C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A5D226709
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 12:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5D226709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935096AbeFZMXr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 08:23:47 -0400
Received: from mga14.intel.com ([192.55.52.115]:58491 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933509AbeFZMXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 08:23:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 05:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,274,1526367600"; 
   d="scan'208";a="51997031"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by orsmga007.jf.intel.com with ESMTP; 26 Jun 2018 05:23:42 -0700
Message-ID: <5B323140.1000306@intel.com>
Date:   Tue, 26 Jun 2018 20:27:44 +0800
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
References: <1529928312-30500-1-git-send-email-wei.w.wang@intel.com> <1529928312-30500-3-git-send-email-wei.w.wang@intel.com> <20180626002822-mutt-send-email-mst@kernel.org> <5B31B71B.6080709@intel.com> <20180626064338-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180626064338-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/26/2018 11:56 AM, Michael S. Tsirkin wrote:
> On Tue, Jun 26, 2018 at 11:46:35AM +0800, Wei Wang wrote:
>

>>
>>>
>>>> +	if (!arrays)
>>>> +		return NULL;
>>>> +
>>>> +	for (i = 0; i < max_array_num; i++) {
>>> So we are getting a ton of memory here just to free it up a bit later.
>>> Why doesn't get_from_free_page_list get the pages from free list for us?
>>> We could also avoid the 1st allocation then - just build a list
>>> of these.
>> That wouldn't be a good choice for us. If we check how the regular
>> allocation works, there are many many things we need to consider when pages
>> are allocated to users.
>> For example, we need to take care of the nr_free
>> counter, we need to check the watermark and perform the related actions.
>> Also the folks working on arch_alloc_page to monitor page allocation
>> activities would get a surprise..if page allocation is allowed to work in
>> this way.
>>
> mm/ code is well positioned to handle all this correctly.

I'm afraid that would be a re-implementation of the alloc functions, and 
that would be much more complex than what we have. I think your idea of 
passing a list of pages is better.

Best,
Wei






