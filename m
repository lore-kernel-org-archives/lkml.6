Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9510C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579EB20869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hD/3kJZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579EB20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeIDKWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 06:22:13 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:46381 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeIDKWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 06:22:12 -0400
Received: by mail-yb1-f196.google.com with SMTP id y20-v6so857193ybi.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 22:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=686k+jR7J1yFAzxJs05rB+UFpjjH5ySkMF76lib8S7o=;
        b=hD/3kJZjwnu5Sg72w5x4lg9gPAFlue/XmA/2PFCDht7H6d7t1IvAnFFL2glraukaeM
         Q8J4RwZZkZoRxGWOjIm2ZNmTP71JRuXfAKlhVOl9vytrvu0CbcoWCKcnyOcT6PfvAEZ/
         OrJ1e5FqVGjFnb7CEsfKMqswxidb4FnZvDBes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=686k+jR7J1yFAzxJs05rB+UFpjjH5ySkMF76lib8S7o=;
        b=htRRxjYQ7u1ZWxz7BWyeQ4b2qLHENHJ49qOJ37EMfBN12GtpyYBSre5weatQCj4EWX
         BB5IQy0h9PrCFOhr5wR7zefQK4c5A1on8FdizLN/BQfhvuBbapzrlggG7nXo8vdMQCZq
         5sZywb3m8Hxj7f+n5XQZ3yAK8eOEumL1kL3hCw/40QuQ3ZBW+ttVtLPTkyr6N0qLANYQ
         35NfjRQqVD7dwPDGbcg7nLa7KFLK7yJyK//nZUGTaZnVM2Ar+c7YWfaWsD5w7CuU5mrf
         zYFxk2J7HwyKIpkjFTS7m/HpEdeqUU7xAb0tI4G3ggo73Cjnt5FC2C7CUP7pno9ZW2SP
         G8BA==
X-Gm-Message-State: APzg51AtDb7hQRTDozC+IK1NxSXr5yNFxDVF64FAgewDnh59iRCpGxrk
        DmrZK4YgGSFE+dwK1DGKGhQaqTaiCIY=
X-Google-Smtp-Source: ANB0Vdb/Pqk1DrMNVQ+R484MPYlYm7c1ryVHPLbRFjRs0WRZR6nKjADeCN+HIv4+7uO/4uZ7jufrfw==
X-Received: by 2002:a25:d34f:: with SMTP id e76-v6mr4697051ybf.227.1536040717727;
        Mon, 03 Sep 2018 22:58:37 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id h65-v6sm7782929ywe.75.2018.09.03.22.58.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 22:58:37 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id n21-v6so842222ywh.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 22:58:37 -0700 (PDT)
X-Received: by 2002:a81:9fd6:: with SMTP id w205-v6mr18030125ywg.288.1536040242096;
 Mon, 03 Sep 2018 22:50:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 3 Sep 2018 22:50:41 -0700 (PDT)
In-Reply-To: <20180904051905.a2vyzijz6xyxvyhb@gondor.apana.org.au>
References: <20180807211843.47586-1-keescook@chromium.org> <20180904051905.a2vyzijz6xyxvyhb@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 3 Sep 2018 22:50:41 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLHkNSGhR7Tk6wg8Vw-7nHPFfAgWyJ0NLMjGQw1BOKovg@mail.gmail.com>
Message-ID: <CAGXu5jLHkNSGhR7Tk6wg8Vw-7nHPFfAgWyJ0NLMjGQw1BOKovg@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] crypto: Remove VLA usage
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Tudor-Dan Ambarus <tudor.ambarus@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Matthew Wilcox <willy@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        qat-linux@intel.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 3, 2018 at 10:19 PM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Tue, Aug 07, 2018 at 02:18:34PM -0700, Kees Cook wrote:
>> v8 cover letter:
>>
>> I continue to hope this can land in v4.19, but I realize that's unlikely.
>> It would be nice, though, if some of the "trivial" patches could get taken
>> (e.g. cbc, xcbc, ccm VLA removals) so I don't have to keep repeating them.
>> *fingers crossed*
>>
>> Series cover letter:
>>
>> This is nearly the last of the VLA removals[1], but it's one of the
>> largest because crypto gets used in lots of places. After looking
>> through code, usage, reading the threads Gustavo started, and comparing
>> the use-cases to the other VLA removals that have landed in the kernel,
>> I think this series is likely the best way forward to shut the door on
>> VLAs forever.
>>
>> For background, the crypto stack usage is for callers to do an immediate
>> bit of work that doesn't allocate new memory. This means that other VLA
>> removal techniques (like just using kmalloc) aren't workable, and the
>> next common technique is needed: examination of maximum stack usage and
>> the addition of sanity checks. This series does that, and in several
>> cases, these maximums were already implicit in the code.
>>
>> This series is intended to land via the crypto tree for 4.19, though it
>> touches dm, networking, and a few other things as well, since there are
>> dependent patches (new crypto #defines being used, etc).
>
> I have applied patches 1-4 and 6-8.  I'd like to get an ack from
> the dm folks regarding patch 5.  As to patch 9, please fix it so
> it doesn't rely on the BUG_ON to catch things.

Great! Thanks very much. I'll get a patch prepared to plumb
crypto_skcipher_set_reqsize() failures.

-Kees

-- 
Kees Cook
Pixel Security
