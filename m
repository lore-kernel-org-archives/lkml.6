Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E1CC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF99208E7
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 13:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZIG2Dxaz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF99208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeJBT4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:56:15 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:41231 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbeJBT4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:56:14 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 25529fb5
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 13:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=vT+JTrUh6OPyKGbRNk5Vn6qy0oc=; b=ZIG2Dx
        azw+zSsM5nFc7qoOzzLDqWFsPrid+zy5TWYXbcNOP4E1frEU++3P86Bb79pRe35D
        7fzI2h+IufKjsZDH14MlJm3XNMnCIJrTw7ngQtUyVk4YkMoKQ3FEt0iaTJUbDsq8
        SvhBV3hB6ue0bs2+tmOCfuq4jgJdNDRM0BSvYXqboV0zMJvRZWXVkso9rNbWLNnn
        3ilnXHR5ope/rh1TgmR82Wru3x6ig10h55plu9aU/+N3ZNxBne3opdBvK1QnNiGR
        JpQ0yH5+OF+s9B8aD2MoJB1lePGsF+RdNaLLtASGw5Gcw8qU04+C3RyhI5hMtU4D
        /GPP8/aW8QP4I30Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8154a10e (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 13:12:53 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id w81-v6so1421586oiw.9
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 06:12:56 -0700 (PDT)
X-Gm-Message-State: ABuFfoh6pRGx7VhEu7EGLYxcYBD4iXsmBFeRYfM7Zs1B4GAWNFIgL6yR
        rap2ycNPXj7DMDaIb4WzvHl2VQ9uYGLbnyZhNkQ=
X-Google-Smtp-Source: ACcGV61CjYCJVFsFzdPPjvQocThWrJArH6yvr4S4/D9K62Q9bE6PImKouxCnDi77QxAr4eiw0ZVR86NDTCh2NZ2TLtQ=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr7088049oig.295.1538485975809;
 Tue, 02 Oct 2018 06:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20180930024904.14240-1-Jason@zx2c4.com> <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
 <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com>
 <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com>
 <CAHmME9pFnuRx2F=xeyK8d3bwv3bJY+WvE1KZn__+2oFWS0RCnA@mail.gmail.com> <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8NXyfNAzk4Fe=J0QHEEV-txbRAoEcQmjG-6PgCyW5SZg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 15:12:44 +0200
X-Gmail-Original-Message-ID: <CAHmME9oz2hFRjFeNSDLe59_pYn3HqB+5rWM5KsH7G_bUWaoy7Q@mail.gmail.com>
Message-ID: <CAHmME9oz2hFRjFeNSDLe59_pYn3HqB+5rWM5KsH7G_bUWaoy7Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, arm@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ard,

On Tue, Oct 2, 2018 at 3:10 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> It builds but it doesn't run, at least not when built into the kernel
> proper (which will be the case after random.c moves to this library)
>
> Your toolchain is implicitly passing --fix-v4bx to the assembler,
> which causes it to permit bx instructions in ARMv4 object code, but
> tag them with special R_ARM_V4BX ELF relocations. The ARM module
> loader does take these into account, so built as a module, it works.
> However, when built into the core kernel, we have to rely on the
> linker to patch this instruction into the ARMv4 equivalent, and a
> quick check reveals that that is currently not the case.
>
> Bottom line: let's not go there.

Oh, thanks a bunch for explaining that. Since I wrote the last email
I've been playing around with as, readelf, and qemu and was slightly
mystified.

>
> > But anyway,
> > I'll go with your primary suggestion and we therefore can move ahead
> > with changing the global cflag to march=armv3m. Would you like me to
> > submit the patch for this, or would yo like to handle it?
> >
>
> Yes please go ahead.

Alright, incoming in a few minutes.

Jason
