Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6698EC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B47E20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 22:28:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B47E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbeIZEht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:37:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:18709 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeIZEht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 00:37:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Sep 2018 15:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,303,1534834800"; 
   d="scan'208";a="94780930"
Received: from ahduyck-mobl.amr.corp.intel.com (HELO [10.7.198.152]) ([10.7.198.152])
  by orsmga002.jf.intel.com with ESMTP; 25 Sep 2018 15:27:59 -0700
Subject: Re: [PATCH v5 2/4] mm: Provide kernel parameter to allow disabling
 page init poisoning
To:     Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, mhocko@suse.com,
        dave.jiang@intel.com, jglisse@redhat.com, rppt@linux.vnet.ibm.com,
        dan.j.williams@intel.com, logang@deltatee.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
References: <20180925200551.3576.18755.stgit@localhost.localdomain>
 <20180925201921.3576.84239.stgit@localhost.localdomain>
 <13285e05-fb90-b948-6f96-777f94079657@intel.com>
 <8faf3acc-e47e-8ef9-a1a0-c0d6ebfafa1e@linux.intel.com>
 <75dde720-c997-51a4-d2e2-8b08eb201550@intel.com>
From:   Alexander Duyck <alexander.h.duyck@linux.intel.com>
Message-ID: <61358149-b233-6194-adcf-2c16b9112fd7@linux.intel.com>
Date:   Tue, 25 Sep 2018 15:27:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <75dde720-c997-51a4-d2e2-8b08eb201550@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/25/2018 3:14 PM, Dave Hansen wrote:
> On 09/25/2018 01:38 PM, Alexander Duyck wrote:
>> On 9/25/2018 1:26 PM, Dave Hansen wrote:
>>> On 09/25/2018 01:20 PM, Alexander Duyck wrote:
>>>> +    vm_debug[=options]    [KNL] Available with CONFIG_DEBUG_VM=y.
>>>> +            May slow down system boot speed, especially when
>>>> +            enabled on systems with a large amount of memory.
>>>> +            All options are enabled by default, and this
>>>> +            interface is meant to allow for selectively
>>>> +            enabling or disabling specific virtual memory
>>>> +            debugging features.
>>>> +
>>>> +            Available options are:
>>>> +              P    Enable page structure init time poisoning
>>>> +              -    Disable all of the above options
>>>
>>> Can we have vm_debug=off for turning things off, please?  That seems to
>>> be pretty standard.
>>
>> No. The simple reason for that is that you had requested this work like
>> the slub_debug. If we are going to do that then each individual letter
>> represents a feature. That is why the "-" represents off. We cannot have
>> letters represent flags, and letters put together into words. For
>> example slub_debug=OFF would turn on sanity checks and turn off
>> debugging for caches that would have causes higher minimum slab orders.
> 
> We don't have to have the same letters mean the same things for both
> options.  We also can live without 'o' and 'f' being valid.  We can
> *also* just say "don't do 'off'" if you want to enable things.

I'm not saying we do either. I would prefer it if we stuck to similar 
behavior though. If we are going to do a slub_debug style parameter then 
we should stick with similar behavior where "-" is used to indicate all 
features off.

> I'd much rather have vm_debug=off do the right thing than have
> per-feature enable/disable.  I know I'll *never* remember vm_debug=- and
> doing it this way will subject me to innumerable trips to Documentation/
> during my few remaining years.
> 
> Surely you can make vm_debug=off happen. :)

I could, but then it is going to confuse people even more. I really feel 
that if we want to do a slub_debug style interface we should use the 
same switch for turning off all the features that they do for slub_debug.

>>> we need to document the defaults.  I think the default is "all
>>> debug options are enabled", but it would be nice to document that.
>>
>> In the description I call out "All options are enabled by default, and this interface is meant to allow for selectively enabling or disabling".
> 
> I found "all options are enabled by default" really confusing.  Maybe:
> 
> "Control debug features which become available when CONFIG_DEBUG_VM=y.
> When this option is not specified, all debug features are enabled.  Use
> this option enable a specific subset."
> 
> Then, let's actually say what the options do, and what their impact is:
> 
> 	P	Enable 'struct page' poisoning at initialization.
> 		(Slows down boot time).
>

 From my perspective I just don't see how this changes much since it 
conveys the same message I had conveyed in my description. Since it 
looks like Andrew applied the patch feel free to submit your suggestion 
here as a follow-up patch and I would be willing to review/ack it.
