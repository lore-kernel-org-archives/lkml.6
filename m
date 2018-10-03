Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2F2C64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E73520878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="vBrAsMr2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E73520878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJCJ5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:57:37 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56429 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbeJCJ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:57:37 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5121f873;
        Wed, 3 Oct 2018 03:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=yOvHGQSsuxbS9p8SsM8HIZThH+g=; b=vBrAsM
        r2cGPNYOoICgxJ9s9fg5ccUs9WruKiFEAHby7tHqJpZqFU9rhQZ+9ZwAZdOkVwaD
        THgViWxlQO5SM/q/jeNMLpf4wtTOqg5muZbuCSn3PWOOz6AqPGwOrYFJIvs6H1AF
        FB2SJQ80t7bNVn4cimeJ7X8UyQRHfUqBxG8mk3ZhZxU5WIn3P7jjWk4z+0j0YBko
        hcO+0m5xhoejFRlP9NtoXStrDjWWLd1/Uw/6S4tC9LroJvvwDryYPg8JVYAZH/VA
        NwgEQJpgOrNhLwnGPhm9zcM26AKbaJiKq9wjjB+F22BDNS7cAH7vyag5N/BtAzNd
        k7oaUzuRHExeKJow==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6c7026f7 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 3 Oct 2018 03:11:02 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id 36-v6so4094034oth.11;
        Tue, 02 Oct 2018 20:11:09 -0700 (PDT)
X-Gm-Message-State: ABuFfoiXyTNRqa0uCR6tTLv3Ncvh0wpbFJEntqldin1P0Sapplw4RxS6
        Y3XwyS7nLiMf8SML1+Dq/6QQH6bxIQ9h1+5v74o=
X-Google-Smtp-Source: ACcGV62xJyJ2FZrOlwsN+QGyBP+u3WejdxdTOjggg6GxpB9e3qiIZOI07MkA2sRA1V1R4a2Ab7qwMR5w2idutuB94Eo=
X-Received: by 2002:a9d:17d0:: with SMTP id j74-v6mr5198870otj.268.1538536268191;
 Tue, 02 Oct 2018 20:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-20-Jason@zx2c4.com>
 <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
In-Reply-To: <CAKv+Gu9FLDRLxHReKcveZYHNYerR5Y2pZd9gn-hWrU0jb2KgfA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 3 Oct 2018 05:10:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9ojGATK+AcFLL2Fij_7XCW-=HBzjtkRqiitCH=p5=8KEA@mail.gmail.com>
Message-ID: <CAHmME9ojGATK+AcFLL2Fij_7XCW-=HBzjtkRqiitCH=p5=8KEA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 19/23] zinc: Curve25519 ARM implementation
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

On Tue, Oct 2, 2018 at 6:59 PM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Could you elaborate on what qhasm is exactly? And, as with the other
> patches, I would prefer it if we could have your changes as a separate
> patch (although having the qhasm base would be preferred)

By the way, as of a few minutes ago, if you look in the development
tree at the commit called "zinc: Curve25519 ARM implementation", that
now shows the diffs to the original, as you requested. I'll probably
obsess over that a little bit more before v7, but if you see anything
gnarly there beforehand, I'd be happy to hear.

Jason
