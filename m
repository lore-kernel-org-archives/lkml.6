Return-Path: <sumit.semwal@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518014124; cv=none;
        d=google.com; s=arc-20160816;
        b=iOp/l6Asl2dDauC14YaIeImOavcy82gApw/6mOq1e34ve8sP2Rtw6GPIDtBz1WVLdl
         d4Gq5WS0OVVgEq9yxWrAt9u1AXzuHquqJvDArvpr9CpwPCcocDWyc3HDeRo43CFvfzIF
         fEUY8yyqOA2vR6LVUhE88kitNlu/iZTWdnE1ehQChvlyLeyFNAj8fzHMEsvVjRFGWdKP
         J01vtMW46a6sy6vinvH+Rzj+v7duWbAiHzTqK/eDaOhJBJxUZXO9a2FgPkyYUCGskWYg
         c+TKjWv7t2jmMOAatt678/p1qgnXNnLGLw++RZKnWCqPd/W2gGg+jLBpu5JXjTzCC5Va
         6NDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=JErCNVIV+BE/R0WrwsZiJEHjDq+bRmbLFXMucMHSn68=;
        b=k5/2keDI/JzrbeecaN12dQWe/4+wdgFDdy/VQRSe6aQqGkozBjk2fyHf/xmZWaqapr
         o50VkY6GXCxbOSdn/g9VkSzkdZfbA1Jtr5iVUgRId8/rF+T5qozt/quwZ6s0yIEOI/9x
         lJ4OzgeChpJQ7KZn9DHza1+DIlXbMtb3TmcGgapsF0TvOfkalqnhWlM3S0GVknUiRNpy
         UcjcRTlpv/FPzv6zdhwCoElplb3v2ILlnrsiJxuquwcHxHXuQdaAsmUYnNEQrLtoPIHG
         RYV5lnGcSIRvrUsugh5S47EESnyCxyh9CUvyKuFQRgZ4qpIo9eg7vqAFywLGuRoIf+uk
         ieWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=B6D7aVKO;
       spf=pass (google.com: domain of sumit.semwal@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=sumit.semwal@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=B6D7aVKO;
       spf=pass (google.com: domain of sumit.semwal@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=sumit.semwal@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x224YwQNS7HNeG5qWYxscL+lHmRcsUZkbmH4ZgLSatFLCLJMyof/Q3uNm3fSF5LYJktXnD9ruK5CSzcZo/eLZzrw=
MIME-Version: 1.0
In-Reply-To: <1517975986-46917-1-git-send-email-xieyisheng1@huawei.com>
References: <1517975986-46917-1-git-send-email-xieyisheng1@huawei.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Wed, 7 Feb 2018 20:05:03 +0530
Message-ID: <CAO_48GFoqYt1nkGdTstQ-wappnN6tkGqXCBcRViCu74Y4bWa2g@mail.gmail.com>
Subject: Re: [PATCH 1/2] staging: android: ion: Cleanup ion_page_pool_alloc_pages
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laura Abbott <labbott@redhat.com>,
	devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591713777245321780?=
X-GMAIL-MSGID: =?utf-8?q?1591753178255166586?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Yisheng,

On 7 February 2018 at 09:29, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> ion_page_pool_alloc_pages calls alloc_pages to allocate pages for page
> pools. If alloc_pages return NULL, it will return NULL, or it will
> return the pages allocate from alloc_pages. So we can just return
> alloc_pages without any judgement.
>
With patch history comment addressed (same as the other patch you sent),
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Please feel free to add my
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

> ---
>  drivers/staging/android/ion/ion_page_pool.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/staging/android/ion/ion_page_pool.c
> index e3a6e32..6d2caf0 100644
> --- a/drivers/staging/android/ion/ion_page_pool.c
> +++ b/drivers/staging/android/ion/ion_page_pool.c
> @@ -11,13 +11,9 @@
>
>  #include "ion.h"
>
> -static void *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
> +static inline struct page *ion_page_pool_alloc_pages(struct ion_page_pool *pool)
>  {
> -       struct page *page = alloc_pages(pool->gfp_mask, pool->order);
> -
> -       if (!page)
> -               return NULL;
> -       return page;
> +       return alloc_pages(pool->gfp_mask, pool->order);
>  }
>
>  static void ion_page_pool_free_pages(struct ion_page_pool *pool,
> --
> 1.7.12.4
>
Best,
Sumit.
