Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C26A2667F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="A56kxlsK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C26A2667F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752889AbeFZILZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:11:25 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54280 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752189AbeFZILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:11:19 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 2B8F35C015F;
        Tue, 26 Jun 2018 10:11:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1530000678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+dIvVaWwEZYKLFBaHhaofzp7lYFP9x6CD2KXEriz0QM=;
        b=A56kxlsKix3Akjy15bpungQNakAevMlB9Mu2XPXaPntqfwYVWeKrqVbyjSQgBrdekn1cxC
        /ntImK1b1PHUnOQ7FpTuGLoiR1aNs7mI372cI3wYq9oM7oVJ8MK9FVFCqpOsWe34ONxWnh
        AGPPg1P+xQyJ9S0rjiEh3EIkRuZmXdQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Date:   Tue, 26 Jun 2018 10:11:18 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Thierry Reding <treding@nvidia.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Stephen Warren <swarren@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>, ard.biesheuvel@linaro.org,
        arnd@arndb.de, nicolas.pitre@linaro.org, marc.zyngier@arm.com,
        behanw@converseincode.com, keescook@chromium.org,
        Bernhard.Rosenkranzer@linaro.org, mka@chromium.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 3/6] ARM: trusted_foundations: do not use naked
 function
In-Reply-To: <20180417081109.GA5804@ulmo>
References: <20180325180959.28008-1-stefan@agner.ch>
 <20180325180959.28008-4-stefan@agner.ch>
 <704c863a-0b5a-6396-d7da-f0ed17b7cca2@gmail.com>
 <263337af-7541-be9e-3db6-6cb987fd08fb@arm.com>
 <f627177c-f813-9e10-ade5-c7654375639b@gmail.com>
 <cf9b916103c0dba1e67682efc69f5bae@agner.ch>
 <498de826-6e6c-63d8-00d6-f394b2725a34@wwwdotorg.org>
 <507a66ab9ab530a6d71db7a74f11ddfb@agner.ch> <20180417081109.GA5804@ulmo>
