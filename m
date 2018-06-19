Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A75C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB09920652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jYZ7CuAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB09920652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755616AbeFSVK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:10:26 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36591 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755295AbeFSVKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:10:21 -0400
Received: by mail-pg0-f67.google.com with SMTP id m5-v6so430998pgd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 14:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vOYa5OpgbJlcJWnIOeuyZvyutSknJw7DZ/BkQNkD//4=;
        b=jYZ7CuAcc41u8I5+Yy360rjcdl+f+eHaLw492EUi3Z27RpqDHveH7A/1+DWVek5Iuv
         pkbJxEIzSvbdcjfGnNQGdT6aleb1npaalT4oJKf/IrpU9dXljLJ6WNMA38rIcYauH3BV
         JpK8//PE2O47vUdGV2SfVPNA7NrFjg0JQouUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vOYa5OpgbJlcJWnIOeuyZvyutSknJw7DZ/BkQNkD//4=;
        b=aCaibtL0U+1KQr3a1arKD71S0akyhhk1bYE0l1FVhMQvcnGJNhNBBE8X+ykFawruMU
         /S1eBDojIIVG829sVVjoXDNY0huYvOysWsjS/sTYhopvYN76oJw3rVyttO/jHXTAodzi
         bDDPuMRSXN2qlzXeyh9xotMRFZ1btCpIYt1EG1CHuHgjO8Vpq5MgOtv2DAn8Ox5QESZ5
         r9J2dU4IcRiZurusAepOe5CX0DUkVfVM2VkfCm9kHdU8PVAUxj++ZQVYfZMpWXUxdB6G
         Zx+EsSJfsAcJy3jhDCt69FpvKOgbJi7cxubxuKCZxgjOusrRtOqi0HIH1YINefAJUlQF
         nWfQ==
X-Gm-Message-State: APt69E3UgrQUFqiTFceHrX1pQRHLG4MBTO7aYivN9awRLEMSbsV5hKVZ
        yCgStspdKMvpLtcK1LI1gt8paw==
X-Google-Smtp-Source: ADUXVKKCwjz8LW1NmLKzbhzqkcmIIRzggPpfOeIYJUrSQ4q9+xeL/AlPkKpbEXpO76/ipTtX+Qamwg==
X-Received: by 2002:a63:5f12:: with SMTP id t18-v6mr15866958pgb.81.1529442621110;
        Tue, 19 Jun 2018 14:10:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:1501:8e2d:4727:1211:622])
        by smtp.gmail.com with ESMTPSA id v26-v6sm681265pfe.13.2018.06.19.14.10.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 14:10:20 -0700 (PDT)
Date:   Tue, 19 Jun 2018 14:10:19 -0700
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
Message-ID: <20180619211019.GE169030@google.com>
References: <20180615182945.GN88063@google.com>
 <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
 <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
 <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
 <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
 <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
 <d6a99e26-b100-715b-2615-b77259ec8397@redhat.com>
 <66b5e5c3ed82a5e1559419deb841c57bf0751fd3.camel@perches.com>
 <20180619183622.GB169030@google.com>
 <7547dfd4045a5acf23505887065bc228e65f2ff9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7547dfd4045a5acf23505887065bc228e65f2ff9.camel@perches.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 12:11:27PM -0700, Joe Perches wrote:
> On Tue, 2018-06-19 at 11:36 -0700, Matthias Kaehlcke wrote:
> > On Tue, Jun 19, 2018 at 11:07:47AM -0700, Joe Perches wrote:
> > > On Tue, 2018-06-19 at 19:35 +0200, Paolo Bonzini wrote:
> > > > On 19/06/2018 19:23, Joe Perches wrote:
> > > > > On Tue, 2018-06-19 at 10:08 -0700, Nick Desaulniers wrote:
> > > > > > On Tue, Jun 19, 2018 at 8:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > > > > > 
> > > > > > > On 15/06/2018 20:45, Nick Desaulniers wrote:
> > > > > > > > > 
> > > > > > > > > > In any case I think it it preferable to fix the code over disabling
> > > > > > > > > > the warning, unless the warning is bogus or there are just too many
> > > > > > > > > > occurrences.
> > > > > > > > > 
> > > > > > > > > Maybe.
> > > > > > > > 
> > > > > > > > Spurious warning today, actual bug tomorrow?  I prefer to not to
> > > > > > > > disable warnings wholesale.  They don't need to find actual bugs to be
> > > > > > > > useful.  Flagging code that can be further specified does not hurt.
> > > > > > > > Part of the effort to compile the kernel with different compilers is
> > > > > > > > to add warning coverage, not remove it.  That said, there may be
> > > > > > > > warnings that are never useful (or at least due to some invariant that
> > > > > > > > only affects the kernel).  I cant think of any off the top of my head,
> > > > > > > > but I'm also not sure this is one.
> > > > > > > 
> > > > > > > This one really makes the code uglier though, so I'm not really inclined
> > > > > > > to applying the patch.
> > > > > > 
> > > > > > Note that of the three variables (w, u, x), only u is used later on.
> > > > > > What about declaring them as negated with the cast, that way there's
> > > > > > no cast in a ternary?
> > > > > 
> > > > > It'd be simpler to cast in the BYTE_MASK macro itself
> > > > 
> > > > I don't think that would work, as the ~ would be done on a zero-extended
> > > > signed int.
> > > 
> > > True, but the whole concept is dubious.
> > > The implicit casts are all over the place,
> > > not just in the file.
> > 
> > Would that have been any different with the solution you proposed (if
> > it worked)?
> > 
> > Apparently both gcc and clang limit the warning to the potentially
> > more problematic case where a value with sign bit is promoted.
> 
> I think the warning is exactly equivalent to -Wsign-conversion
> and we don't normally compile the kernel with that either.

I disagree with "exactly equivalent". With -Wsign-conversion a warning
is generated whenever a signed type is assigned to an unsigned
variable or viceversa.

-Wconstant-conversion is only issued when a *constant value* is assigned to
an incompatible type.

> Trying to allow a "make W=3" to be compiler warning message free
> is also silly.
> 
> I think it's better to make the warning emitted only at a W=3
> level instead.

Another difference with -Wsign-conversion is that enabling it would
probably result in thousands of warnings. Do you have evidence that
there is a significant number of spurious -Wconstant-conversion
warnings?
