Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbeE3MyH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 08:54:07 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:45204 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751591AbeE3MyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 08:54:02 -0400
X-Google-Smtp-Source: ADUXVKKcOxFqzJ6Na/S+hjXyXvXjc4QR/mBznnjeTtpqa8qSFYNO1QWpVV3SsUpZSXhLnVBCvE0Nj36hB0S2KzJhJNA=
MIME-Version: 1.0
In-Reply-To: <20180530103936.17812-1-liwang@redhat.com>
References: <20180530103936.17812-1-liwang@redhat.com>
From: Dan Streetman <ddstreet@ieee.org>
Date: Wed, 30 May 2018 08:53:21 -0400
X-Google-Sender-Auth: 5pysO-SE7ZSR_a-AOgYAMSJCRrs
Message-ID: <CALZtONBKSVfXe+RHOjgS=4VrDqFsxNRx3OuGctp0o1Hrtix3Ew@mail.gmail.com>
Subject: Re: [PATCH v2] zswap: re-check zswap_is_full after do zswap_shrink
To: Li Wang <liwang@redhat.com>
Cc: Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Huang Ying <huang.ying.caritas@gmail.com>, Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 6:39 AM, Li Wang <liwang@redhat.com> wrote:
> The '/sys/../zswap/stored_pages:' keep raising in zswap test with
> "zswap.max_pool_percent=0" parameter. But theoretically, it should
> not compress or store pages any more since there is no space in
> compressed pool.
>
> Reproduce steps:
>   1. Boot kernel with "zswap.enabled=1"
>   2. Set the max_pool_percent to 0
>       # echo 0 > /sys/module/zswap/parameters/max_pool_percent
>   3. Do memory stress test to see if some pages have been compressed
>       # stress --vm 1 --vm-bytes $mem_available"M" --timeout 60s
>   4. Watching the 'stored_pages' number increasing or not
>
> The root cause is:
>   When zswap_max_pool_percent is setting to 0 via kernel parameter, the
>   zswap_is_full() will always return true to do zswap_shrink(). But if
>   the shinking is able to reclain a page successful, then proceeds to
>   compress/store another page, so the value of stored_pages will keep
>   changing.
>
> To solve the issue, this patch adds zswap_is_full() check again after
> zswap_shrink() to make sure it's now under the max_pool_percent, and
> not to compress/store if reach its limitaion.
>
> Signed-off-by: Li Wang <liwang@redhat.com>

Acked-by: Dan Streetman <ddstreet@ieee.org>

> Cc: Seth Jennings <sjenning@redhat.com>
> Cc: Dan Streetman <ddstreet@ieee.org>
> Cc: Huang Ying <huang.ying.caritas@gmail.com>
> Cc: Yu Zhao <yuzhao@google.com>
> ---
>  mm/zswap.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 61a5c41..fd320c3 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1026,6 +1026,15 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
>                         ret = -ENOMEM;
>                         goto reject;
>                 }
> +
> +               /* A second zswap_is_full() check after
> +                * zswap_shrink() to make sure it's now
> +                * under the max_pool_percent
> +                */
> +               if (zswap_is_full()) {
> +                       ret = -ENOMEM;
> +                       goto reject;
> +               }
>         }
>
>         /* allocate entry */
> --
> 2.9.5
>
