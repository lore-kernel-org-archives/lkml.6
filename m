Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B76C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F9972152A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JJnAgbOY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9972152A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbeIZWDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:03:43 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:35511 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbeIZWDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:03:43 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fdcb482a;
        Wed, 26 Sep 2018 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=MkP6Pc8roKurV8NXLQ4pCZBYq+c=; b=JJnAgb
        OY1NLmB69TKed84sVqfFHS1ADE67KGd20IqiFTxPrWNUrKN7T/t+d2rTUwK7vCGo
        xzezRBL1+hcRqU4imupqVQChiUL0KWBaASeSZMxs3zc8ygi7wx/hea1wPJ7+MjT7
        pZ0aXKnZST5mmYVEamrqDy1iLLCK8Fo33g+7Q+1fKEKfOCDZntijUzhOnotNS27q
        CZslmag/tPusmvGtZv0J1l48X/24hcjfsgndtZxMQw9hykhLdSFNmZes/YX6NAe5
        KVz1JHge+whxyCYwYFVaRNlAHNn1UoMRG65OvKKjQgjCsfu4d9dpohFpGbL9v0Ew
        WlznDJ2QGK4aik9w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5b66f19a (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 26 Sep 2018 15:31:33 +0000 (UTC)
Received: by mail-ot1-f48.google.com with SMTP id c13-v6so10880416otf.12;
        Wed, 26 Sep 2018 08:50:07 -0700 (PDT)
X-Gm-Message-State: ABuFfoigqPsHXoFkyexMRDbgKxn5Hag+6hfeohdYib92r05SotC3CRUB
        PP282T09rH7HX5JyhEzdpNSTYZNRdTVRND9xHuY=
X-Google-Smtp-Source: ACcGV62yopT6W8FYdqTiRijjKnyp0CxWkJAXVBOaHmOIqQJYRTvttOC710dv1qe4DkzquKUuihQTEyIyCM2fU9cIHp8=
X-Received: by 2002:a9d:522d:: with SMTP id e45-v6mr4395062oth.250.1537977006136;
 Wed, 26 Sep 2018 08:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180925145622.29959-1-Jason@zx2c4.com> <20180925145622.29959-8-Jason@zx2c4.com>
 <CAKv+Gu9mVAfdBvOMCFqRJj+wBiWu3JVOgPZdkcdjzqSdQQ5Jrw@mail.gmail.com>
 <CAHmME9r9KppoFwwNVpzpYbU+9dCPzb7Pit+4iRa4MY_ouJBWrA@mail.gmail.com>
 <CAKv+Gu8ih-TsASRGqK+ST_5+EQ0=Zo-zhGCadOdGyPjucMFTCg@mail.gmail.com>
 <CAKv+Gu8w74dUSEAGxxh=C6To6F=bSm8DjiExUPmh_LUyhoDLhg@mail.gmail.com> <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com>
In-Reply-To: <CAHmME9pbRabkGjNh-65S9qBNNS1GLJSwZ_tTM507S_Ezr1=QLg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Sep 2018 17:49:55 +0200
X-Gmail-Original-Message-ID: <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com>
Message-ID: <CAHmME9ru=kJO8QiW+uNNgt5NgFVZzRsQ4tNSgo+f+KfHs3fAKQ@mail.gmail.com>
Subject: Re: [PATCH net-next v6 07/23] zinc: ChaCha20 ARM and ARM64 implementations
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
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

On Wed, Sep 26, 2018 at 5:45 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> So what you have in mind is something like calling simd_relax() every
> 4096 bytes or so?

That was actually pretty easy, putting together both of your suggestions:

static inline bool chacha20_arch(struct chacha20_ctx *state, u8 *dst,
                 u8 *src, size_t len,
                 simd_context_t *simd_context)
{
    while (len > PAGE_SIZE) {
        chacha20_arch(state, dst, src, PAGE_SIZE, simd_context);
        len -= PAGE_SIZE;
        src += PAGE_SIZE;
        dst += PAGE_SIZE;
        simd_relax(simd_context);
    }
    if (IS_ENABLED(CONFIG_KERNEL_MODE_NEON) && chacha20_use_neon &&
        len >= CHACHA20_BLOCK_SIZE * 3 && simd_use(simd_context))
        chacha20_neon(dst, src, len, state->key, state->counter);
    else
        chacha20_arm(dst, src, len, state->key, state->counter);

    state->counter[0] += (len + 63) / 64;
    return true;
}
