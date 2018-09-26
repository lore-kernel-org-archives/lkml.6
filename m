Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7656EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DBC21524
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:45:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="C5Dnm0oA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DBC21524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeIZV7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:59:08 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54209 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbeIZV7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:59:08 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 01dd254b;
        Wed, 26 Sep 2018 15:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Ye0gNrGAiMxFaM5DVYfED5qBxwU=; b=C5Dnm0
        oAKO6AqKkfiQly1sKoeIjVDbkY05p38EWfb3kfx21bQW81uYyYWfjMNkhmz4syQT
        iCTmUXitavt+DPfeWs43L632DJV/3UVMIIoq19/nmbabNdLvnXDheMYr3iJxtkH8
        Hgc4y0UTyQyQPpbdfO2BtQW43hDH8GLK1Cv8gsceqi6Mgf4j8hn8Lzo7P4NAgR82
        pUdyq+94EYtCXeGI6Brz77WIiEDLUqeQUjNy7maZUcFWMVK6MduyZtosTI4dHkh0
        YGbpqEDPiXVlFkV9BI5xt7gFmoDs5lTjKDdXqLlnv68DoQO3cCiSs5yTXWaNQuKa
        r52IZEJIospOWA9A==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 97307b1f (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 15:26:59 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id h26-v6so28604269otl.9;
        Wed, 26 Sep 2018 08:45:32 -0700 (PDT)
X-Gm-Message-State: ABuFfojXEoQG2ltE8gM/xF2qQ15wmKYhv443vmFvpEqse2A1wg/BzgZG
        x1Dl3euO2QoLpNnD7efXe+69uwkt25hyOGbLBCw=
X-Google-Smtp-Source: ACcGV60gMSyNjzZVQfR+P7TtA7d2qRLrtvEQaU/EVG1d0TltSL0anO4Yek/Dy/NvHSOdESk4YsgjyB5NYOdjZ9soNdI=
X-Received: by 2002:a9d:6554:: with SMTP id q20-v6mr4757686otl.209.1537976731409;
 Wed, 26 Sep 2018 08:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com> <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
In-Reply-To: <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Sep 2018 17:45:20 +0200
X-Gmail-Original-Message-ID: <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com>
Message-ID: <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 5:42 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Wed, 26 Sep 2018 at 16:02, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Actually, looking at the code again, the abstraction does appear to be
> fine, it is just the chacha20 code that does not make use of it.

So what you have in mind is something like calling simd_relax() every
4096 bytes or so?
