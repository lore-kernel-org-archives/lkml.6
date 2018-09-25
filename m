Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553ABC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3F820867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 16:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UXZT+IEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3F820867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbeIYWLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 18:11:41 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50355 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729306AbeIYWLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 18:11:41 -0400
Received: by mail-it1-f194.google.com with SMTP id j81-v6so16129476ite.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 09:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5GV4hMV5biu/RxQ0FvsNjPALRR2nr3ZmEGH7IGGYM6o=;
        b=UXZT+IEPIXmSNjFsb/R7lQZMVBEg8fdRi1K0a85aFAIdOcDn+jvBlSFYfUX4XSx9Wo
         ZdMcjB5qwrake++0L2VV6ZRrRbIhFzcjGWts7+TcQL040YqRPLEFqffjNbF1evnSauJZ
         Pio2tVNNz+hl6uV9moiglB6YI32QP3uQLhP8bWPin0qFP5yu6ROUcAcGLVFCdDfYt2FM
         RM5SbvEaYO2yDOUeRfksOYfam5lSCMry8aVf4I8DtGsb2In2DE5+9E53sO4L8Mra92go
         aykKE9LtYfPc1BW06HB8Wuc12Gq0t2x1YnaxEK3AeBWGQgsYBEOaZieafvKK74HohSfF
         Brtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5GV4hMV5biu/RxQ0FvsNjPALRR2nr3ZmEGH7IGGYM6o=;
        b=Orq8dyt2FtGXLmshAWPFrGomOWM1omrDFL63ejy74PpD47Nv2rrwwFjr1e3AMNjBQS
         7WRT3yrACkl/pkkc9NIjygBg0byLSXcli87ZwzwwAYbuwbjK8NOhVCDjA00MvBDanfQj
         ZCaJZgfsAAGcp8gkIIMPpp3j8soneJmtYg0B5d15cpVMnddxKdaumV/vJ9OwG0+2cOjW
         w4MWuNoa+kvkpeN7J5q/lfmfaZ/bvA9nsRPeroF5b5nKYm4LEJphPpDy6NTLbO6lzO+q
         whvvetOgr3kDA/8HJKQvaNT0gYtJAxYMNejVYpuE9iGQg8owt9AYGoTtnTQ1H9N0MudZ
         1OIA==
X-Gm-Message-State: ABuFfojPW7vRrq9zecK9Jkfmdoxp6fEMbT94C43Wusqr0K/YOkpe04Bu
        4RWpRKfeC4N/NWKtinEudQtP2bPJmiE=
X-Google-Smtp-Source: ACcGV612JaEZoiZt+JRBjh2zV7x8XdzCGLf/J/rqLIn8R7rIyHsheCJMIKYC0Q7wA3xRWhiwQ9vhVQ==
X-Received: by 2002:a24:7941:: with SMTP id z62-v6mr1370991itc.20.1537891410274;
        Tue, 25 Sep 2018 09:03:30 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v13-v6sm1083897ita.38.2018.09.25.09.03.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 09:03:29 -0700 (PDT)
Subject: Re: [PATCH crypto-next 07/23] block: cryptoloop: Remove VLA usage of
 skcipher
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        linux-block@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180919021100.3380-1-keescook@chromium.org>
 <20180919021100.3380-8-keescook@chromium.org>
 <CAKv+Gu8ynaVi1KCMNsjCU0ucAjFFku=ourh9Yc9Rizoc4ztvOQ@mail.gmail.com>
 <CAGXu5jLw3+nvb9opPeoCyH0MhyVK5UY7H5qeQ2b8GFTUGDGrUQ@mail.gmail.com>
 <CAKv+Gu-xKWsiegZXnsMvmMVgKTo7S2cm4wEqdaL7w9z64X7SAA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9c71afda-a668-10b3-842e-26f72e425691@kernel.dk>
Date:   Tue, 25 Sep 2018 10:03:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-xKWsiegZXnsMvmMVgKTo7S2cm4wEqdaL7w9z64X7SAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/18 3:25 AM, Ard Biesheuvel wrote:
> On Mon, 24 Sep 2018 at 19:53, Kees Cook <keescook@chromium.org> wrote:
>>
>> On Mon, Sep 24, 2018 at 4:52 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On Wed, 19 Sep 2018 at 04:11, Kees Cook <keescook@chromium.org> wrote:
>>>> @@ -119,7 +119,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
>>>>         unsigned in_offs, out_offs;
>>>>         int err;
>>>>
>>>> -       skcipher_request_set_tfm(req, tfm);
>>>> +       skcipher_request_set_sync_tfm(req, tfm);
>>>>         skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
>>>>                                       NULL, NULL);
>>>>
>>>
>>> Does this work?
>>
>> Everything is a direct wrapper for existing types and functions, so I
>> wouldn't expect any functional change. I haven't been able to test
>> this particular interface, though. cryptoloop is very deprecated,
>> isn't it?
>>
> 
> Ah yes, I managed to confuse myself there. This looks all fine to me.
> 
> In any case, this is another example where we may decide to fix the
> code rather than retain the request allocation on the stack (but that
> is Jens's call ultimately, I suppose)
> 
> diff --git a/drivers/block/cryptoloop.c b/drivers/block/cryptoloop.c
> index 7033a4beda66..5ed2167219ba 100644
> --- a/drivers/block/cryptoloop.c
> +++ b/drivers/block/cryptoloop.c
> @@ -110,7 +110,7 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
>                     int size, sector_t IV)
>  {
>         struct crypto_skcipher *tfm = lo->key_data;
> -       SKCIPHER_REQUEST_ON_STACK(req, tfm);
> +       struct skcipher_request *req;
>         struct scatterlist sg_out;
>         struct scatterlist sg_in;
> 
> @@ -119,7 +119,10 @@ cryptoloop_transfer(struct loop_device *lo, int cmd,
>         unsigned in_offs, out_offs;
>         int err;
> 
> -       skcipher_request_set_tfm(req, tfm);
> +       req = skcipher_request_alloc(tfm, GFP_NOIO);
> +       if (!req)
> +               return -ENOMEM;

Is this going to be reliable? ->transfer() is called when we're doing IO,
and you'd normally need a mempool backed allocation to make this safe
and guarantee forward progress.

-- 
Jens Axboe

