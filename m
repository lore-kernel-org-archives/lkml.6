Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661D9C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3902064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DiujcvEk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3902064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbeJBTNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:13:49 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:48379 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeJBTNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:13:48 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 87760f02
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 12:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ZUgnEYIHak7goDzeL/mEDWJbJE4=; b=Diujcv
        EknzYriCum5J8+xZ6zdIir9ONq2sBnXUNfCiIn9petpS2BEZRJgCgKyUn3JDIcEB
        +xa3fjMQrQfYXi+cs7IDyFZKPlcDs84a40w3VprRcYhyZjgor9e12SsKupP9Eowb
        piJteQBzLKHFJnJDOa3MqMlABqNx47g53Yq0MFXMIKnyHOhyJKJg+9smIXr5gAmo
        Ome/FdSpL0OAQ0Art5KqZ4y9D+Vqo9i+Zc8dW/eB9m0lyjmxwlBnoDdIpi0qt/Pg
        ppLw3sbskUPVuhEk6TNTybnzUm0xHiQsTXafG86yUWIgeN72KWLN0jkPHF4+PAj8
        9daORKgwDgsGHCdA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7eafd538 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 2 Oct 2018 12:30:38 +0000 (UTC)
Received: by mail-ot1-f51.google.com with SMTP id e18-v6so1659415oti.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 05:30:41 -0700 (PDT)
X-Gm-Message-State: ABuFfoi8fVPRldw3L5dof4/sDPcmBuZRZVvob7g6KbjX+XA73QMixxPj
        VnD1T6WwfB4f9/6odBXYOWrL4ZsSEDCZiAfwc04=
X-Google-Smtp-Source: ACcGV63HiigicaZ46+caHUiaHEZIsMPe1PSanx/5w+nyFk8rVSV/+bYb58iKh0cuHGYj1Bd6VYdwYdxxkhpDQURUKDI=
X-Received: by 2002:a9d:17d0:: with SMTP id j74-v6mr3433314otj.268.1538483441093;
 Tue, 02 Oct 2018 05:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180930024904.14240-1-Jason@zx2c4.com> <CAK8P3a0grG5OBjwpTeH0fqzoFFBLDH6-oGM4ibzHypUKWedg3A@mail.gmail.com>
 <CAHmME9rVbKCNJfVBEene0SvhBEm_g7N-XJ26ugoAab1Vj7G_ww@mail.gmail.com> <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com>
In-Reply-To: <CAK8P3a3TE8HW0wD9ETCDWMf7quDRx94-2iS6goYDQ18JQ6r=rw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 14:30:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9pFnuRx2F=xeyK8d3bwv3bJY+WvE1KZn__+2oFWS0RCnA@mail.gmail.com>
Message-ID: <CAHmME9pFnuRx2F=xeyK8d3bwv3bJY+WvE1KZn__+2oFWS0RCnA@mail.gmail.com>
Subject: Re: [PATCH] ARM: makefile: pass -march=armv4 to assembler even on CPU32v3
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>, arm@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Oct 2, 2018 at 9:58 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > I think we're going to wind up playing whack-a-mole in silly ways. The
> > fact of the matter is that the ARM assembly I'm adding to the tree is
> > for ARMv4 and up, and not for ARMv3.
>
> I don't see what issues remain. The 'reteq lr' that Ard mentioned
> is definitely the correct way to return from assembly (you also need
> that for plain armv4, as 'bx' was added in armv4t), and Russell
> confirmed that using -march=armv3m is something we want
> anyway for mach-rpc.

I'll do that. I can confirm that after changing it to `reteq lr`,
everything works well with armv3m.

> > I think there are three options to work around this issue:
> >
> > 1) Not build my assembly when CONFIG_CPU_32v3 via a Kconfig "depends".
> > 2) Set asflags-$(CONFIG_CPU_32v3) inside my module locally to select
> > -march=armv4.
> > 3) This patch.
> >
> > My initial plan was (1). ArdB recommended I do (2) instead. I thought
> > that was a bit too nuanced and submitted (3).
>
> I suspect all three of the above fail to work for armv4.

Armv4 does actually work in this configuration, in fact. But anyway,
I'll go with your primary suggestion and we therefore can move ahead
with changing the global cflag to march=armv3m. Would you like me to
submit the patch for this, or would yo like to handle it?

Jason
