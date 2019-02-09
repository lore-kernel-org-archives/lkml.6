Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EA1C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E38220844
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 19:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfBITK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 14:10:57 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:35593 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbfBITK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 14:10:57 -0500
X-IronPort-AV: E=Sophos;i="5.58,352,1544482800"; 
   d="scan'208";a="368707933"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2019 20:10:54 +0100
Date:   Sat, 9 Feb 2019 20:10:53 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Wen Yang <yellowriver2010@hotmail.com>
cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] coccinelle: semantic patch for missing put_device()
In-Reply-To: <HK0PR02MB3634D25073591A4AB6D41D32B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
Message-ID: <alpine.DEB.2.21.1902092007450.2512@hadrien>
References: <HK0PR02MB3634D25073591A4AB6D41D32B26A0@HK0PR02MB3634.apcprd02.prod.outlook.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Feb 2019, Wen Yang wrote:

> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> Use this semantic patch, we've found some object reference leaks,
> such as:
> 11907e9d3533 ("ASoC: fsl-asoc-card: fix object reference leaks in fsl_asoc_card_probe")
> a12085d13997 ("mtd: rawnand: atmel: fix possible object reference leak")
> 11493f26856a ("mtd: rawnand: jz4780: fix possible object reference leak")
> There are still dozens of reference leaks in the kernel code.
>
> Signed-off-by: Wen Yang <yellowriver2010@hotmail.com>
> ---
>  scripts/coccinelle/free/put_device.cocci | 54 ++++++++++++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 scripts/coccinelle/free/put_device.cocci
>
> diff --git a/scripts/coccinelle/free/put_device.cocci b/scripts/coccinelle/free/put_device.cocci
> new file mode 100644
> index 0000000..d3e3ba9
> --- /dev/null
> +++ b/scripts/coccinelle/free/put_device.cocci
> @@ -0,0 +1,54 @@
> +/// Find missing put_device for every of_find_device_by_node.
> +///
> +// Confidence: Moderate
> +// Copyright: (C) 2018-2019 Wen Yang, ZTE.  GPLv2.
> +// Comments:
> +// Options: --no-includes --include-headers
> +
> +virtual report
> +virtual org
> +
> +@search@

Just put exists after search, and then drop the when exists below.

> +local idexpression id;
> +expression x,e;
> +position p1,p2;
> +type T;
> +@@
> +
> +id = of_find_device_by_node@p1(x)
> +... when != e = id

This should not use the same e as in the when's below.  Make a new
matavariavle e1 and use that here.

> +if (id == NULL || ...) { ... return ...; }
> +... when != put_device(&id->dev)

I have the impression that you should also consider platform_device_put.

> +    when != of_dev_put(&id)
> +    when != if (id) { ... put_device(&id->dev) ... }
> +    when != e = (T)id
> +    when != e = &id->dev
> +    when != e = gen_pool_get(&id->dev, ...)
> +    when != e = platform_get_drvdata(id)
> +    when exists
> +(
> +return id;
> +|
> +return dev_get_drvdata(&id->dev);
> +|
> +return platform_get_drvdata(id)

Make a new type metavariable T1 amd use it to put a cast on the result of
platform_get_drvdata.  For dev_get_drvdata, I didn't actually find any
examples with a cast, but it wouldn't hurt to put a cast there too

Thanks,
julia

> +|
> +return@p2 ...;
> +)
> +
> +@script:python depends on report@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +msg = "ERROR: missing put_device; of_find_device_by_node on line %s and return without releasing on line %s" % (p1[0].line,p2[0].line)
> +coccilib.report.print_report(p2[0],msg)
> +
> +@script:python depends on org@
> +p1 << search.p1;
> +p2 << search.p2;
> +@@
> +
> +msg = "ERROR: missing put_device; of_find_device_by_node on line %s and return without releasing on line %s" % (p1[0].line,p2[0].line)
> +cocci.print_main(msg,p1)
> +cocci.print_secs("",p2)
> --
> 2.7.4
>
>
