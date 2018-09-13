Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ADFC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8DAA20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 14:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="hu5uB6md"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8DAA20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeIMT20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:28:26 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:36191 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeIMT2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:28:25 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id e7457ea0;
        Thu, 13 Sep 2018 14:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=XeBBJ3q0RSrBChF3c4/O2/jZAFc=; b=hu5uB6
        mdqTNACJ4ANfwQmPUBrkSVCPtPVq1pv37q4CJhSp5YVtFYBrQZAuI+0sWC5RrhE1
        kgj425meEzquyeO8UteBmdYiQd+IlX00lPYnGS/s/h9Z+SQWiINu9fkipvnH+gM+
        /g0Xfvcwms7OerUuVmYXheNzXgP9er07sviZYYh+ofAl3rZs+H9MXzkg32h3WSIM
        xECe8eSnrQ3RqyAWV53wzFbbwvzLBu347A8xrogGw3mpYjCF4mtoOSo/pz8N9taz
        m4VlMLh3+sTzIXpmtkjcUfvV7BuXHRNAudWcRlAZ/mWfs1jKhjqJ2Sm7MhjlRbZf
        8/jR6hx/x1EGHugQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id d6fc8ea4 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Thu, 13 Sep 2018 14:01:45 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id v10-v6so1370950otk.7;
        Thu, 13 Sep 2018 07:18:40 -0700 (PDT)
X-Gm-Message-State: APzg51ASekd0bnCQvHDi6WtEFWbSRcuJwUZ9Q7jEqTDf/deSy3kIy4wa
        0oaTYElJrxe8j8Qi0VKT5cmJDjW/QKEQ6ZrJ4eQ=
X-Google-Smtp-Source: ANB0VdaId0YSHS04r9P2QQval4NWRBkEhuJbrc4/UngEYsgD6GH9JHhrT1ZYtAYkMlEpkFCWrls0zqNMH21BE+KRSK8=
X-Received: by 2002:a9d:3a34:: with SMTP id j49-v6mr1296817otc.317.1536848319595;
 Thu, 13 Sep 2018 07:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-3-Jason@zx2c4.com>
 <CAKv+Gu9nSeo4PFVrtjtqGQ32eqyxUp3xVCczZfu+dhFz5yLM0A@mail.gmail.com>
 <CAHmME9rTEFLaYmzFrc719LW2DWS2Ua_vL6by1UXZ9uDvMpbhYw@mail.gmail.com>
 <CAKv+Gu9RGo9rtGsmwMLZ_=-WSQ_h7har4agXP-2XOKupq-KYtA@mail.gmail.com> <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
In-Reply-To: <CALCETrU2qkLVaxC=cpU5iAeT5B7xGsR+m2ZWtLVK37jMMWtcAA@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 13 Sep 2018 16:18:28 +0200
X-Gmail-Original-Message-ID: <CAHmME9pp8HoisxQWL_eELR-ziiBii-7mcA=oF9UF-WMucewX5w@mail.gmail.com>
Message-ID: <CAHmME9pp8HoisxQWL_eELR-ziiBii-7mcA=oF9UF-WMucewX5w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 1:45 AM Andy Lutomirski <luto@kernel.org> wrote:
> I'm not convinced that there's any real need for *all* crypto
> algorithms to move into lib/zinc or to move at all.  As I see it,
> there are two classes of crypto algorithms in the kernel:
>
> a) Crypto that is used by code that chooses its algorithm statically
> and wants synchronous operations.  These include everything in
> drivers/char/random.c, but also a bunch of various networking things
> that are hardcoded and basically everything that uses stack buffers.
> (This means it includes all the code that I broke when I did
> VMAP_STACK.  Sign.)

Right, exactly. This is what will wind up using Zinc. I'm working on
an example usage of this for v4 of the patch submission, which you can
ogle in a preview here if you're curious:

https://git.zx2c4.com/linux-dev/commit/?h=big_key_rewrite

28 insertions, 206 deletions :-D

> b) Crypto that is used dynamically.  This includes dm-crypt
> (aes-xts-plain64, aes-cbc-essiv, etc), all the ALG_IF interfaces, a
> lot of IPSEC stuff, possibly KCM, and probably many more.  These will
> get comparatively little benefit from being converted to a zinc-like
> interface.  For some of these cases, it wouldn't make any sense at all
> to convert them.  Certainly the ones that do async hardware crypto
> using DMA engines will never look at all like zinc, even under the
> hood.

Right, this is what the crypto API will continue to be used for.


> I think that, as a short-term goal, it makes a lot of sense to have
> implementations of the crypto that *new* kernel code (like Wireguard)
> wants to use in style (a) that live in /lib, and it obviously makes
> sense to consolidate their implementations with the crypto/
> implementations in a timely manner.  As a medium-term goal, adding
> more algorithms as needed for things that could use the simpler APIs
> (Bluetooth, perhaps) would make sense.

Agreed 100%. With regards to "consolidate their implementations" --
I've actually already done this after your urging yesterday, and so
that will be a part of v4.

> But I see no reason at all that /lib should ever contain a grab-bag of
> crypto implementations just for the heck of it.  They should have real
> in-kernel users IMO.  And this means that there will probably always
> be some crypto implementations in crypto/ for things like aes-xts.

Right, precisely.

Jason
