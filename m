Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033425AbeCAR2z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 12:28:55 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:55944 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033238AbeCAR2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 12:28:53 -0500
X-Google-Smtp-Source: AG47ELu211xmXccWYsq+zi+BTnj30WVB2IG8VKsWMSRXoiPDCDErS8Vo0CA8e/8QTcMPjvuBA2G8XQbDB0WpUNEV928=
MIME-Version: 1.0
In-Reply-To: <286eaefc0a6c3fa9b83b87e7d6dc0fbb5b5c9926.1519924383.git.andreyknvl@google.com>
References: <cover.1519924383.git.andreyknvl@google.com> <286eaefc0a6c3fa9b83b87e7d6dc0fbb5b5c9926.1519924383.git.andreyknvl@google.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Thu, 1 Mar 2018 18:28:52 +0100
Message-ID: <CAAeHK+w86uMUrJjwV1Sei=N4udhfTmWab5e3FuT72=BEMcCu3A@mail.gmail.com>
Subject: Re: [PATCH 1/2] kasan: fix invalid-free test crashing the kernel
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Nick Terrell <terrelln@fb.com>, Chris Mason <clm@fb.com>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Jeff Layton <jlayton@redhat.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc: Kostya Serebryany <kcc@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 6:15 PM, Andrey Konovalov <andreyknvl@google.com> wrote:
> When an invalid-free is triggered by one of the KASAN tests, the object
> doesn't actually get freed. This later leads to a BUG failure in
> kmem_cache_destroy that checks that there are no allocated objects in the
> cache that is being destroyed. Fix this by calling kmem_cache_free with
> the proper object address after the call that triggers invalid-free.

Note, that for this patch to fix the issue, it is supposed to go on
top of the "kasan, slub: fix handling of kasan_slab_free hook" patch I
sent recently.

https://patchwork.kernel.org/patch/10238179/

>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/test_kasan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/lib/test_kasan.c b/lib/test_kasan.c
> index 98854a64b014..ec657105edbf 100644
> --- a/lib/test_kasan.c
> +++ b/lib/test_kasan.c
> @@ -567,7 +567,15 @@ static noinline void __init kmem_cache_invalid_free(void)
>                 return;
>         }
>
> +       /* Trigger invalid free, the object doesn't get freed */
>         kmem_cache_free(cache, p + 1);
> +
> +       /*
> +        * Properly free the object to prevent the "Objects remaining in
> +        * test_cache on __kmem_cache_shutdown" BUG failure.
> +        */
> +       kmem_cache_free(cache, p);
> +
>         kmem_cache_destroy(cache);
>  }
>
> --
> 2.16.2.395.g2e18187dfd-goog
>
