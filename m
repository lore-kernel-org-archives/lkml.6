Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31628C04EBC
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D07208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 22:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F9ba1EdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D07208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJPGdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 02:33:54 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35046 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbeJPGdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 02:33:53 -0400
Received: by mail-yb1-f196.google.com with SMTP id o63-v6so8156199yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Yq7cAHf8F7PW+t95dpp6GCWUFslhvWiPYFUB7IEr9FU=;
        b=F9ba1EdOUKaafX9xrEqBARmbgLTf5BTazH9EUA2zqpIfgfemc+EGfElDFaacLlXV70
         SA7qSzK0tJNB0lhVdaPyb67bG07z0qrCMfA8JY1yy0usQeNdR/5MAAilhLx9CDq/xc6w
         D6ks2MQH8YTAZYX27MjGeIYcrdDQWf7iSlB7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Yq7cAHf8F7PW+t95dpp6GCWUFslhvWiPYFUB7IEr9FU=;
        b=FfiXN4Fo6AGHK2HXn3o1vq1o/gMZ/EuqfOPCBsja0td1hWqAi4u1zMXOBgjTS6CeIk
         pVjpsMSDL6HQDncmOUx2WDTCtuYjgOfRumZ3xIANj2OdgainSmbEqG7fhDoce4zbPxhJ
         GcSIket8lHqJ/tFo0uKCYN9+Ws1zhzzGmZ7U6qRwYAKDQk9TmXXJnLTV1MoAljRqjjpB
         kEJk5xOaLmOaaTqRtDWoS1WlNbTR62U/HqVLbkWInwycpOJFna7SkfzQcqPdpwyqoe7/
         nO9NBX8l08edC5Zgins48xC9JeoQcu46/DykNxwEOUAh4dkhT0LTYtdpMA1RnkE5JO8K
         RejQ==
X-Gm-Message-State: ABuFfoiJvQ0kM2nXToAiWEN7qOSip+pCVBfAamFUHG6i//NjItyk3Edq
        DsXWjzyuWJdviDdBqMwMvcx9gE61ZhU=
X-Google-Smtp-Source: ACcGV62/9wEpazOQBMe1VfVZgoGNXXewZ/sm7fa5VUoW5uWyhV9FnuWZXSb+Qg29H0fwPxH2yB5ayw==
X-Received: by 2002:a25:ce83:: with SMTP id x125-v6mr10686326ybe.145.1539643595159;
        Mon, 15 Oct 2018 15:46:35 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id r5-v6sm4966713ywr.80.2018.10.15.15.46.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 15:46:34 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id j75-v6so8165167ywj.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:46:34 -0700 (PDT)
X-Received: by 2002:a81:2cc3:: with SMTP id s186-v6mr10806432yws.168.1539643133798;
 Mon, 15 Oct 2018 15:38:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 15:38:53
 -0700 (PDT)
In-Reply-To: <d0e36e1f-fa1a-f4ab-5a83-11e095801fef@arm.com>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-18-kristina.martsenko@arm.com> <d0e36e1f-fa1a-f4ab-5a83-11e095801fef@arm.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Oct 2018 15:38:53 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL5v_Db9RnLYEJtFcGHYf3j023Kxd5eWvtpBjYYQorYMQ@mail.gmail.com>
Message-ID: <CAGXu5jL5v_Db9RnLYEJtFcGHYf3j023Kxd5eWvtpBjYYQorYMQ@mail.gmail.com>
Subject: Re: [RFC 17/17] arm64: compile the kernel with ptrauth -msign-return-address
To:     Vladimir Murzin <vladimir.murzin@arm.com>
Cc:     Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Adam Wallis <awallis@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 7:23 AM, Vladimir Murzin
<vladimir.murzin@arm.com> wrote:
> Hi Kristina,
>
> On 05/10/18 09:47, Kristina Martsenko wrote:
>> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
>> index 106039d25e2f..dbcd43ea99d8 100644
>> --- a/arch/arm64/Makefile
>> +++ b/arch/arm64/Makefile
>> @@ -56,6 +56,10 @@ KBUILD_AFLAGS      += $(lseinstr) $(brokengasinst)
>>  KBUILD_CFLAGS        += $(call cc-option,-mabi=lp64)
>>  KBUILD_AFLAGS        += $(call cc-option,-mabi=lp64)
>>
>> +ifeq ($(CONFIG_ARM64_PTR_AUTH),y)
>> +KBUILD_CFLAGS        += -msign-return-address=all
>> +endif
>
> Should not it be done via cc-option so old toolchains keep working [1]?
>
> [1]
> $ aarch64-linux-gnu-gcc --version
> aarch64-linux-gnu-gcc (Linaro GCC 2014.11) 4.9.3 20141031 (prerelease)
> Copyright (C) 2014 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>
> $ aarch64-linux-gnu-gcc -msign-return-address=all
> aarch64-linux-gnu-gcc: error: unrecognized command line option '-msign-return-address=all'
> ...

I would like to see CONFIG_ARM64_PTR_AUTH testing for compiler support
via Kconfig (as stack-protector does). This would allow developers to
only see the option if it was available (i.e. no "downgrade" happens
if the compiler is missing support). Using cc-option runs the risk of
building a kernel with CONFIG_ARM64_PTR_AUTH set, but _not_ actually
using ptr auth.

-Kees

-- 
Kees Cook
Pixel Security
