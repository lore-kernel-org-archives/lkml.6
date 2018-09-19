Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C34AECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 461262083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 00:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="xsrcl7i3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461262083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbeISGVL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:21:11 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:37789 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbeISGVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:21:11 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 2fd69d60;
        Wed, 19 Sep 2018 00:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=Ej8cbOf50zxWVmDYal00+LfH7Dk=; b=xsrcl7
        i3iHFZM95G9gp3ntTEjVuDq30fibtgfPe+VEdEmlZJc9Aqb3VUwwU9CdXl/pik4i
        AcJzP90XgFJKfd2i0Pon4XLQCzoCI+Di88AOA3JWIhKieI5DZ/qhGNdlh3JdUM2n
        Y5a1Dw51ukRwguJeKl323cO5pr3LtPtusjuhWvdLLDR/CBeGD2RwD3XnLcj+ic3e
        MR5D3J2QGzmyYz0m+Brb3NNgGt+NPIG9/wpfViqxtm5KIdTBAIcjOY5QJomnjcaz
        zLXWRpTfEGx5NymV6M3uQIL0/fxkbOo8qtwlyE8dtt2JHopEujmmkRj1vydU1ibs
        Ui1eih5ylRCxwivA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0904a8f8 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 19 Sep 2018 00:28:21 +0000 (UTC)
Received: by mail-oi0-f54.google.com with SMTP id r69-v6so3535151oie.3;
        Tue, 18 Sep 2018 17:45:58 -0700 (PDT)
X-Gm-Message-State: APzg51Ap16VeSaDbN83Y8INaaeydt0nCn0shn9KYbecSArmDRb/U63cc
        7dSEPvuiyawtLsINsA1MnfBpKTunaCqVZaWjn4M=
X-Google-Smtp-Source: ANB0VdbflTWkvbGiWy+n4hGSfYtHCubX/Av3uA1RiZ7mEGKxHnuR9+vgTKHtC/cljJhlq99M12NnWPHNfKGvJUehooI=
X-Received: by 2002:aca:b256:: with SMTP id b83-v6mr186110oif.235.1537317957448;
 Tue, 18 Sep 2018 17:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180918161646.19105-1-Jason@zx2c4.com> <20180918161646.19105-13-Jason@zx2c4.com>
 <20180919004132.GB74746@gmail.com>
In-Reply-To: <20180919004132.GB74746@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 19 Sep 2018 02:45:46 +0200
X-Gmail-Original-Message-ID: <CAHmME9quryj4RW6gDEYiXpz61oh-xcEett3kv36ZZ4y1in-yTQ@mail.gmail.com>
Message-ID: <CAHmME9quryj4RW6gDEYiXpz61oh-xcEett3kv36ZZ4y1in-yTQ@mail.gmail.com>
Subject: Re: [PATCH net-next v5 12/20] zinc: BLAKE2s generic C implementation
 and selftest
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

Hey Eric,

On Wed, Sep 19, 2018 at 2:41 AM Eric Biggers <ebiggers@kernel.org> wrote:
> This buffer is 4 times too long.

Nice catch.

> Or how about something much simpler:
>
> static inline void blake2s_final(struct blake2s_state *state, u8 *out,
>                                  const size_t outlen)
> {
> #ifdef DEBUG
>         BUG_ON(!out || !outlen || outlen > BLAKE2S_OUTBYTES);
> #endif
>         __blake2s_final(state);
>
>         cpu_to_le32_array(state->h, ARRAY_SIZE(state->h));
>         memcpy(out, state->h, outlen);
>
>         memzero_explicit(state, sizeof(*state));
> }

Oh, that's excellent, thanks. Much better than prior. I'll do exactly that.

Jason
