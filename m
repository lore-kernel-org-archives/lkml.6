Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EF6C64EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E912082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="DWnTMSw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E912082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeJCU5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 16:57:35 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:58091 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726543AbeJCU5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 16:57:35 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 64b0583c;
        Wed, 3 Oct 2018 14:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=h/T/oC705z8l6OszRxSdgLeOKc0=; b=DWnTMS
        w1DuxMTxkMzzgeboCIY0dtXiO6Fe7IuxHo31d+652S38uLQK9TEvDGnBiKb/v3tI
        xeiXCOV8V8tgE7dI3ZDbzxO7WllN/eIm/WpX7fSW4KbN6FwqdKgunBwH5JwukN3B
        LMR9R0+jB8muRqImAyDZvcYJ/11v8ry9a0otKBsC8xBmDchqivAlWpmt84k2u3TC
        mnPU3U7LG+BzrzwahZKdmo25SlAY0SCwKcsXLhZhUlev7UNFIevinVlhC1atNeFC
        klHDmTZ7oA5vdg1XGoKzclRBDxp4uUwRmmn9wEkKs3JHPz9Fr4S+nIAxi74twGLg
        VE75LqI13UgsEz6Q==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5ca046fa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 3 Oct 2018 14:08:49 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id j9-v6so5673859otl.2;
        Wed, 03 Oct 2018 07:08:59 -0700 (PDT)
X-Gm-Message-State: ABuFfojSka0BjYkYsvqT904QCb6dg1LL4/S0dEq4CdK3jESB1lYXzhfO
        WUg3cCrPdYSubydQyOMZx5FftZjuyeEbaxUqNtA=
X-Google-Smtp-Source: ACcGV63VazE0I6mKGHh0m+BSqtRa0gajLvQBNxYzoLFwMBuDGf24SoTc6T2A9JbXwsTLbm8zYAtxYH1JkgmqHJhT31E=
X-Received: by 2002:a9d:30c2:: with SMTP id r2mr889339otg.143.1538575738813;
 Wed, 03 Oct 2018 07:08:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-12-Jason@zx2c4.com>
 <20181003061236.GB745@sol.localdomain> <CAKv+Gu8-HoAEyYiPYqMOMy9MGduFLQik2YxdJziqxN_cUs0nCA@mail.gmail.com>
In-Reply-To: <CAKv+Gu8-HoAEyYiPYqMOMy9MGduFLQik2YxdJziqxN_cUs0nCA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 3 Oct 2018 16:08:47 +0200
X-Gmail-Original-Message-ID: <CAHmME9oAa+Ezqy639_wSKsUDW4vgSrkbJUVd1O8Jcbo3CN4WKg@mail.gmail.com>
Message-ID: <CAHmME9oAa+Ezqy639_wSKsUDW4vgSrkbJUVd1O8Jcbo3CN4WKg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 11/23] zinc: import Andy Polyakov's Poly1305
 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Andy Polyakov <appro@openssl.org>,
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

Hi Ard,

On Wed, Oct 3, 2018 at 9:58 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> it has changed. This awkward commit splitting has been requested for the
> >> ARM[64] implementations in particular.
> >>
>
> "This awkward commit splitting"

Awkward in the sense that only those two commits are doing it, whereas
the rest of the series is not. Not awkward in any other sense that you
seemed to have divined based on your oversized punctuation below.
Fortunately, at your suggestion for v7, I've now done the splitting
for all of the other places, and so I the comment in the dev tree a
few days ago, since it's now done consistently across the patchset.

>
> Seriously?!?
>
> So you really think it is fine to import huge chunks of code like this
> from other projects without keeping track of the local changes?

As explained above, that's not what I meant at all.

Jason
