Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D04C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906EB2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cttwwr7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906EB2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754178AbeFTXAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:00:21 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46895 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeFTXAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:00:19 -0400
Received: by mail-pf0-f196.google.com with SMTP id q1-v6so498827pff.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yn1XqboOcbrKOurKT7uzIZpp2/lTqgO4+WGxvsb+928=;
        b=Cttwwr7HQhyUqQaahdaPyWyIcjON6/NgwDie4nGgBuu7l3wXkFofd6iFWk6Q+7PLwc
         tqvnNawnQekpogVRWwSKlXkUUcuEbcjBhAjMuzd5v4L37r/skx6HyZxZ42R8Vj/LN97R
         BsoaiEcXP+Ffduco2obKIMouyHNbirmjN9/E8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yn1XqboOcbrKOurKT7uzIZpp2/lTqgO4+WGxvsb+928=;
        b=BL4/tYlM8FEIQT0i9CI0YRHlu2LZCLe9wZ4t2ND+JfkuG+0cq5K4ngnQYcsedzkPSU
         CqC1MIVD/MaYruCFXfww1uFi8W2e6+H+XhUi9my6tvRKIDhGog78eHuyDN7rGYYAOEvU
         q+pVSI4IgHxXd6jYund1lkZpfumSpJ585LLwYcjWyjgccx4pe5Vyu4gxjFn7phg98aAx
         8bFu5kFeiDHeV4A8+G/1koAcrLMPECGMWR63YtAjdZ/26QQFA2IxQi+RlLGv3k54NFQO
         QMZhIHMo8a61Rrf9NAz8/hzwjf4AysllnSc6uRHdfaiJSCXybiMYkyfxMVVFA+CU391F
         chxg==
X-Gm-Message-State: APt69E0R5CW+z1yBfunBFn217UMpE5oW0oMuN1Vc+p8cyxl0UHpv7rbW
        QwYNUKOaJjXa+1RKF/EhxQq88XsY9+U=
X-Google-Smtp-Source: ADUXVKK3II6XaOIJcx9t2hN2r0oC463bpTseJic9UaxA5GRg82AFRT+fzGioFpU4dKULqAd2OxPh+g==
X-Received: by 2002:a62:8d03:: with SMTP id z3-v6mr24314979pfd.112.1529535619190;
        Wed, 20 Jun 2018 16:00:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id e24-v6sm4754316pfi.70.2018.06.20.16.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 16:00:17 -0700 (PDT)
Date:   Wed, 20 Jun 2018 16:00:17 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
Message-ID: <20180620230017.GI169030@google.com>
References: <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
 <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
 <d6a99e26-b100-715b-2615-b77259ec8397@redhat.com>
 <66b5e5c3ed82a5e1559419deb841c57bf0751fd3.camel@perches.com>
 <20180619183622.GB169030@google.com>
 <7547dfd4045a5acf23505887065bc228e65f2ff9.camel@perches.com>
 <20180619211019.GE169030@google.com>
 <951ccf2a257fb8f8827f88e1c17ce64d23173e94.camel@perches.com>
 <20180619234543.GG169030@google.com>
 <c1d26d79-6e0c-fca8-af3c-e97af47b6b5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c1d26d79-6e0c-fca8-af3c-e97af47b6b5f@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:02:15AM +0200, Paolo Bonzini wrote:
> On 20/06/2018 01:45, Matthias Kaehlcke wrote:
> > 
> > v4.16 with an x86 allyesconfig and a few drivers disabled since they
> > don't build with clang (yet):
> > 
> > 16 occurrences of -Wconstant-conversion, including the ones fixed by
> > this patch. Certainly no need for an endless churn of patches, and
> > given the limited number it also doesn't seem likely that new
> > instances will be added on a regular base.
> 
> Thanks for providing numbers!  The next question is: how many of these
> 16 occurrences are actual bugs?

Probably none.

> This is what measures the usefulness of the warning.

I very much doubt that this is a useful metric given the limited
number of occurrences.

Let's assume that 1 out of 20 patches not doing the cast have an
actual problem. For 16 occurrences this means there's a 44% chance
that none of these instances is an error (18.5% for 1 out 10). This
is without taking into account that some of the instances are in the
same file and likey similar (as in the KVM case), and that most of the
code has undergone years of testing in the field.
