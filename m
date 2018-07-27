Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0E5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7038C20857
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7038C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeG0D3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:29:00 -0400
Received: from mga02.intel.com ([134.134.136.20]:56556 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731974AbeG0D3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:29:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2018 19:09:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,407,1526367600"; 
   d="scan'208";a="70311575"
Received: from unknown (HELO [10.239.13.97]) ([10.239.13.97])
  by orsmga003.jf.intel.com with ESMTP; 26 Jul 2018 19:09:26 -0700
Message-ID: <5B5A7FD9.2010105@intel.com>
Date:   Fri, 27 Jul 2018 10:13:45 +0800
From:   Wei Wang <wei.w.wang@intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Yury Norov <ynorov@caviumnetworks.com>
CC:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        corbet@lwn.net, linux@rasmusvillemoes.dk, dgilbert@redhat.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com> <20180726093728.GA9069@yury-thinkpad> <5B599F5F.2070705@intel.com> <20180726121042.GA11481@yury-thinkpad>
In-Reply-To: <20180726121042.GA11481@yury-thinkpad>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 08:10 PM, Yury Norov wrote:
> On Thu, Jul 26, 2018 at 06:15:59PM +0800, Wei Wang wrote:
>> External Email
>>
>> On 07/26/2018 05:37 PM, Yury Norov wrote:
>>> On Thu, Jul 26, 2018 at 04:07:51PM +0800, Wei Wang wrote:
>>>> The existing BITMAP_LAST_WORD_MASK macro returns 0xffffffff if nbits is
>>>> 0. This patch changes the macro to return 0 when there is no bit needs to
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
> But your patch doesn't remove external conditional, and it fact
> introduces overhead, right? Also, in some cases it's not so trivial to
> remove it. Consider __bitmap_intersects() for example.
>
> Anyway, this patch changes the very basic API. In that case you should
> check every user of the macro to be safe against the change, including
> possible performance downsides.
>
> If you find this corner case behavior of macro confusing, I think that
> the better option would be introducing detailed comment to the
> BITMAP_LAST_WORD_MASK(), or writing wrapper around it that handles
> nbits == 0 as you expect.
>

OK. Thanks Yury and Andy for the discussion. It seems the more preferred 
way is just to add comments as a note. Agree with that.

Best,
Wei