Message-ID: <b7d7f3db651e2ef5411be73e5dabbe77@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-2.22 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[16];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         ASN(0.00)[asn:29691, ipnet:2a02:418::/29, country:CH];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-2.12)[95.76%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.2018 10:11, Thierry Reding wrote:
> On Mon, Apr 16, 2018 at 08:21:09PM +0200, Stefan Agner wrote:
>> On 16.04.2018 18:08, Stephen Warren wrote:
>> > On 04/16/2018 09:56 AM, Stefan Agner wrote:
>> >> On 27.03.2018 14:16, Dmitry Osipenko wrote:
>> >>> On 27.03.2018 14:54, Robin Murphy wrote:
>> >>>> On 26/03/18 22:20, Dmitry Osipenko wrote:
>> >>>>> On 25.03.2018 21:09, Stefan Agner wrote:
>> >>>>>> As documented in GCC naked functions should only use Basic asm
>> >>>>>> syntax. The Extended asm or mixture of Basic asm and "C" code is
>> >>>>>> not guaranteed. Currently this works because it was hard coded
>> >>>>>> to follow and check GCC behavior for arguments and register
>> >>>>>> placement.
>> >>>>>>
>> >>>>>> Furthermore with clang using parameters in Extended asm in a
>> >>>>>> naked function is not supported:
>> >>>>>>     arch/arm/firmware/trusted_foundations.c:47:10: error: parameter
>> >>>>>>             references not allowed in naked functions
>> >>>>>>                   : "r" (type), "r" (arg1), "r" (arg2)
>> >>>>>>                          ^
>> >>>>>>
>> >>>>>> Use a regular function to be more portable. This aligns also with
>> >>>>>> the other smc call implementations e.g. in qcom_scm-32.c and
>> >>>>>> bcm_kona_smc.c.
>> >>>>>>
>> >>>>>> Cc: Dmitry Osipenko <digetx@gmail.com>
>> >>>>>> Cc: Stephen Warren <swarren@nvidia.com>
>> >>>>>> Cc: Thierry Reding <treding@nvidia.com>
>> >>>>>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> >>>>>> ---
>> >>>>>> Changes in v2:
>> >>>>>> - Keep stmfd/ldmfd to avoid potential ABI issues
>> >>>>>>
>> >>>>>>    arch/arm/firmware/trusted_foundations.c | 14 +++++++++-----
>> >>>>>>    1 file changed, 9 insertions(+), 5 deletions(-)
>> >>>>>>
>> >>>>>> diff --git a/arch/arm/firmware/trusted_foundations.c
>> >>>>>> b/arch/arm/firmware/trusted_foundations.c
>> >>>>>> index 3fb1b5a1dce9..689e6565abfc 100644
>> >>>>>> --- a/arch/arm/firmware/trusted_foundations.c
>> >>>>>> +++ b/arch/arm/firmware/trusted_foundations.c
>> >>>>>> @@ -31,21 +31,25 @@
>> >>>>>>      static unsigned long cpu_boot_addr;
>> >>>>>>    -static void __naked tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>> >>>>>> +static void tf_generic_smc(u32 type, u32 arg1, u32 arg2)
>> >>>>>>    {
>> >>>>>> +    register u32 r0 asm("r0") = type;
>> >>>>>> +    register u32 r1 asm("r1") = arg1;
>> >>>>>> +    register u32 r2 asm("r2") = arg2;
>> >>>>>> +
>> >>>>>>        asm volatile(
>> >>>>>>            ".arch_extension    sec\n\t"
>> >>>>>> -        "stmfd    sp!, {r4 - r11, lr}\n\t"
>> >>>>>> +        "stmfd    sp!, {r4 - r11}\n\t"
>> >>>>>>            __asmeq("%0", "r0")
>> >>>>>>            __asmeq("%1", "r1")
>> >>>>>>            __asmeq("%2", "r2")
>> >>>>>>            "mov    r3, #0\n\t"
>> >>>>>>            "mov    r4, #0\n\t"
>> >>>>>>            "smc    #0\n\t"
>> >>>>>> -        "ldmfd    sp!, {r4 - r11, pc}"
>> >>>>>> +        "ldmfd    sp!, {r4 - r11}\n\t"
>> >>>>>>            :
>> >>>>>> -        : "r" (type), "r" (arg1), "r" (arg2)
>> >>>>>> -        : "memory");
>> >>>>>> +        : "r" (r0), "r" (r1), "r" (r2)
>> >>>>>> +        : "memory", "r3", "r12", "lr");
>> >>>>>
>> >>>>> Although seems "lr" won't be affected by SMC invocation because it should be
>> >>>>> banked and hence could be omitted entirely from the code. Maybe somebody could
>> >>>>> confirm this.
>> >>>> Strictly per the letter of the architecture, the SMC could be trapped to Hyp
>> >>>> mode, and a hypervisor might clobber LR_usr in the process of forwarding the
>> >>>> call to the firmware secure monitor (since Hyp doesn't have a banked LR of its
>> >>>> own). Admittedly there are probably no real systems with the appropriate
>> >>>> hardware/software combination to hit that, but on the other hand if this gets
>> >>>> inlined where the compiler has already created a stack frame then an LR clobber
>> >>>> is essentially free, so I reckon we're better off keeping it for reassurance.
>> >>>> This isn't exactly a critical fast path anyway.
>> >>>
>> >>> Okay, thank you for the clarification.
>> >>
>> >> So it seems this change is fine?
>> >>
>> >> Stephen, you picked up changes for this driver before, is this patch
>> >> going through your tree?
>> >
>> > You had best ask Thierry; he's taken over Tegra maintenance upstream.
>> > But that said, don't files in arch/arm go through Russell?
>>
>> I think the last patches applied to that file went through your tree.
>>
>> Thierry, Russel, any preferences?
> 
> I don't mind picking this up into the Tegra tree. Might be a good idea
> to move this into drivers/firmware, though, since that's where all the
> other firmware-related drivers reside.
> 
> Firmware code, such as the BPMP driver, usually goes through ARM-SoC
> these days. I think this is in the same category.
> 
> Russell, any objections to me picking this patch up and moving it into
> drivers/firmware?

Russel, I think Thierry is waiting for your ok on this.

--
Stefan
