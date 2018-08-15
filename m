Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B561C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 664B0208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 17:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n7qMmncl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 664B0208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbeHOUHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 16:07:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58818 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbeHOUHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 16:07:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=N7jIi1aWuvXOGWrIYtpZlDQtVqYauNgTxMOYt7I4FpQ=; b=n7qMmnclXg6Q9FmZljtpmQ1zYm
        Jcfgx+NC7BUaqONNpkgiZbFDqfPgbHxmM5ZZsQAFTA3ay7lRSsnviGBKJl514atC4xgmU5UHvQ9XE
        hDykRR2dh1SnjiLMucmPrdKDpONtKPrMyN8SZsD6VuDkbWW9xIV0gRHnJDIOYe1AGoOs0MSJTIkgp
        JdUmgDkpxu0wtN0tnsDKo5jhknuGxH9pGWAvnqxi6vCQ5caYM4JAaMDXRhim1qyWSEmPghv88v31C
        6Zl8mYS4ZCD95M0MdknFS1kSl1Yj/aWgnyUEzr4aa2mgakVkARtI6zmOO7lN7cbiwKlKv7F5xvA5T
        3lkMeRqQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fpzNS-00047L-P3; Wed, 15 Aug 2018 17:14:35 +0000
Subject: Re: docs/core-api: add memory allocation guide
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-mm@kvack.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hi@d06av22.portsmouth.uk.ibm.com
References: <1534314887-9202-1-git-send-email-rppt@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <2f1c03e4-1c80-709d-f571-c7b17859fa59@infradead.org>
Date:   Wed, 15 Aug 2018 10:14:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534314887-9202-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2018 11:34 PM, Mike Rapoport wrote:
> As Vlastimil mentioned at [1], it would be nice to have some guide about
> memory allocation. I've drafted an initial version that tries to summarize
> "best practices" for allocation functions and GFP usage.
> 
> [1] https://www.spinics.net/lists/netfilter-devel/msg55542.html
> 
> From 8027c0d4b750b8dbd687234feda63305d0d5a057 Mon Sep 17 00:00:00 2001
> From: Mike Rapoport <rppt@linux.vnet.ibm.com>
> Date: Wed, 15 Aug 2018 09:10:06 +0300
> Subject: [RFC PATCH] docs/core-api: add memory allocation guide
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
>  Documentation/core-api/gfp_mask-from-fs-io.rst |   2 +
>  Documentation/core-api/index.rst               |   1 +
>  Documentation/core-api/memory-allocation.rst   | 117 +++++++++++++++++++++++++
>  Documentation/core-api/mm-api.rst              |   2 +
>  4 files changed, 122 insertions(+)
>  create mode 100644 Documentation/core-api/memory-allocation.rst
> 

Hi Mike,

I have some suggestions below.


> diff --git a/Documentation/core-api/memory-allocation.rst b/Documentation/core-api/memory-allocation.rst
> new file mode 100644
> index 0000000..b1f2ad5
> --- /dev/null
> +++ b/Documentation/core-api/memory-allocation.rst
> @@ -0,0 +1,117 @@
> +=======================
> +Memory Allocation Guide
> +=======================
> +
> +Linux supplies variety of APIs for memory allocation. You can allocate

         supplies a variety
or even
         provides a variety

> +small chunks using `kmalloc` or `kmem_cache_alloc` families, large
> +virtually contiguous areas using `vmalloc` and it's derivatives, or

                                                  its

> +you can directly request pages from the page allocator with
> +`__get_free_pages`. It is also possible to use more specialized
> +allocators, for instance `cma_alloc` or `zs_malloc`.
> +
> +Most of the memory allocations APIs use GFP flags to express how that

                      allocation APIs

> +memory should be allocated. The GFP acronym stands for "get free
> +pages", the underlying memory allocation function.
> +
> +Diversity of the allocation APIs combined with the numerous GFP flags
> +makes the question "How should I allocate memory?" not that easy to
> +answer, although very likely you should use
> +
> +::
> +
> +  kzalloc(<size>, GFP_KERNEL);
> +
> +Of course there are cases when other allocation APIs and different GFP
> +flags must be used.
> +
> +Get Free Page flags
> +===================
> +
> +The GFP flags control the allocators behavior. They tell what memory
> +zones can be used, how hard the allocator should try to find a free

                                                        to find free

> +memory, whether the memory can be accessed by the userspace etc. The
> +:ref:`Documentation/core-api/mm-api.rst <mm-api-gfp-flags>` provides
> +reference documentation for the GFP flags and their combinations and
> +here we briefly outline their recommended usage:
> +
> +  * Most of the times ``GFP_KERNEL`` is what you need. Memory for the

