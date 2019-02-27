Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE11DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE09C218CD
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="W/NDbkVF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfB0HkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:40:13 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37278 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726702AbfB0HkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:40:13 -0500
Received: from zn.tnic (p200300EC2BCDB200B0CF70802C24D707.dip0.t-ipconnect.de [IPv6:2003:ec:2bcd:b200:b0cf:7080:2c24:d707])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0F571EC05D6;
        Wed, 27 Feb 2019 08:40:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1551253211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=L7TXJkiBYmuZkTpf7zWCrqRcXXFm6Ob4r7zqfQrv5cg=;
        b=W/NDbkVFAsL+nNcPrq8rq6HGqfMarxINxZJjUgIpvmRSgZCwyjMMBB9zaK7CU03ZBVjAuE
        AiyO4rOsuYlv2VSz0bJLUfuEJSxDt5ig4koQj2JeHSwL1A+7SKzQUIcSVYozWs0pqCt8+j
        eKhT8gdmvn7jg5NYC5JaN+ZkoEEToRE=
Date:   Wed, 27 Feb 2019 08:39:58 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Baoquan He <bhe@redhat.com>, Kees Cook <keescook@chromium.org>
Cc:     Pingfan Liu <kernelfans@gmail.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Nicolas Pitre <nico@linaro.org>,
        Chao Fan <fanc.fnst@cn.fujitsu.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/boot/KASLR: skip the specified crashkernel reserved
 region
Message-ID: <20190227073958.GA1786@zn.tnic>
References: <1551081596-2856-1-git-send-email-kernelfans@gmail.com>
 <20190225094522.GC26145@zn.tnic>
 <CAFgQCTtYp5mV0xmt4ZJbS0igBFe8S1ZbUnuTWE1-wj8CuHPJew@mail.gmail.com>
 <20190226104653.GB14836@zn.tnic>
 <20190227013034.GP14858@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190227013034.GP14858@MiWiFi-R3L-srv>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Kees.

@Kees, you might want to go upthread a bit for context.

On Wed, Feb 27, 2019 at 09:30:34AM +0800, Baoquan He wrote:
> Agree that 'crashkernel=x' should be encouraged to use as the first
> choice when reserve crashkernel. If we decide to not obsolete
> 'crashkernel=x@y', it will leave a unstable kernel parameter.

Is anyone even talking about obsoleting this?

And if anyone is, anyone can think a bit why we can't do this.

> Another worry is that KASLR won't always fail 'crashkernel=x@y',
> customer may set and check in testing stage, then later in production
> environment one time of neglect to not check may cause carashed kernel
> uncaptured.
>
> IMHO, 'crashkernel=x@y' is similar to those specified memmap=ss[#$!]nn
> which have been avoided in boot stage KASLR.

So my worry is that by specifying too many exclusion ranges, we might
limit the kaslr space too much and make it too predictable. Especially
since distros slap those things automatically and most users take them
for granted.

But I might be way off here because of something else I'm missing ...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
