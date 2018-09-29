Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2A5C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAAD0206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="rBMO7Vix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAAD0206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeI2I2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:28:39 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:45123 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726325AbeI2I2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:28:39 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f624277f;
        Sat, 29 Sep 2018 01:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=WWrCsfhVAJ6kulBSfJIoVMdB1ZM=; b=rBMO7V
        ixwMCYZYc7eVkPhm6/bClFCwAJFmFdhp45MD2mVL+IhoXTdq3jA4uiA4bquH8zlB
        qrh1m3EPHvNQEET0DvG0lIxFKv6OQZIXBJCEOCXX13zF+JIPbibDIXksMWkbmg/A
        TK0/SIDAacOCFQRYgx3KU3cMZiM92zYnCHtK4nzNFoyuHRLSNvEYt99OanGNLWBN
        DbYau4HPSxWFoeyp+oqMsm1lc1H2eAPyNhzfyxcT1U+5RTwcIwYPA6SBBhZ3i1kX
        xMtTju3AztEQ2TP8ckznJ55/PjAMW9bKU1lnWhxMiKz4E3TYCvggPZoowOBoOyT4
        0862Yji+cQMa0QcA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 43b7a49a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 29 Sep 2018 01:43:14 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id e17-v6so6121871oib.4;
        Fri, 28 Sep 2018 19:02:06 -0700 (PDT)
X-Gm-Message-State: ABuFfohFruDA48Y/3mL6wSNsbxG99D29Pd+jzHkFhbI5JnjWhQbviBvl
        zMkXp8f/cSivlTOwdyMGIpKAtH2BMHzdsCZ1Kzg=
X-Google-Smtp-Source: ACcGV63vdpK706wiAuuvAOTvN40Tsg6Pbfk9hTx3ke51IohTlB7Gww7gDQTcFHgH2mI+DNJcBGa3hDaYcaXn3tSO51g=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr574335oig.295.1538186524986;
 Fri, 28 Sep 2018 19:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-5-Jason@zx2c4.com>
 <CAKv+Gu9aOiYdEzHHrHFHUFK=hNfeS=zEsvMe9OWD8hEdAYkffg@mail.gmail.com>
In-Reply-To: <CAKv+Gu9aOiYdEzHHrHFHUFK=hNfeS=zEsvMe9OWD8hEdAYkffg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 29 Sep 2018 04:01:53 +0200
X-Gmail-Original-Message-ID: <CAHmME9rc5zgN4HhBy0_oq+EbEXdS8nePzA7qW39nocx_y4ay1Q@mail.gmail.com>
Message-ID: <CAHmME9rc5zgN4HhBy0_oq+EbEXdS8nePzA7qW39nocx_y4ay1Q@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/23] zinc: ChaCha20 x86_64 implementation
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, Sep 28, 2018 at 5:47 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Please drop this SOB line: SOB is not about (co-)authorship but about
> who handled the patch on its way into mainline.

The s-o-b line is about the DCoO, which is given here by both of us,
with the code starting in a shared tree that only had that s-o-b. I
can remove it though if you think it's strange to have two s-o-bs.

> You are sending the
> patch so your SOB should come last.

I was wondering about the ordering of these, actually. I've seen s-o-b
on top and s-o-b on bottom of the cc list in lots of commits and
haven't yet divined the One True Position.

> You can drop the #ifdefs above ...

Yep. All of those ifdefs in this and in the other primitives are
already gone, and everything is fully IS_ENABLEDenabled now.

> > +#ifdef CONFIG_AS_AVX512
>
> ... and use IS_ENABLED(CONFIG_AS_AVX512) here inside the if().

Already done, per your suggestion a few days ago.

> > -#ifndef HAVE_CHACHA20_ARCH_IMPLEMENTATION
>
> As I mentioned in reply to the previous patch, please get rid of this
> CPP symbol ^^^

Ack.

Jason
