Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D47FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9EA21A53
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 17:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="DwWXg/cj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jbZUQzvu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D9EA21A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbeHFTh3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 15:37:29 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:34397 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732545AbeHFTh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 15:37:29 -0400
Received: by mail-yb0-f195.google.com with SMTP id e9-v6so5603981ybq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 10:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=NBPcMZpj6Xt3J+0tlMnJed0sVc5kZAWuFg1y7I5yFh4=;
        b=DwWXg/cjWAQs2c+k8Jcv0cO9Wae5YUWN2DogKyHIgTdYwYSARnnVt7WfrPcVbxBeip
         zBi0kdJDA0dWBMI+qCYR/8Qn8D55OmDRxl+d8gXzCcJjeHvh+f2HoMirtJh2i0xQKuKe
         cbcHHtoXWFSZ2I5BdZrrqMz07dZh3OjRWSp6PrrCS3oNO9Hr0bWAzkMF4NBnvnEZLFzB
         SBNP0QymuhyY1vMIBIiETGZGmCZaLB+0n1nRbts/xcGODl3GaEq5VFL6Z/8ibsLdkO4x
         UHCA0XvOOUYQLRG02Q9+uGHULRBu/MNJZanvNCnfeN9nsK7oYsUEYnx2EPlbs4uVe31G
         ofYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=NBPcMZpj6Xt3J+0tlMnJed0sVc5kZAWuFg1y7I5yFh4=;
        b=jbZUQzvuGkqAO8aQBdHm8aO4aFaw8mnqhmKbm/nVZSBKtwcVhFIdFOLJ1R53IM5lTG
         tbg+zg0GKEtvbVezAhKDnGQtYk/0QB5JTKQMEh7VB7GxS+0ThQB6Js87gK7gvhsswW9/
         CUrfAJRCggpXV0z4wsAWkZaV4E1qmBCGn4Ewk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=NBPcMZpj6Xt3J+0tlMnJed0sVc5kZAWuFg1y7I5yFh4=;
        b=rM2unsTqXLPEVawv6ij7qsayA0DQ8qvHg8FvU/m/ceuYIzZF8miHmZ5V2Hy8FWd+Z7
         nErS5ZfK4Wwh5aG00Ij904YdPPnWm9jDZRI+rvTaOrfAW/V+p1lmPHXVY0rpfqocUIq6
         ZM6JR68v/WGC6LRPX+knGboVMO98hv5cJc2p4N94yCADFN4TK+sNdO9izgUCybW4AvnQ
         cMnwrwvTYjIBzwguaGZpG/BaAOqYldtN20b7VaQyoRE0qsiYBpA9GCIYNO3uq4XEU2uw
         1Shdj/kOIhtJY+Bhi38wB0HzKgBuJ9TAuH7KilzYum9AqiMovdDPCaOhFpF+jR7YfWyL
         h47w==
X-Gm-Message-State: AOUpUlHjex708x9OPzHarAcsTHTiLsO4eNWz6yYRWW60nJfANvISHbcC
        /7U1fqtkCO7EA3BO2t9a85mZvt/sggYsFLouqCC+5A==
X-Google-Smtp-Source: AAOMgpeW1siyPfOKx66a3UpXx9+iSKmSggwesNZva6GEd63GSBvqMFUvrrxF5GT+ZrAcfwRMoAzWVfRFm0w3XMu7aKI=
X-Received: by 2002:a25:a302:: with SMTP id d2-v6mr8316448ybi.193.1533576443279;
 Mon, 06 Aug 2018 10:27:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:7450:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 10:27:22 -0700 (PDT)
In-Reply-To: <20180803134357.GB28982@soda.linbit>
References: <20180724164936.37477-1-keescook@chromium.org> <20180724164936.37477-13-keescook@chromium.org>
 <CAGXu5jJB6V0r8LXOGL6+sO0NVZ0HK3VCthML=T3gLEwMABhSDQ@mail.gmail.com> <20180803134357.GB28982@soda.linbit>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 6 Aug 2018 10:27:22 -0700
