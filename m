Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DBE7C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46B1E216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ieee.org header.i=@ieee.org header.b="faTswss9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46B1E216FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ieee.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbeI1DCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 23:02:06 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55127 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727436AbeI1DCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 23:02:06 -0400
Received: by mail-it1-f196.google.com with SMTP id f14-v6so172098ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 13:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSb6lgbkEKRFaGdmBWqMU23xZBo4EVXhsGFHPgqXa7w=;
        b=faTswss9v3nkOZdHJx69Nru0N57Ra6IL40Ozxkjhrg0KUBRDuK4GNHYnWF/tUYWQw8
         Boh6Hwk7MCuQ/tW7R3rQw+sHRKntC9JmHWiFioSVYyoaf5SEkCJYnMVyO+8D4KXGJo8F
         +fGjWRDGNMuiqw6lqDX5x9a+Ni14308diT8yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSb6lgbkEKRFaGdmBWqMU23xZBo4EVXhsGFHPgqXa7w=;
        b=plGLnARnD3U8Uah8oEJTxEeCxKAKAwcyFtlyiYW8fTObVVSFkehvHvC9WdlIkE3BNa
         iZeJVLGf/rSO70rzV6AcDrtyxMRclkac4dQChOlJT+XLR8bLo1Swgp/fiRnhEc1im6AH
         Pk3tgOeAihVPRBUINdaIjIjjQs8jwnncES+ayPh7osTm10B/cjHV3zGanrtGRXsSJzfE
         2MP1Zm73dBdqInK86h+MOmBhbDqtQ3KpLi3KdlfEUnFQCHtjn8Y5Hgbiwz88I/P8mp6T
         WliHBYhYflVKvRga6ws1mk0acch7qKl2MhusZibIRKnGHcPDAEwavOn3ELTEHXgzoatY
         wPKw==
X-Gm-Message-State: ABuFfohNv0caIJHyJHu7CdcKIV58HlRuvXpgvmT/ITbrku6xaMcQlyKh
        vt/N+L58VoctfvSDncTfnhIMCRNrBtLr8Tdzg0UiRg==
X-Google-Smtp-Source: ACcGV61vbdBABHXl3/nbvN958bX3wlKgDNxC6FrXEKNKUpuE5TEPNIGSEQfe7x8BljakllDbHtq5xtNYRmBzI1DZJxw=
X-Received: by 2002:a24:6e87:: with SMTP id w129-v6mr228244itc.49.1538080918370;
 Thu, 27 Sep 2018 13:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <1538079759.qxp8zh3nwh.astroid@alex-archsus.none>
In-Reply-To: <1538079759.qxp8zh3nwh.astroid@alex-archsus.none>
From:   Dan Streetman <ddstreet@ieee.org>
Date:   Thu, 27 Sep 2018 16:41:21 -0400
Message-ID: <CALZtONA9r6=gnK-5a++tjaReqEnRzrBb3hzYMTFNXZ13z+UOWQ@mail.gmail.com>
Subject: Re: [PATCH] mm: fix z3fold warnings on CONFIG_SMP=n
To:     alex_y_xu@yahoo.ca
Cc:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 4:27 PM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> Spinlocks are always lockable on UP systems, even if they were just
> locked.

i think it would be much better to just use either
assert_spin_locked() or just spin_is_locked(), instead of an #ifdef.

>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> ---
>  mm/z3fold.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index 4b366d181..4e6ad2de4 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -202,6 +202,13 @@ static inline void z3fold_page_lock(struct z3fold_header *zhdr)
>         spin_lock(&zhdr->page_lock);
>  }
>
> +static inline void z3fold_page_ensure_locked(struct z3fold_header *zhdr)
> +{
> +#ifdef CONFIG_SMP
> +       WARN_ON(z3fold_page_trylock(zhdr));
> +#endif
> +}
> +
>  /* Try to lock a z3fold page */
>  static inline int z3fold_page_trylock(struct z3fold_header *zhdr)
>  {
> @@ -277,7 +284,7 @@ static void release_z3fold_page_locked(struct kref *ref)
>  {
>         struct z3fold_header *zhdr = container_of(ref, struct z3fold_header,
>                                                 refcount);
> -       WARN_ON(z3fold_page_trylock(zhdr));
> +       z3fold_page_ensure_locked(zhdr);
>         __release_z3fold_page(zhdr, true);
>  }
>
> @@ -289,7 +296,7 @@ static void release_z3fold_page_locked_list(struct kref *ref)
>         list_del_init(&zhdr->buddy);
>         spin_unlock(&zhdr->pool->lock);
>
> -       WARN_ON(z3fold_page_trylock(zhdr));
> +       z3fold_page_ensure_locked(zhdr);
>         __release_z3fold_page(zhdr, true);
>  }
>
> @@ -403,7 +410,7 @@ static void do_compact_page(struct z3fold_header *zhdr, bool locked)
>
>         page = virt_to_page(zhdr);
>         if (locked)
> -               WARN_ON(z3fold_page_trylock(zhdr));
> +               z3fold_page_ensure_locked(zhdr);
>         else
>                 z3fold_page_lock(zhdr);
>         if (WARN_ON(!test_and_clear_bit(NEEDS_COMPACTING, &page->private))) {
> --
> 2.19.0
>
