Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA49CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7493E2156E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 20:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FYKHBTH2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7493E2156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeHGXPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 19:15:52 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37541 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeHGXPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 19:15:52 -0400
Received: by mail-yw1-f66.google.com with SMTP id w76-v6so20572ywg.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LTPUUp/AGMk81cmpB2rQ5GGcpci70pDuPTY3tV2VyTI=;
        b=FYKHBTH2RAXA+JyHV9XIaq4pJj+lJCUhKz8TQ3qj7dHBD+Nu/pTYZRdtQ0ah2CWhbp
         xbE3KIW0TwFkm96yxcSZT2PWM8OZSzagjAWQ8eJ3JD5MV6okRZkIAPEUiTOXKoDdmoi8
         L+1AEZjxWRA9TcErXYkVfrpov8g/nBf9U+sZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LTPUUp/AGMk81cmpB2rQ5GGcpci70pDuPTY3tV2VyTI=;
        b=emsyk61+5oequE1uHJBXuePAWyA1cf7REc7i6nyenvglIYWZjFof/rzrAF2v0dy5RB
         YGkmWqmfS0W9Vd640FBFDBVuc5tiwR9gMcddQ8jzs+6yAwECLa/ryKR7s/q96WcA83bo
         VJaiQhaLLuI/kTGQCsGkQuK5tnKHN8tuEVB9ruqBn70C3txpb4MPF0d7cD6NO4hmz/s0
         ydw3EOUHabwO5BCUpcR7VxO9RMlkMYrlUXemsRCUuc7rrex4qi5LdrV23SqO03WBEF5X
         /yKSsRQ7yeSdynWzJT2PdixYBjW0IXKzHcHJQBB4y8pfrbaLQPeMVCEuUJ4kRzdc+i3h
         CSJA==
X-Gm-Message-State: AOUpUlFzaPNJWq6jNlrVBvK2Q0JKSilVl8Eyh0jHYZnS4lRhQN1PooLu
        jeBnSY/w7TQakuHgbXwESltJMqIY1VE=
X-Google-Smtp-Source: AA+uWPxyXOV245QC8w3DBEZyTLSJSy6Iu0pgkrXKBI21fh8cO+27KWdTemLlh7E01DR7kBE6SanYVg==
X-Received: by 2002:a0d:d949:: with SMTP id b70-v6mr29332ywe.396.1533675576057;
        Tue, 07 Aug 2018 13:59:36 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id b11-v6sm1324973ywa.46.2018.08.07.13.59.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 13:59:35 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id z143-v6so13203ywa.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 13:59:35 -0700 (PDT)
X-Received: by 2002:a81:39d7:: with SMTP id g206-v6mr15795ywa.416.1533675141708;
 Tue, 07 Aug 2018 13:52:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7450:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 13:52:20 -0700 (PDT)
In-Reply-To: <20180807094720.ljie32lewzlgymm4@gondor.apana.org.au>
References: <20180802225152.19194-1-keescook@chromium.org> <20180802225152.19194-3-keescook@chromium.org>
 <20180807094720.ljie32lewzlgymm4@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 7 Aug 2018 13:52:20 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKvP0BqYx7vG1DP=W_xG40M42NL9iXdm+dqdm9b_r3YMQ@mail.gmail.com>
Message-ID: <CAGXu5jKvP0BqYx7vG1DP=W_xG40M42NL9iXdm+dqdm9b_r3YMQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/9] crypto: cbc: Remove VLA usage
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>, qat-linux@intel.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 2:47 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Aug 02, 2018 at 03:51:45PM -0700, Kees Cook wrote:
>> In the quest to remove all stack VLA usage from the kernel[1], this
>> uses the upper bounds on blocksize. Since this is always a cipher
>> blocksize, use the existing cipher max blocksize.
>>
>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  include/crypto/cbc.h | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/crypto/cbc.h b/include/crypto/cbc.h
>> index f5b8bfc22e6d..47db0aac2ab9 100644
>> --- a/include/crypto/cbc.h
>> +++ b/include/crypto/cbc.h
>> @@ -113,7 +113,9 @@ static inline int crypto_cbc_decrypt_inplace(
>>       unsigned int bsize = crypto_skcipher_blocksize(tfm);
>>       unsigned int nbytes = walk->nbytes;
>>       u8 *src = walk->src.virt.addr;
>> -     u8 last_iv[bsize];
>> +     u8 last_iv[MAX_CIPHER_BLOCKSIZE];
>> +
>> +     BUG_ON(bsize > sizeof(last_iv));
>
> Ugh, please don't add these BUG_ONs.  Add them to the places where
> the algorithm is created (if they aren't checking that already).

It's already being checked (cra_blocksize vs MAX_CIPHER_BLOCKSIZE) so
I was just adding the BUG_ON to catch "impossible" behavior. I'll
leave it out in the next revision.

-Kees

-- 
Kees Cook
Pixel Security
