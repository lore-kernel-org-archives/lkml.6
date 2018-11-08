Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1862C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A53720857
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 02:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A53720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbeKHM3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 07:29:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:12839 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbeKHM3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 07:29:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 18:56:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,478,1534834800"; 
   d="scan'208";a="84192790"
Received: from unknown (HELO [10.239.13.114]) ([10.239.13.114])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2018 18:56:29 -0800
Message-ID: <5BE3A6FD.5040801@intel.com>
Date:   Thu, 08 Nov 2018 11:01:17 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     linux-kernel@vger.kernel.org
Subject: Re: virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON discussion
References: <286AC319A985734F985F78AFA26841F73DE40B6C@shsmsx102.ccr.corp.intel.com> <20181107102538-mutt-send-email-mst@kernel.org> <5BE3A430.7030505@intel.com> <20181107214929-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181107214929-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2018 10:50 AM, Michael S. Tsirkin wrote:
> On Thu, Nov 08, 2018 at 10:49:20AM +0800, Wei Wang wrote:
>> On 11/07/2018 11:27 PM, Michael S. Tsirkin wrote:
>>
>> + LKML
>>
>>> On Wed, Nov 07, 2018 at 02:29:02PM +0000, Wang, Wei W wrote:
>>>> Hi Michael,
>>>>
>>>>
>>>> Thanks again for reviewing so many versions of patches, and I learnt a lot from
>>>> your comments.
>>>>
>>>>
>>>> While I’m writing the virtio-balloon spec patches, I’m thinking probably we
>>>> don’t need VIRTIO_BALLOON_F_PAGE_POISON to limit
>>>> VIRTIO_BALLOON_F_FREE_PAGE_HINT, because now the guest frees the allocated
>>>> pages after the migration is done (that is, the skipped free pages will be
>>>> poisoned when the guest is already on the destination machine).
>>> The concern was this:
>>>
>>> guest poisons the page by writing a non-0 pattern there
>>> guest sends page to host
>>> VM is migrated, page is unmapped
>>> guest reads page, zero page is mapped
>> Not sure about this one: I think guest wouldn't read the page,
>> since they are held by balloon (balloon itself will also
>> not read it, the page just stays on a list waiting to be freed).
>> Please see the below example.
>>
>>> guest sees 0 in page and detects it as use after free
>>   - balloon collects (i.e. alloc) a free page X (now it
>>     has 0xaa poison value) and reports X to host to be skipped in
>>     migration;
>>   -  Now VM is migrated to the destination, and on the destination
>>      side, X is not mapped initially.
>>   -  Nobody will access X since it has been taken by balloon
>>      and stays on a list waiting to be freed. So the first chance
>>      that will get X mapped will be the moment that balloon
>>      returns X to mm via free(), as free() writes the
>>      poison value to X.
>>
>>
>> Best,
>> Wei
>
> Oh I see, that was with the previous design where we bypassed alloc.
> I think you are right, but better stress-test it.
>

Sure, will do.

Best,
Wei
