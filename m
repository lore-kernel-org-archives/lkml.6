Return-Path: <SRS0=itv6=LI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA62C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 17:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051CB2173D
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Aug 2018 17:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="S8mt48J8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051CB2173D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeHYU5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Aug 2018 16:57:19 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:60349 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbeHYU5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Aug 2018 16:57:18 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 5877c344;
        Sat, 25 Aug 2018 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=EqGIxTPnweK0XbShgttNIg0Tm1k=; b=S8mt48
        J8aGNXcx1cGW9Z75mM5f6XH3iXuODg6WSdWdhhlDGFyBh/jLKcaATnQvNmK3zHp/
        VWFP/jtBcgvyhIwVckCbXZVICYH5DNMQkP4KsO4OQWJv/xkVvKd0HU30/KBOGcLi
        HhxXfBn93qa1yVGLymQt6oFDHY8VLYf2eOWV16e3dl5lelPuJBuiMlCHZ8vvE7a6
        9Zxyp+7g2MS52dk8DwllvfYjw1HOvDyrgsZFiAHSYDimH8UPwr3D+XrsztrOjZod
        t2qEmvg1vrzQBokD0IDPp56MAThqyLZS2mGl+/N6WVXjaEvssRloAqHi/iqmH3/y
        ZjI/bxglzTEjmAxg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ac8af107 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sat, 25 Aug 2018 17:03:11 +0000 (UTC)
Received: by mail-oi0-f50.google.com with SMTP id p84-v6so20588718oic.4;
        Sat, 25 Aug 2018 10:17:43 -0700 (PDT)
X-Gm-Message-State: APzg51AdXjmi3m4HBsbjCmmVvdDhzF54LnmXGYPUZkaA1aeIZOooG+8x
        4XrOLWVb417w/HpysxU41NI4TGqSI1tuhIG6d4Y=
X-Google-Smtp-Source: ANB0Vdbk6/Z6hE8brk4U0xgiz6j3Nl+cXrQu69kXHjqri99Jv41/F1gJjd2w3vg/r578/NyUiHmUO7rJI4lWQMHBthY=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr6141380oiy.191.1535217462661;
 Sat, 25 Aug 2018 10:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-3-Jason@zx2c4.com>
 <CAKv+Gu-u7vPkU49AzToGHyf_cWp0MiOmpD3cRUt8260QC2wj-Q@mail.gmail.com> <20180825170629.GA8971@zx2c4.com>
In-Reply-To: <20180825170629.GA8971@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 25 Aug 2018 11:17:31 -0600
X-Gmail-Original-Message-ID: <CAHmME9oE-Gb94PqVE0Bvenf9OycZN50Th2-KZV7M==5vg7x5TA@mail.gmail.com>
Message-ID: <CAHmME9oE-Gb94PqVE0Bvenf9OycZN50Th2-KZV7M==5vg7x5TA@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pressed send too fast.

On Sat, Aug 25, 2018 at 11:06 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>   - https://www.wireguard.com/papers/wireguard-formal-verification.pdf
>   - https://www.wireguard.com/papers/dowling-paterson-computational-2018.pdf
>   - https://www.wireguard.com/formal-verification/
- https://www.wireguard.com/papers/lipp-computational-2018.pdf
- https://eprint.iacr.org/2018/766.pdf
