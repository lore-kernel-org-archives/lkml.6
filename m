Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9321CC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB7F21A13
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 23:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="LFs+weJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB7F21A13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbeHGBmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 21:42:25 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38228 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731432AbeHGBmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 21:42:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so6017644edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 16:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=neZ8FFXpRkV9UxAb1tTs660M5XglbrWKf/vAekDUMOM=;
        b=LFs+weJZO+phYkViY1ExlR1CYRBlUDkHtWsxqjlmUXIAuqx++YqA3sYRGxa5BY1ZCn
         gDev/7x5wtItPXZHi/vvXMsSRuFJX5c/rUyE41T4OvX6rfG5TGCxSubeVOHitpW3ki8v
         yMGC3Vf7NzRRBRRR8ypO5SbdEsk+6+IRa24CE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=neZ8FFXpRkV9UxAb1tTs660M5XglbrWKf/vAekDUMOM=;
        b=G+j4HHEfUca9rBgqoS4fYJ6qmmft6oOYd32CKLPWvc3CdBLp6QuJY43nX+oarZ2FOP
         dPwGakM8xAKoFtlCixnXvdncChKYPLDh/4JpF2rznLZgwa7lXfwkoDAgb6hCCWxXTGsb
         PcBU5/8WGXlALq3ZAsQP1MKHldDZ78Z+YJiByR8sqxGVIC+7MKNiL0k66aJoqGngRhjB
         kUVArUpvwAztE2sO8FO3ChbMRamIWeceVpKhFa5KK1KxAa0+C000AKopODIhtRBLVJr3
         O53DebCl+TT0IY5VlRBeV6PMx0OqFwcm9KuQnQMPR6Y5XkfAziX999lR0Ptvabbsbsy/
         CvXw==
X-Gm-Message-State: AOUpUlHZcnihb3X1cGSKZXHtMma32PaaPM1foHT0x/0MjVZQ/DonHtNn
        03BDCZMh7md2fb91OKxvZAC9SA==
X-Google-Smtp-Source: AAOMgpf5OVP7MPSuCgiwT8LFZvYIE016ZCXgrC1byc6X2+PuR2Aq6nf+Tt3GhlhNmCZc98j/D9gqyA==
X-Received: by 2002:a50:8c06:: with SMTP id p6-v6mr19976952edp.282.1533598258496;
        Mon, 06 Aug 2018 16:30:58 -0700 (PDT)
Received: from [192.168.0.189] (dhcp-5-186-126-104.cgn.ip.fibianet.dk. [5.186.126.104])
        by smtp.gmail.com with ESMTPSA id h10-v6sm27478edb.51.2018.08.06.16.30.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 16:30:57 -0700 (PDT)
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
To:     Wei Wang <wei.w.wang@intel.com>,
        Yury Norov <ynorov@caviumnetworks.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        corbet@lwn.net, dgilbert@redhat.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com>
 <20180726093728.GA9069@yury-thinkpad> <5B599F5F.2070705@intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <08410774-8b10-d620-064c-fdf4399d7336@rasmusvillemoes.dk>
Date:   Tue, 7 Aug 2018 01:30:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5B599F5F.2070705@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-26 12:15, Wei Wang wrote:
> On 07/26/2018 05:37 PM, Yury Norov wrote:
>> On Thu, Jul 26, 2018 at 04:07:51PM +0800, Wei Wang wrote:
>>> The existing BITMAP_LAST_WORD_MASK macro returns 0xffffffff if nbits is
>>> 0. This patch changes the macro to return 0 when there is no bit
>>> needs to
>>> be masked.
>> I think this is intentional behavour. Previous version did return ~0UL
>> explicitly in this case. See patch 89c1e79eb3023 (linux/bitmap.h: improve
>> BITMAP_{LAST,FIRST}_WORD_MASK) from Rasmus.
> 
> Yes, I saw that. But it seems confusing for the corner case that nbits=0
> (no bits to mask), the macro returns with all the bits set.
> 
> 
>>
>> Introducing conditional branch would affect performance. All existing
>> code checks nbits for 0 before handling last word where needed
>> explicitly. So I think we'd better change nothing here.
> 
> I think that didn't save the conditional branch essentially, because
> it's just moved from inside this macro to the caller as you mentioned.
> If callers missed the check for some reason and passed 0 to the macro,
> they will get something unexpected.
> 
> Current callers like __bitmap_weight, __bitmap_equal, and others, they have
> 
> if (bits % BITS_PER_LONG)
>     w += hweight_long(bitmap[k] & BITMAP_LAST_WORD_MASK(bits));
> 
> we could remove the "if" check by "w += hweight_long(bitmap[k] &
> BITMAP_LAST_WORD_MASK(bits % BITS_PER_LONG));" the branch is the same.

Absolutely not! That would access bitmap[lim] (the final value of the k
variable) despite that word not being part of the bitmap.

More generally, look at the name of the macro: last_word_mask. It's a
mask to apply to the last word of a bitmap. If the bitmap happens to
consist of a multiple of BITS_PER_LONG bits, than that mask is and must
be ~0UL. So for nbits=64, 128, etc., that is what we want.

OTOH, for nbits=0, there _is_ no last word (since there are no words at
all), so by the time you want to apply the result of
BITMAP_LAST_WORD_MASK(0) to anything, you already have a bug, probably
either having read or being about to write into bitmap[0], which you
cannot do. Please check that user-space port and see if there are bugs
of that kind.

So no, the existing users of BITMAP_LAST_WORD_MASK do not check for
nbits being zero, they check for whether there is a partial last word,
which is something different. And they mostly (those in lib/bitmap.c) do
that because they've already handled _all_ the full words. Then there
are some users in include/linux/bitmap.h, that check for
small_const_nbits(nbits), and in those cases, we really want ~0UL when
nbits is BITS_PER_LONG, because small_const_nbits implies there is
exactly one word. Yeah, there's an implicit assumption that the bitmap
routines are never called with a compile-time constant nbits==0 (see the
unconditional accesses to *src and *dst), but changing the semantics of
BITMAP_LAST_WORD_MASK and making it return different values for nbits=0
vs nbits=64 wouldn't fix that latent bug.

Andrew, you may consider this a NAK of the v2 patch. Callers should
indeed avoid using BITMAP_LAST_WORD_MASK with nbits==0, but not because
the macro returns a wrong or unexpected value in that case, but simply
because it is meaningless to use it at all.

Rasmus
