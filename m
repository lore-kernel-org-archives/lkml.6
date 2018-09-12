Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AFEC04ABB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4844720880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 00:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="J/P/8y3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4844720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbeILFDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 01:03:47 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:36983 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725740AbeILFDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 01:03:47 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5360167e;
        Tue, 11 Sep 2018 23:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type:content-transfer-encoding; s=mail; bh=6JvlHkIYKM2h
        w+HMGOR9Du/TVWM=; b=J/P/8y3QxWZyJ1sX2Af/9Sk1nbtaYUfs76o6Qylg2IDL
        DhkX68bdo2oyOd1pB9BLyT6AhZXcdhw1F51Iz7oN3Tbowz9WCmxxkLsWptrvvpim
        gWo/6BmWmHvD/I4ijGN9MKZ4dbe3btOTT1KWGqTYSbNQSPPgJiduAScdvbjIEB1s
        HwLI/KdiMd8aVPZB29DNTWmmBuhYe/UcpXcB34zM4TI+OxGieW3q4CHvNY2l9L8S
        4hpugWvHWrgoSeb3f0j0jYvGkIsBTBdOOcKuiaSkvRFHUIMXaGIqM2UEh94zRnRf
        9AtGXkBmstZLkhd1XG4PxdrD7+bLAx5YxaZ6AyBu/Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d77455d4 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 23:45:18 +0000 (UTC)
Received: by mail-oi0-f47.google.com with SMTP id m11-v6so229088oic.2;
        Tue, 11 Sep 2018 17:02:02 -0700 (PDT)
X-Gm-Message-State: APzg51ClUejzmd1dJPzfUcfhsNRnIr+Kn08o+GWPWifrqXkUtSwMUDHs
        mr/4s6zR0ICwfb6zFjyVCBJC6BjTuUrshUBEUqo=
X-Google-Smtp-Source: ANB0VdZ5gA9tOAFAfnmU0fBrnwzoW38BhPVObbiknb6hWx/Ef1ESfpXMkLMe/Vz17elApT5cocDu2zDbd1lvAQguCME=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr29882611oiy.191.1536710521303;
 Tue, 11 Sep 2018 17:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <20180911145624.GA21635@kroah.com> <20180911214737.GA81235@gmail.com>
 <49BAF465-B3DC-4155-BFF9-DB6C386C1878@amacapital.net> <CAHmME9q+mqT+vtM1FdBvf8=nAFu=u+wN48sOxqLcFthxYVn7NQ@mail.gmail.com>
 <2E01FBB6-030A-40AB-8BEE-F8F271A57568@amacapital.net>
In-Reply-To: <2E01FBB6-030A-40AB-8BEE-F8F271A57568@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 18:01:49 -0600
X-Gmail-Original-Message-ID: <CAHmME9om2rJONj6mMvSPHjiZDQKe05BCe=GonHN=c2Rg4n=pkg@mail.gmail.com>
Message-ID: <CAHmME9om2rJONj6mMvSPHjiZDQKe05BCe=GonHN=c2Rg4n=pkg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Sep 11, 2018 at 5:01 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
> I think Ard=E2=80=99s point is valid: in the long run we don=E2=80=99t wa=
nt two competing software implementations of each primitive. It clearly *sh=
ould* be possible to make crypto API call into zinc for synchronous softwar=
e operations, but a demonstration of how this actually works and that there=
 isn=E2=80=99t some change to zinc to make it would well would be in order,=
 I think.
>
> IMO the right approach is do one conversion right away and save the rest =
for later.

Alright, I'll go ahead and do this for v4. Thanks for the guidance.

Jason
