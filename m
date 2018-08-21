Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396DDC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 035D821837
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 17:25:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035D821837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbeHUUqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:46:24 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52634 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726810AbeHUUqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:46:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 431D8ED1;
        Tue, 21 Aug 2018 10:25:21 -0700 (PDT)
Received: from [10.4.12.131] (e110467-lin.emea.arm.com [10.4.12.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B93E43F739;
        Tue, 21 Aug 2018 10:25:19 -0700 (PDT)
Subject: Re: [PATCH] arm64/crypto: remove non-standard notation
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180820224032.53194-1-ndesaulniers@google.com>
 <CAKv+Gu-xAmadr96vwStOxdeqi=rCEBrn8V6GofexBhpmA=JiuA@mail.gmail.com>
 <CAKwvOdkZR-MWuMU=j=kKXQwA0LEj1n0uoZQyTpwOzZuz9gjmJQ@mail.gmail.com>
 <CAKv+Gu8ZZYvh9ZthRH7mvG7_j3bvT=3st-aj0kdwpNQaAcs=-w@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <0dda3996-a4f3-33f8-ef4f-935943f132b4@arm.com>
Date:   Tue, 21 Aug 2018 18:25:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8ZZYvh9ZthRH7mvG7_j3bvT=3st-aj0kdwpNQaAcs=-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/18 18:00, Ard Biesheuvel wrote:
> On 21 August 2018 at 18:50, Nick Desaulniers <ndesaulniers@google.com> wrote:
>> On Tue, Aug 21, 2018 at 5:23 AM Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>>
>>> Hi Nick,
>>>
>>> On 21 August 2018 at 00:40, Nick Desaulniers <ndesaulniers@google.com> wrote:
>>>> It seems that:
>>>> ldr q8, =0x30000000200000001
>>>>
>>>> is a GNU as convience notation for:
>>>> ldr q8, .Lconstant
>>>> .Lconstant
>>>> .word 0x00000001
>>>> .word 0x00000002
>>>> .word 0x00000003
>>>> .word 0x00000000
>>>>
>>>> based on this comment in binutils' source [0]. I've asked for this
>>>> non-standard convience notation to be added to other assemblers [1], but
>>>> until then, we can remove it and get equivalent disassembly:
>>>>
>>>
>>> What do you mean by 'non-standard convenience notation'? Which asm
>>> 'standard' does Clang actually claim to implement?
>>
>> Well, for assembly 'standard' is a bit nebulous.  But it's frustrating
>> when you can't find what the `=0x...` notation means in either the ARM
>> or GNU as manuals.  The source of truth happened to be a comment in
>> the source [0] that explained that this was a "programmer friendly
>> notation."  Sure, if you can find it.
>>
> 
> Well, it is documented in the ARM manuals as the 'ldr pseudo
> instruction' for 32-bit ARM, and originally, it would only emit a
> literal if the value could not be loaded using a ordinary mov.

FWIW It's certainly well-documented by common A64 assemblers too:

http://infocenter.arm.com/help/topic/com.arm.doc.100069_0610_01_en/dom1395139540926.html

https://sourceware.org/binutils/docs/as/AArch64-Opcodes.html#AArch64-Opcodes

> For AArch64, I don't think that occurs any longer, i.e., a ldr is
> always emitted as an ldr. However, it is used widely in the ARM code
> (although not as much in arch/arm64) for loading compile time
> constants and even symbol addresses into general purpose registers.
> The FP variant may actually be a GNU invention, but given that there
> is no standard to begin with, playing the 'GNU is non-standard' card
> again is just a bit annoying.

I note that GAS just says "register" rather than explicitly calling out 
GPRs as armasm does, so in some ways it's not even all that unexpected 
that FP registers also work there, even if it is a bit funky.

Robin.
