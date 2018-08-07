Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58F5C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9169021707
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IecwKrij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9169021707
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390130AbeHGUZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:25:47 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:41948 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389046AbeHGUZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:25:47 -0400
Received: by mail-yb0-f196.google.com with SMTP id q5-v6so3792387ybk.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 11:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ldCnVVfuby+iBgouIKcjiocUEVE8eLaQ0+5ecVmUo1Y=;
        b=IecwKrijEkihl+E/Ab8r5FjcY5ymuACZKBn+VKdSi54/VynqClW7qNKAhRyji2/fob
         Woai+Y5F5PvLSj5CQ4WWTyxPsaK1IRO5q/fmGlNnL0tW73UJtUDXL6tjlzHvQMvvz8v0
         ZxO9vaRzsv5Uow3J6GARTjAVIQ2AjWAf9GET0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ldCnVVfuby+iBgouIKcjiocUEVE8eLaQ0+5ecVmUo1Y=;
        b=Zgo42mA6eq5dTqH1NFZ/9cKjPDzKSUH+lMfpkQf8NtSVqFhK2/iLQs4LmZsYQ7cYHL
         96ZMjcaiAj7GgYggjN0txOYrz1zYHhnaikvAu1TS80tQz4GADV6L4YYg/NhkPn0WinVg
         p1axnHYnDkgGwcjgr6c/MgkP1+bzOwo0BVdsKuUHNVh0VWXrGLTWNj5ecxmMmECK8Mji
         XuVu2wwu400cQhXPSW4IZTYLeHvRqQtdcPrnmbuEHRrkJaa4RN3cKJ80d8lQj0AgCLNa
         wT52QDKUP4W/RDvVuOj8gbIBProAI5LiDgg/C5Mjm9/6Jtcr4u+Nb2EVE7Ukp/mDExbB
         6Biw==
X-Gm-Message-State: AOUpUlHW3Z5mWbVVJWsFlx40HiYHr3pXxAn3gR9DTODDC8G9ZDQ5EYko
        szRjgsN2VLKIjKiKmR79zeQKdz2ZWw1GVg==
X-Google-Smtp-Source: AA+uWPyVhRJmaTOq5uCh8yOkM7+QiO1G/7IZOEE/4AybAN3wqklT8Q8fwRd/PR5rCrf1PgvPH4oPWw==
X-Received: by 2002:a25:b328:: with SMTP id l40-v6mr2365608ybj.433.1533665414878;
        Tue, 07 Aug 2018 11:10:14 -0700 (PDT)
Received: from mail-yb0-f180.google.com (mail-yb0-f180.google.com. [209.85.213.180])
        by smtp.gmail.com with ESMTPSA id t6-v6sm1822134ywe.81.2018.08.07.11.10.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 11:10:12 -0700 (PDT)
Received: by mail-yb0-f180.google.com with SMTP id r3-v6so6962112ybo.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 11:10:12 -0700 (PDT)
X-Received: by 2002:a25:add4:: with SMTP id d20-v6mr9586046ybe.463.1533665411534;
 Tue, 07 Aug 2018 11:10:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7450:0:0:0:0:0 with HTTP; Tue, 7 Aug 2018 11:10:10 -0700 (PDT)
In-Reply-To: <20180807094513.vstt5dhbb7n6kvds@gondor.apana.org.au>
References: <20180802215118.17752-1-keescook@chromium.org> <20180802215118.17752-2-keescook@chromium.org>
 <20180807094513.vstt5dhbb7n6kvds@gondor.apana.org.au>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 7 Aug 2018 11:10:10 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+dPqpJZbO_AuGsNqJzq7XGcB2deXA5RELWv1-Ywi5QOA@mail.gmail.com>
Message-ID: <CAGXu5j+dPqpJZbO_AuGsNqJzq7XGcB2deXA5RELWv1-Ywi5QOA@mail.gmail.com>
Subject: Re: [PATCH 1/9] crypto: add zbufsize() interface
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Geliang Tang <geliangtang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Haren Myneni <haren@us.ibm.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 7, 2018 at 2:45 AM, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Aug 02, 2018 at 02:51:10PM -0700, Kees Cook wrote:
>> When pstore was refactored to use the crypto compress API in:
>>
>>   commit cb3bee0369bc ("pstore: Use crypto compress API")
>>
>> nearly all the pstore-specific compression routines were replaced with
>> the existing crypto compression API. One case remained: calculating the
>> "worst case" compression sizes ahead of time so it could have a buffer
>> preallocated for doing compression (which was called "zbufsize").
>>
>> To make pstore fully algorithm-agnostic, the compression API needs to
>> grow this functionality. This adds the interface to support querying the
>> "worst case" estimate, with a new "zbufsize" routine that each compressor
>> can implement. The per-compressor implementations come in later commits.
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>>  crypto/compress.c                   |  9 +++++++++
>>  include/crypto/internal/scompress.h | 11 +++++++++++
>>  include/linux/crypto.h              | 12 ++++++++++++
>>  3 files changed, 32 insertions(+)
>>
>> diff --git a/crypto/compress.c b/crypto/compress.c
>> index f2d522924a07..29a80bb3b9d3 100644
>> --- a/crypto/compress.c
>> +++ b/crypto/compress.c
>> @@ -33,12 +33,21 @@ static int crypto_decompress(struct crypto_tfm *tfm,
>>                                                          dlen);
>>  }
>>
>> +static int crypto_zbufsize(struct crypto_tfm *tfm,
>> +                        unsigned int slen, unsigned int *dlen)
>> +{
>> +     if (!tfm->__crt_alg->cra_compress.coa_zbufsize)
>> +             return -ENOTSUPP;
>> +     return tfm->__crt_alg->cra_compress.coa_zbufsize(tfm, slen, dlen);
>> +}
>
> Please don't add new features to the old compress interface.  Any
> new improvements should be added to scomp/acomp only.  Users who
> need new features should be converted.

So, keep crypto_scomp_zbufsize() and drop crypto_comp_zbufsize() and
crypto_zbufsize()? Should I add crypto_acomp_zbufsize()?

-Kees

-- 
Kees Cook
Pixel Security
