Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957A9C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE832073F
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="D58wREGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE832073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeI2IrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:47:14 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39421 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727351AbeI2IrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:47:14 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5ad6ee9b;
        Sat, 29 Sep 2018 02:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=mv2dSoGLO22zS0xIK2LqyVeb/uM=; b=D58wRE
        GOVeKmNNXdF5ebyEfl4KZKE3p0l9qVKA9g/MKNq9ALZZ4uK/mWWmIupWO6x/zgVM
        atpOKye7ETKHc0SjIGFEOKtaIcINZJ/aCcHu6mkSTqrKvieH3z+AXvJ2LFeXTlMN
        mS+h6EZuG+Rxf1H7kUifstDO48smuJNuC115rCDDJ6OLs/35qgyiGFo9iMKSbQ1k
        8ryiZmqMJd+PoSYXxBxTKKQTUKKJ+oM7ElVQWh+VfcrTZlZNbzWiboVxS2esU0Xy
        SF0Cn8qcLJGtVU9yLloPp5Qs6HZn6DVNnPEYXPfMcv2Cryjd1LPsarapbjH3iIjf
        FhdSp4VoaXR19OUQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2ea1a21b (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 29 Sep 2018 02:01:46 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id m23-v6so7907283otf.0;
        Fri, 28 Sep 2018 19:20:37 -0700 (PDT)
X-Gm-Message-State: ABuFfojKmokaiIXHnoSygVPUlV0c35TIB7qMNaYSM7QEpEHu+HSqrIu1
        5EVE7aY+NoVdDXIaxQSLxdLh03eZiTHnYGHyKI8=
X-Google-Smtp-Source: ACcGV63501DXuehFmFA5b/WOBK/ievuUKSF6OGbGPiU9Vy/Juya3W/pXWDveS97plJ3gJ8fI1+w93GGhZkBDnmqpydk=
X-Received: by 2002:a9d:fae:: with SMTP id d43-v6mr846041otd.199.1538187636658;
 Fri, 28 Sep 2018 19:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu8knzzmK4_KouFQWKzMdHFgEsk-CtBrcuAvk0bYkDFO=w@mail.gmail.com>
In-Reply-To: <CAKv+Gu8knzzmK4_KouFQWKzMdHFgEsk-CtBrcuAvk0bYkDFO=w@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 29 Sep 2018 04:20:24 +0200
X-Gmail-Original-Message-ID: <CAHmME9qtN8kiKnMHTa76r9a_5Ou_s3WhAMT_HnH7-1FeoHUOZg@mail.gmail.com>
Message-ID: <CAHmME9qtN8kiKnMHTa76r9a_5Ou_s3WhAMT_HnH7-1FeoHUOZg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Fri, Sep 28, 2018 at 6:02 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> Please put comments like this below the ---

git-notes is nice for this indeed.

> Are these CONFIG_ symbols defined anywhere at this point?

Yes, they're introduced in the first zinc commit. There's no git-blame
on git.kernel.org, presumably because it's expensive to compute, but
there is on my personal instance, so this might help:
https://git.zx2c4.com/linux-dev/blame/lib/zinc/Kconfig?h=jd/wireguard

> In any case, I don't think these is a reason for these, at least not
> on ARM/arm64. The 64-bitness is implied in both cases

You mean to say that since these nobs are def_bool y and are
essentially "depends on ARM", then I should just straight up use
CONFIG_ARM? I had thought about this, but figured this would make it
easier to later make these optional or have other options block them
need be, or even if the dependencies and requirements for having them
changes (for example, with UML on x86). I think doing it this way
gives us some flexibility later on. So if that's a compelling enough
reason, I'd like to keep those.

> and the
> dependency on !CPU_32v3 you introduce (looking at the version of
> Kconfig at the end of the series) seems spurious to me. Was that added
> because of some kbuild robot report? (we don't support ARMv3 in the
> kernel but ARCH_RPC is built in v3 mode because of historical reasons
> while the actual core is a v4)

I added the !CPU_32v3 in my development tree after posting v6, so good
to hear you're just looking straight at the updated tree. If you see
things jump out in there prior to me posting v7, don't hesitate to let
me know.

The reason it was added was indeed because of:
https://lists.01.org/pipermail/kbuild-all/2018-September/053114.html
-- exactly what you suspected, ARCH_RPC. Have a better suggestion than
!CPU_32v3? It seems to me like so long as the kernel has CPU_32v3 as a
thing in any form, I should mark Zinc as not supporting it, since
we'll certainly be at least v4 and up. (Do you guys have any old Acorn
ARM610 boxes sitting around for old time's sake at LinaroHQ? ;-)

> > +#endif
> > +
>
> No need to make asmlinkage declarations conditional

Yep, addressed in the IS_ENABLED cleanup.

>
> if (IS_ENABLED())

Sorted.

>
> """
> if (!IS_ENABLED(CONFIG_ARM))
>    return false;
>
> hchacha20_arm(x, derived_key);
> return true;
> """
>
> and drop the #ifdefs

Also sorted.

Regards,
Jason
