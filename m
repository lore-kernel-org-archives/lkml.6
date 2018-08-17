Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3676EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B37E2151C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="S3ldox4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B37E2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rasmusvillemoes.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeHQKsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:48:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39935 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeHQKsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:48:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id l15-v6so5656140lji.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 00:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r0J0M6yOOz10vtJb1ELqdHvXPHAMM8Y569KvVMT7atc=;
        b=S3ldox4S3Dvm5JKpN3/CZL1ZCIn5G+1QrTqG/YkZv/wMtvDVzdMoIfECXgWofTkISO
         ygpR2jysHCoHnSy2aI/KxMvQQgtnhnvFYWfWSvPtERAd4ALVNaB9+81cCzfcFwuGrcug
         GmVAO3enSoGVjVzY+tb5vRMxeZrtnUjFCnQ2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0J0M6yOOz10vtJb1ELqdHvXPHAMM8Y569KvVMT7atc=;
        b=rj9KwNffkLSIwCXgXdy7/sMqIuHL1NDyPVHiVnBe5MMF9b8FiRF9RenTYTaFfKTKsl
         aAIaPthik1Kivlokpvrn3Mx7hBG2jNiViOzirZ+cq9hyjlhvavRSLyNc6VG3RpHsGQ4n
         MDIub+x3Hf9wOOepwBrVYcsh9qLA7OQAC0nwODjzXwl1Ve6JNahbWOT9bYKNACP8l27G
         Gy3XNMMEhWOFSsT9hAoZFRFGQ1LzTE6HhwZqNLdXbJEByWPZFQ7tYCrNuZ9OzbV/0Eu+
         lUx//kVczwLM6yB1t7yiEl7FnHhGqZXYvF1Uj02t3gFH0bnQxt/dLttLobCjJS1M8gpH
         TaSw==
X-Gm-Message-State: AOUpUlHuD/k0zk3CkSudFI/pZ8MPLVDHzmro20n7w3KYkXU1YkSiDOtI
        rs6n/QIqfAX4Pj15uEncHVzJ0A==
X-Google-Smtp-Source: AA+uWPwvphZ0MCfAr5Uj6o0wgKzUtzVXVmaNhFYSbWNDw11Z28lRXSN4GZDbcApYOY6jA2SDdrRj2g==
X-Received: by 2002:a2e:6304:: with SMTP id x4-v6mr24821602ljb.9.1534491958194;
        Fri, 17 Aug 2018 00:45:58 -0700 (PDT)
Received: from [172.16.11.40] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id w8-v6sm265988lfe.67.2018.08.17.00.45.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 00:45:57 -0700 (PDT)
Subject: Re: [PATCH] linux/bitmap.h: (buildbot-only) check if we have any
 compile-time zero-size bitmaps
To:     Yury Norov <ynorov@caviumnetworks.com>
Cc:     linux-kernel@vger.kernel.org,
        Matthew Wilcox <mawilcox@microsoft.com>,
        akpm@linux-foundation.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20180815085539.27485-1-linux@rasmusvillemoes.dk>
 <20180816232125.GA6119@yury-thinkpad>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <a9227924-1311-3171-2f50-c5a617677558@rasmusvillemoes.dk>
Date:   Fri, 17 Aug 2018 09:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816232125.GA6119@yury-thinkpad>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-17 01:21, Yury Norov wrote:
> Hi Rasmus,
> 
> On Wed, Aug 15, 2018 at 10:55:39AM +0200, Rasmus Villemoes wrote:
>> Most of the inline bitmap functions are buggy if passed a compile-time
>> constant nbits==0.
> 
> I think it's bad wording. Functions are OK. The problem is in users.

Why shouldn't we handle a zero-size bitmap gracefully? In any case, if
you believe nbits==0 is an implicit violation of the API, all the more
reason to detect if we have such users.

> Also, run-time nbits==0 is buggy as well.

No, not according to my reading of lib/bitmap.c. Can you point out any
function in there that doesn't behave correctly when passed nbits==0?

 On the other hand, we have a rule
> in include/linux/bitmap.h:
>   * Note that nbits should be always a compile time evaluable constant.
>   * Otherwise many inlines will generate horrible code.
> So runtime-defined nbits is bad thing by itself.

Yeah, that ship has sailed long ago. We have lots of users where for
whatever reason nbits is not constant and/or is bigger than
BITS_PER_LONG, and a function call isn't really that horrible. Probably
that piece of doc should be removed or relaxed. I have a small series
that removes another piece of wrong doc, I'll tweak this as well.

One thing that might be worth looking into is to see if we have some
places where nbits is not compile-time const, but is compile-time known
to be in 1 <= nbits <= BITS_PER_LONG, and use the inline branches in
those cases as well. Matthew already did something like that with
2c6deb01525, where we use the inline case when nbits are known to be a
multiple of 8.

>>
>> Not-really-signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>>
>> +int const_zero_size_bitmaps_are_buggy(void);
> 
> It introduces undefined symbol and uses it in pretty unusual way. I think
> it worth to add comment about it.

So I thought the subject and the not-really-signed-off made it clear
enough: I don't mean for this patch to get upstream, it was only for the
buildbot to chew on and send me a build error report if we did indeed
have any such users.

The real fix(es) I'm planning to send is in
https://github.com/Villemoes/linux/tree/4.18_bitmap-zero-fix , but I'm
still waiting for the buildbot to send a report for the fake patch.

>>  #define small_const_nbits(nbits) \
>> -       (__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG)
>> +       (__builtin_constant_p(nbits) && (nbits) <= BITS_PER_LONG && \
>> +        ((nbits) > 0 || const_zero_size_bitmaps_are_buggy()))
> 
> Some functions in bitmap API has signed type for nbits. (This is wrong
> by itself. I think I'll write patch for it.) 

I thought I fixed that years ago, but looking again, it seems
2fbad29917c98 failed to update bitmap_shift_right properly. There may be
other extern functions with signed nbits, but I think bitmap_shift_right
is the only inline that passes a signed nbits to small_const_nbits().
I'll include a fix in the above series.

So in fact you check here
> that nbits is not negative as well. Would it be better name like
> const_nonpositive_size_bitmaps_are_buggy?

The name of the undefined function is irrelevant per the above.

Rasmus
