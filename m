Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A714C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3CF20825
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 12:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdiZetIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB3CF20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeKIWFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 17:05:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33223 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIWFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 17:05:09 -0500
Received: by mail-wr1-f68.google.com with SMTP id u9-v6so1718715wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 04:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=K4++d6mnMPSWwZs7slknABswK6L4IJIPhWv0sJbKZj4=;
        b=kdiZetIn3cYEhoDB3griK2Q+vdRqNkYYz+9bOTVTMbRBjg7myCKZ6icAV+yNjtc4F9
         GLvjihVG6ILHCUu/bkLzi0gYWi5aFxLzF5VXdmJaiIxIAWqIwu+4dm/I6Gba6lQpIXvN
         QplhpTFCiXJPpYuEE9sDdSnXBqNJrjD2NrbSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=K4++d6mnMPSWwZs7slknABswK6L4IJIPhWv0sJbKZj4=;
        b=Ro2+ujGf8PVTibnknIN4Scx+hHGapdmR0fx4MDyGlq6gH7LOgNTgnBgUIHYQOiqiBY
         wMnMbZHf1sidg6StvqJdNkbiwfShjq7qbkNBN9KdTcfbjF1Ai5vXD3nMYG4hJFbOMIoH
         w4JzpsYEOBXUeCZb+Z0Um7HqHydlb+EWfD9isMYfZSyi32RUH2cg2B73xYjdGPRip3qg
         1lL2K58VvhJeMFIVay+UHvy4kEi8HzxCoZ1vsEU8DE1ELQMnPqpSsg4cc75G3sr+4zOc
         Ixxhe8A5LGaHbS4t9wqzw6844tJ43eEywXgFg1KrgkgO3QSDzAirG54q6PJ8+7Hjnupd
         fmzw==
X-Gm-Message-State: AGRZ1gIYf4rzxrDNKnUHyMlhTS1VL6Zh8yjK9vp/ZtXberBFeAgvwd/c
        wx0JMuxKCnHBnflL1YKdoWXiQg==
X-Google-Smtp-Source: AJdET5frk8wLoR1wLH+pRBNSxso5CncTI44pPXxUVX1Am9jf2FI4PWCngLd6B9ZmHV/WIxFD94WTsw==
X-Received: by 2002:adf:b745:: with SMTP id n5-v6mr7960074wre.274.1541766283238;
        Fri, 09 Nov 2018 04:24:43 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id p188-v6sm893011wmp.31.2018.11.09.04.24.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Nov 2018 04:24:42 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id C3EF33E02B6;
        Fri,  9 Nov 2018 12:24:41 +0000 (GMT)
References: <20181107171031.22573-1-alex.bennee@linaro.org> <20181107180120.urnvkcrkh46ytsdb@lakrids.cambridge.arm.com> <20181107180829.sex54bxhd5wyqvan@lakrids.cambridge.arm.com> <87r2fv68us.fsf@linaro.org> <20181108135122.llmfsel32dbe2q7o@lakrids.cambridge.arm.com> <87pnvf63u2.fsf@linaro.org> <CAFEAcA9v+XvAJBWpDMvEQPeJ7ALM15Yz5KY+wfGPmLG2a8yPRQ@mail.gmail.com> <20181109115644.f4qjqnv2kogoke42@lakrids.cambridge.arm.com>
User-agent: mu4e 1.1.0; emacs 26.1.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Maydell <peter.maydell@linaro.org>,
        kvm-devel <kvm@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Christoffer Dall <christoffer.dall@linaro.org>,
        kvmarm@lists.cs.columbia.edu,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
In-reply-to: <20181109115644.f4qjqnv2kogoke42@lakrids.cambridge.arm.com>
Date:   Fri, 09 Nov 2018 12:24:41 +0000
Message-ID: <87lg625th2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Mark Rutland <mark.rutland@arm.com> writes:

> On Thu, Nov 08, 2018 at 02:38:43PM +0000, Peter Maydell wrote:
>> On 8 November 2018 at 14:28, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> >
>> > Mark Rutland <mark.rutland@arm.com> writes:
>> >> One problem is that I couldn't spot when we advance the PC for an MMIO
>> >> trap. I presume we do that in the kernel, *after* the MMIO trap, but I
>> >> can't see where that happens.
>> >
>> > Nope it gets done before during decode_hsr in mmio.c:
>> >
>> >         /*
>> >          * The MMIO instruction is emulated and should not be re-execu=
ted
>> >          * in the guest.
>> >          */
>> >         kvm_skip_instr(vcpu, kvm_vcpu_trap_il_is32bit(vcpu));
>>
>> I think that this attempt to do the PC-advance early is
>> probably an underlying problem that is not helping the
>> code structure here.
>>
>> An enhancement that's been floated previously is that the
>> MMIO emulation in userspace should be able to report back
>> to KVM "nope, that access should generate a guest synchronous
>> external abort (with ESR_EL1.EA =3D 0/1)".
>> If we have that, then we definitely need to not advance the
>> PC until after userspace has done the emulation and told
>> us whether the memory access succeeded or not...
>
> Yup.
>
> I think that we absolutely want to do all the CPU state advancement (PC,
> SS bit, etc) at the point we apply the effects of the instruction. Not
> before we emulate the instruction, and not higher/lower in the call
> stack.

There is certainly an argument to abstract some of the advancement logic
so we can make debug related decisions in one place. I don't know how
much churn we would need to get there.

Currently most of the guest debug decisions are made in one place as we
head into the guest run. Generally I don't think the emulation code want
to know or care about the SS bit or what debug is currently happening
although I guess the presence of the SS bit could be used to decide on
exactly what exit type you are going to do - back to guest or out to
user space. Currently kvm_arm_handle_step_debug on cares about host
directed debug but we could expand it to raise the appropriate guest
exception if required.

> We have a big problem in that guest-directed singlestep and
> host-directed singlestep don't compose, and given that host-directed
> singlestep doesn't work reliably today I'd be tempted to rip that out
> until we've fixed guest-directed singlestep.

Getting host and guest debug to run at the same time is tricky given we
end up subverting guest state when the host debug is in control. It did
make my head spin when I worked on it originally which led to the
acceptance that guest debug couldn't be expected to work transparently
while host directed debug was in effect. If we can support it without
adding complexity then that would be great but it's a pretty niche use
case.

I'd be loathed to rip out the current single step support as it does
actually work pretty well - it's just corner cases with emulated MMIO
and first step that are failing. Last I looked these were cases x86
didn't even get right and no one has called to remove it's single step
support AFAIK.

> We should have a story for how host-directed debug is handled
> transparently from the PoV of a guest using guest-directed debug.

What's the use case for this apart from having a cleaner abstraction? Do
users really spend time running multiple gdbs at different levels in
the stack?

>
> Thanks,
> Mark.


--
Alex Benn=C3=A9e
