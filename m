Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B89ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22F22145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 17:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fWvQuVh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22F22145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbeIXX4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 19:56:53 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:35408 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbeIXX4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 19:56:53 -0400
Received: by mail-yb1-f196.google.com with SMTP id o63-v6so8612840yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=B/psylvf9zwFpHg66fPdLSR1ZEPOmHk0seLGPsG82fk=;
        b=fWvQuVh58tJGWqSoBz/ZEIM9HKnv067DXl1Y+/72UbFjBk61lSBAUrmK/cB7Whj2wQ
         ZEyRtRflEyvLLnfvWrIA4s707GhK3wrWiBfFAWcgpjUhoKEXEyPk2+vhBC5qvBSTP0Wv
         xpPvS2qYITj8XyEUp+cWzIfvvQMqLwRxtBLl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=B/psylvf9zwFpHg66fPdLSR1ZEPOmHk0seLGPsG82fk=;
        b=S2Es5NZWaEhpAJKE7t516RS0QYzxRaZl2v97Jz+nBmVZ8AL2R5MEuYfTTPr9B5Lavn
         9zCCPD2AWl/7iXP5NNWr5iMAyoAP4L0y8U3CV31B+mkl6o8odRHdqvYPsf766TYEGzHI
         hJLqD9BFIp8eLq0ixDuu2neN3oJjbvgVxbeq1dDmUCtjjgZfu0wb/xmtJFSqJwTCn+/N
         CszFSjR7irno5aqmHhEcTzxN5Xfta+e6xoHFW+SqVGePYbw3drf8LGYLF+kY4j/puk6M
         QY51AEQoOzbS5GMMRD++XNd2R3yY2KS4mDwuqyaaFMaT5VWUy6+yqifPjuocdrrFsfa3
         n4ig==
X-Gm-Message-State: ABuFfoior7GfkzFpF7az17GPTcSy037gHUtdPvrmw3xKRtqmaEcWowIH
        JVTBwys25y/CKgkO2+Xtj3Lb6hoiDl4=
X-Google-Smtp-Source: ACcGV60UkwOhNv4Sb5N22xZ7J38beBSXoVMIUdCylVQdfwsRKLLU7ZvVJDtH3L7co3HDslFixrxQ7A==
X-Received: by 2002:a25:2ce:: with SMTP id 197-v6mr3544735ybc.215.1537811613458;
        Mon, 24 Sep 2018 10:53:33 -0700 (PDT)
Received: from mail-yw1-f52.google.com (mail-yw1-f52.google.com. [209.85.161.52])
        by smtp.gmail.com with ESMTPSA id y204-v6sm936294ywc.106.2018.09.24.10.53.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:53:32 -0700 (PDT)
Received: by mail-yw1-f52.google.com with SMTP id b2-v6so4059430ywe.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 10:53:31 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr5449910ywr.168.1537811611616;
 Mon, 24 Sep 2018 10:53:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 24 Sep 2018 10:53:30
 -0700 (PDT)
In-Reply-To: <CAKv+Gu8ynaVi1KCMNsjCU0ucAjFFku=ourh9Yc9Rizoc4ztvOQ@mail.gmail.com>
References: <20180919021100.3380-1-keescook@chromium.org> <20180919021100.3380-8-keescook@chromium.org>
 <CAKv+Gu8ynaVi1KCMNsjCU0ucAjFFku=ourh9Yc9Rizoc4ztvOQ@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 24 Sep 2018 10:53:30 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLw3+nvb9opPeoCyH0MhyVK5UY7H5qeQ2b8GFTUGDGrUQ@mail.gmail.com>
Message-ID: <CAGXu5jLw3+nvb9opPeoCyH0MhyVK5UY7H5qeQ2b8GFTUGDGrUQ@mail.gmail.com>
Subject: Re: [PATCH crypto-next 07/23] block: cryptoloop: Remove VLA usage of skcipher
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 4:52 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On Wed, 19 Sep 2018 at 04:11, Kees Cook <keescook@chromium.org> wrote:
>> @@ -119,7 +119,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
>>         unsigned in_offs, out_offs;
>>         int err;
>>
>> -       skcipher_request_set_tfm(req, tfm);
>> +       skcipher_request_set_sync_tfm(req, tfm);
>>         skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
>>                                       NULL, NULL);
>>
>
> Does this work?

Everything is a direct wrapper for existing types and functions, so I
wouldn't expect any functional change. I haven't been able to test
this particular interface, though. cryptoloop is very deprecated,
isn't it?

-Kees

-- 
Kees Cook
Pixel Security
