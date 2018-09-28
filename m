Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804B0C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46699215F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GRgsD8nk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46699215F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeI1ULU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:11:20 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:53461 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeI1ULT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:11:19 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5f7dd145;
        Fri, 28 Sep 2018 13:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=8zNqg5sjcogZBT5WwrzisBc2jiY=; b=GRgsD8
        nkMYpLtsfkBrga8qwOHIpPi0B14Y7X+N64/3ibiyahwN2kc215DXut5bU+5Guh7j
        Vu7FT88ceJYCbKexqV4mGDucN1oMIN88YvfDRxIivBhGuo0O8xz6K6F2h3b+krUD
        bM4ZK6yVFV1WzQwI/PVDy/KA6qMJDkaIvGmOtHoJ/IrJKnGVsv7gkjQnAKf6s5Q2
        T2ITvs/0gVxIpUGdrkh0S1s63gR9PqXsjuFjL8tTSCtgCloHnz1mSQ3WsHZx2FvQ
        G4KdnjN+f8JyZPIHtrVIf4hFsljrDxFzsTBFQWSXq/FPrEVH+084FyMSSsJbaVg0
        Lr7x1FT681tZIdSw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7469f1f6 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 28 Sep 2018 13:28:39 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id j9-v6so6109677otl.2;
        Fri, 28 Sep 2018 06:47:26 -0700 (PDT)
X-Gm-Message-State: ABuFfoia0daBd8Amk3CpXDomp6SLDjVmpBmkdMxEo+sFkJji+JbmBKK3
        Etkd2IlNKIgKwvpG87B9xnwzR711PwygLqote5E=
X-Google-Smtp-Source: ACcGV60QMwim4MG8qWkYtHVJF7PrCm2xkgKMzQUfYAE4Srrv9OvxeymCdTyJ60M8G3TOi19al7jqv1M21TE/mZ+iikU=
X-Received: by 2002:a9d:42c3:: with SMTP id c3-v6mr9503602otj.54.1538142445660;
 Fri, 28 Sep 2018 06:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-2-Jason@zx2c4.com>
 <CAKv+Gu9e35+AyktmSq9qeNE0LR83_yrEEB3DiQv0bmyArivqRQ@mail.gmail.com> <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu9kbLPZH4W0zKAfuv-b11mcDaZ05HUauvh9gMZVGVR0AQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Sep 2018 15:47:14 +0200
X-Gmail-Original-Message-ID: <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com>
Message-ID: <CAHmME9pfs0_MsD9QAGfSm31_w-=6BCF_gZO04XkfhD=mEoZmtQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 01/23] asm: simd context helper API
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Sep 28, 2018 at 10:49 AM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> >> +typedef enum {
> >> +       HAVE_NO_SIMD = 1 << 0,
> >> +       HAVE_FULL_SIMD = 1 << 1,
> >> +       HAVE_SIMD_IN_USE = 1 << 31
> >> +} simd_context_t;
> >> +
>
> Oh, and another thing (and I'm surprised checkpatch.pl didn't complain
> about it): the use of typedef in new code is strongly discouraged.
> This policy predates my involvement, so perhaps Joe can elaborate on
> the rationale?

In case it matters, the motivation for making this a typedef is I
could imagine this at some point turning into a more complicated
struct on certain platforms and that would make refactoring easier. I
could just make it `struct simd_context` now with 1 member though...
