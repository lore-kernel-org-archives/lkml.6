Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E5BC4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1182720866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="yj/oQ6jw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1182720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeILCXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:23:41 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:49811 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbeILCXk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:23:40 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id df10649f;
        Tue, 11 Sep 2018 21:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=NCxkzguwvgNyVDMfTb8Y/xrfzR8=; b=yj/oQ6
        jww7aGkMPo95ECfYgTX1QmnK0fn/0j9/tpnHDPSGAELxY88kRECeN84rj+mu8jUY
        YyJke+xL8CuXSwJqlQfWxj+fDfmOFiXhUjUM5D0OYVtPSQ39dX7DN8NsU2idfYK1
        5fMzKgFybt2vFpveZKKr/368xWO9N6m9KDY2fZKQC0UkmONSsqaq/3gwx1dRHn1P
        sY+SZfIeqzSED0vv2ifB2t7Z+bzohG1D4wukLmS8QfqI97qgKzfQ7JxxctzYW8YQ
        1vNzaVQ7L60fC8KswcMnl1/3/Tgsmc7WEZNvUATQCV1Ex+HpHNzCkb5iX5FBQfHV
        u9ExNXEbRAs1EyAw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 97e6da18 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 11 Sep 2018 21:05:44 +0000 (UTC)
Received: by mail-oi0-f41.google.com with SMTP id t68-v6so50062751oie.12;
        Tue, 11 Sep 2018 14:22:26 -0700 (PDT)
X-Gm-Message-State: APzg51CZqetJgG0L8y0cnEI8MCodn4Oem/vwvNqLI6x0ee+zeI5oSM6M
        /Ih1WCIZqLEAHO9HcuVGJU3F+XDdgs2e6lI5zhw=
X-Google-Smtp-Source: ANB0Vdb8qs5ydiJmnjUCyD5qLf7OHKQfB/73nf20vxeLgQ+a0hY9gi0/c7QG7Zuv8S1lPrJxr9PdtQQONOJ73YKvayM=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr29331955oiy.191.1536700945834;
 Tue, 11 Sep 2018 14:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
In-Reply-To: <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 11 Sep 2018 15:22:13 -0600
X-Gmail-Original-Message-ID: <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
Message-ID: <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Ard,

I realize you've put a lot of good and hard work into the existing
crypto API, and that my writing in these commit messages might be a
bit too bristly and dismissive of that hard work. So I think in a
sense it's understandable that you've responded as such here. But
hopefully I can address your concerns. One thing to keep in mind is
that Zinc endeavors to provide the basis for simple and direct
functions to software algorithms. This is fairly modest goal. Just
some functions that do some stuff in software. Around these you'll
still be able to have complicated and impressive dynamic dispatch and
asynchronous mechanisms such as the present crypto API. Zinc is merely
getting the software implementation side done in a very simple and
direct way. So I don't think there's a good reason for so much
antagonism, despite a perhaps overbearing tone of my commit messages.
Rather, I expect that we'll wind up working together on this quite a
bit down the line.

> In spite of the wall of text, you fail to point out exactly why the
> existing AEAD API in unsuitable, and why fixing it is not an option.

I thought I had addressed this. Firstly, there's a need for more than
just AEAD, but ignoring that, the AEAD API is a big full API that does
lots of things, makes allocations, parses descriptors, and so forth.
I'm sure this kind of highly-engineered approach will continue to
improve over time in that highly engineered direction. Zinc is doing
something a bit different: it's providing a series of simple functions
for various cryptographic routines. This is a considerably different
goal -- perhaps even a complementary one -- to the AEAD API.

> I don't think you have
> convinced anyone else yet either.

Please only speak for yourself and refrain from rhetoric like this,
which is patently false.

> Please refrain from sending a v4 with just a couple of more tweaks on
> top

Sorry, no, I'm not going to stop working hard on this because you're
wary of a new approach. I will continue to improve the submission
until it is mergable, and I do not intend to stop.

Anyway, it sounds like this whole thing may have ruffled your feathers
a bit. Will you be at Linux Plumbers Conference in November? I'm
planning on attending, and perhaps we could find some time there to
sit down and talk one on one a bit.

Regards,
Jason
