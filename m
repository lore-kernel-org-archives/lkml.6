Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D0AC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03A7C20843
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 20:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZB1z2bFv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03A7C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbeIBArX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 20:47:23 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34767 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbeIBArX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 20:47:23 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 8098b4a3;
        Sat, 1 Sep 2018 20:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=T+5omoo9pWmGmG3M36oUeMsRkEY=; b=ZB1z2b
        FvVnYsmjNVtr4XnsMqUb1pfrNIvhva63DI02jWDw30yzjP0LMM66TUO7zvBbI2nZ
        ftI7dYHDd230v8xCZPlbHYvDxdoMVLi+OA7Zh+QpH0Wyr/uX2xx1FfY17C4djF3S
        gAXuByGJiIEelKn9ONKJnKUVilHsKs4UJJpnE1XzsB7sZbW9VsK1r/5kWSC3cCPp
        BuHecpD1pKCw0tKsvIzSOnW2YvaNSxhRZEdO9obl/l7LzvwKb7CZXAC47oPzeo5v
        i7T139leNtZwPF92NLLbgW4q4FbuM2P8iAbAm1Yrpso6fyj6e896CTfrWNhU+RVG
        r8fdDWl9BH57tgVA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cbcd6bef (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 1 Sep 2018 20:18:47 +0000 (UTC)
Received: by mail-oi0-f50.google.com with SMTP id l202-v6so27502634oig.7;
        Sat, 01 Sep 2018 13:34:13 -0700 (PDT)
X-Gm-Message-State: APzg51DJiyxpZP793T8HHkP0xTm5g2Ub14/Jt1LKXbtZ4XMExbyp13ae
        SsUYClBYsJ54Xuuqnqyg8W5Fq4aJUnBS77nd4x4=
X-Google-Smtp-Source: ANB0Vdbfp4bbR0f/FGp4M78n5VpEzib2XmcUXSuInVFQJncSiGgbEHfCTLVJaKmF1NNxofZEnc8ODMr/CoP+kM8y4qw=
X-Received: by 2002:aca:310b:: with SMTP id x11-v6mr1193015oix.74.1535834052904;
 Sat, 01 Sep 2018 13:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com>
 <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de>
 <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com>
 <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
 <CAHmME9pP-rfzE9VAysm-tRiQrrKXpP2=8VEUrbS5Xt-wpEXCcA@mail.gmail.com> <CALCETrUdjCKcjg9R7P7hXxOt_Nt-htTVrJN9cwLfteh4aBz7Gw@mail.gmail.com>
In-Reply-To: <CALCETrUdjCKcjg9R7P7hXxOt_Nt-htTVrJN9cwLfteh4aBz7Gw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 1 Sep 2018 14:34:01 -0600
X-Gmail-Original-Message-ID: <CAHmME9rL2omQxqMVCcX-jPMpcQDk8ftEn3YXWcFhS=AkVK8ZXw@mail.gmail.com>
Message-ID: <CAHmME9rL2omQxqMVCcX-jPMpcQDk8ftEn3YXWcFhS=AkVK8ZXw@mail.gmail.com>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 1, 2018 at 2:32 PM Andy Lutomirski <luto@kernel.org> wrote:
> I tend to think the right approach is to merge Jason's code and then
> make it better later.  Even with a totally perfect lazy FPU restore
> implementation on x86, we'll probably still need some way of dealing
> with SIMD contexts.  I think we're highly unlikely to ever a allow
> SIMD usage in all NMI contexts, for example, and there will always be
> cases where we specifically don't want to use all available SIMD
> capabilities even if we can.  For example, generating random numbers
> does crypto, but we probably don't want to do *SIMD* crypto, since
> that will force a save and restore and will probably fire up the
> AVX512 unit, and that's not worth it unless we're already using it for
> some other reason.
>
> Also, as Rik has discovered, lazy FPU restore is conceptually
> straightforward but isn't entirely trivial :)

Sounds good. I'll move ahead on this basis.