I would write:
       Most of the time

> +    kernel data structures, DMAable memory, inode cache, all these and
> +    many other allocations types can use ``GFP_KERNEL``. Note, that
> +    using ``GFP_KERNEL`` implies ``GFP_RECLAIM``, which means that
> +    direct reclaim may be triggered under memory pressure; the calling
> +    context must be allowed to sleep.
> +  * If the allocation is performed from an atomic context, e.g
> +    interrupt handler, use ``GFP_ATOMIC``.
> +  * Untrusted allocations triggered from userspace should be a subject
> +    of kmem accounting and must have ``__GFP_ACCOUNT`` bit set. There
> +    is handy ``GFP_KERNEL_ACCOUNT`` shortcut for ``GFP_KERNEL``

       is the handy

> +    allocations that should be accounted.
> +  * Userspace allocations should use either of the ``GFP_USER``,
> +    ``GFP_HIGHUSER`` and ``GFP_HIGHUSER_MOVABLE`` flags. The longer

                        or

> +    the flag name the less restrictive it is.
> +
> +    The ``GFP_HIGHUSER_MOVABLE`` does not require that allocated

s/The//

> +    memory will be directly accessible by the kernel or the hardware
> +    and implies that the data may move.
> +
> +    The ``GFP_HIGHUSER`` means that the allocated memory is not

s/The//

> +    movable, but it is not required to be directly accessible by the
> +    kernel or the hardware. An example may be a hardware allocation
> +    that maps data directly into userspace but has no addressing
> +    limitations.
> +
> +    The ``GFP_USER`` means that the allocated memory is not movable

s/The//

> +    and it must be directly accessible by the kernel or the
> +    hardware. It is typically used by hardware for buffers that are
> +    mapped to userspace (e.g. graphics) that hardware still must DMA
> +    to.
> +
> +You may notice that quite a few allocations in the existing code
> +specify ``GFP_NOIO`` and ``GFP_NOFS``. Historically, they were used to

                        or

> +prevent recursion deadlocks caused by direct memory reclaim calling
> +back into the FS or IO paths and blocking on already held
> +resources. Since 4.12 the preferred way to address this issue is to
> +use new scope APIs described in
> +:ref:`Documentation/core-api/gfp_mask-from-fs-io.rst <gfp_mask_from_fs_io>`.
> +
> +Another legacy GFP flags are ``GFP_DMA`` and ``GFP_DMA32``. They are

   Other

> +used to ensure that the allocated memory is accessible by hardware
> +with limited addressing capabilities. So unless you are writing a
> +driver for a device with such restrictions, avoid using these flags.
> +
> +Selecting memory allocator
> +==========================
> +
> +The most straightforward way to allocate memory is to use a function
> +from the `kmalloc` family. And, to be on the safe size it's best to
> +use routines that set memory to zero, like `kzalloc`. If you need to
> +allocate memory for an array, there are `kmalloc_array` and `kcalloc`
> +helpers.
> +
> +The maximal size of a chunk that can be allocated with `kmalloc` is
> +limited. The actual limit depends on the hardware and the kernel
> +configuration, but it is a good practice to use `kmalloc` for objects
> +smaller than page size.
> +
> +For large allocations you can use `vmalloc` and `vzalloc`, or directly
> +request pages from the page allocator. The memory allocated by
> +`vmalloc` and related functions is not physically contiguous.
> +
> +If you are not sure whether the allocation size is too large for
> +`kmalloc` it is possible to use `kvmalloc` and its derivatives. It

   `kmalloc`,

> +will try to allocate memory with `kmalloc` and if the allocation fails
> +it will be retried with `vmalloc`. There are restrictions on which GFP
> +flags can be used with `kvmalloc`, please see :c:func:`kvmalloc_node`

                                    ^ s/,/;/

> +reference documentation. Note, that `kvmalloc` may return memory that

                            Note that

> +is not physically contiguous.
> +
> +If you need to allocate many identical objects you can use slab cache

                                                      can use the slab cache

> +allocator. The cache should be set up with `kmem_cache_create` before
> +it can be used. Afterwards `kmem_cache_alloc` and its convenience
> +wrappers can allocate memory from that cache.
> +
> +When the allocated memory is no longer needed it must be freed. You
> +can use `kvfree` for the memory allocated with `kmalloc`, `vmalloc`
> +and `kvmalloc`. The slab caches should be freed with
> +`kmem_cache_free`. And don't forget to destroy the cache with
> +`kmem_cache_destroy`.

Thanks for the new documentation.

-- 
~Randy
