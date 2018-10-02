Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFDF2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8454420652
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 03:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JIlcMXGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8454420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbeJBKBV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 06:01:21 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:43757 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726239AbeJBKBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 06:01:21 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 50a717ca;
        Tue, 2 Oct 2018 03:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=AU3/VQE65FI/Y/fM+M1PpykjnKQ=; b=JIlcMX
        GtcsGj/APQSOwoGDG/VhSQGcdOCTnl3UhXifxkf+6um9hdeCaiWNlvCYmdl7eO6v
        DAv9YWWGUtD1o1+iyNT49eWlPdp6s5koHnxMq9F7+OzHx92Bk8Nl4fgNpcLPo2od
        obuO4ALyx3AakZAMqoK31LADHNNASoANFn8NNp/RdvJd7HmWcAld84p2GQf4F+2h
        5Wtbh5bZujQOSfUVksLgKFKdqwhvRTzaIitzyEQWMKP8+dMH+wmYqriIgxlPl8Gc
        /D9J+IQvKdRqcmY7jYhGRv8ADiSYQ/fZ/9N21j0rSBW/UOG1WEC/acFYrtgehcwn
        qE0lqB3AntooIpNg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ddd732f6 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 2 Oct 2018 03:20:19 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id o21so207575otb.13;
        Mon, 01 Oct 2018 20:20:19 -0700 (PDT)
X-Gm-Message-State: ABuFfogF3FekLiPt+TK3tbR2FviFiPMf/pzGgMA2/eTIBB+U4h6qjmGG
        uixhumawTqP4diWG4EISRTMrEEEA2XD8osjUuAk=
X-Google-Smtp-Source: ACcGV608djTBqkHfkScw4OPkuk9DjzVYknFeN4900Gt96sOUEup0UZ4jhfc8JG0ylXKZrTjhu0+/KOHob0ipADTYpK8=
X-Received: by 2002:a9d:42c3:: with SMTP id c3-v6mr8499577otj.54.1538450418668;
 Mon, 01 Oct 2018 20:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-5-Jason@zx2c4.com> <20181002031848.lyxrergyyxyc5cwi@gondor.apana.org.au>
In-Reply-To: <20181002031848.lyxrergyyxyc5cwi@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 2 Oct 2018 05:20:06 +0200
X-Gmail-Original-Message-ID: <CAHmME9oR4=ajV4jPaFrB9G93B3boT+fzY+0FxO5AaoT5rrsORQ@mail.gmail.com>
Message-ID: <CAHmME9oR4=ajV4jPaFrB9G93B3boT+fzY+0FxO5AaoT5rrsORQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 04/23] zinc: ChaCha20 x86_64 implementation
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Neves <sneves@dei.uc.pt>,
        Andrew Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Andy Polyakov <appro@openssl.org>,
        Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

On Tue, Oct 2, 2018 at 5:18 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > size    old     new
> > ----    ----    ----
> > 0       62      52
>
> What is the old column? Is it the existing x86-64 implementation
> in the kernel or something else? This needs to be made clear in the
> patch description.

Good idea. I'll make that more clear.

> The same comment from the previous patch also stands here.  Please
> ensure that we only have one copy of chacha x86-64 code in the kernel.
> Either replace the existing one right here or in a follow-up patch
> in the same series.

Yes indeed this happens within this same series.

Jason
