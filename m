Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BEFAC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D7320661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZdVU1FD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D7320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967191AbeFSSg0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:36:26 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34275 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967140AbeFSSgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:36:24 -0400
Received: by mail-pg0-f66.google.com with SMTP id q4-v6so266895pgr.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 11:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mmcw59e5stFa2JNE+Va33BOiwI3TvIcmetVDKv9o1hQ=;
        b=oZdVU1FD/YZ8/n1bIzNoQPwx1hpl2TOViQboKZrwigskZGV2OR/268RrWrDhK1DiFE
         kHSAH9LFlM2zxxBCma06LkisbyM2WbcSadhKeF6MogT6WDamL4a1PfPPukVBXnutgMuG
         mbpUD8Sj36WtmQuFHThEmLw+jdDnWT2ap9XIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mmcw59e5stFa2JNE+Va33BOiwI3TvIcmetVDKv9o1hQ=;
        b=EW6QA+vLtGJbTvkvsCioFJ0gJe1YutPT9XpiMCTPzb/PTILi3VUvTrOAJZCiWOB/ko
         VXNpImQvS/MfXDoTCJTBpU5ojkBJeIAXyNUyr4r4Y5VsKxEXV6/ywZLzHjIjt2b7Hpyi
         wuk0y1Q/ItOXPAgpCv1YhPjH+QjngjxNNv8+EmwTKbrWraotcPOP2qXV3aq1hq1Ero+7
         qDqGEqo53E7OLAZFdzPf0uDRNVFk9/Ni6uYkSItqBfA683Nw+/Dfz4ELmabPFaC82RqR
         6ATBOuQVqruyajbu3EGXThcbWtiSW15maTToRZ71Gn6rN5PAxFQhN/TUWraKM9UtJOoX
         mmRw==
X-Gm-Message-State: APt69E1LDYTHsW6q8gF0tDGItUteszBClx2mL2FkWUg6Nuz4fyG3Wn5s
        YpVLq0oK4cHqOTo7D0+EA2Y8lw==
X-Google-Smtp-Source: ADUXVKKwagIghQEKD35t9BitX8+ww+WTNc2l/mGfcs42jiD6gzsm6WJhLPXUuQSXUGr60T6/Tet4iQ==
X-Received: by 2002:a63:a44a:: with SMTP id c10-v6mr15629213pgp.198.1529433383657;
        Tue, 19 Jun 2018 11:36:23 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id 63-v6sm547940pfo.1.2018.06.19.11.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:36:22 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:36:22 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
Message-ID: <20180619183622.GB169030@google.com>
References: <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
 <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
 <20180615182945.GN88063@google.com>
 <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
 <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
 <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
 <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
 <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
 <d6a99e26-b100-715b-2615-b77259ec8397@redhat.com>
 <66b5e5c3ed82a5e1559419deb841c57bf0751fd3.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <66b5e5c3ed82a5e1559419deb841c57bf0751fd3.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:07:47AM -0700, Joe Perches wrote:
> On Tue, 2018-06-19 at 19:35 +0200, Paolo Bonzini wrote:
> > On 19/06/2018 19:23, Joe Perches wrote:
> > > On Tue, 2018-06-19 at 10:08 -0700, Nick Desaulniers wrote:
> > > > On Tue, Jun 19, 2018 at 8:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > > 
> > > > > On 15/06/2018 20:45, Nick Desaulniers wrote:
> > > > > > > 
> > > > > > > > In any case I think it it preferable to fix the code over disabling
> > > > > > > > the warning, unless the warning is bogus or there are just too many
> > > > > > > > occurrences.
> > > > > > > 
> > > > > > > Maybe.
> > > > > > 
> > > > > > Spurious warning today, actual bug tomorrow?  I prefer to not to
> > > > > > disable warnings wholesale.  They don't need to find actual bugs to be
> > > > > > useful.  Flagging code that can be further specified does not hurt.
> > > > > > Part of the effort to compile the kernel with different compilers is
> > > > > > to add warning coverage, not remove it.  That said, there may be
> > > > > > warnings that are never useful (or at least due to some invariant that
> > > > > > only affects the kernel).  I cant think of any off the top of my head,
> > > > > > but I'm also not sure this is one.
> > > > > 
> > > > > This one really makes the code uglier though, so I'm not really inclined
> > > > > to applying the patch.
> > > > 
> > > > Note that of the three variables (w, u, x), only u is used later on.
> > > > What about declaring them as negated with the cast, that way there's
> > > > no cast in a ternary?
> > > 
> > > It'd be simpler to cast in the BYTE_MASK macro itself
> > 
> > I don't think that would work, as the ~ would be done on a zero-extended
> > signed int.
> 
> True, but the whole concept is dubious.
> The implicit casts are all over the place,
> not just in the file.

Would that have been any different with the solution you proposed (if
it worked)?

Apparently both gcc and clang limit the warning to the potentially
more problematic case where a value with sign bit is promoted.
