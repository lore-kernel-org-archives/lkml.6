Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AE4C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDA721754
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ur3eurF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDA721754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeI1HbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 03:31:17 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:44157 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbeI1HbR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 03:31:17 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7494aa7b;
        Fri, 28 Sep 2018 00:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=eBmhDTw0W8Hg/+vYb4BCXZpKn0g=; b=ur3eur
        F0DDP8esJVJSw0ODEyzryULYAww8hyz4jEPWDZJ5kU8QImElauI9lEKK/nnzZgc6
        Lk8qnglOXLceKA1wHZU8YulPa/c1uck7SdJNGjF9tSdOPcDzMoIpvdZAXPW9MOPW
        tg3uV/nFsB7cSHKGxNWWzfMVZrGX+n7xxXiBz8UWE09vmPfOV0wDEFui2EKtaKJt
        IxqlWAHdsUp0/4zpoel7VFggcNBVs6xYtXh4Klmu7DsLyLd+4QscACq2HvtEoT55
        HCoPWyjUr/UWvkB6osYykbSiFGs3IqE9xUk8vNX9OsgEtjFzoLO2bUSF//XSx8bM
        wLwcNZXr0TqqKGjA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c5e124a8 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Fri, 28 Sep 2018 00:51:24 +0000 (UTC)
Received: by mail-oi1-f178.google.com with SMTP id a203-v6so3938723oib.0;
        Thu, 27 Sep 2018 18:10:08 -0700 (PDT)
X-Gm-Message-State: ABuFfoi0Yn3w/JZ0IsalU/pAy6WN+RUiSvhuRj8AfKsHNi39hXjj6e7V
        U0Nnd5bFN1AOwcdmdNXtVHgsFBj7iqE2IggXu1Y=
X-Google-Smtp-Source: ACcGV63Jl6oViHNv++naxecBlSdUtbCH6K9NBaUcYZh3sOp9IEoueCRKHqeXPysh6hbvn38L7hwdLaZpoK3goKympaU=
X-Received: by 2002:aca:d4cd:: with SMTP id l196-v6mr4262718oig.15.1538097007668;
 Thu, 27 Sep 2018 18:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-24-Jason@zx2c4.com>
 <20180927011526.GB1193@lunn.ch> <CAHmME9q7WRGF3TTRhhy0i_EB4ad2DaSD=tnHM92zfV4Cckyw=A@mail.gmail.com>
In-Reply-To: <CAHmME9q7WRGF3TTRhhy0i_EB4ad2DaSD=tnHM92zfV4Cckyw=A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 28 Sep 2018 03:09:56 +0200
X-Gmail-Original-Message-ID: <CAHmME9q72YbkM5FsZMf-KR32pOXa6n=pHVYGnRmkxYk19tZ4CQ@mail.gmail.com>
Message-ID: <CAHmME9q72YbkM5FsZMf-KR32pOXa6n=pHVYGnRmkxYk19tZ4CQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 23/23] net: WireGuard secure network tunnel
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 12:37 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Will do. v7 will include the wg_ prefix.

$ nm *.o | while read a b c; do [[ $b == T ]] && echo $c; done | grep -v ^wg_
cleanup_module
init_module

Success.
