Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC52C6787A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C5752089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nE/1HXCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C5752089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJIHRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:17:02 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:40547 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725759AbeJIHRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:17:00 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 215f7c60;
        Tue, 9 Oct 2018 00:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=5in/RYU2U40tdxrJ1ovROPUS/yo=; b=nE/1HX
        Ci+RiM0J0Wg4TlNGb7coUZLx08RsY2o0L1EPhcSV3h2kaetFfGnVfYRYO5xb0ovH
        lst8UGk1M1uTkSTQqfV5ZBcCHu0D0cIZvYw8optxLPc3lsJIFdONl9PW+BMfnJvS
        L+KxPyKzMNb7VE834CxbzdEmJg4iGTayPTdJ/nGJZeTDS2MAy1azpA4LKbVLMWj4
        UrIoF/uBI/w8Rs2dFGS2UI1ns0GuHGMhG9vdZTmH0vsK2e0I2Qp8fmkcNqA50jtv
        uKjzfymrJAYjyLO3lAbDR08A6An4o3owCK+Wchnk6xtSI0nFbr+dm/rvJLA/8e3D
        obkStD7BUO95AqIw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id af354587 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 9 Oct 2018 00:01:55 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id e17-v6so16852369oig.12;
        Mon, 08 Oct 2018 17:02:45 -0700 (PDT)
X-Gm-Message-State: ABuFfoiUI82ORPZDQ0qB8glViL31lnuN6/ATHWH0UwNzS96ex95623kI
        OvNlxHwr3dWbOeyToU0h+qffCXOSrABFazmivdc=
X-Google-Smtp-Source: ACcGV63gBbVtI89YYCMXztYxIJNO4s84zGPf+apodNgvCm9x5h2OJ2qKEoGpeKUIQ+frKw/XRKqGDtUHou4R9tNUE3g=
X-Received: by 2002:aca:f512:: with SMTP id t18-v6mr6095485oih.244.1539043364096;
 Mon, 08 Oct 2018 17:02:44 -0700 (PDT)
MIME-Version: 1.0
References: <20181006025709.4019-1-Jason@zx2c4.com> <20181006025709.4019-26-Jason@zx2c4.com>
 <20181008232059.GA164708@gmail.com>
In-Reply-To: <20181008232059.GA164708@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 9 Oct 2018 02:02:32 +0200
X-Gmail-Original-Message-ID: <CAHmME9qo+8JKL_J10UghiJjxQABA5meOg=TqgpfvbV=nPJx7Tg@mail.gmail.com>
Message-ID: <CAHmME9qo+8JKL_J10UghiJjxQABA5meOg=TqgpfvbV=nPJx7Tg@mail.gmail.com>
Subject: Re: [PATCH net-next v7 25/28] crypto: port Poly1305 to Zinc
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, Oct 9, 2018 at 1:21 AM Eric Biggers <ebiggers@kernel.org> wrote:
> This crashes on very short inputs.  crypto_poly1305_final() is missing:
>
>         if (dctx->rem_key_bytes)
>                 return -ENOKEY;

Good catch, thanks. Queued for v8.

Jason
