Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0EF7C5AE59
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963D220693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 01:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="R4Q1P6f9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963D220693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937081AbeFSBuM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 21:50:12 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:40847 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934880AbeFSBuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 21:50:10 -0400
Received: by mail-qk0-f194.google.com with SMTP id r66-v6so10550498qkr.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 18:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0ibjPmdK67/VJOvCzG+NsNGMvU2IPKZSLnyxb4dVOAo=;
        b=R4Q1P6f9BjQA318v5ryW5hT363XbOdeS6SUxIyi/tkIFBVdlUXcSdGro43Q7Ouja0Y
         sw4i8cZ271NQObV0x/XcxZqYFj2oEOzjXTibKmb4Zd6s1zywGgQzzJY6vgSJuVSkA9pL
         SdC3L75qEMr1AguWiqZrHc3OIVROhdK859tpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0ibjPmdK67/VJOvCzG+NsNGMvU2IPKZSLnyxb4dVOAo=;
        b=Z3mjBLbpdIE6BEWK94NjwCxw7aaAdLm/4XOEjxkbKgQRG1V5oqejZAbCyjJbP77+Bh
         px/5sTQXSE27XQSwR/T3KcBupuQYWwUpkGm/Ifal5mCC3u6VjTW2VrY0E5T7idPFmeh+
         Nn1h5cO+nM+anK46RbReVgefX9z4J1sfFwybl4/So17m3G14Vgzn7ZpVSsTn2RYP9TGg
         J+MLjjpf75GGOO6+IMiXPf7ycm73pDbsnIs7QRKDV912ICDG48VcCOTqDFGRCkPy6muI
         pG/Xn4d5N6LEiUFRP0nA/qXqzYsPuzvmm4UdRls4deMeiHoNmIVn7S4XKgX0CZZ9tuxa
         13NQ==
X-Gm-Message-State: APt69E2+ysC7CWv+Aw0c5aUc5qbDRtKqfE/iWy/PlSymXVgn3PLLXcIK
        1hrzRi1jw+PEjiXl9AhZFHQciQ==
X-Google-Smtp-Source: ADUXVKIyEe5PaybT0eTo1jTnSnHhR8ROmfxxx/eZdKQ2Tcg80PQ+lgW7eeA+paWQMExqquKwybkwxg==
X-Received: by 2002:a37:2e46:: with SMTP id u67-v6mr11713489qkh.106.1529373010310;
        Mon, 18 Jun 2018 18:50:10 -0700 (PDT)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id k129-v6sm9764134qkd.13.2018.06.18.18.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 18:50:09 -0700 (PDT)
Date:   Mon, 18 Jun 2018 21:50:08 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] vt: coherence validation code for the unicode
 screen buffer
In-Reply-To: <CAHp75VfG_4zw+NPuHTUyH-gzdktiCKVcnWcwo0D_fAgfPbdk+A@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1806182110450.16670@knanqh.ubzr>
References: <20180617190706.14614-1-nicolas.pitre@linaro.org> <20180617190706.14614-5-nicolas.pitre@linaro.org> <CAHp75VfG_4zw+NPuHTUyH-gzdktiCKVcnWcwo0D_fAgfPbdk+A@mail.gmail.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2018, Andy Shevchenko wrote:

> On Sun, Jun 17, 2018 at 10:07 PM, Nicolas Pitre
> <nicolas.pitre@linaro.org> wrote:
> > Make sure the unicode screen buffer matches the video screen content.
> > This is provided for debugging convenience and disabled by default.
> 
> > +#define VC_UNI_SCREEN_DEBUG 0
> 
> > +       if (!VC_UNI_SCREEN_DEBUG || !uniscr)
> > +               return;
> 
> Hmm... Interesting. I would rather go with
> #ifdef ..._DEBUG
> ...
> #else
> return;
> #endif
> 
> It will relax requirement on how to define _DEBUG. I don't recall I
> see something like you proposing in the kernel for the same purpose.

Some random examples:

include/crypto/scatterwalk.h:106;
                if (ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE && !PageSlab(page))

include/math-emu/single.h:68:
    if (!FP_INHIBIT_RESULTS)

This form also allows for the compiler to parse and validate the code 
whether or not the feature is enabled, while still optimizing it away in 
the end if not enabled.

> > +
> > +       WARN_CONSOLE_UNLOCKED();
> > +
> > +       /*
> > +        * Make sure our unicode screen translates into the same glyphs
> > +        * as the actual screen. This is brutal indeed.
> > +        */
> > +       p = (unsigned short *)vc->vc_origin;
> > +       mask = vc->vc_hi_font_mask | 0xff;
> > +       for (y = 0; y < vc->vc_rows; y++) {
> > +               char32_t *line = uniscr->lines[y];
> > +               for (x = 0; x < vc->vc_cols; x++) {
> > +                       u16 glyph = scr_readw(p++) & mask;
> > +                       char32_t uc = line[x];
> > +                       int tc = conv_uni_to_pc(vc, uc);
> > +                       if (tc == -4)
> > +                               tc = conv_uni_to_pc(vc, 0xfffd);
> > +                       if (tc == -4)
> > +                               tc = conv_uni_to_pc(vc, '?');
> > +                       if (tc != glyph)
> 
> > +                               pr_notice("%s: mismatch at %d,%d: "
> > +                                         "glyph=%#x tc=%#x\n", __func__,
> > +                                         x, y, glyph, tc);
> 
> Don't split format string in printk(). checkpatch will not warn on longer lines.

I didn't do it like that for checkpatch but to keep the code readable.
I don't particularly care either ways though.


Nicolas
