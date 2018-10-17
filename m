Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0BECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9665A21473
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:23:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bq/UCC2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9665A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbeJRCUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:20:00 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:36368 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeJRCT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:19:59 -0400
Received: by mail-yb1-f194.google.com with SMTP id 5-v6so10783798ybf.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3UouDUUDdFnLl24CphG2coVlgIMvH8p2ZqDDteO7N2g=;
        b=bq/UCC2mfaTmSuv4mSe0FAILftVLX6VOLWhOyirv52uVS+J8Gh5arGWpQORYtHI9Jc
         B8qt29NLHSEGTm561/upg8jZOaIePxijhGnNio3I2Kg8k3TOz6lz8uB1DG/t7SZ6bCUZ
         PiiEsNbwopIHX+CIhMz38cWzUHROHCmheBRS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3UouDUUDdFnLl24CphG2coVlgIMvH8p2ZqDDteO7N2g=;
        b=ttYgRvUiE2SJFkJerPmVp0/r3XmodnBUvMxjMLcoYPR2T3YQuuppJPhnAYXvU0IDoR
         zJKB6U17Gn4LStopom0cm8tPmnt1xwOTwxO5z4W3fNC9ul+bQuUjIm3ublHlQaCbiKj+
         FiRMwFjfpjVyuinr80c/2LXM3vVGbBMWlPYFzBnIX1gWbh6bjWdi8gb5gaKvBf7tWAMI
         4h5BJ/bsG7H59iUnqEPH+rImRjuNZR7R3ID8gE3nBpcWctRbtnC107dOw/IG9K1TwIfx
         pMKDgqkhCC7cFUhTa6zDMB1gtUbwtcR4cNXUzyW01Q4FDRxHGvoJkdRogaNeyqfQKlDh
         GxuA==
X-Gm-Message-State: ABuFfoip7/P9Js1bnunGGfYlmMNHKH6NXRCfjZ0FGpkXlZqOdKMR7grz
        crRpZ10y9dCORTtWeWa8hfZmmUo8WSA=
X-Google-Smtp-Source: ACcGV60jn99Xeya1Rys37nLFUZv2TJP8MzR5PuJzxiCb93NAaNJYZNUTXv3m3SI/RI4B6uUFci8jRQ==
X-Received: by 2002:a25:84d2:: with SMTP id x18-v6mr16101414ybm.31.1539800585272;
        Wed, 17 Oct 2018 11:23:05 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id o202-v6sm14859808ywo.38.2018.10.17.11.23.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 11:23:03 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id l79-v6so10757113ywc.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 11:23:03 -0700 (PDT)
X-Received: by 2002:a81:98cb:: with SMTP id p194-v6mr15879100ywg.353.1539800583041;
 Wed, 17 Oct 2018 11:23:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Wed, 17 Oct 2018 11:23:02
 -0700 (PDT)
In-Reply-To: <0529a397-f104-5f3a-663e-7ef2d883dcb2@embeddedor.com>
References: <20181008191712.GA12892@embeddedor.com> <CAGXu5j+a=81mGFrF5igMXe46mv_PsqzUKCzLWj0oCEMk1PY62g@mail.gmail.com>
 <9fa270bc-502d-5ff5-2acb-88ababcc9262@embeddedor.com> <20181017061741.qr23stkwqf36fet6@gondor.apana.org.au>
 <20181017072034.GD28572@kwain> <0529a397-f104-5f3a-663e-7ef2d883dcb2@embeddedor.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 17 Oct 2018 11:23:02 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKL07_ofMpTbaH2E=JnWEF8Y=36T+sQ5m-aRke5H=3twA@mail.gmail.com>
Message-ID: <CAGXu5jKL07_ofMpTbaH2E=JnWEF8Y=36T+sQ5m-aRke5H=3twA@mail.gmail.com>
Subject: Re: [PATCH] crypto: inside-secure: safexcel - fix memory allocation
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 7:41 AM, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
>
> On 10/17/18 9:20 AM, Antoine Tenart wrote:
>> Hi,
>>
>> On Wed, Oct 17, 2018 at 02:17:41PM +0800, Herbert Xu wrote:
>>> On Tue, Oct 16, 2018 at 09:44:02PM +0200, Gustavo A. R. Silva wrote:
>>>> On 10/9/18 12:20 AM, Kees Cook wrote:
>>>>> On Mon, Oct 8, 2018 at 12:17 PM, Gustavo A. R. Silva
>>>>> <gustavo@embeddedor.com> wrote:
>>>>>> The original intention is to allocate space for EIP197_DEFAULT_RING_SIZE
>>>>>> *pointers* to struct, so sizeof(priv->ring[i].rdr_req) should be
>>>>>> sizeof(*priv->ring[i].rdr_req).
>>>>>>
>>>>>> Addresses-Coverity-ID: 1473962 ("Sizeof not portable")
>>>>>> Fixes: 9744fec95f06 ("crypto: inside-secure - remove request list to improve performance")
>>>>>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>>>>>
>>>>> Reviewed-by: Kees Cook <keescook@chromium.org>
>>>>>
>>>>
>>>>
>>>> Friendly ping. Who can take this?
>>>
>>> Well I tried to take it but it doesn't apply against cryptodev.
>>> So I presume this can go into the tree that carried the change
>>> which it depended on?
>>
>> I would say this should go in cryptodev. The issue is probably because
>> of other changes that got applied in the meantime. Gustavo can probably
>> rebase his patch on top of cryptodev, and re-send it.
>>
>
> cryptodev is missing the previous commit 329e09893909d409039f6a79757d9b80b67efe39
> to which this patch applies.
>
> Kees, did you apply the commit above to your tree?
>
> If so, could you take this patch?

Since this has no functional exposure (the sizes are the same), let's
just wait until after the merge window to get this into crypto-next.

-Kees

-- 
Kees Cook
Pixel Security
