Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3ECC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9781214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="uu6x/2XD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9781214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbeIZVjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 17:39:32 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:56935 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbeIZVjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 17:39:32 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4c7fbd06;
        Wed, 26 Sep 2018 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=YiCKe8pcP2DO+YtdsZI1AzccR5M=; b=uu6x/2
        XDtgw3KonPMnNMiljE2IqpdI1blFRNvlgJSr7xOAPVOpI8ZcPxaA1GBJOssaZYtt
        MMUv1cqcA63BpNwlKrudbQlMWKm7SZ+6SkdKeHktbFDPfZbkd+qjp9BCGsIEiQHe
        Ngh4yV0Ud1C7922epM5jCqjhMMi4QctkUhLyJ8JuKSQCXTyH4ajlfScmfPB27r6D
        zeVarqBQXVNUXvhqI+F7LLbWBncdBlux4hKiSh7MsHUhxSmvXL+7OXQVG2kkTxCx
        Ka4pPMPETO6nDRgEO7nb0/7Y8CMlM+VWpF2D1bRr5rfAKPkiW4HwHtjxTXzefE7I
        tbudEywdWe4Dzgsw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f4a1176d (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 15:07:27 +0000 (UTC)
Received: by mail-ot1-f47.google.com with SMTP id e18-v6so28577677oti.8;
        Wed, 26 Sep 2018 08:26:00 -0700 (PDT)
X-Gm-Message-State: ABuFfojXtd4ValtswosaANp+bPaJgGFLrv2l4JPUgoyDmL673FOXkKy8
        hZ6f834IYw+xWBr0Uj9QuJhLi4tE2d4IKNsGjyk=
X-Google-Smtp-Source: ACcGV63WG0qsJ1Z/F+XHQYk9+UrDe6MkKlgsNkryIHPBiQYUCENn9YGRKlUhzdpa2D5AthlC/jzX7JpOee/Vtr3QO+E=
X-Received: by 2002:a9d:3c47:: with SMTP id j7-v6mr3053925ote.317.1537975559666;
 Wed, 26 Sep 2018 08:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com> <20180926143614.GL1676@lunn.ch>
In-Reply-To: <20180926143614.GL1676@lunn.ch>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Sep 2018 17:25:48 +0200
X-Gmail-Original-Message-ID: <CAHmME9pm0tsW7ou-M811nsoN0pk2Tb49pH2b0Fzzq_ae6zHR4g@mail.gmail.com>
Message-ID: <CAHmME9pm0tsW7ou-M811nsoN0pk2Tb49pH2b0Fzzq_ae6zHR4g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Samuel Neves <sneves@dei.uc.pt>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 4:36 PM Andrew Lunn <andrew@lunn.ch> wrote:
> The wireguard interface claims it is GSO capable. This means the
> network stack will pass it big chunks of data and leave it to the
> network interface to perform the segmentation into 1500 byte MTU
> frames on the wire. I've not looked at how wireguard actually handles
> these big chunks. But to get maximum performance, it should try to
> keep them whole, just add a header and/or trailer. Will wireguard pass
> these big chunks of data to the crypto code? Do we now have 64K blocks
> being worked on? Does the latency jump from 4K to 64K? That might be
> new, so the existing state of the tree does not help you here.

No, it only requests GSO superpackets so that it can group the pieces
and encrypt them on the same core. But they're each encrypted
separately (broken up immediately after ndo_start_xmit), and so they
wind up being ~1420 bytes each to encrypt. I spoke about this at
netdev2.2 if you're interested in the architecture; there's a paper:

https://www.wireguard.com/papers/wireguard-netdev22.pdf
https://www.youtube.com/watch?v=54orFwtQ1XY
https://www.wireguard.com/talks/netdev2017-slides.pdf
