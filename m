Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeBAJku (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:40:50 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:50943
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751520AbeBAJkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:40:45 -0500
X-IronPort-AV: E=Sophos;i="5.46,443,1511823600";
   d="scan'208";a="253233217"
Date: Thu, 1 Feb 2018 10:40:40 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: SF Markus Elfring <elfring@users.sourceforge.net>
cc: cocci@systeme.lip6.fr, Gilles Muller <Gilles.Muller@lip6.fr>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: zalloc-simple: Delete function "kmem_cache_alloc"
 from SmPL rules
In-Reply-To: <6bee0e11-59ef-b7b1-886e-7abaa30887f2@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1802011040110.3135@hadrien>
References: <CAK7LNAR27r4j4c1FCh_ObpMpBKXgSP6Vq3P=reA-JKoTji6Q1A@mail.gmail.com> <6bee0e11-59ef-b7b1-886e-7abaa30887f2@users.sourceforge.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Feb 2018, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 1 Feb 2018 10:20:47 +0100
>
> The deletion for a call of the function "memset" depends on
> the specification that a size determination is passed by
> the expression "E1".
> The function "kmem_cache_alloc" was specified despite of the technical
> detail that this function does not get a parameter passed which would
> correspond to such a size information.
>
> Thus remove it from the first two SmPL rules and omit the rule "r4".

Nack.  It should be supported by the size determined in another way.

julia

> Link: https://elixir.free-electrons.com/linux/v4.15/source/tools/testing/radix-tree/linux/slab.h#L14
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/tools/testing/radix-tree/linux/slab.h?id=f26e52e08ab8e56f528ac14aa7929b3477de5616#n14
> Fixes: 5e2d9da5b9ba350a4f13bd3b255be046bcf86465 ("Coccinelle: kzalloc-simple: Add all zero allocating functions")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 41 +-----------------------
>  1 file changed, 1 insertion(+), 40 deletions(-)
>
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index 92b20913055f..3bee6cdd99ea 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -34,7 +34,7 @@ statement S;
>  @@
>
>  * x = (T)\(kmalloc(E1, ...)\|vmalloc(E1)\|dma_alloc_coherent(...,E1,...)\|
> -  kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|kmem_alloc(E1, ...)\|
> +  kmalloc_node(E1, ...)\|kmem_alloc(E1, ...)\|
>    devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|pci_alloc_consistent(...,E1,...)\|
>    kvmalloc_node(E1,...)\);
>    if ((x==NULL) || ...) S
> @@ -88,15 +88,6 @@ statement S;
>  - x = (T)kmalloc_node(E1,E2,E3);
>  + x = (T)kzalloc_node(E1,E2,E3);
>  |
> -- x = kmem_cache_alloc(E3,E4);
> -+ x = kmem_cache_zalloc(E3,E4);
> -|
> -- x = (T *)kmem_cache_alloc(E3,E4);
> -+ x = kmem_cache_zalloc(E3,E4);
> -|
> -- x = (T)kmem_cache_alloc(E3,E4);
> -+ x = (T)kmem_cache_zalloc(E3,E4);
> -|
>  - x = kmem_alloc(E1,E2);
>  + x = kmem_zalloc(E1,E2);
>  |
> @@ -268,36 +259,6 @@ x << r3.x;
>  msg="WARNING: kzalloc_node should be used for %s, instead of kmalloc_node/memset" % (x)
>  coccilib.report.print_report(p[0], msg)
>
> -//-----------------------------------------------------------------
> -@r4 depends on org || report@
> -type T, T2;
> -expression x;
> -expression E1,E2,E3;
> -statement S;
> -position p;
> -@@
> -
> - x = (T)kmem_cache_alloc@p(E2,E3);
> - if ((x==NULL) || ...) S
> - memset((T2)x,0,E1);
> -
> -@script:python depends on org@
> -p << r4.p;
> -x << r4.x;
> -@@
> -
> -msg="%s" % (x)
> -msg_safe=msg.replace("[","@(").replace("]",")")
> -coccilib.org.print_todo(p[0], msg_safe)
> -
> -@script:python depends on report@
> -p << r4.p;
> -x << r4.x;
> -@@
> -
> -msg="WARNING: kmem_cache_zalloc should be used for %s, instead of kmem_cache_alloc/memset" % (x)
> -coccilib.report.print_report(p[0], msg)
> -
>  //-----------------------------------------------------------------
>  @r5 depends on org || report@
>  type T, T2;
> --
> 2.16.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
