Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC71C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF9020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WOV2O2vR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF9020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbeIFXz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 19:55:28 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36534 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIFXz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 19:55:27 -0400
Received: by mail-yb1-f194.google.com with SMTP id d34-v6so4568590yba.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 12:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5K2AF4hd3u2iLAJIF5jwpMp9/BO/mt7wf28Abi9aVmw=;
        b=WOV2O2vR5A5fe/9qGbf0AwAUT834DRV7mMLQ+GE4XaKz9ivFC/DWQkHRAUHameYnSb
         yiaAJr8DjKTqTUJ7YUNarYwK84tYYPEQXzZSlMP9NB94vPb+KLkHeqjEQVYapYFsqJA1
         1sIDgHQd4398gU8Zfi9R/HqYLP4ZWdkp/XuI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5K2AF4hd3u2iLAJIF5jwpMp9/BO/mt7wf28Abi9aVmw=;
        b=VgwA6D6ukczA8l74cCG+yk6/MfwuWIO9K+iapODZ1Uvdl4kS1TQLsfCQLc113FEwH5
         71dF3kkOu4J1oCH4GAMb+dHgu8vij7qSj/AN5+ZyJbcN5qW2n3jtTgL0AiFYxiBCcoQM
         dd4WQiPcwc2ck/HyZ3L3RhcDHaIR8KueBqpeRHrYb+n0ZqZw44usq2bZCGNo/0/Zfx7g
         jCki1gIYqZ1zUGQ2mwqCrkv9R93+G0gOQ8Q5fGGTPXxUSEkgZuRlbtILDHsO0eVm9CEq
         0uN/PtDuudBscWfDX6vnskWCS7bN6b6etqHOv+0vxQgUckMA/lIuf70seKhUk5Bf8WAO
         POpg==
X-Gm-Message-State: APzg51CCwQAzu/66d9fyh6zF5erBeJBRnbexYP+L0oROKuF5F5DfNqrc
        nmM3p/bZm0GEM4Qc2aKpMaWN2J8x7Ec=
X-Google-Smtp-Source: ANB0VdZmvpmpwSZnMsEVzP+yT+NRmZxA52g9CQpOhAk9O5OTFZ17CV0HPODPSHMknE3ULVJ2Aesshg==
X-Received: by 2002:a25:8205:: with SMTP id q5-v6mr2345283ybk.363.1536261514047;
        Thu, 06 Sep 2018 12:18:34 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id v185-v6sm1962588ywc.94.2018.09.06.12.18.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Sep 2018 12:18:32 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id h22-v6so4547447ybg.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 12:18:30 -0700 (PDT)
X-Received: by 2002:a25:19c3:: with SMTP id 186-v6mr2369882ybz.410.1536261510130;
 Thu, 06 Sep 2018 12:18:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 12:18:28 -0700 (PDT)
In-Reply-To: <CAKv+Gu9tSFg9ekEagfn4sPbK-NLYHmmEtij=iMm7szGGQD9B1A@mail.gmail.com>
References: <20180904181629.20712-1-keescook@chromium.org> <20180904181629.20712-3-keescook@chromium.org>
 <CAKv+Gu9uJ+ZjBSCM=aU0GDvYR72cy2k8reXdLV5on3dOVw8KdQ@mail.gmail.com>
 <CAGXu5jKmcuhULMR=O9B_hJAxEK8uV36uoMxm4F3F8yYSuMzYNA@mail.gmail.com>
 <CAKv+Gu_0vWUqkUex45iW=pAfUbKVsqzP9MDf6OOwTg-nUVPZNg@mail.gmail.com>
 <CAOtvUMfu4-DWD4n4c5itjArAYWhGaBnPBEnkh6cbCubG-k9cCA@mail.gmail.com>
 <CAKv+Gu8bKcPksgoryaVjoD9G5KeCYrqWOCgVhqrBqGw5dCzXag@mail.gmail.com>
 <CAKv+Gu-QkCE0pY4+5anEZ0eWv-FTH1QJtOQfPcTVLcvNf7XNiA@mail.gmail.com>
 <20180906085100.xcqqftgqg4sizkec@gondor.apana.org.au> <CAKv+Gu_0ehX9sLCtUYR00D4iQw+ytwmsLKmG6dgq9EnLjidKFw@mail.gmail.com>
 <20180906131149.ge2db74nxffs2tbz@gondor.apana.org.au> <CAKv+Gu9tSFg9ekEagfn4sPbK-NLYHmmEtij=iMm7szGGQD9B1A@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 6 Sep 2018 12:18:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKg2GTPxo=N2xLoxbLM3LQHhE+TButPJQeP-Ze1zqEs_w@mail.gmail.com>
Message-ID: <CAGXu5jKg2GTPxo=N2xLoxbLM3LQHhE+TButPJQeP-Ze1zqEs_w@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: skcipher: Remove VLA usage for SKCIPHER_REQUEST_ON_STACK
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Eric Biggers <ebiggers@google.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 7:49 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 6 September 2018 at 15:11, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> On Thu, Sep 06, 2018 at 11:29:41AM +0200, Ard Biesheuvel wrote:
>>>
>>> Perhaps not, but it is not enforced atm.
>>>
>>> In any case, limiting the reqsize is going to break things, so that
>>> needs to occur based on the sync/async nature of the algo. That also
>>> means we'll corrupt the stack if we ever end up using
>>> SKCIPHER_REQUEST_ON_STACK() with an async algo whose reqsize is
>>> greater than the sync reqsize limit, so I do think some additional
>>> sanity check is appropriate.
>>
>> I'd prefer compile-time based checks.  Perhaps we can introduce
>> a wrapper around crypto_skcipher, say crypto_skcipher_sync which
>> could then be used by SKCIPHER_REQUEST_ON_STACK to ensure that
>> only sync algorithms can use this construct.
>>
>
> That would require lots of changes in the callers, including ones that
> already take care to use sync algos only.
>
> How about we do something like the below instead?

Oh, I like this, thanks!

-Kees

-- 
Kees Cook
Pixel Security
