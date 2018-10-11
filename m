Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95E7C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2E320841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2E320841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbeJKV2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:28:21 -0400
Received: from foss.arm.com ([217.140.101.70]:37912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbeJKV2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:28:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4905CEBD;
        Thu, 11 Oct 2018 07:01:02 -0700 (PDT)
Received: from [10.1.197.21] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4BAFF3F5D3;
        Thu, 11 Oct 2018 07:00:59 -0700 (PDT)
Subject: Re: [RFC 17/17] arm64: compile the kernel with ptrauth
 -msign-return-address
To:     Ramana Radhakrishnan <ramana.radhakrishnan@foss.arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Wallis <awallis@codeaurora.org>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Christoffer Dall <Christoffer.Dall@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-18-kristina.martsenko@arm.com>
 <cd1eface-aebb-b654-c57c-91690087957f@foss.arm.com>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
Message-ID: <edbb3ad0-a38e-743f-f2e7-2241f2ed12ee@arm.com>
Date:   Thu, 11 Oct 2018 15:00:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <cd1eface-aebb-b654-c57c-91690087957f@foss.arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2018 10:01, Ramana Radhakrishnan wrote:
> On 05/10/2018 09:47, Kristina Martsenko wrote:
>> Compile all functions with two ptrauth instructions: paciasp in the
>> prologue to sign the return address, and autiasp in the epilogue to
>> authenticate the return address. This should help protect the kernel
>> against attacks using return-oriented programming.
>>
>> CONFIG_ARM64_PTR_AUTH enables pointer auth for both userspace and the
>> kernel.
>>
>> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
>> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
>> ---
>>   arch/arm64/Makefile | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index 106039d25e2f..dbcd43ea99d8 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -56,6 +56,10 @@ KBUILD_AFLAGS    += $(lseinstr) $(brokengasinst)
>>   KBUILD_CFLAGS    += $(call cc-option,-mabi=lp64)
>>   KBUILD_AFLAGS    += $(call cc-option,-mabi=lp64)
>>   +ifeq ($(CONFIG_ARM64_PTR_AUTH),y)
>> +KBUILD_CFLAGS    += -msign-return-address=all
> 
> Glad to see this being done and being proposed for mainline.
> 
> I can see why you would prefer this though have you guys experimented at
> all with -msign-return-address=non-leaf as well ?

I've tried non-leaf and it works too. I'd be fine with switching to it,
I'm not sure which would be better for the kernel.

What kind of experiments did you have in mind? If I understand
correctly, then compared to non-leaf, "all" additionally protects leaf
functions that write to the stack. I don't know how many of those there
are in the kernel (or will be in the future). I also don't know the
additional performance impact of "all", as I don't think we have any
v8.3 hardware to test on yet. There is a minor code size impact (0.36%
on the current kernel), but I'm not sure how much that matters.

> Orthogonally and just fair warning - the command lines for this are also
> being revised to provide ROP and JOP protection using BTI from v8.5-a
> during the GCC-9 timeframe but I suspect that's a different option.

Thanks. I expect it will be a separate Kconfig option to build the
kernel with BTI and pointer auth, yes.

> Reviewed-by: Ramana Radhakrishnan  <ramana.radhakrishnan@arm.com>

Thanks!

Kristina
