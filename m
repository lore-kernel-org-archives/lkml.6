Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39B2C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C79C250F3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C79C250F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeGBRvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:51:03 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:51392 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752728AbeGBRvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:51:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 41AAE60A359C;
        Mon,  2 Jul 2018 19:51:00 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xKekcrY-1zSi; Mon,  2 Jul 2018 19:50:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C751260B5C39;
        Mon,  2 Jul 2018 19:50:59 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iTIfY036XU0R; Mon,  2 Jul 2018 19:50:59 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A21ED60B3040;
        Mon,  2 Jul 2018 19:50:59 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux mtd <linux-mtd@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] Revert "UBIFS: Fix potential integer overflow in allocation"
Date:   Mon, 02 Jul 2018 19:50:58 +0200
Message-ID: <2073665.T6vW7v0NJO@blindfold>
In-Reply-To: <CAGXu5jJyeoKdqo86+tWoq1n34sELSAXQu8LSBpEbiu2oFg2JPQ@mail.gmail.com>
References: <20180701212051.29486-1-richard@nod.at> <CAGXu5jJyeoKdqo86+tWoq1n34sELSAXQu8LSBpEbiu2oFg2JPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 2. Juli 2018, 18:00:05 CEST schrieb Kees Cook:
> On Sun, Jul 1, 2018 at 2:20 PM, Richard Weinberger <richard@nod.at> wrote:
> > This reverts commit 353748a359f1821ee934afc579cf04572406b420.
> > It bypassed the linux-mtd review process and fixes the issue not as it
> > should.
> 
> Ah, sorry, I thought you were CCed on the original report.

No big deal. I was just "surprised".
 
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Silvio Cesare <silvio.cesare@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> >  fs/ubifs/journal.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
> > index 07b4956e0425..da8afdfccaa6 100644
> > --- a/fs/ubifs/journal.c
> > +++ b/fs/ubifs/journal.c
> > @@ -1282,11 +1282,10 @@ static int truncate_data_node(const struct ubifs_info *c, const struct inode *in
> >                               int *new_len)
> >  {
> >         void *buf;
> > -       int err, compr_type;
> > -       u32 dlen, out_len, old_dlen;
> > +       int err, dlen, compr_type, out_len, old_dlen;
> 
> What's wrong with making these unsigned?

Well, what is the benefit?
In ubifs a data node carries at most 4k of bytes.
WORST_COMPR_FACTOR is 2.
So the computed lengths are always in a range where a natural int does work just fine.

> >
> >         out_len = le32_to_cpu(dn->size);
> > -       buf = kmalloc_array(out_len, WORST_COMPR_FACTOR, GFP_NOFS);
> > +       buf = kmalloc(out_len * WORST_COMPR_FACTOR, GFP_NOFS);
> >         if (!buf)
> >                 return -ENOMEM;
> 
> Please leave the kmalloc() -> kmalloc_array() change, as that has
> happened treewide already. We don't want to have any multiplications
> in the size argument for the allocators (i.e. they should use 2-factor
> arg version like here, or use array_size() for things like vmalloc()).

Let's queue another patch for the next merge window which converts
kmalloc() -> kmalloc_array().

Thanks,
//richard
