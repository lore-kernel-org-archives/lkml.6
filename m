Return-Path: <sumit.semwal@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518014062; cv=none;
        d=google.com; s=arc-20160816;
        b=Wh4tgD2RztE9lKkCo1T5PonYmkFrcGMlZiLVb23k5DVJ9uNyGdh9d1eTJGb89zdasd
         B9a76qO9hlkaZBu7unP8/yUY7dRrS4xR1mRTO/l1K7yxZ/UUsONiMFK6vlBSUSUQSr51
         +xaNAsGBPYFjMvYzK7+/vJh5mIcT2K/XsAX4ToAxV8TM2e+2EnItRozO1qirZ0CBV91k
         oLKdzac2ROo0W4dyI9foambJkmEBisxsaeWeJwa5bYUqbLS4ZLg87Eg6SRfdVB4Ml+wS
         V14EHKjl9jcdK//TVnUvtaI5Mxa3DT8THDdPv7k57qgw3GLXKB6/YQ7ojVL9kxIl1JfG
         eGrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=6gVPzm7Sw3G6sQJ+IpsXdWVG/JbNuCYMgzPrcW2pdnU=;
        b=0Qudb9gM+s1k75k1wxsyo9p55x7RNIh3S8pGLrOCnJSXrtTvAZpZW2RCNjndiiQu8c
         hnzXOI9jNO/biCiC6OEMcO227d3SSGQFyIqzadLzm3fxQN/Y2govtdfvHrAVYkOoTtJU
         ga+0rtXLV4scdkqKyTdykoe3J7P5guPlOmS1yxqoYQCBSEq7gPyGIoKD9sKIIjfSiPEK
         jmwrWemk47OBAxggNNd7/BYhk85X6jrvhNbIFm9N2vTNOZNlZ1DeXLFThiLPOvDOG5LN
         ak2cqQVcf5CtLXpcIXKgJrDHoyQf2NsSCvkKFV+Y9wafW/IFYSwpfyqomN25MEy+3c6B
         7xFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EtlgAFcL;
       spf=pass (google.com: domain of sumit.semwal@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=sumit.semwal@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EtlgAFcL;
       spf=pass (google.com: domain of sumit.semwal@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=sumit.semwal@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x224O11ybAmKmM/8YQSSOK9s3fvNrkmkJvvWpF/5GbpDui6v3vIAgzjpxzMvmFMapp/g7kVwWvzDJqergPDBSEkE=
MIME-Version: 1.0
In-Reply-To: <1517975986-46917-2-git-send-email-xieyisheng1@huawei.com>
References: <1517975986-46917-1-git-send-email-xieyisheng1@huawei.com> <1517975986-46917-2-git-send-email-xieyisheng1@huawei.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Wed, 7 Feb 2018 20:04:00 +0530
Message-ID: <CAO_48GFXWWN7NwT8=YWSLwj98c-Fh+KH-9qG8v5pnO6goqmtXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] staging: android: ion: Combine cache and uncache pools
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laura Abbott <labbott@redhat.com>,
	devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591713777808858467?=
X-GMAIL-MSGID: =?utf-8?q?1591753113054642703?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Yisheng,

On 7 February 2018 at 09:29, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> Now we call dma_map in the dma_buf API callbacks and handle explicit
> caching by the dma_buf sync API, which make cache and uncache pools
> in the same handling flow, which can be combined.
>
Thanks for the patch! Perhaps you should also put the version history
here, to capture the changes from previous versions?

> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
With that done, please feel free to add
Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

> ---
>  drivers/staging/android/ion/ion.c             |  5 --
>  drivers/staging/android/ion/ion.h             | 13 +----
>  drivers/staging/android/ion/ion_page_pool.c   |  5 +-
>  drivers/staging/android/ion/ion_system_heap.c | 76 +++++----------------=
------
>  4 files changed, 16 insertions(+), 83 deletions(-)
>
> diff --git a/drivers/staging/android/ion/ion.c b/drivers/staging/android/=
ion/ion.c
> index 461b193..c094be2 100644
> --- a/drivers/staging/android/ion/ion.c
> +++ b/drivers/staging/android/ion/ion.c
> @@ -33,11 +33,6 @@
>  static struct ion_device *internal_dev;
>  static int heap_id;
>
> -bool ion_buffer_cached(struct ion_buffer *buffer)
> -{
> -       return !!(buffer->flags & ION_FLAG_CACHED);
> -}
> -
>  /* this function should only be called while dev->lock is held */
>  static void ion_buffer_add(struct ion_device *dev,
>                            struct ion_buffer *buffer)
> diff --git a/drivers/staging/android/ion/ion.h b/drivers/staging/android/=
ion/ion.h
> index 1bc443f..ea08978 100644
> --- a/drivers/staging/android/ion/ion.h
> +++ b/drivers/staging/android/ion/ion.h
> @@ -185,14 +185,6 @@ struct ion_heap {
>  };
>
>  /**
> - * ion_buffer_cached - this ion buffer is cached
> - * @buffer:            buffer
> - *
> - * indicates whether this ion buffer is cached
> - */
> -bool ion_buffer_cached(struct ion_buffer *buffer);
> -
> -/**
>   * ion_device_add_heap - adds a heap to the ion device
>   * @heap:              the heap to add
>   */
> @@ -302,7 +294,6 @@ size_t ion_heap_freelist_shrink(struct ion_heap *heap=
,
>   * @gfp_mask:          gfp_mask to use from alloc
>   * @order:             order of pages in the pool
>   * @list:              plist node for list of pools
> - * @cached:            it's cached pool or not
>   *
>   * Allows you to keep a pool of pre allocated pages to use from your hea=
p.
>   * Keeping a pool of pages that is ready for dma, ie any cached mapping =
have
> @@ -312,7 +303,6 @@ size_t ion_heap_freelist_shrink(struct ion_heap *heap=
,
>  struct ion_page_pool {
>         int high_count;
>         int low_count;
> -       bool cached;
>         struct list_head high_items;
>         struct list_head low_items;
>         struct mutex mutex;
> @@ -321,8 +311,7 @@ struct ion_page_pool {
>         struct plist_node list;
>  };
>
> -struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int =
order,
> -                                          bool cached);
> +struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int =
order);
>  void ion_page_pool_destroy(struct ion_page_pool *pool);
>  struct page *ion_page_pool_alloc(struct ion_page_pool *pool);
>  void ion_page_pool_free(struct ion_page_pool *pool, struct page *page);
> diff --git a/drivers/staging/android/ion/ion_page_pool.c b/drivers/stagin=
g/android/ion/ion_page_pool.c
> index 6d2caf0..db8f614 100644
> --- a/drivers/staging/android/ion/ion_page_pool.c
> +++ b/drivers/staging/android/ion/ion_page_pool.c
> @@ -123,8 +123,7 @@ int ion_page_pool_shrink(struct ion_page_pool *pool, =
gfp_t gfp_mask,
>         return freed;
>  }
>
> -struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int =
order,
> -                                          bool cached)
> +struct ion_page_pool *ion_page_pool_create(gfp_t gfp_mask, unsigned int =
order)
>  {
>         struct ion_page_pool *pool =3D kmalloc(sizeof(*pool), GFP_KERNEL)=
;
>
> @@ -138,8 +137,6 @@ struct ion_page_pool *ion_page_pool_create(gfp_t gfp_=
mask, unsigned int order,
>         pool->order =3D order;
>         mutex_init(&pool->mutex);
>         plist_node_init(&pool->list, order);
> -       if (cached)
> -               pool->cached =3D true;
>
>         return pool;
>  }
> diff --git a/drivers/staging/android/ion/ion_system_heap.c b/drivers/stag=
ing/android/ion/ion_system_heap.c
> index bc19cdd..701eb9f 100644
> --- a/drivers/staging/android/ion/ion_system_heap.c
> +++ b/drivers/staging/android/ion/ion_system_heap.c
> @@ -41,31 +41,16 @@ static inline unsigned int order_to_size(int order)
>
>  struct ion_system_heap {
>         struct ion_heap heap;
> -       struct ion_page_pool *uncached_pools[NUM_ORDERS];
> -       struct ion_page_pool *cached_pools[NUM_ORDERS];
> +       struct ion_page_pool *pools[NUM_ORDERS];
>  };
>
> -/**
> - * The page from page-pool are all zeroed before. We need do cache
> - * clean for cached buffer. The uncached buffer are always non-cached
> - * since it's allocated. So no need for non-cached pages.
> - */
>  static struct page *alloc_buffer_page(struct ion_system_heap *heap,
>                                       struct ion_buffer *buffer,
>                                       unsigned long order)
>  {
> -       bool cached =3D ion_buffer_cached(buffer);
> -       struct ion_page_pool *pool;
> -       struct page *page;
> +       struct ion_page_pool *pool =3D heap->pools[order_to_index(order)]=
;
>
> -       if (!cached)
> -               pool =3D heap->uncached_pools[order_to_index(order)];
> -       else
> -               pool =3D heap->cached_pools[order_to_index(order)];
> -
> -       page =3D ion_page_pool_alloc(pool);
> -
> -       return page;
> +       return ion_page_pool_alloc(pool);
>  }
>
>  static void free_buffer_page(struct ion_system_heap *heap,
> @@ -73,7 +58,6 @@ static void free_buffer_page(struct ion_system_heap *he=
ap,
>  {
>         struct ion_page_pool *pool;
>         unsigned int order =3D compound_order(page);
> -       bool cached =3D ion_buffer_cached(buffer);
>
>         /* go to system */
>         if (buffer->private_flags & ION_PRIV_FLAG_SHRINKER_FREE) {
> @@ -81,10 +65,7 @@ static void free_buffer_page(struct ion_system_heap *h=
eap,
>                 return;
>         }
>
> -       if (!cached)
> -               pool =3D heap->uncached_pools[order_to_index(order)];
> -       else
> -               pool =3D heap->cached_pools[order_to_index(order)];
> +       pool =3D heap->pools[order_to_index(order)];
>
>         ion_page_pool_free(pool, page);
>  }
> @@ -190,8 +171,7 @@ static void ion_system_heap_free(struct ion_buffer *b=
uffer)
>  static int ion_system_heap_shrink(struct ion_heap *heap, gfp_t gfp_mask,
>                                   int nr_to_scan)
>  {
> -       struct ion_page_pool *uncached_pool;
> -       struct ion_page_pool *cached_pool;
> +       struct ion_page_pool *pool;
>         struct ion_system_heap *sys_heap;
>         int nr_total =3D 0;
>         int i, nr_freed;
> @@ -203,26 +183,15 @@ static int ion_system_heap_shrink(struct ion_heap *=
heap, gfp_t gfp_mask,
>                 only_scan =3D 1;
>
>         for (i =3D 0; i < NUM_ORDERS; i++) {
> -               uncached_pool =3D sys_heap->uncached_pools[i];
> -               cached_pool =3D sys_heap->cached_pools[i];
> +               pool =3D sys_heap->pools[i];
>
>                 if (only_scan) {
> -                       nr_total +=3D ion_page_pool_shrink(uncached_pool,
> +                       nr_total +=3D ion_page_pool_shrink(pool,
>                                                          gfp_mask,
>                                                          nr_to_scan);
>
> -                       nr_total +=3D ion_page_pool_shrink(cached_pool,
> -                                                        gfp_mask,
> -                                                        nr_to_scan);
>                 } else {
> -                       nr_freed =3D ion_page_pool_shrink(uncached_pool,
> -                                                       gfp_mask,
> -                                                       nr_to_scan);
> -                       nr_to_scan -=3D nr_freed;
> -                       nr_total +=3D nr_freed;
> -                       if (nr_to_scan <=3D 0)
> -                               break;
> -                       nr_freed =3D ion_page_pool_shrink(cached_pool,
> +                       nr_freed =3D ion_page_pool_shrink(pool,
>                                                         gfp_mask,
>                                                         nr_to_scan);
>                         nr_to_scan -=3D nr_freed;
> @@ -253,26 +222,16 @@ static int ion_system_heap_debug_show(struct ion_he=
ap *heap, struct seq_file *s,
>         struct ion_page_pool *pool;
>
>         for (i =3D 0; i < NUM_ORDERS; i++) {
> -               pool =3D sys_heap->uncached_pools[i];
> +               pool =3D sys_heap->pools[i];
>
> -               seq_printf(s, "%d order %u highmem pages uncached %lu tot=
al\n",
> +               seq_printf(s, "%d order %u highmem pages %lu total\n",
>                            pool->high_count, pool->order,
>                            (PAGE_SIZE << pool->order) * pool->high_count)=
;
> -               seq_printf(s, "%d order %u lowmem pages uncached %lu tota=
l\n",
> +               seq_printf(s, "%d order %u lowmem pages %lu total\n",
>                            pool->low_count, pool->order,
>                            (PAGE_SIZE << pool->order) * pool->low_count);
>         }
>
> -       for (i =3D 0; i < NUM_ORDERS; i++) {
> -               pool =3D sys_heap->cached_pools[i];
> -
> -               seq_printf(s, "%d order %u highmem pages cached %lu total=
\n",
> -                          pool->high_count, pool->order,
> -                          (PAGE_SIZE << pool->order) * pool->high_count)=
;
> -               seq_printf(s, "%d order %u lowmem pages cached %lu total\=
n",
> -                          pool->low_count, pool->order,
> -                          (PAGE_SIZE << pool->order) * pool->low_count);
> -       }
>         return 0;
>  }
>
> @@ -285,8 +244,7 @@ static void ion_system_heap_destroy_pools(struct ion_=
page_pool **pools)
>                         ion_page_pool_destroy(pools[i]);
>  }
>
> -static int ion_system_heap_create_pools(struct ion_page_pool **pools,
> -                                       bool cached)
> +static int ion_system_heap_create_pools(struct ion_page_pool **pools)
>  {
>         int i;
>         gfp_t gfp_flags =3D low_order_gfp_flags;
> @@ -297,7 +255,7 @@ static int ion_system_heap_create_pools(struct ion_pa=
ge_pool **pools,
>                 if (orders[i] > 4)
>                         gfp_flags =3D high_order_gfp_flags;
>
> -               pool =3D ion_page_pool_create(gfp_flags, orders[i], cache=
d);
> +               pool =3D ion_page_pool_create(gfp_flags, orders[i]);
>                 if (!pool)
>                         goto err_create_pool;
>                 pools[i] =3D pool;
> @@ -320,18 +278,12 @@ static struct ion_heap *__ion_system_heap_create(vo=
id)
>         heap->heap.type =3D ION_HEAP_TYPE_SYSTEM;
>         heap->heap.flags =3D ION_HEAP_FLAG_DEFER_FREE;
>
> -       if (ion_system_heap_create_pools(heap->uncached_pools, false))
> +       if (ion_system_heap_create_pools(heap->pools))
>                 goto free_heap;
>
> -       if (ion_system_heap_create_pools(heap->cached_pools, true))
> -               goto destroy_uncached_pools;
> -
>         heap->heap.debug_show =3D ion_system_heap_debug_show;
>         return &heap->heap;
>
> -destroy_uncached_pools:
> -       ion_system_heap_destroy_pools(heap->uncached_pools);
> -
>  free_heap:
>         kfree(heap);
>         return ERR_PTR(-ENOMEM);
> --
> 1.7.12.4
>



--=20
Thanks and regards,

Sumit Semwal
Linaro Mobile Group - Kernel Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
