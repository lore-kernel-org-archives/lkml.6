Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D03C46465
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08DEC2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FJ4LsXki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DEC2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbeKHWBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:01:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41873 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeKHWBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:01:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id v18-v6so1735824wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=mniJ0igHPGZh+8A6l+B8DDrahafLN8APE03nMO7Ahh8=;
        b=FJ4LsXkifUsqSONm8fH02wUT+xRmm8XHN4wZU/fCNsipQB5QUfDP7je95/DKRNYPN+
         bWVRPbgzp+fpySap3Xpaq2ELPLB8xJShPre44o86twOynCuAAmkt2TCJwarRo8eUyx1E
         CMJyCBJLbHr55xdkDExrqre+ul3k+6OEMi2lA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=mniJ0igHPGZh+8A6l+B8DDrahafLN8APE03nMO7Ahh8=;
        b=QYSB/6A6XQcI5PpPk3P+Q2EqzLDdbSfwGfwCeCzoDYSwNpy4GHSH9MpKJ2g0tOJ8uZ
         OXFfn9/w/0sGXB2bEwUohq0KmIJqAhrv4cQLayIBoUaSdgmXAQ9nWx4Y+3pk07BZLzkU
         jYHZzTfL0GRbsar/v4M4rOzx8psrLPHNvfjDohjAtwLXT+A/J2/HVOtCUQdGoJ0ky8Fd
         wgpHkkFAKZoBt58rtwrsKgnO7ZTtwK+2d4D9XRo5wsy04znI5WWHkryV3yEK1jCk3D4U
         /HKoqrRAJV6kpeNF5SMwcF0M5e4UgZ+ucEa/T20y/Xrd0TS+md+Hq9pobM1GE0boAxn8
         CAzA==
X-Gm-Message-State: AGRZ1gKsUsGOd7Nx5p1e2amPDEK6p0PR9MakqJM3EOAih9kNwr53xszf
        Cc5vTnhAvdKyivnEX3QXrtauzw==
X-Google-Smtp-Source: AJdET5etXJJLDeIRZ10L8te/AGttLdmbfy/YBVeFgu279PZ2Kw5lfAHoXqSUPMFImFV3+AF1a0Nc8w==
X-Received: by 2002:adf:9245:: with SMTP id 63-v6mr3830299wrj.130.1541679977669;
        Thu, 08 Nov 2018 04:26:17 -0800 (PST)
Received: from zen.linaro.local ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id u4-v6sm3595389wrt.89.2018.11.08.04.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Nov 2018 04:26:17 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
        by zen.linaro.local (Postfix) with ESMTPS id 5C92D3E03FE;
        Thu,  8 Nov 2018 12:26:16 +0000 (GMT)
References: <20181107171031.22573-1-alex.bennee@linaro.org> <CAFEAcA8LL0uC6o1V3W2T=2P47xZ0zGhMR5mEE+x=8qwmDKZL_g@mail.gmail.com> <CAFEAcA8mKCTeswpiznVWR3kSfVfjbot1aTSfemFVNjzXYdSJwA@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.1.50
From:   Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     kvm-devel <kvm@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        Christoffer Dall <christoffer.dall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] KVM: arm64: don't single-step for non-emulated faults
In-reply-to: <CAFEAcA8mKCTeswpiznVWR3kSfVfjbot1aTSfemFVNjzXYdSJwA@mail.gmail.com>
Date:   Thu, 08 Nov 2018 12:26:16 +0000
Message-ID: <87sh0b69hz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Maydell <peter.maydell@linaro.org> writes:

> On 7 November 2018 at 17:39, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>> On 7 November 2018 at 17:10, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>> Not all faults handled by handle_exit are instruction emulations. For
>>> example a ESR_ELx_EC_IABT will result in the page tables being updated
>>> but the instruction that triggered the fault hasn't actually executed
>>> yet. We use the simple heuristic of checking for a changed PC before
>>> seeing if kvm_arm_handle_step_debug wants to claim we stepped an
>>> instruction.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> What's the rationale for this change? Presumably it's fixing
>> something, but the commit message doesn't really say what...
>>
>> This feels to me like it's working around the fact that
>> we've separated two things ("advance pc (or set it if we're
>> going to make the guest take an exception)" and "notice that
>> we have completed a single step") that should be handled
>> at one point in the code.
>
> ...so for instance if your guest PC is at the entrypoint for
> an exception, and you singlestep and take the same exception
> again, this should count as a single step completed, even
> though the PC has not changed. Granted, that's a little
> contrived, but it can happen in cases where the guest gets
> completely confused and is sitting in a tight loop taking
> exceptions because there's no ram at the vector table
> address, or whatever.

The alternative I thought of as I was hacking^H^H^H^H^H^H carefully
engineering this was to expand arm_exit_handlers[] and tag each handler
that was an instruction emulation and gate on that.

--
Alex Benn=C3=A9e
