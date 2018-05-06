Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751337AbeEFJkE (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 05:40:04 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40781 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750967AbeEFJkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 05:40:03 -0400
X-Google-Smtp-Source: AB8JxZonMF+yR6TZW+ircLCndq7l+D3z3Nueefi9hAZ7aIQ/N1dwspfSnSSWga16Lo3b2BGlVcqi5XDaXSzP/fqUe2M=
MIME-Version: 1.0
References: <1525329378-1864-1-git-send-email-ks77sj@gmail.com>
In-Reply-To: <1525329378-1864-1-git-send-email-ks77sj@gmail.com>
From: Vitaly Wool <vitalywool@gmail.com>
Date: Sun, 06 May 2018 09:39:51 +0000
Message-ID: <CAMJBoFNdk3fRMmcBe46TFgk9=Q1T6eJEubZ86oASicLvEzj3ng@mail.gmail.com>
Subject: Re: [PATCH v2] z3fold: fix reclaim lock-ups
To: ks77sj@gmail.com
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jongseok,

Den tors 3 maj 2018 kl 08:36 skrev Jongseok Kim <ks77sj@gmail.com>:

> In the processing of headless pages, there was a problem that the
> zhdr pointed to another page or a page was alread released in
> z3fold_free(). So, the wrong page is encoded in headless, or test_bit
> does not work properly in z3fold_reclaim_page(). This patch fixed these
> problems.

> Signed-off-by: Jongseok Kim <ks77sj@gmail.com>
> ---
>   mm/z3fold.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)

> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index d5b3f49..a36ffa5ab 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -819,6 +819,7 @@ static void z3fold_free(struct z3fold_pool *pool,
unsigned long handle)
>   static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int
retries)
>   {
>          int i, ret = 0;
> +       bool is_headless;
>          struct z3fold_header *zhdr = NULL;
>          struct page *page = NULL;
>          struct list_head *pos;
> @@ -836,11 +837,11 @@ static int z3fold_reclaim_page(struct z3fold_pool
*pool, unsigned int retries)
>                  }
>                  list_for_each_prev(pos, &pool->lru) {
>                          page = list_entry(pos, struct page, lru);
> +                       zhdr = page_address(page);
>                          if (test_bit(PAGE_HEADLESS, &page->private))
>                                  /* candidate found */
>                                  break;

> -                       zhdr = page_address(page);
>                          if (!z3fold_page_trylock(zhdr))
>                                  continue; /* can't evict at this point */
>                          kref_get(&zhdr->refcount);


I don't see how that is relevant, we don't use zhdr variable if the page is
headless anyway.

> @@ -873,9 +874,11 @@ static int z3fold_reclaim_page(struct z3fold_pool
*pool, unsigned int retries)
>                           * reference to this page
>                           */
>                          z3fold_page_unlock(zhdr);
> +                       is_headless = false;
>                  } else {
>                          first_handle = encode_handle(zhdr, HEADLESS);
>                          last_handle = middle_handle = 0;
> +                       is_headless = true;
>                  }

>                  /* Issue the eviction callback(s) */
> @@ -895,11 +898,10 @@ static int z3fold_reclaim_page(struct z3fold_pool
*pool, unsigned int retries)
>                                  goto next;
>                  }
>   next:
> -               if (test_bit(PAGE_HEADLESS, &page->private)) {
> -                       if (ret == 0) {
> -                               free_z3fold_page(page);
> +               if (is_headless) {
> +                       if (ret == 0)
>                                  return 0;
> -                       }
> +

Thanks, that is indeed a valid fix, but given the operation of eviction in
zswap case, I'd prefer to release the page here and not in _free().
Basically we should bail very early from z3fold_free() if the page is
headless and UNDER_RECLAIM and keep the code intact in
z3fold_reclaim_page().

~Vitaly
