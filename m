Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E0AC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D80320844
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 11:18:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D80320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388885AbeHGNcY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 09:32:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:20540 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388764AbeHGNcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 09:32:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 04:18:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,455,1526367600"; 
   d="scan'208";a="251997279"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by fmsmga005.fm.intel.com with ESMTP; 07 Aug 2018 04:18:21 -0700
Message-ID: <5B698106.5080806@intel.com>
Date:   Tue, 07 Aug 2018 19:22:46 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, dgilbert@redhat.com
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com> <20180726093728.GA9069@yury-thinkpad> <5B599F5F.2070705@intel.com> <08410774-8b10-d620-064c-fdf4399d7336@rasmusvillemoes.dk> <5B69445D.1000107@intel.com> <CAHp75VeQaHGaRgN8o1t7bA2BTjshZqO1GUO+D9BBqp1cVVrV2A@mail.gmail.com>
In-Reply-To: <CAHp75VeQaHGaRgN8o1t7bA2BTjshZqO1GUO+D9BBqp1cVVrV2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/2018 06:26 PM, Andy Shevchenko wrote:
>> Probably it's more clear to post the entire function here for a discussion:
>>
>> int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
>> {
>>          unsigned int k, lim = bits/BITS_PER_LONG;
>>          int w = 0;
>>
>>          for (k = 0; k < lim; k++)
>>                  w += hweight_long(bitmap[k]);
>>
>>          if (bits % BITS_PER_LONG)
>> ==>            w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
>>
>>          return w;
>> }
>>
>> When the execution reaches "==>", isn't "k=lim"?
> Let's check again, if bits == 0, bits % whatever == 0 as well, thus,
> no execution. When bits < BITS_PER_LONG, the execution is fine (k = 0
> and still 0).
> When bits >= BITS_PER_LONG, but not aligned, k goes from 0 to lim and
> last word is exactly the partially filled one. No problem here. Las
> case if bits % BITS_PER_LONG == 0, but hey, we have a guard against
> this.
>
> So, where is the problem exactly?

There is no problem here. All the discussions here are about if it is 
better to
1) put this guard to the macro or 2) have each callers to do it.

If we go with 2) as we discussed before, then do we need to add notes 
above the macro to people who will use/port this macro.


>
>>> OTOH, for nbits=0, there _is_ no last word (since there are no words at
>>> all), so by the time you want to apply the result of
>>> BITMAP_LAST_WORD_MASK(0) to anything, you already have a bug, probably
>>> either having read or being about to write into bitmap[0], which you
>>> cannot do. Please check that user-space port and see if there are bugs
>>> of that kind.
>> Yes, some callers there don't check for nbits=0, that's why I think it is
>> better to offload that check to the macro. The macro itself can be robust to
>> handle all the cases.
> Where they are? Can't you point out?

"there", I meant that user-space port, not in the kernel.
e.g.
Line 225 at https://github.com/qemu/qemu/blob/master/include/qemu/bitmap.h
(there are a couple of other places)

>> nbits=64, means all the 64 bits need to mask
>>
>> The two are different cases, I'm not sure why we let the macro to return the
>> same value.
> The point is macro mustn't be called when nbits==0.
>

Yes, I fully agree with that point, but it seems Rasmus NAK-ed that point.

To conclude the point of the discussion: with the current macro, there 
is no doc saying 0 can't be given to this macro and 
"BITMAP_LAST_WORD_MASK(0)=0xffffffff" doesn't seem correct to me.


Best,
Wei
