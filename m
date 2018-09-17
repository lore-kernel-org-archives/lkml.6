Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B061BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61A482088F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LoqQBG31"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A482088F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbeIQU47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:56:59 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:54193 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728361AbeIQU46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:56:58 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7b4f43f5;
        Mon, 17 Sep 2018 15:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=djsXRQdagi35JBCKpgAwu94ywlY=; b=LoqQBG
        31kQs+MoT9LP3TF57gSNooOKlhrGe0PMcYv7O/pDa3pRXJkfKs0VOrzGGS41X0d4
        c/oudCaFlpQK67FMlMhWbArAQnKXY+WxBXDQm80ku00k0V1slAcc+jP2MqMva3c8
        cYT5+V/5+k5i6rMdXkB0l20NXH/UmHU5OZTcp31XA7ZeSZFpH/vUXLtCq85S0sID
        o0K7lk/nbkiMTi2Tl19Y3YE1EbYRKZCsMB+iQdb+EUediwz+/42e5TdjxEVIo90S
        kwVUtKlrEP0+9qiyPnBqE+PFJDh4YcNZmh8lp2JE+yFAbyNkuFU6vooqQLn1zSYY
        pfb3eRW8eTRDAyKQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e616a778 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Mon, 17 Sep 2018 15:11:39 +0000 (UTC)
Received: by mail-ot1-f45.google.com with SMTP id j9-v6so11714354otl.2;
        Mon, 17 Sep 2018 08:29:06 -0700 (PDT)
X-Gm-Message-State: APzg51DETvevBrdbNzH7xiwP1OiZCiUzMXzPjHn8HmY2ymPFDplwVvqu
        49ErVh1mbjmMw7IvDNGU+gJNK1HmeAaANIRv3DE=
X-Google-Smtp-Source: ANB0VdbHGn7DGqxO2/biZqcZjx0pGF1Ks326vPskeQvIo3MxIRuSU/eS5Nfn7D4XqQM/1OqqEyP6AO+GVWwW29To0Ug=
X-Received: by 2002:a9d:4a8f:: with SMTP id i15-v6mr13455698otf.138.1537198145166;
 Mon, 17 Sep 2018 08:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180911214737.GA81235@gmail.com> <CAHmME9rFUruF-VN1pmU-k5nFsb9ppAPhPpW-5Ho9dKL2HCg4kA@mail.gmail.com>
 <20180911233015.GD11474@lunn.ch> <20180911.165739.2032677219588723041.davem@davemloft.net>
 <CALCETrXrJPcs3h9CtF50N4k2AGx3qzspJd_UW3t+KGYOj7+p=Q@mail.gmail.com>
 <CAKv+Gu8QgRo-Oex2Sk5unET3FMq+1Cp2btAWXCB8xsALxjatHg@mail.gmail.com> <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net>
In-Reply-To: <35BC21D7-01F4-4F91-A7E9-8D15DE5B95D6@amacapital.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Sep 2018 17:28:52 +0200
X-Gmail-Original-Message-ID: <CAHmME9qQR4ynsZ5xXejEdnr3oZcOnpRRTdohX+eT9Df+AU2_iA@mail.gmail.com>
Message-ID: <CAHmME9qQR4ynsZ5xXejEdnr3oZcOnpRRTdohX+eT9Df+AU2_iA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 02/17] zinc: introduce minimal cryptography library
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andrew Lutomirski <luto@kernel.org>,
        David Miller <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Biggers <ebiggers@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, Samuel Neves <sneves@dei.uc.pt>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 4:52 PM Andy Lutomirski <luto@amacapital.net> wrote:
> > * (Nit) The GCC command line -include'd .h files contain variable and
> > function definitions so they are actually .c files.
>
> Hmm. I would suggest just getting rid of the -include magic entirely.  The resulting ifdef will be more comprehensible.

I really don't think so, actually. The way the -include stuff works
now is that the glue code is inlined in the same place that the
assembly object file is added to the build object list, so it gels
together cleanly, as the thing is defined and set in one single place.
I could go back to the ifdefs - and even make them as clean as
possible - but I think that puts more things in more places and is
therefore more confusing. The -include system now works extremely
well.
