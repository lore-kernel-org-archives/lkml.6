Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81299C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 444BE20878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 06:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhOZvdEC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 444BE20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbeJBMpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 08:45:36 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:55623 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbeJBMpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 08:45:35 -0400
Received: by mail-it1-f194.google.com with SMTP id c23-v6so1963284itd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 23:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7yiTZUNv9eZDdhySK8sUATbRjhR0YFHOJrAlbUptltI=;
        b=KhOZvdECX+WC2N0tBelgyHIeR39OSw0XHnmw4M5xMW5/TcMjZaZU3uEqBQG5hiXRkw
         mezvQQZYEcVhPLvTN7j0TsemBxCO5Djm+XReuKAvEpTFMNg4MZuUCJUfiAyYMizwwZ+U
         T15aEaMTvyqtwRY2Jncmnj2b4FOIDlThQcpt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7yiTZUNv9eZDdhySK8sUATbRjhR0YFHOJrAlbUptltI=;
        b=Dm21Pdk1A+b/lUNxs8MzuacImtoRAtGFn2v3fS4ELZk9ysTZYVpvbwZsI9EWHZHyAZ
         uOCmfcPgUQraEJ/HwQRy7PrnBJMExuQFioVc5DKNRS7XEdSJPyTkmvrfkPmorK4RKuZm
         JLsby2oTKz6HEdo9nKvyt9RhgqTWhxTIBfBcfuXTRdgoB/QI8VPFdTTV57KGJyepbpK8
         5JKAtnRk6PBCgcrK+xFt+jWcIzd/SjET26j/B8aurjbAcyiUzhyxYZJvEt4HOfy/pTf3
         wca8+n9/qCXAj8g9YMOvYP5WxWUzAA0s4FWpNLNiFrriyK4wy5mnSuw+B/xLjrsew45L
         qWvw==
X-Gm-Message-State: ABuFfogTvMcgi3plpYQT17/icTsGLfXGqaKRVvYsC1bXMaWJZBsVcQWY
        7WLlK20gtiKKoSQwj6PHuFJ08OgeUDgjUMl+/HoP7g==
X-Google-Smtp-Source: ACcGV62lpYorJcAUpN7qFbZ2PE+ilGNCnSrtTPnkWWDG4BnU3s1CM2o2lXr6ZReTv7zkDzHJOksSpaVnfwv8qSp4AbQ=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr875147itc.123.1538460245549;
 Mon, 01 Oct 2018 23:04:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:5910:0:0:0:0:0 with HTTP; Mon, 1 Oct 2018 23:04:04 -0700 (PDT)
In-Reply-To: <CAHmME9piX1kbUhOBcUKVdecr45EjxuruxYuMTepfXVvRrkVmyg@mail.gmail.com>
References: <CAKv+Gu-ZMR7zEAKv6_2tyD3OqnjVugOzKHzBEXW3pQs5W-SvLw@mail.gmail.com>
 <20181002033908.324yhwqaohfsq65d@gondor.apana.org.au> <CAHmME9piX1kbUhOBcUKVdecr45EjxuruxYuMTepfXVvRrkVmyg@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 2 Oct 2018 08:04:04 +0200
Message-ID: <CAKv+Gu8fr_qADiTJH05nVWF7Yi3U722nfKJsMaRE9CP3YjNBbg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/23] WireGuard: Secure Network Tunnel
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 October 2018 at 05:45, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Hi Herbert,
>
> On Tue, Oct 2, 2018 at 5:39 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> > I would also strongly prefer that all crypto work is taken through
>> > Herbert's tree, so we have a coherent view of it before it goes
>> > upstream.
>>
>> I agree.  I don't have any problems with the zinc code living in
>> its own git tree.  But any upstream merges should definitely go
>> through the crypto tree because the inherent ties between the two
>> code-base.
>
> I can send you pull requests then if there are development cycles when
> there are in fact relations between the two trees. I'll update the
> commit message describing Zinc to include this.
>

Can you explain why you it is so important to you that your changes
remain outside the crypto tree?

Also, I still think the name Zinc (zinc is not crypto/) is needlessly
divisive and condescending, and unsaying it (in v2 and up) doesn't
really work on the Internet (especially since you are still repeating
it in your conference talk.)