X-Google-Sender-Auth: ztssAbo9FI-S1nbP1rJn8R1pXC8
Message-ID: <CAGXu5j+i5UoPRd64hzNa6E1juzOHvL_ta5COn+vtUnWMjkV0=A@mail.gmail.com>
Subject: Re: [PATCH v6 12/18] drbd: Convert from ahash to shash
To:     Kees Cook <keescook@chromium.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@kernel.dk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        drbd-dev@lists.linbit.com,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 6:44 AM, Lars Ellenberg
<lars.ellenberg@linbit.com> wrote:
> On Thu, Aug 02, 2018 at 04:43:19PM -0700, Kees Cook wrote:
>> On Tue, Jul 24, 2018 at 9:49 AM, Kees Cook <keescook@chromium.org> wrote:
>> > In preparing to remove all stack VLA usage from the kernel[1], this
>> > removes the discouraged use of AHASH_REQUEST_ON_STACK in favor of
>> > the smaller SHASH_DESC_ON_STACK by converting from ahash-wrapped-shash
>> > to direct shash. By removing a layer of indirection this both improves
>> > performance and reduces stack usage. The stack allocation will be made
>> > a fixed size in a later patch to the crypto subsystem.
>>
>> Philipp or Lars, what do you think of this? Can this go via your tree
>> or maybe via Jens?
>>
>> I'd love an Ack or Review.
>
> I'm sorry, summer time and all, limited online time ;-)
>
> I'm happy for this to go in via Jens, or any other way.
>
> Being not that fluent in the crypto stuff,
> I will just "believe" most of it.
>
> I still think I found something, comments below:
>
>> > diff --git a/drivers/block/drbd/drbd_worker.c b/drivers/block/drbd/drbd_worker.c
>> > index 1476cb3439f4..62dd3700dd84 100644
>> > --- a/drivers/block/drbd/drbd_worker.c
>> > +++ b/drivers/block/drbd/drbd_worker.c
>> > @@ -295,60 +295,54 @@ void drbd_request_endio(struct bio *bio)
>> >                 complete_master_bio(device, &m);
>> >  }
>> >
>> > -void drbd_csum_ee(struct crypto_ahash *tfm, struct drbd_peer_request *peer_req, void *digest)
>> > +void drbd_csum_ee(struct crypto_shash *tfm, struct drbd_peer_request *peer_req, void *digest)
>> >  {
>> > -       AHASH_REQUEST_ON_STACK(req, tfm);
>> > -       struct scatterlist sg;
>> > +       SHASH_DESC_ON_STACK(desc, tfm);
>> >         struct page *page = peer_req->pages;
>> >         struct page *tmp;
>> >         unsigned len;
>> >
>> > -       ahash_request_set_tfm(req, tfm);
>> > -       ahash_request_set_callback(req, 0, NULL, NULL);
>> > +       desc->tfm = tfm;
>> > +       desc->flags = 0;
>> >
>> > -       sg_init_table(&sg, 1);
>> > -       crypto_ahash_init(req);
>> > +       crypto_shash_init(desc);
>> >
>> >         while ((tmp = page_chain_next(page))) {
>> >                 /* all but the last page will be fully used */
>> > -               sg_set_page(&sg, page, PAGE_SIZE, 0);
>> > -               ahash_request_set_crypt(req, &sg, NULL, sg.length);
>> > -               crypto_ahash_update(req);
>> > +               crypto_shash_update(desc, page_to_virt(page), PAGE_SIZE);
>
> These pages may be "highmem", so page_to_virt() seem not appropriate.
> I think the crypto_ahash_update() thingy did an implicit kmap() for us
> in the crypto_hash_walk()?
> Maybe it is good enough to add a kmap() here,
> and a kunmap() on the next line?

Oooh, excellent point. Thanks, I'll see what I can do to sort this out.

-Kees

-- 
Kees Cook
Pixel Security
