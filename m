Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12911C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E058E2173C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 15:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbfBRPHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 10:07:55 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32974 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728954AbfBRPHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 10:07:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 377B515AB;
        Mon, 18 Feb 2019 07:07:54 -0800 (PST)
Received: from [10.1.196.50] (e108454-lin.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC51E3F675;
        Mon, 18 Feb 2019 07:07:52 -0800 (PST)
Subject: Re: [RFC PATCH] arm64/fpsimd: Don't disable softirq when touching
 FPSIMD/SVE state
To:     Dave Martin <Dave.Martin@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rt-users@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190208165513.8435-1-julien.grall@arm.com>
 <20190213143029.ad2kzg7vtuo3zpjk@linutronix.de>
 <20190213153630.GK3567@e103592.cambridge.arm.com>
 <CAKv+Gu__0uy6Y-EJGSygSYH4RqpLDWMMNFE3yauF_x7-UNcgFQ@mail.gmail.com>
 <20190213165227.7ekekkxazhbaqxoe@linutronix.de>
 <20190214103449.GN3567@e103592.cambridge.arm.com>
From:   Julien Grall <julien.grall@arm.com>
Message-ID: <32ba7e1e-37ce-c904-15e4-9c908e873479@arm.com>
Date:   Mon, 18 Feb 2019 15:07:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214103449.GN3567@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 14/02/2019 10:34, Dave Martin wrote:
> On Wed, Feb 13, 2019 at 05:52:27PM +0100, Sebastian Andrzej Siewior wrote:
>> On 2019-02-13 16:40:00 [+0100], Ard Biesheuvel wrote:
>>>>> This is equal what x86 is currently doing. The naming is slightly
>>>>> different, there is irq_fpu_usable().
>>>>
>>>> Yes, I think it's basically the same idea.
>>>>
>>>> It's been evolving a bit on both sides, but is quite similar now.
>>>>
>>>
>>> may_use_simd() only exists because we have a generic crypto SIMD
>>> helper, and so we needed something arch agnostic to wrap around
>>> irq_fpu_usable()
>>
>> My question was more if this is helpful and we want to keep or if
>> it would be better to remove it and always disable BH as part of SIMD
>> operations.
> 
> Wouldn't this arbitrarily increase softirq latency?  Unconditionally
> forbidding SIMD in softirq might make more sense.  It depends on how
> important the use cases are...

Looking at the commit message from cb84d11e1625 "arm64: neon: Remove support for 
nested or hardirq kernel-mode NEON", one of the use case for crypto in softirq 
is certain mac80211 drivers.

Is there any other use case for use crypto in softirqs?

Cheers,

-- 
Julien Grall
