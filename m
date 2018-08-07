Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0817C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA9C2173F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA9C2173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbeHGJMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:12:32 -0400
Received: from mga03.intel.com ([134.134.136.65]:15907 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbeHGJMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:12:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2018 23:59:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,454,1526367600"; 
   d="scan'208";a="63145595"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2018 23:59:32 -0700
Message-ID: <5B69445D.1000107@intel.com>
Date:   Tue, 07 Aug 2018 15:03:57 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <ynorov@caviumnetworks.com>
CC:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        corbet@lwn.net, dgilbert@redhat.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com> <20180726093728.GA9069@yury-thinkpad> <5B599F5F.2070705@intel.com> <08410774-8b10-d620-064c-fdf4399d7336@rasmusvillemoes.dk>
In-Reply-To: <08410774-8b10-d620-064c-fdf4399d7336@rasmusvillemoes.dk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2018 07:30 AM, Rasmus Villemoes wrote:
> On 2018-07-26 12:15, Wei Wang wrote:
>> On 07/26/2018 05:37 PM, Yury Norov wrote:
>>> On Thu, Jul 26, 2018 at 04:07:51PM +0800, Wei Wang wrote:
>>>> The existing BITMAP_LAST_WORD_MASK macro returns 0xffffffff if nbits is
>>>> 0. This patch changes the macro to return 0 when there is no bit
>>>> needs to
>>>> be masked.
>>> I think this is intentional behavour. Previous version did return ~0UL
>>> explicitly in this case. See patch 89c1e79eb3023 (linux/bitmap.h: improve
>>> BITMAP_{LAST,FIRST}_WORD_MASK) from Rasmus.
>> Yes, I saw that. But it seems confusing for the corner case that nbits=0
>> (no bits to mask), the macro returns with all the bits set.
>>
>>
>>> Introducing conditional branch would affect performance. All existing
>>> code checks nbits for 0 before handling last word where needed
>>> explicitly. So I think we'd better change nothing here.
>> I think that didn't save the conditional branch essentially, because
>> it's just moved from inside this macro to the caller as you mentioned.
>> If callers missed the check for some reason and passed 0 to the macro,
>> they will get something unexpected.
>>
>> Current callers like __bitmap_weight, __bitmap_equal, and others, they have
>>
>> if (bits % BITS_PER_LONG)
>>      w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
>>
>> we could remove the "if" check by "w += hweight_long(bitmap[k] &
>> BITMAP_LAST_WORD_MASK(bits % BITS_PER_LONG));" the branch is the same.
> Absolutely not! That would access bitmap[lim] (the final value of the k
> variable) despite that word not being part of the bitmap.

Probably it's more clear to post the entire function here for a discussion:

int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
{
         unsigned int k, lim = bits/BITS_PER_LONG;
         int w = 0;

         for (k = 0; k < lim; k++)
                 w += hweight_long(bitmap[k]);

         if (bits % BITS_PER_LONG)
==>            w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));

         return w;
}

When the execution reaches "==>", isn't "k=lim"?

For example, assume bits = 70, then the point of that line is to check 
the remaining 6 bits (i.e. 70 % 64).

* BITMAP_LAST_WORD_MASK(70) is effectively the same as 
BITMAP_LAST_WORD_MASK(6).

If having doubts about the * statement above, please check below the old 
implementation (replaced by 89c1e79eb3), which has a more 
straightforward logic to understand

#define BITMAP_LAST_WORD_MASK(nbits)                                   \
( \
        ((nbits) % BITS_PER_LONG) ?                                     \
                (1UL<<((nbits) % BITS_PER_LONG))-1 : ~0UL               \
)

I think having the branch in the macro would be much easier than having 
it in each caller.

>
> More generally, look at the name of the macro: last_word_mask. It's a
> mask to apply to the last word of a bitmap. If the bitmap happens to
> consist of a multiple of BITS_PER_LONG bits, than that mask is and must
> be ~0UL. So for nbits=64, 128, etc., that is what we want.

For nbits=64, it is correct to return ~0UL, since it just asks to check 
all the remaining 64 bits, thus keeping the entire 64 bits set.

> OTOH, for nbits=0, there _is_ no last word (since there are no words at
> all), so by the time you want to apply the result of
> BITMAP_LAST_WORD_MASK(0) to anything, you already have a bug, probably
> either having read or being about to write into bitmap[0], which you
> cannot do. Please check that user-space port and see if there are bugs
> of that kind.

Yes, some callers there don't check for nbits=0, that's why I think it 
is better to offload that check to the macro. The macro itself can be 
robust to handle all the cases.


>
> So no, the existing users of BITMAP_LAST_WORD_MASK do not check for
> nbits being zero, they check for whether there is a partial last word,
> which is something different.

Yes, but "partial" could be "0". If the macro doesn't handle that case, 
I think that wouldn't be a robust macro.

We shouldn't assume how the callers will use this macro. Please check 
bitmap_shift_right, I think the bug is already there:

         if (small_const_nbits(nbits))
                 *dst = (*src & BITMAP_LAST_WORD_MASK(nbits)) >> shift;

  *dst should be 0 if nbits=0, but nbits=0 will pass the 
small_const_nbits(nbits) check above, and BITMAP_LAST_WORD_MASK(0) 
returning 0xffffffff will take *src value to *dst.


> And they mostly (those in lib/bitmap.c) do
> that because they've already handled _all_ the full words. Then there
> are some users in include/linux/bitmap.h, that check for
> small_const_nbits(nbits), and in those cases, we really want ~0UL when
> nbits is BITS_PER_LONG, because small_const_nbits implies there is
> exactly one word. Yeah, there's an implicit assumption that the bitmap
> routines are never called with a compile-time constant nbits==0 (see the
> unconditional accesses to *src and *dst), but changing the semantics of
> BITMAP_LAST_WORD_MASK and making it return different values for nbits=0
> vs nbits=64 wouldn't fix that latent bug.

nbits=0, means there is no bit needs to mask
nbits=64, means all the 64 bits need to mask

The two are different cases, I'm not sure why we let the macro to return 
the same value.


Best,
Wei
