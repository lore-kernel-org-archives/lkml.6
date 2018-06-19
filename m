Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A8EC1B0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE1D20652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 21:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="vfG6zq4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE1D20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=zx2c4.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967270AbeFSVyN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 17:54:13 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:34287 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935912AbeFSVyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 17:54:10 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 645aac03;
        Tue, 19 Jun 2018 21:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=eBHSgleS+pHQhgu3S2eYih1yzfo=; b=vfG6zq
        4Mmyi0Sco7Lbn09eE8ksF2IplierVCReEF3VRad53LkRTxRgg5tdWzhLE94ncF7t
        PjiCWTp81ej70LKadRuH8Jdt/I2//7wQSDM/fULFWgp4IRArAmaj10cG0Dfe0vai
        ZoTlObLVwBE6XnrY9wUW86y1AKtPGWAi3aExQrXFq3nY3KQ4JyKBxsUeLPLM7/LH
        M4Q5ZV4TIfkWYIZwsmKDwGAn9Rn1sVILH/1EuXe9DeV8UQF0wXzElO2kDsb+nCGz
        t2h/As23P9sk/prm9sVxjOex+K1eKY8+ai6eS96W75sMuHJiZUNauNhpNz1q6dtX
        MUKu20W4omllxihQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 75854957 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Tue, 19 Jun 2018 21:48:14 +0000 (UTC)
Received: by mail-oi0-f41.google.com with SMTP id e8-v6so1185210oii.2;
        Tue, 19 Jun 2018 14:54:09 -0700 (PDT)
X-Gm-Message-State: APt69E1Z27uv3u328XrBCmUMT/N++qIelXMakEw0MOo15PBPua19+eXc
        8GD6+iv1Fx5EZxghMstkGy1ab6clMVcQMlvGnP8=
X-Google-Smtp-Source: ADUXVKKWnOBxWMT7BPeZpe5j9uOh3HazFFSP8HaCOoCNvc30Zr9pzOugQpSyOCeOGtON+/PERZYQDCdJAe2F+DgcDWU=
X-Received: by 2002:aca:3048:: with SMTP id w69-v6mr9634688oiw.29.1529445248526;
 Tue, 19 Jun 2018 14:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180619213352.71740-1-shakeelb@google.com>
In-Reply-To: <20180619213352.71740-1-shakeelb@google.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 19 Jun 2018 23:53:57 +0200
X-Gmail-Original-Message-ID: <CAHmME9pUoXod3pC4g+HLYUbCafj=1_53qHqu9ScB+NtJ2zpwqA@mail.gmail.com>
Message-ID: <CAHmME9pUoXod3pC4g+HLYUbCafj=1_53qHqu9ScB+NtJ2zpwqA@mail.gmail.com>
Subject: Re: [PATCH] slub: fix __kmem_cache_empty for !CONFIG_SLUB_DEBUG
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:34 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> For !CONFIG_SLUB_DEBUG, SLUB does not maintain the number of slabs
> allocated per node for a kmem_cache. Thus, slabs_node() in
> __kmem_cache_empty() will always return 0. So, in such situation, it is
> required to check per-cpu slabs to make sure if a kmem_cache is empty or
> not.
>
> Please note that __kmem_cache_shutdown() and __kmem_cache_shrink() are
> not affected by !CONFIG_SLUB_DEBUG as they call flush_all() to clear
> per-cpu slabs.
>
> Fixes: f9e13c0a5a33 ("slab, slub: skip unnecessary kasan_cache_shutdown()")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reported-by: Jason A . Donenfeld <Jason@zx2c4.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/slub.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index a3b8467c14af..731c02b371ae 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3673,9 +3673,23 @@ static void free_partial(struct kmem_cache *s, struct kmem_cache_node *n)
>
>  bool __kmem_cache_empty(struct kmem_cache *s)
>  {
> -       int node;
> +       int cpu, node;
>         struct kmem_cache_node *n;
>
> +       /*
> +        * slabs_node will always be 0 for !CONFIG_SLUB_DEBUG. So, manually
> +        * check slabs for all cpus.
> +        */
> +       if (!IS_ENABLED(CONFIG_SLUB_DEBUG)) {
> +               for_each_online_cpu(cpu) {
> +                       struct kmem_cache_cpu *c;
> +
> +                       c = per_cpu_ptr(s->cpu_slab, cpu);
> +                       if (c->page || slub_percpu_partial(c))
> +                               return false;
> +               }
> +       }
> +
>         for_each_kmem_cache_node(s, node, n)
>                 if (n->nr_partial || slabs_node(s, node))
>                         return false;
> --
> 2.18.0.rc1.244.gcf134e6275-goog
>

I can confirm that this fixes the test case on build.wireguard.com.
