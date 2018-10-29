Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8356BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FFB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJBtKs9G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FFB20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJ3CNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbeJ3CNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:13:20 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0532C20657;
        Mon, 29 Oct 2018 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540833828;
        bh=w1YnWt+AnwXv/iS2szCUWKOpLQDHkLKhFgwvClfS/eA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=MJBtKs9GnpyaQ0ZEieMECWGU9IX3goI8lnsgPjeQrGhQwWcbRJJ/6lzfYAP3biVAe
         w5HB88qL6AbOwRLQZLb/47qCAp/9Y1Qe0ULzZ9F/X8leUWeHzUUrI2nwhsoDJUaEV1
         Z+Bi4QsHJu3p4CrLmpwW+8i+0Nak4O8aiBgeuQfI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yi Wang <wang.yi59@zte.com.cn>, paul.burton@mips.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1540801907-31544-1-git-send-email-wang.yi59@zte.com.cn>
Cc:     mturquette@baylibre.com, linux-mips@linux-mips.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhong.weidong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>
References: <1540801907-31544-1-git-send-email-wang.yi59@zte.com.cn>
Message-ID: <154083382731.98144.10932242759017894372@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: boston: fix possible memory leak in clk_boston_setup()
Date:   Mon, 29 Oct 2018 10:23:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yi Wang (2018-10-29 01:31:47)
> 'onecell' is malloced in clk_boston_setup(), but is not freed
> before leaving from the error handling cases.

How did you find this? Visual inspection? Some coccinelle script?

> =

> Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
> ---
> v2: fix syntax issue in comment, thanks to  Sergei.
> =

>  drivers/clk/imgtec/clk-boston.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-bos=
ton.c
> index 15af423..f5d54a6 100644
> --- a/drivers/clk/imgtec/clk-boston.c
> +++ b/drivers/clk/imgtec/clk-boston.c
> @@ -73,27 +73,32 @@ static void __init clk_boston_setup(struct device_nod=
e *np)
>         hw =3D clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq=
);
>         if (IS_ERR(hw)) {
>                 pr_err("failed to register input clock: %ld\n", PTR_ERR(h=
w));
> -               return;
> +               goto error;
>         }
>         onecell->hws[BOSTON_CLK_INPUT] =3D hw;
>  =

>         hw =3D clk_hw_register_fixed_rate(NULL, "sys", "input", 0, sys_fr=
eq);
>         if (IS_ERR(hw)) {
>                 pr_err("failed to register sys clock: %ld\n", PTR_ERR(hw)=
);
> -               return;
> +               goto error;
>         }
>         onecell->hws[BOSTON_CLK_SYS] =3D hw;
>  =

>         hw =3D clk_hw_register_fixed_rate(NULL, "cpu", "input", 0, cpu_fr=
eq);
>         if (IS_ERR(hw)) {
>                 pr_err("failed to register cpu clock: %ld\n", PTR_ERR(hw)=
);
> -               return;
> +               goto error;
>         }
>         onecell->hws[BOSTON_CLK_CPU] =3D hw;
>  =

>         err =3D of_clk_add_hw_provider(np, of_clk_hw_onecell_get, onecell=
);
>         if (err)
>                 pr_err("failed to add DT provider: %d\n", err);
> +
> +       return;
> +
> +error:
> +       kfree(onecell);

Ok, sure. But then clks are still left registered on failure?

