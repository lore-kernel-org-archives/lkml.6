Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FBEC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D2B22198F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D2B22198F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388737AbeHGJXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:23:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:16726 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728157AbeHGJXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:23:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 00:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,454,1526367600"; 
   d="scan'208";a="246777172"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by orsmga005.jf.intel.com with ESMTP; 07 Aug 2018 00:10:54 -0700
Message-ID: <5B694706.9080404@intel.com>
Date:   Tue, 07 Aug 2018 15:15:18 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <ynorov@caviumnetworks.com>
CC:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        corbet@lwn.net, dgilbert@redhat.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com> <20180726093728.GA9069@yury-thinkpad> <5B599F5F.2070705@intel.com> <08410774-8b10-d620-064c-fdf4399d7336@rasmusvillemoes.dk> <5B69445D.1000107@intel.com>
In-Reply-To: <5B69445D.1000107@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2018 03:03 PM, Wei Wang wrote:
> On 08/07/2018 07:30 AM, Rasmus Villemoes wrote:
>> On 2018-07-26 12:15, Wei Wang wrote:
>>> On 07/26/2018 05:37 PM, Yury Norov wrote:
>>>> On Thu, Jul 26, 2018 at 04:07:51PM +0800, Wei Wang wrote:
>>>>> The existing BITMAP_LAST_WORD_MASK macro returns 0xffffffff if 
>>>>> nbits is
>>>>> 0. This patch changes the macro to return 0 when there is no bit
>>>>> needs to
>>>>> be masked.
>>>> I think this is intentional behavour. Previous version did return ~0UL
>>>> explicitly in this case. See patch 89c1e79eb3023 (linux/bitmap.h: 
>>>> improve
>>>> BITMAP_{LAST,FIRST}_WORD_MASK) from Rasmus.
>>> Yes, I saw that. But it seems confusing for the corner case that 
>>> nbits=0
>>> (no bits to mask), the macro returns with all the bits set.
>>>
>>>
>>>> Introducing conditional branch would affect performance. All existing
>>>> code checks nbits for 0 before handling last word where needed
>>>> explicitly. So I think we'd better change nothing here.
>>> I think that didn't save the conditional branch essentially, because
>>> it's just moved from inside this macro to the caller as you mentioned.
>>> If callers missed the check for some reason and passed 0 to the macro,
>>> they will get something unexpected.
>>>
>>> Current callers like __bitmap_weight, __bitmap_equal, and others, 
>>> they have
>>>
>>> if (bits % BITS_PER_LONG)
>>>      w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
>>>
>>> we could remove the "if" check by "w += hweight_long(bitmap[k] &
>>> BITMAP_LAST_WORD_MASK(bits % BITS_PER_LONG));" the branch is the same.
>> Absolutely not! That would access bitmap[lim] (the final value of the k
>> variable) despite that word not being part of the bitmap.
>
> Probably it's more clear to post the entire function here for a 
> discussion:
>
> int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
> {
>         unsigned int k, lim = bits/BITS_PER_LONG;
>         int w = 0;
>
>         for (k = 0; k < lim; k++)
>                 w += hweight_long(bitmap[k]);
>
>         if (bits % BITS_PER_LONG)
> ==>            w += hweight_long(bitmap[k] & 
> BITMAP_LAST_WORD_MASK(bits));
>
>         return w;
> }
>
> When the execution reaches "==>", isn't "k=lim"?

And accessing to bitmap[lim] which does not exist should be a case 
considered by the caller rather than the macro. For example, with 
"BITMAP_LAST_WORD_MASK(bits) & bitmap[k]", making 
BITMAP_LAST_WORD_MASK(0) be 0 will not be a problem.
Anyway, my point is that we could make the macro itself robust.

Best,
Wei
