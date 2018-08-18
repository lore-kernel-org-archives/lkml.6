Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E2E9C04AB9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B76720645
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 12:24:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B76720645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbeHRP1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:27:20 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:55777 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbeHRP1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:27:20 -0400
X-IronPort-AV: E=Sophos;i="5.53,256,1531778400"; 
   d="scan'208";a="342917527"
Received: from abo-214-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.214])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Aug 2018 14:19:46 +0200
Date:   Sat, 18 Aug 2018 14:19:46 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     zhong jiang <zhongjiang@huawei.com>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>, nicolas.palix@imag.fr,
        michal.lkml@markovi.net, himanshujha199640@gmail.com,
        yamada.masahiro@socionext.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Coccinelle: remove pci_alloc_consistent semantic to
 dectect in zalloc-simple.cocci
In-Reply-To: <1534593700-3036-1-git-send-email-zhongjiang@huawei.com>
Message-ID: <alpine.DEB.2.21.1808181419230.2365@hadrien>
References: <1534593700-3036-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 18 Aug 2018, zhong jiang wrote:

> Because pci_alloc_consistent has been deprecated. We prefer to use
> dam_alloc_coherent directly. Therefore, we should remove pci_alloc_consistent
> to increase the confidence.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>

Thanks for the suggestion.

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  scripts/coccinelle/api/alloc/zalloc-simple.cocci | 41 +-----------------------
>  1 file changed, 1 insertion(+), 40 deletions(-)
>
> diff --git a/scripts/coccinelle/api/alloc/zalloc-simple.cocci b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> index 92b2091..d819275 100644
> --- a/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> +++ b/scripts/coccinelle/api/alloc/zalloc-simple.cocci
> @@ -35,8 +35,7 @@ statement S;
>
>  * x = (T)\(kmalloc(E1, ...)\|vmalloc(E1)\|dma_alloc_coherent(...,E1,...)\|
>    kmalloc_node(E1, ...)\|kmem_cache_alloc(...)\|kmem_alloc(E1, ...)\|
> -  devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|pci_alloc_consistent(...,E1,...)\|
> -  kvmalloc_node(E1,...)\);
> +  devm_kmalloc(...,E1,...)\|kvmalloc(E1, ...)\|kvmalloc_node(E1,...)\);
>    if ((x==NULL) || ...) S
>  * memset((T2)x,0,E1);
>
> @@ -124,15 +123,6 @@ statement S;
>  - x = (T)kvmalloc(E1,E2);
>  + x = (T)kvzalloc(E1,E2);
>  |
> -- x = pci_alloc_consistent(E2,E1,E3);
> -+ x = pci_zalloc_consistent(E2,E1,E3);
> -|
> -- x = (T *)pci_alloc_consistent(E2,E1,E3);
> -+ x = pci_zalloc_consistent(E2,E1,E3);
> -|
> -- x = (T)pci_alloc_consistent(E2,E1,E3);
> -+ x = (T)pci_zalloc_consistent(E2,E1,E3);
> -|
>  - x = kvmalloc_node(E1,E2,E3);
>  + x = kvzalloc_node(E1,E2,E3);
>  |
> @@ -389,35 +379,6 @@ msg="WARNING: kvzalloc should be used for %s, instead of kvmalloc/memset" % (x)
>  coccilib.report.print_report(p[0], msg)
>
>  //-----------------------------------------------------------------
> -@r8 depends on org || report@
> -type T, T2;
> -expression x;
> -expression E1,E2,E3;
> -statement S;
> -position p;
> -@@
> -
> - x = (T)pci_alloc_consistent@p(E2,E1,E3);
> - if ((x==NULL) || ...) S
> - memset((T2)x,0,E1);
> -
> -@script:python depends on org@
> -p << r8.p;
> -x << r8.x;
> -@@
> -
> -msg="%s" % (x)
> -msg_safe=msg.replace("[","@(").replace("]",")")
> -coccilib.org.print_todo(p[0], msg_safe)
> -
> -@script:python depends on report@
> -p << r8.p;
> -x << r8.x;
> -@@
> -
> -msg="WARNING: pci_zalloc_consistent should be used for %s, instead of pci_alloc_consistent/memset" % (x)
> -coccilib.report.print_report(p[0], msg)
> -//-----------------------------------------------------------------
>  @r9 depends on org || report@
>  type T, T2;
>  expression x;
> --
> 1.7.12.4
>
>
