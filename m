Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C781C1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4176420836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 23:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SD9NgX1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4176420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeFSXpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 19:45:50 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46194 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752892AbeFSXpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 19:45:44 -0400
Received: by mail-pg0-f65.google.com with SMTP id d2-v6so570056pga.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KcG7aJuqNQM5D1p3BinIK6J88eMi6xxp2lYIz0s1sk4=;
        b=SD9NgX1Ss/ccio+/XstN9i76cWo9UUVBdoOG7VnfLR/amPmaUTiiGohZrBeUcypD+W
         EunuqZNH0eylzYRSK9pEcXtTnIWaQ5V03w/B5iRgy5480U0qJ6AFQbdYoFqOGYkelJXY
         q6dXnNUkld19/VnVOz4vQOShz4N0akc3DaPrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KcG7aJuqNQM5D1p3BinIK6J88eMi6xxp2lYIz0s1sk4=;
        b=Zxb4gTYDD/83Jb7d71sKasUs/5xhorCJpalxFwdge5f8lPx1wGkqOFdVvgEizfEOtv
         5bZYCHz8auPUlGN9dAuOUf7AX8nD8bW79ohePjFBkQcOxwKj+3N608YGakZ/KZtNSeZQ
         kqsshg9YxVvJo3Ia4h1x+2GK8i6Nzji3+aL4GYO3C+AeaOEVqRfZH+ZPKbIFxZI27EdR
         QppUqx/p7DQ6tHSanQQmJRElEhjrq9o2VPEnLITldVONO4TVV89iLEuZYSbLDo+F4iCL
         TOeUWWc7puLD2K8MK/zY6zRVk34Nomq2VGvTsY1pvtBT5W0FwmUwQY9F0mDmjGZN4dOS
         qVtA==
X-Gm-Message-State: APt69E0jDE5xK8SB8TFhrv8l+kOf2pnFA1zNTYCTV/zUSZSBYUTzAqSO
        uSYJOqEbwYvU1Q9MwfHWHmA0Oo7nDmY=
X-Google-Smtp-Source: ADUXVKILZMaLLWjKe8Nd6agI90o68QgkSlJXPsCG70QbVrMO3bXYZRfogNPJfB9DguT5lpMIImK6Og==
X-Received: by 2002:a63:6fce:: with SMTP id k197-v6mr16729962pgc.307.1529451944461;
        Tue, 19 Jun 2018 16:45:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id y81-v6sm972459pfd.178.2018.06.19.16.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 16:45:43 -0700 (PDT)
Date:   Tue, 19 Jun 2018 16:45:43 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
Message-ID: <20180619234543.GG169030@google.com>
References: <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
 <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
 <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
 <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
 <d6a99e26-b100-715b-2615-b77259ec8397@redhat.com>
 <66b5e5c3ed82a5e1559419deb841c57bf0751fd3.camel@perches.com>
 <20180619183622.GB169030@google.com>
 <7547dfd4045a5acf23505887065bc228e65f2ff9.camel@perches.com>
 <20180619211019.GE169030@google.com>
 <951ccf2a257fb8f8827f88e1c17ce64d23173e94.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <951ccf2a257fb8f8827f88e1c17ce64d23173e94.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:55:05PM -0700, Joe Perches wrote:
> On Tue, 2018-06-19 at 14:10 -0700, Matthias Kaehlcke wrote:
> > On Tue, Jun 19, 2018 at 12:11:27PM -0700, Joe Perches wrote:
> > > -Wconstant-conversion is only issued when a *constant value* is assigned to
> > an incompatible type.
> > 
> > > Trying to allow a "make W=3" to be compiler warning message free
> > > is also silly.
> > > 
> > > I think it's better to make the warning emitted only at a W=3
> > > level instead.
> > 
> > Another difference with -Wsign-conversion is that enabling it would
> > probably result in thousands of warnings. Do you have evidence that
> > there is a significant number of spurious -Wconstant-conversion
> > warnings?
> 
> Not my issue really.

Well, you advocate to disable a possibly useful warning globally ...

> You're advocating for making the code more complex/ugly for a
> condition where the result is identical.

My goal is no to make the code (slightly) more complex/ugly but have
the rest of the kernel benefit from a possibly useful warning.

> Do you have evidence this is the only location in
> an allyesconfig compilation?

I never claimed that this is the only location, but that it is not an
extremely noisy warning that can not be fixed without a major effort.

Since you asked:

v4.16 with an x86 allyesconfig and a few drivers disabled since they
don't build with clang (yet):

16 occurrences of -Wconstant-conversion, including the ones fixed by
this patch. Certainly no need for an endless churn of patches, and
given the limited number it also doesn't seem likely that new
instances will be added on a regular base.
