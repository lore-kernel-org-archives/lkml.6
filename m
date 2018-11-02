Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B411C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8D3A2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D3A2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbeKCGDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 02:03:49 -0400
Received: from mga11.intel.com ([192.55.52.93]:45897 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728193AbeKCGDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 02:03:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 13:55:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,457,1534834800"; 
   d="scan'208";a="102987150"
Received: from kohsamui.iil.intel.com (HELO [10.236.193.12]) ([10.236.193.12])
  by fmsmga004.fm.intel.com with ESMTP; 02 Nov 2018 13:55:03 -0700
Subject: Re: lib/genalloc
To:     Daniel Mentz <danielmentz@google.com>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.co>,
        lkml <linux-kernel@vger.kernel.org>, labbott@redhat.com
References: <a170cf65-6884-3592-1de9-4c235888cc8a@intel.com>
 <4DECD467-AD45-419D-8F0F-1456863274FD@raithlin.com>
 <d127f28f-71fe-c175-c0e4-a368ff1d01a1@intel.com>
 <CAE2F3rBifp4y=WQFC6CTcYtPUFyvLD4ZZMrZSzu4P+Fzot_f0A@mail.gmail.com>
From:   Alexey Skidanov <alexey.skidanov@intel.com>
Message-ID: <de2e1756-329b-7df2-559e-a603a7edc2ff@intel.com>
Date:   Fri, 2 Nov 2018 22:56:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAE2F3rBifp4y=WQFC6CTcYtPUFyvLD4ZZMrZSzu4P+Fzot_f0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/18 9:17 PM, Daniel Mentz wrote:
> On Thu, Nov 1, 2018 at 10:07 AM Alexey Skidanov
> <alexey.skidanov@intel.com> wrote:
>> On 11/1/18 18:48, Stephen  Bates wrote:
>>>>    I use gen_pool_first_fit_align() as pool allocation algorithm allocating
>>>>    buffers with requested alignment. But if a chunk base address is not
>>>>    aligned to the requested alignment(from some reason), the returned
>>>>    address is not aligned too.
>>>
>>> Alexey
>>>
>>> Can you try using gen_pool_first_fit_order_align()? Will that give you the alignment you need?
>>>
>>> Stephen
>>>
>>>
>> I think it will not help me. Let's assume that the chunk base address is
>> 0x2F400000 and I want to allocate 16MB aligned buffer. I get back the
>> 0x2F400000. I think it happens because of this string in the
>> gen_pool_alloc_algo():
>>
>> addr = chunk->start_addr + ((unsigned long)start_bit << order);
>>
>> and the gen_pool_first_fit_align() implementation that doesn't take into
>> account the "incorrect" chunk base alignment.
> 
> gen_pool_first_fit_align() has no information about the chunk base
> alignment. Hence, it can't take it into account.
> 
> How do you request the alignment in your code?
> 
> I agree with your analysis that gen_pool_first_fit_align() performs
> alignment only with respect to the start of the chunk not the memory
> address that gen_pool_alloc_algo() returns. I guess a solution would
> be to only add chunks that satisfy all your alignment requirements. In
> your case, you must only add chunks that are 16MB aligned.
> I am unsure whether this is by design, but I believe it's the way that
> the code currently works.
> 

Daniel,

I think the better solution is to use bitmap_find_next_zero_area_off()
that receives the bit offset (CMA allocator uses it to solve the same
issue). Of course, we need to pass the chunk base address to the
gen_pool_first_fit_align().

What do you think?

Thanks,
Alexey
