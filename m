Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58985C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BDEC222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbfBPIgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:36:51 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:42195
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730942AbfBPIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:36:51 -0500
X-IronPort-AV: E=Sophos;i="5.58,376,1544482800"; 
   d="scan'208";a="296376495"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 09:36:49 +0100
Date:   Sat, 16 Feb 2019 09:36:48 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     Markus.Elfring@web.de, julia.lawall@lip6.fr, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, michal.lkml@markovi.net,
        wang.yi59@zte.com.cn, yamada.masahiro@socionext.com,
        yellowriver2010@hotmail.com, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [v5] coccinelle: semantic code search for missingput_device()
In-Reply-To: <201902161633004137519@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1902160934400.3212@hadrien>
References: 201902161504357846572@zte.com.cn,10281c5d-8b32-0a02-17ae-20bf86f8dc65@web.de <201902161633004137519@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1482400413-1550306209=:3212"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1482400413-1550306209=:3212
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 16 Feb 2019, wen.yang99@zte.com.cn wrote:

> > > Thanks, We will change it to something like this:
> > > In a function, for a local variable obtained by of_find_device_by_node()
> >
> > How do you think about another wording approach?
> >
> > 1. Precondition:
> > It will be checked where the return value is stored from
> > a call of the function “of_find_device_by_node”.
> >
> > 2. The source code search will be continued with …
>
> Thanks.
> This is more rigorous, we will follow your advice
>
> > > Thank you, but a local variable is necessary.
> >
> > Would you like to take additional storage possibilities for a safer
> > analysis approach into account?
> >
> > Is the restriction “local” really sufficient when such a pointer
> > could be copied to other variables?
>
> We may be able to handle this situation:
> +id = of_find_device_by_node@p1(x)
> ...
> +    when != e1 = (T)id
> +    when != e1 = &id->dev
> +    when != e1 = get_device(&id->dev)

This looks good.  To be double sure, you can put (T)(&id->dev) in the
second case.

When you have a chance please send the revised version.  As long as I
don't see that it is giving many false positives, I will accept it.  We
don't need perfection.  We need more to eliminate the memory leaks.

julia

>
> > > But it's over 80 characters.
> >
> > Long string literals can be accepted because of error message search concerns
> > around a tool like “grep”.
>
> Thanks.
> We will follow your advice
>
> >> Will any more advanced error diagnostics be eventually developed?
> > >
> > > Hello, we are just doing the practical work in this field.
> >
> > Are you aware of additional software design options from computer science
> > and existing analysis tools?
>
> We also use the commercial software klockwork, which will also find errors in the code,
> but a lot of false positives.
>
> Regards,
> Wen
--8323329-1482400413-1550306209=:3212--
