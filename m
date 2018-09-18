Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B38CECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1417E206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R+J94fdt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1417E206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeIRLBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:01:40 -0400
Received: from mail-yw1-f45.google.com ([209.85.161.45]:39450 "EHLO
        mail-yw1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeIRLBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:01:40 -0400
Received: by mail-yw1-f45.google.com with SMTP id m62-v6so296303ywd.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 22:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nXOCi1axkWrRe727/xfKkYt90rRVD32ActECvEimU30=;
        b=R+J94fdt5/Q0X5rV9s5yUEjUPUzv95zmxFtLxdMMf8xYYhmMGwLtVEpZ3AD5nKUbsQ
         nxKFJu89u3Oy7TKIiVuJ6QHUHC6s7TJg4ZyuzOmgxLzPftLHSOWzb2fIiJWqWS7q+iqr
         e98vNW/c+z+ZxbVgr5rCapeg4jHRH28Wj0uGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nXOCi1axkWrRe727/xfKkYt90rRVD32ActECvEimU30=;
        b=P1GAN1jFvVnsIOSGxvlTZg2aYyUU1cEIQ9Aq2Wh/cFJ/IzS6dhKvyiaW18KiIsxRAo
         48YCYr+TlGjmvCrbAYBlzpaFPvVsTVjFSXxJpr42XfDVcidOJU6GwuepEyg56HUotKbl
         GNXJ2WOkguByLbVMlsMcYR0+bgdTQp7Y4orfSYLlK4kR3EO4A6pnnH3lLJ4oznyoThVs
         w5CWYr+R+42xDlpJd0OVTzlVNTDz4nXV2DSA2GHo9e5haTT9FuuQOtKmWhRexmgOOZyd
         ivMBQlAZ95Mu9sl97JD6h2j1ZWFPZTXm6VD4SIAAxesmE0EdUZiu42n8q18Ukd63CmCy
         79Rg==
X-Gm-Message-State: APzg51BvRuy11mRRca7QPFQW/cigRS4Ow1UleR3XU4kyQS9MjVq7SVO6
        lzR1g/nAvcRZrpVLDo8vsOsuUrIZtlM=
X-Google-Smtp-Source: ANB0Vdbe6yANEa5U9ReC/fskyBkPjLjxEv/Mt6a6/Uj3GbDRwtgc9xkFFD6YjFkVePSsKT/+CZoeRA==
X-Received: by 2002:a81:6846:: with SMTP id d67-v6mr11218506ywc.189.1537248639135;
        Mon, 17 Sep 2018 22:30:39 -0700 (PDT)
Received: from mail-yw1-f49.google.com (mail-yw1-f49.google.com. [209.85.161.49])
        by smtp.gmail.com with ESMTPSA id r126-v6sm504364ywb.92.2018.09.17.22.30.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 22:30:38 -0700 (PDT)
Received: by mail-yw1-f49.google.com with SMTP id x67-v6so308390ywg.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 22:30:37 -0700 (PDT)
X-Received: by 2002:a0d:db10:: with SMTP id d16-v6mr12102236ywe.124.1537248637420;
 Mon, 17 Sep 2018 22:30:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 22:30:36
 -0700 (PDT)
In-Reply-To: <20180913182328.GA9812@beast>
References: <20180913182328.GA9812@beast>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Sep 2018 22:30:36 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJdqs4Rf=RvRtzQavT0oAtEEWppmjJRFRhLL4iQfCkVnQ@mail.gmail.com>
Message-ID: <CAGXu5jJdqs4Rf=RvRtzQavT0oAtEEWppmjJRFRhLL4iQfCkVnQ@mail.gmail.com>
Subject: Re: [PATCH][RFC] crypto: skcipher: Remove VLA usage
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
> RFC follow-up to https://lkml.kernel.org/r/CAGXu5j+bpLK=EQ9LHkO8V=sdaQwt==6fbGhgn2Vi1E9_WxSGRQ@mail.gmail.com
>
> The core API changes:
>
>         struct crypto_sync_skcipher
>         crypto_alloc_sync_skcipher()
>         crypto_free_sync_skcipher()
>         crypto_sync_skcipher_setkey()
>         skcipher_request_set_sync_tfm()
>         SKCIPHER_REQUEST_ON_STACK type check
>
> and a single user's refactoring as an example:
>
>         drivers/crypto/ccp/ccp-crypto.h
>         drivers/crypto/ccp/ccp-crypto-aes-xts.c
>
> Does this look correct? If so, I can continue and do the other 60
> instances of SKCIPHER_REQUEST_ON_STACK().

Herbert, how does this look? Should I do the other 60 instances? I'd
really like to get this finished up. :)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
