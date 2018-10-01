Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5527C00449
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8714E2089A
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 15:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8714E2089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbeJAWTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:19:33 -0400
Received: from mga01.intel.com ([192.55.52.88]:27786 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeJAWTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:19:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 08:41:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,328,1534834800"; 
   d="scan'208";a="78950359"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.166]) ([10.7.198.166])
  by orsmga006.jf.intel.com with ESMTP; 01 Oct 2018 08:41:08 -0700
Subject: Re: [PATCH] libnvdimm, dimm: Maximize label transfer size
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <153816098159.2233877.8382846671636531035.stgit@dwillia2-desk3.amr.corp.intel.com>
 <3cf89dd3-a024-dbab-36ed-923f9466669c@linux.intel.com>
 <CAPcyv4hi7XLAswcoWEKOcQq_0FCTybxTUd_4H+mJj0S7BkTCjg@mail.gmail.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <9f24ed83-5fea-da70-5470-36992b90c521@linux.intel.com>
Date:   Mon, 1 Oct 2018 08:41:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hi7XLAswcoWEKOcQq_0FCTybxTUd_4H+mJj0S7BkTCjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/2018 4:03 PM, Dan Williams wrote:
> On Fri, Sep 28, 2018 at 3:44 PM Alexander Duyck
> <alexander.h.duyck@linux.intel.com> wrote:
>>
>> On 9/28/2018 11:56 AM, Dan Williams wrote:
>>> Use kvzalloc() to bypass the arbitrary PAGE_SIZE limit of label transfer
>>> operations. Given the expense of calling into firmware, maximize the
>>> amount of label data we transfer per call to be up to the total label
>>> space if allowed by the firmware.
>>>
>>> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> This looks mostly fine to me.
>>
>> The only thing I am not certain about is if we want to use the raw
>> max_cmd_size value or not since there is no guarantee it is aligned to
>> any sort of boundary. It might be beneficial to either cache line align
>> it or align it to 256B if it is larger than that since that way we at
>> least would be getting full labels instead of partial ones.
> 
> If we leave any portion of the max transfer size unused it just means
> we're that much more likely to need an additional call into the ASL
> interpreter. That said It might be worthwhile capping the max transfer
> size in case the BIOS specifies something extreme (> 1MB) in the
> future.

Actually it all depends on the size of the max transfer versus the size 
of the label area. So for example if the label area is 128K and the max 
transfer size is 64K minus 32 then it doesn't really make much 
difference until we get below 44K for our max read size.

My main concern is that I don't want to waste resources on allocating 
memory that isn't needed. For smaller allocations I agree we need to use 
everything we have to minimize calls to the ASL interpreter, but when 
max transfer sizes start getting large we are just allocating multiple 
pages of memory that do not need to be used.

If nothing else I can look at doing the logic to reduce our memory 
allocations as a set of follow-up patches.

- Alex
