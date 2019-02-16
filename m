Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FEEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37E420842
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 08:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfBPIJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 03:09:18 -0500
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:38917
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727724AbfBPIJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 03:09:18 -0500
X-IronPort-AV: E=Sophos;i="5.58,375,1544482800"; 
   d="scan'208";a="296375171"
Received: from abo-58-107-68.mrs.modulonet.fr (HELO hadrien) ([85.68.107.58])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2019 09:09:15 +0100
Date:   Sat, 16 Feb 2019 09:09:14 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     wen.yang99@zte.com.cn
cc:     Markus.Elfring@web.de, Gilles Muller <Gilles.Muller@lip6.fr>,
        nicolas.palix@imag.fr, michal.lkml@markovi.net,
        wang.yi59@zte.com.cn, yamada.masahiro@socionext.com,
        yellowriver2010@hotmail.com, cheng.shengyu@zte.com.cn,
        cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [v5] Coccinelle: semantic code search for missing put_device()
In-Reply-To: <201902161529041506841@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1902160908150.3212@hadrien>
References: 1550217319-40418-1-git-send-email-wen.yang99@zte.com.cn,b2f195e8-c3a3-f876-a075-317bb33496c6@web.de <201902161529041506841@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-938833334-1550304555=:3212"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-938833334-1550304555=:3212
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sat, 16 Feb 2019, wen.yang99@zte.com.cn wrote:

> >>> Does the first SmPL when specification include the case that a call
> >>> of the function “put_device” can occur within a branch of an if statement?
> >>
> >> It does include that,
> >
> >Thanks for this acknowledgement.
> >
> >So it seems that you find my interpretation of this bit of SmPL code appropriate.
> >
> >> but there is another execution path where the put device is not present.
> >
> >It is tried to find such cases.
> >
> >> But given the test in the if in the when code,
> >> on that execution path id is NULL, an so there is no need to put it.
> >
> >I would like to point out that the function “put_device” belongs also to
> >the category of functions which tolerate the passing of null pointers.
> >https://elixir.bootlin.com/linux/v5.0-rc6/source/drivers/base/core.c#L2053
> >https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/core.c?id=cb5b020a8d38f77209d0472a0fea755299a8ec78#n2053
> >
> >Have we got still different software development opinions about the need
> >for an extra pointer check in the “second” SmPL when specification?
>
> Thanks to Julia and Markus.
> We will modify the the if in the when code like this:
>
> @@ -22,7 +22,7 @@ if (id == NULL || ...) { ... return ...; }
>  ... when != put_device(&id->dev)
>      when != platform_device_put(id)
>      when != of_dev_put(id)
> -    when != if (id) { ... put_device(&id->dev) ... }
> +    when != if (...) { ... put_device(&id->dev) ... }

This looks ok.  You can check the old version and the new version and see
if there is any differencein the set of reports.

julia
--8323329-938833334-1550304555=:3212--
