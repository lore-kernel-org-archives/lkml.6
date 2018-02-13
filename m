Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965736AbeBMUOT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:14:19 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38353 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965611AbeBMUOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:14:17 -0500
X-Google-Smtp-Source: AH8x225OahDK0CCECwiiJLIbEO+b7J8Swuf9yW48vIPOw9aTkMdE5nqBcuBaUq4a9tgXq9/JQxi+6l03h/QzVzIW7ic=
MIME-Version: 1.0
In-Reply-To: <1518285964-31657-1-git-send-email-alexey.skidanov@intel.com>
References: <1518285964-31657-1-git-send-email-alexey.skidanov@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2018 22:14:16 +0200
Message-ID: <CAHp75VdzafHdDzpgnc74XZQOfUdgxuH6QwrtXw_YMvWEX0icUQ@mail.gmail.com>
Subject: Re: [PATCH] lib/scatterlist: Make sg_page_count() accessible to other modules
To: Alexey Skidanov <alexey.skidanov@intel.com>
Cc: chris@chris-wilson.co.uk,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 8:06 PM, Alexey Skidanov
<alexey.skidanov@intel.com> wrote:
> Currently, sg_page_count() may be used only inside the scatterlist.c file.
>
> However, the same calculation is done outside of scatterlist.c file
> causing to code duplication.
>
> To fix this, we move the sg_page_count() to the scatterlist.h file, making it
> accessible to other modules.

Can you provide an example of potential (or existing?) use case?

>
> Signed-off-by: Alexey Skidanov <alexey.skidanov@intel.com>
> ---
>  include/linux/scatterlist.h | 5 +++++
>  lib/scatterlist.c           | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
> index b7c8325..fe28148 100644
> --- a/include/linux/scatterlist.h
> +++ b/include/linux/scatterlist.h
> @@ -248,6 +248,11 @@ static inline void *sg_virt(struct scatterlist *sg)
>         return page_address(sg_page(sg)) + sg->offset;
>  }
>
> +static inline int sg_page_count(struct scatterlist *sg)
> +{
> +       return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
> +}
> +
>  int sg_nents(struct scatterlist *sg);
>  int sg_nents_for_len(struct scatterlist *sg, u64 len);
>  struct scatterlist *sg_next(struct scatterlist *);
> diff --git a/lib/scatterlist.c b/lib/scatterlist.c
> index 7c1c55f..4a59131 100644
> --- a/lib/scatterlist.c
> +++ b/lib/scatterlist.c
> @@ -486,11 +486,6 @@ void __sg_page_iter_start(struct sg_page_iter *piter,
>  }
>  EXPORT_SYMBOL(__sg_page_iter_start);
>
> -static int sg_page_count(struct scatterlist *sg)
> -{
> -       return PAGE_ALIGN(sg->offset + sg->length) >> PAGE_SHIFT;
> -}
> -
>  bool __sg_page_iter_next(struct sg_page_iter *piter)
>  {
>         if (!piter->__nents || !piter->sg)
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
