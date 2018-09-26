Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D1FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63E12156E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 17:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="STzC75qG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63E12156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbeIZXRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 19:17:45 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:39923 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728262AbeIZXRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 19:17:44 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5fd81665;
        Wed, 26 Sep 2018 16:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=2c4lzHE6xMXM
        GWOnCYyEiiWxKJ4=; b=STzC75qGc4Hy+QJzMV7nbukxMMWe0AHViatkRo9N32Md
        xUfJgjSSqkPy+myk/yp1Bksf0dikh3oem/63nUdW/mXkP2cajs689XNPB1tI6IhO
        3OIlLzbXDLNLtPYOTtDosQEYHi/DJ1lQ5ycS8cKnxkHw3PLDto0a4vq3m62+JloY
        rt0Bv8gdq+OAb45tPxeXhSKrXNHJMvwHc8Ib0aY3gHlIGQA0ifrZi444ar195tuD
        XlspMgXSdkXJPAnJ21Ouegi8cyBjuYAbk2WHdPJEbaGBB6gFBo5WgkqYI53l6f8L
        Rhimb1Gly9dw0/PYaBMKcetOLr7N8LV2vDgTatwplQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2538e568 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 16:45:13 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id n1-v6so5022761oic.4;
        Wed, 26 Sep 2018 10:03:47 -0700 (PDT)
X-Gm-Message-State: ABuFfojtiEmVtabDjPq4KdO5wZ/B92LRn1oIzPko5bwdIbnNDvhDBJnH
        bJdaIl5nX6wvetkZmpkdNAkfprP3hyRMZCoOL0c=
X-Google-Smtp-Source: ACcGV62ObtUsQy/TiUXeE4jVA7Bz2uUOWbJzSDLCFCuYkSvNIL1qJR8KlUyOInKTBGNCnJeKPQaOcYQRCtEvsAkxIO0=
X-Received: by 2002:aca:d4cd:: with SMTP id l196-v6mr1133667oig.15.1537981426102;
 Wed, 26 Sep 2018 10:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com> <D93C2C15-DC70-4A95-9350-AD4036C9556A@amacapital.net>
In-Reply-To: <D93C2C15-DC70-4A95-9350-AD4036C9556A@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Sep 2018 19:03:34 +0200
X-Gmail-Original-Message-ID: <CAHmME9pZKUMnnSZ0670rUH4H61g0x88c-B-DZYw_X-8+xgH-=g@mail.gmail.com>
Message-ID: <CAHmME9pZKUMnnSZ0670rUH4H61g0x88c-B-DZYw_X-8+xgH-=g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 6:21 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> Are, is what you=E2=80=99re saying that the Zinc chacha20 functions shoul=
d call simd_relax() every n bytes automatically for some reasonable value o=
f n?  If so, seems sensible, except that some care might be needed to make =
sure they interact with preemption correctly.
>
> What I mean is: the public Zinc entry points should either be callable in=
 an atomic context or they should not be.  I think this should be checked a=
t runtime in an appropriate place with an __might_sleep or similar.  Or sim=
d_relax should learn to *not* schedule if the result of preempt_enable() le=
aves it atomic. (And the latter needs to be done in a way that works even o=
n non-preempt kernels, and I don=E2=80=99t remember whether that=E2=80=99s =
possible.). And this should happen regardless of how many bytes are process=
ed. IOW, calling into Zinc should be equally not atomic-safe for 100 bytes =
and for 10 MB.

I'm not sure this is actually a problem. Namely:

preempt_disable();
kernel_fpu_begin();
kernel_fpu_end();
schedule(); <--- bug!

Calling kernel_fpu_end() disables preemption, but AFAIK, preemption
enabling/disabling is recursive, so kernel_fpu_end's use of
preempt_disable won't actually do anything until the outer preempt
enable is called:

preempt_disable();
kernel_fpu_begin();
kernel_fpu_end();
preempt_enable();
schedule(); <--- works!

Or am I missing some more subtle point?

Jason
