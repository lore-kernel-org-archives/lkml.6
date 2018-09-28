Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E257C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13621215F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hQYpCSyE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13621215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbeI1UJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:09:26 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35371 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeI1UJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:09:26 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 956d62f0;
        Fri, 28 Sep 2018 13:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=85KEiH+HEWdpKzwre9WUKCPAVmc=; b=hQYpCS
        yEBui2BTppXXTZjzYeAQn2o8g17QP/odVZEWGEKDt0WkJ5fu25vFWRIxqJsm/3e5
        8k9G4zkQogbQUGg+TCSqry29VE7MNJKubWPeVPdiLqw7zfkFQG8sG+bjNHI6nkQt
        ioLN7OaImDW1dC/t12MbyXcvsdd/5X7fTyGW2/Q4jr/UwEd+U3xpZFJuVfjwwMBr
        P9xD7YN2J8I6ggD2AkrwWrj88LzT8rArpfr3Xci+0YJC/TOmK/IikRKOYD5DNKYG
        7Cv1wsEDbDRPi13C/JzirQ10BOgHuUl8AsXMDzAiqOEcNrNmpmQSOSfUtT/wP6sC
        mPKu4DzXnRHcMz4Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ff3735a0 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 28 Sep 2018 13:26:45 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id j9-v6so6103953otl.2;
        Fri, 28 Sep 2018 06:45:32 -0700 (PDT)
X-Gm-Message-State: ABuFfojiUTlzQQ2mhQKRgPJK/CE8OPZmckooCe5ggKO0mevmKaYgboRR
        0sfcZRgwo9fVPXihNnT6tsJJBKQvltoL94XsSyw=
X-Google-Smtp-Source: ACcGV63lA3OXiDC6pfETawgQC3g9svRNse0kvzZ7MO58ZaV9DvXy555E0K+iqpDCf9efPMSNw+t9b63E77DA09Chy4I=
X-Received: by 2002:a9d:1719:: with SMTP id i25-v6mr9530887ota.223.1538142331791;
 Fri, 28 Sep 2018 06:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-2-Jason@zx2c4.com>
 <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Sep 2018 15:45:20 +0200
X-Gmail-Original-Message-ID: <CAHmME9qpRSNZnPds8dcoObstWhMm_QXs55o=QHipLFfT7n=edg@mail.gmail.com>
Message-ID: <CAHmME9qpRSNZnPds8dcoObstWhMm_QXs55o=QHipLFfT7n=edg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/23] asm: simd context helper API
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:28 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Given that this patch applies to all architectures at once, it is
> probably better to drop the unrelated reordering hunks to avoid
> conflicts.

Ack. Will retain order for v7.

> > +static __must_check inline bool may_use_simd(void)
> > +{
> > +       return !in_interrupt();
> > +}
> > +
>
> Remember this guy?
>
> https://marc.info/?l=linux-arch&m=149631094625176&w=2
>
> That was never merged, so let's get it right this time.

Wow, nice memory. I had forgotten all about that. Queued for v7.

> > +static inline void simd_relax(simd_context_t *ctx)
> > +{
> > +#ifdef CONFIG_PREEMPT
> > +       if ((*ctx & HAVE_SIMD_IN_USE) && need_resched()) {
> > +               simd_put(ctx);
> > +               simd_get(ctx);
> > +       }
> > +#endif
>
> Could we return a bool here indicating whether we rescheduled or not?
> In some cases, we could pass that into the asm code as a 'reload'
> param, allowing repeated loads of key schedules, round constant tables
> or S-boxes to be elided.

Sure, sounds easy enough.
