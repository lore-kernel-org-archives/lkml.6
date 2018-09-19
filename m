Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523BDECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F9D2146D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="psJ8RB4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F9D2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbeISHOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 03:14:47 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:52035 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeISHOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 03:14:47 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id f9d3d76f;
        Wed, 19 Sep 2018 01:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=wD37vfunmq4u/fZavF0KtBLymGo=; b=psJ8RB
        4XwALrl5kABhF1jSpyMy5F0K3sTPeUPaB6RgC+2BKRg3wdHI2buenYZjqwyQbiPr
        aRK8dpTAQ3GgHgHnUyfBUiHPLX/mW2onQkTtR418qfMbON9dSCDMA3nU501WPeQF
        qxduKYxPitia2mJ3Aq7emJibRmfKv1ndMbzD0Cwp6LhmM+sz8uMjIynlLjqYDj4W
        PMCDYnot5e546MCO36Gb0BbIYyxCbJS96I6wjMLSXLaiaqgi9sTeyj4yJIvADR69
        xQq0byhISJ96m/3Eac5yb9HDVB+096IhUAA/mTtZYrttSwAbkpdFMXTX/7Qr83pz
        JS5E/doQ3fl2nNRA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cd0cf264 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 19 Sep 2018 01:21:45 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id o13-v6so4085307otl.4;
        Tue, 18 Sep 2018 18:39:23 -0700 (PDT)
X-Gm-Message-State: APzg51BGj4zMC1aSTKC4lcwNRNL3B4IUuZObTqILerGN5mjKa6+L+1fq
        iSB9oMhHanPMbQjkiilR7iBiPjBkJ96hmvQ+0NU=
X-Google-Smtp-Source: ANB0Vdb7628/kR1CSpspWgBg3Vv3kZnFuvz5PLeB9NxLsfGQ6vgNrcn5EGhyaVhagvK55FznUVIG5Cgqbv379MVnDmA=
X-Received: by 2002:a9d:51d0:: with SMTP id d16-v6mr18404701oth.384.1537321162496;
 Tue, 18 Sep 2018 18:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-8-Jason@zx2c4.com>
 <20180919005054.GC74746@gmail.com>
In-Reply-To: <20180919005054.GC74746@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 03:39:11 +0200
X-Gmail-Original-Message-ID: <CAHmME9rab92gc68tGX384eGR71q+7JtovpxBLSYrYNHA7L5zFw@mail.gmail.com>
Message-ID: <CAHmME9rab92gc68tGX384eGR71q+7JtovpxBLSYrYNHA7L5zFw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 07/20] zinc: Poly1305 generic C
 implementations and selftest
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +     const size_t num = ctx->num % POLY1305_BLOCK_SIZE;
> 0 <= ctx->num < POLY1305_BLOCK_SIZE, so no need to mod by POLY1305_BLOCK_SIZE.
> > +     size_t num = ctx->num % POLY1305_BLOCK_SIZE;
> Same here.

I know, but I was having a hard time convincing gcc-8 of that
invariant, and it was warning me. Perhaps this is something they
fixed, though, between 8.1 and 8.2 though. I'll check back and adjust
accordingly.
