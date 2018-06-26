Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA27C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705982197C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:34:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705982197C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934789AbeFZKeB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:34:01 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:40514 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933880AbeFZKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:33:59 -0400
Received: by mail-vk0-f47.google.com with SMTP id o71-v6so9711024vke.7;
        Tue, 26 Jun 2018 03:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZF+sJS6v7TvhYCRP7iAShui8LZVSJG/Baxd7sSB6M/8=;
        b=titnR3PHflpmMfjoWvISwsZJC64h68CuEgYDVcbj4R3rPyRU38BW5g+1ONFipodCJ3
         u6gKBZbiocKZSabOvXMaHZKoVTf1IeoK/P+Qo04SMnOv1a9XWblOMPonHDQ/2PyHZcEP
         Ksx3vnBVxE+vg6NwxsA4p6Uk4itHxBVRxzscXOKPTpfngbkd632/HpuuwJqIqd5ywSPH
         iuNGRlqkmJ6Xgr+5Mc5cX45BSmxPcXjfHMPVY+3UAvM6oxdPHYmM028xBKG18KaMV47K
         TO32UfIYjH+T+9krAWx57M9LufX6mSSxbku91rUsNDv/FE86m3F8m2xySXulKCYz7M6U
         1OsQ==
X-Gm-Message-State: APt69E2zDnbN51KQmPQsXWLuWh4lu6G9gZaGBh92FwVaIqzlAyKbvq4T
        tcLtjtWJczp6r0pDzrCFc5IgNrMHkLgZftupGiwAc3pt
X-Google-Smtp-Source: AAOMgpf+FQYny7abbUlyrfX2r1FxcZKZWCpgtH4finkW2UmnrLTriSjxdPIEsOy4vD2Uf9W/jOS7yUfS3gJCTe4JdlM=
X-Received: by 2002:a1f:644:: with SMTP id 65-v6mr499348vkg.159.1530009238857;
 Tue, 26 Jun 2018 03:33:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdW_4gvQYhCxcXR+sa6dhwAshyJnhXhc36=VC=hWKB-7Jw@mail.gmail.com>
 <14009987.cibGRJrWdm@positron.chronox.de>
In-Reply-To: <14009987.cibGRJrWdm@positron.chronox.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Jun 2018 12:33:48 +0200
Message-ID: <CAMuHMdXfn6YuG9imLKd5nEdxhT4gWu-V8bn1LRt+M3bESaUAkA@mail.gmail.com>
Subject: Re: cryptomgr_test / drbg_ctr: BUG: sleeping function called from
 invalid context
To:     Stephan Mueller <smueller@chronox.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephan,

On Sun, May 20, 2018 at 9:54 PM Stephan Müller <smueller@chronox.de> wrote:
> Am Freitag, 18. Mai 2018, 10:36:04 CEST schrieb Geert Uytterhoeven:
> > I tried following the code path, but couldn't find where it went wrong.
> >
> > mutex_lock(&drbg->drbg_mutex) is called from drbg_instantiate(), which is
> > inlined by the compiler into drbg_kcapi_seed().
> >
> > Do you have a clue?
>
> It is the first time I hear from such an issue. Yes, the DRBG should not be
> called in atomic context. But I do not see where we have an atomic context
> (either a spin_lock or in an interrupt handler) when we are executing the test
> manager.
>
> I will keep looking.

Issue is gone. I assume due to commit 6e88f01206edab0e ("crypto: arm64/aes-blk
- fix and move skcipher_walk_done out of kernel_neon_begin, _end").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
