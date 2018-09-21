Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF29ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16F9B21522
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 04:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="zL900dMg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16F9B21522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389095AbeIUKC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 06:02:59 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:48265 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389010AbeIUKC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 06:02:59 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id dabe48db;
        Fri, 21 Sep 2018 03:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=8QfnaCuM0dxs
        CaigjyeDr2rFBOQ=; b=zL900dMgclMhLbdwavVM29VwlonNqk+Yej9EnsgIbcrg
        4JHHasX+DXpFAjeIIbuLCBs0t5eSG3LsLWU7zPT3Gdenj5Jwo/PDYtwX6fgKn/KT
        sTaQTazTvY1ji9y+5uyAQma9KkIWBPPRMuZy0vlWD01g2qoQ6ti0Fdz/fnwxNnMH
        oPsQ9v5R/Xb+/9hwlST6X66+ppzP4tcEK+vaAcfugw3FF2UhwegOjHp6R6J6cYzH
        llceJKqY4jfIbQjsw+8/h5yl3G+sAuT7b5c4AuXO1yuIiwj6wpjh5uRm1W9n6uuW
        y8cVrdjDPxznM/cLd7bJRjPK5fxoJifJ4fBlARLDYQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a69cae28 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 21 Sep 2018 03:58:06 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id j9-v6so11757716otl.2;
        Thu, 20 Sep 2018 21:15:59 -0700 (PDT)
X-Gm-Message-State: APzg51DAp4tVn4mqbd676vSuDM1LoGUJpg6+BK4hFp5mv54KRUuiPonU
        Ssrii+mxt//oV7f+4Nex9zGYvqrKjuM3wXfbQ7Q=
X-Google-Smtp-Source: ANB0VdaFwWGYoUtcsRpNehvXL3aikTsRIJOHQULoxhD+I7obob+7OqSc1FLjscZd+EeCBBxEZvDiDueWyq3tutlYHh4=
X-Received: by 2002:a9d:6554:: with SMTP id q20-v6mr24856004otl.209.1537503358074;
 Thu, 20 Sep 2018 21:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-3-Jason@zx2c4.com>
 <CAKv+Gu-0oTBrg3T8TsNYPOdrmJSSC313-CYASO34kb_nviva6A@mail.gmail.com>
 <CAK8P3a0CS3QzEKEV5==qj8hUYgW+q2v1f13jA+s0TjQd8kYXFA@mail.gmail.com>
 <CAHmME9rJq=q7xj_E_84GN5FuzSW2KdP4Ch=y527Lem0ME4GnLg@mail.gmail.com>
 <20180921031255.GB11109@lunn.ch> <8FA361E3-FBCB-469E-88DC-F4085BD91175@amacapital.net>
In-Reply-To: <8FA361E3-FBCB-469E-88DC-F4085BD91175@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Sep 2018 06:15:46 +0200
X-Gmail-Original-Message-ID: <CAHmME9rF=FfOf-_EOB-BeT-BM=B9Q9YzFAoUimaPiM2RKb5sGA@mail.gmail.com>
Message-ID: <CAHmME9rF=FfOf-_EOB-BeT-BM=B9Q9YzFAoUimaPiM2RKb5sGA@mail.gmail.com>
Subject: Re: [PATCH net-next v5 02/20] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Sep 21, 2018 at 5:23 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
> At the risk on suggesting something awful: on x86_64, since we turn preem=
ption off for simd, it wouldn=E2=80=99t be *completely* insane to do the cr=
ypto on the irq stack. It would look like:
>
> kernel_fpu_call(func, arg);
>
> And this helper would disable preemption, enable FPU, switch to the irq s=
tack, call func(arg), disable FPU, enable preemption, and return. And we ca=
n have large IRQ stacks.
>
> I refuse to touch this with a ten-foot pole until the lazy FPU restore pa=
tches land.

Haha. That's fun, and maybe we'll do that at some point, but I have
some other reasons too for being on a workqueue now.

>
> All that being said, why are these frames so large?  It sounds like somet=
hing may be spilling that ought not to.

They're not. Well, they're not anymore. I had a silly thing before
like "u8 buffer[1 << 12]" in some debugging code, which is what
prompted the ccflag-y addition. I cleaned up the mistakes like that
and frames are now reasonable everywhere. Non-issue.

Jason
