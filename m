Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E50EC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E1A2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 14:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VDjkM5O3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E1A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbeLJOWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 09:22:12 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34121 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727580AbeLJOWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 09:22:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so10555331otk.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 06:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l4J1rNwiRfY2atde+pNuC/RCOGv0XvhLnWyTfm8Kx6o=;
        b=VDjkM5O3nKtNwOdTGGUS50kGy2mre1CwAriJZw6w4tTFULajmo+DAhviWwa3j2iEeC
         YFLl5Gj8YWvO11HgjsUWNxj4CiYs1DdLIL2E4MfwOM8aves3WvSvskmEg2YRa+37Ka0w
         N/e2zcfBU0oYLp/ab2e/P0CXfJr7KwVBtrF8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l4J1rNwiRfY2atde+pNuC/RCOGv0XvhLnWyTfm8Kx6o=;
        b=rI0+ngyBM5lQ5tEn4+O38km072zrAdHZhaOacHFPPaHPp+p8RFgQ9daJnSdyjYeBPI
         i0Wx8cdbIKepYfLMSTqwPGvVR0ND4FWA125JA2FYdQNEmy5C425A86bQyVfewDV6fITH
         7Y2oUnivUDiUYmUaPxLElchAakAEMT51EyEuSRCoxKcVY67RFp/rzteGAjzrIzZyiRv2
         NevnlcLl+pYjrGMv387EsGkHs3QIwEQuKZ3DeVV8jRy9FI0AXNA2IZkmBQ/ZdOz7LVnD
         4piSseFWvoDSONVQWyEi2rjLheWnQ2ocWfASoXHHJMUwrwphaIoLzhR3vSLev0SJgaSG
         uJzw==
X-Gm-Message-State: AA+aEWb6XgsOgDekA3/vxpaYmnKQWfR3IGwG52DtsRdGYboGFP052cBr
        GyuPSo+YKJKaPCE1nbYiUHiesQoWRWpN4Q==
X-Google-Smtp-Source: AFSGD/UOxM2x7WK6gkfI6r6Qaia7FeCuytHyl3UQp9MmQQewhmjOgm6aVq/ASsKhAgyx4rMy7nhtxw==
X-Received: by 2002:a9d:42c:: with SMTP id 41mr9300029otc.41.1544451730481;
        Mon, 10 Dec 2018 06:22:10 -0800 (PST)
Received: from cloudburst.twiddle.net ([187.217.227.243])
        by smtp.gmail.com with ESMTPSA id m2sm9077478otp.34.2018.12.10.06.22.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 06:22:09 -0800 (PST)
Subject: Re: [PATCH v6 08/13] arm64: expose user PAC bit positions via ptrace
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Adam Wallis <awallis@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        kvmarm@lists.cs.columbia.edu, Cyrill Gorcunov <gorcunov@gmail.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Dave P Martin <dave.martin@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Steve Capper <Steve.Capper@arm.com>
References: <20181207183931.4285-1-kristina.martsenko@arm.com>
 <20181207183931.4285-9-kristina.martsenko@arm.com>
 <a31ca10a-ee1a-71fb-2c3d-a6184e12b543@linaro.org>
 <20181210120330.GB4048@arrakis.emea.arm.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ba48e082-3e47-43bc-77d1-97d741c59284@linaro.org>
Date:   Mon, 10 Dec 2018 08:22:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210120330.GB4048@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/18 6:03 AM, Catalin Marinas wrote:
>> However, it won't be too long before someone implements support for
>> ARMv8.2-LVA, at which point, without changes to mandatory pointer tagging, we
>> will only have 3 authentication bits: [54:52].  This seems useless and easily
>> brute-force-able.
> 
> Such support is already here (about to be queued):
> 
> https://lore.kernel.org/linux-arm-kernel/20181206225042.11548-1-steve.capper@arm.com/

Thanks for the pointer.

>> Unfortunately, there is no obvious path to making this optional that does not
>> break compatibility with Documentation/arm64/tagged-pointers.txt.
> 
> There is also the ARMv8.5 MTE (memory tagging) which relies on tagged
> pointers.

So it does.  I hadn't read through that extension completely before.

> An alternative would be to allow the opt-in to 52-bit VA, leaving it at
> 48-bit by default. However, it has the problem of changing the PAC size
> and not being able to return.

Perhaps the opt-in should be at exec time, with ELF flags (or equivalent) on
the application.  Because, as you say, changing the shape of the PAC in the
middle of execution is in general not possible.

It isn't perfect, since old kernels won't fail to exec an application setting
flags that can't be supported.  And it requires tooling changes.


r~
