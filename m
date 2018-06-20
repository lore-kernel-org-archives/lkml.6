Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3354DC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFB620874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GcQ+Z8Ej"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFB620874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754192AbeFTBga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:36:30 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34129 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeFTBg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:36:26 -0400
Received: by mail-pg0-f67.google.com with SMTP id q4-v6so695824pgr.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 18:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MUOQWEkwH1Oe2tvHyWLyBtXxgcI19napO9k1/SDL2D4=;
        b=GcQ+Z8EjVeSnyhJYNXbAcV3lUKdb0KofVU7E3zl0sXRUejw3dM208V+sfVKCuAdNKf
         2q7Hd8bUNTCYrhdy3OB846fkswboo2jlXqkXCrlZ6j2++hw3THxtOy7oR3HduE2OxVWl
         dw3Zbuf09fGf7HinlvfoNFNhk+MeG7pbnBcwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MUOQWEkwH1Oe2tvHyWLyBtXxgcI19napO9k1/SDL2D4=;
        b=fqqXIEd6O9RO2o7c0kXK0Kv2cDzs/WKtAnex48Sw+4G6vyV8vZQ9b3PL8EVVK52+V3
         hL7HU0X+6rrFHuDG4EGwlKn/yXiJGrgtJ/s/4/d1o4U162FP7S1hLTCAiEdhHl/TriBC
         PSWJEBwKLfrYr6SO3lvYDHN19SqPcsm7wczyWD4K+d8fkDbOAyzZK62RMWQd05DkYZzj
         219XZjjeTm24YzODjiORaMIzYH7z5b+BIJRjH+dnxS8iYFYzD/s1DTDU5KvOX64awoMO
         +5yApFP4/GWXW5b8fHIrSRxLIFWNukyjkmA9nP1c6RDVW8wGy/m59xzVBqbfnXGrnxNS
         x9uA==
X-Gm-Message-State: APt69E1Ec7p/kFPkmI686bCoU/41619J9/kdiDwZrkltOWxO+X/X4C67
        YYrDtXGyyKrUkx5aCRyve68NFQ==
X-Google-Smtp-Source: ADUXVKLX7WV+Xcgif0JT0GXkoGT5eGwrbr/NOE30pWPZjYQefS5Zz/uk5NALy8Ftx7lz3H7h6z7SMw==
X-Received: by 2002:a62:8b0a:: with SMTP id j10-v6mr20420033pfe.28.1529458586066;
        Tue, 19 Jun 2018 18:36:26 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id l85-v6sm1297043pfk.79.2018.06.19.18.36.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 18:36:24 -0700 (PDT)
Date:   Tue, 19 Jun 2018 18:36:24 -0700
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
Message-ID: <20180620013624.GH169030@google.com>
References: <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
 <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
 <d6a99e26-b100-715b-2615-b77259ec8397@redhat.com>
 <66b5e5c3ed82a5e1559419deb841c57bf0751fd3.camel@perches.com>
 <20180619183622.GB169030@google.com>
 <7547dfd4045a5acf23505887065bc228e65f2ff9.camel@perches.com>
 <20180619211019.GE169030@google.com>
 <951ccf2a257fb8f8827f88e1c17ce64d23173e94.camel@perches.com>
 <20180619234543.GG169030@google.com>
 <366638527170f814bbe98f7189900ebf6c04d007.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <366638527170f814bbe98f7189900ebf6c04d007.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 05:18:02PM -0700, Joe Perches wrote:
> On Tue, 2018-06-19 at 16:45 -0700, Matthias Kaehlcke wrote:
> > On Tue, Jun 19, 2018 at 02:55:05PM -0700, Joe Perches wrote:
> > > Well, you advocate to disable a possibly useful warning globally ...
> > > You're advocating for making the code more complex/ugly for a
> > > condition where the result is identical.
> > My goal is no to make the code (slightly) more complex/ugly but have
> > the rest of the kernel benefit from a possibly useful warning.
> 
> For what case in the kernel is this warning useful?

It's less about finding errors that are currently in the kernel (I
don't know if there are any) and more about preventing new ones from
creeping in.

Code similar to the example from the link shared by Nick could easily
be part of some kernel driver:

https://wiki.sei.cmu.edu/confluence/display/c/EXP14-C.+Beware+of+integer+promotion+when+performing+bitwise+operations+on+integer+types+smaller+than+int
