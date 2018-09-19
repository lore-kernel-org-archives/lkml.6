Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5919EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D47612146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 02:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="1rTVC63P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D47612146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730898AbeISHuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:50:16 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:36447 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730499AbeISHuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:50:15 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id a61134d9;
        Wed, 19 Sep 2018 01:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=glVk8zBWf+bAyxNXwAlRulDIPhU=; b=1rTVC6
        3PwAKWh6T9vqrTEgLe6qUMb51X3SgXCiJcRu2aEg0hl4luHeRexHMXyjm26HRD1b
        ec8QKeswdlsZrAeXSZTgB28o7QxwNLK4xyci8hHGrh+T7RK3g5Rti1NmppF21bN1
        3JFRKF1oie83VW0yktg4Ot3YUgZiOfr79V0edMRBBDf2qhVbelNuoPdhLKNBeLr5
        9Mddm5uz2eb3rJmAt7RiJgtSVqEiP+eyM5Tof9lMtH6Yzsy0E3JqLrB91Biw8Lyz
        9XUKkurYB5U58QQdYqahfXOtSy91WNSYpKtK9Za9sKuafaXBq+yStOCKN9hjtYKq
        h8D8tkikD9gOhnGQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 74d75822 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 19 Sep 2018 01:57:05 +0000 (UTC)
Received: by mail-oi0-f46.google.com with SMTP id y207-v6so3653515oie.13;
        Tue, 18 Sep 2018 19:14:43 -0700 (PDT)
X-Gm-Message-State: APzg51Ciz5f3IjZ5PdwSJYuSvKj70/hkCaCRmbhKLtNG+uF86N6L8aIu
        thxlrvxE1j52O2ZQPLevi/xZC2firJXGK3hlCRs=
X-Google-Smtp-Source: ANB0VdZZOYGRXxtJ6a0Tdtqrvyx5s2xRa5A9s9X0hRJhoUj26t+OcTiTfqSJ+rF+16vPyZ3FckiwAZb1ZPVByreNOYQ=
X-Received: by 2002:aca:df42:: with SMTP id w63-v6mr306416oig.295.1537323282564;
 Tue, 18 Sep 2018 19:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-5-Jason@zx2c4.com>
 <alpine.DEB.2.21.1809190017050.1468@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1809190017050.1468@nanos.tec.linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 04:14:31 +0200
X-Gmail-Original-Message-ID: <CAHmME9oARODJsrDbcNK7A22KrTRJP945hj9+oCJtQM6OjGF4Ag@mail.gmail.com>
Message-ID: <CAHmME9oARODJsrDbcNK7A22KrTRJP945hj9+oCJtQM6OjGF4Ag@mail.gmail.com>
Subject: Re: [PATCH net-next v5 04/20] zinc: ChaCha20 x86_64 implementation
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>, mingo@redhat.com,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Sep 19, 2018 at 12:30 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> I'm a bit confused by this SOB chain. So above you write that it's from
> Andy Polakovs implementation and Samuel did the changes. But here it seems
> you are the main author. If Samuel just did some modifications then you
> want to use the Co-developed-by tag along with his SOB.

Thanks, I'll use that tag.

>
> Also I'd recommend to add a Originally-by or Based-on-code-from: Andy
> Polyakov tag. Both are not formal tags but widely in use for attributions.

Great idea.

>
> > +++ b/lib/zinc/chacha20/chacha20-x86_64-glue.h
> > @@ -0,0 +1,100 @@
> > +/* SPDX-License-Identifier: MIT
>
> Please put that into a separate one liner comment. Also this should be
> 'GPL-2.0[+] or MIT' I think.

I had that originally, but changed it to just MIT, since MIT is a
subset of GPL-2.0. And looking at tree repo, it appears this is what
others do too.

Jason
