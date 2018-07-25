Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A7BC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B570C20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wTKCEkly"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B570C20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731381AbeGYVzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:55:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730337AbeGYVzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:55:00 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD0A20671;
        Wed, 25 Jul 2018 20:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532551299;
        bh=PBtccEFy57UmBYlVldEJvevLkSpfzE29ezyDIabhv4A=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=wTKCEklyqeeXEWOb1gRTCejL5+Agn/CKjcfL8OqMSz+qQ0Nrsk/hpMvgWNlyNPrkc
         0Hm04ooxK+1Q6SfLEAjemOfpkXYxq0+KFt/B9NBSqWaU9lArJI7tg6iGoL+o+JbWi4
         0RkjpvISf3s36sgNJAx9aLRWWXTAvpK1q6bd+DCo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Nicholas Mc Guire <hofrat@osadl.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531649904-6072-1-git-send-email-hofrat@osadl.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
References: <1531649904-6072-1-git-send-email-hofrat@osadl.org>
Message-ID: <153255129875.48062.4075642035553635128@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] drivers: clk: st: warn on iomap failure
Date:   Wed, 25 Jul 2018 13:41:38 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicholas Mc Guire (2018-07-15 03:18:23)
>  While the return value of clkgen_get_register_base() is being checked
> at the call site, there is no indication of failure cause thus making
> diagnosis of the issues hard. The WARN_ON() allows to determine the
> cause of failure.
> =

> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> ---
> =

> Problem found by an experimental coccinelle script
> =

> Patch was compile tested with: multi_v7_defconfig (implies
> CONFIG_ARCH_STI=3Dy)
> =

> Patch is against 4.18-rc4 (localversion-next is next-20180713)
> =

>  drivers/clk/st/clkgen-pll.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
> index cbb5184..aeb30ab 100644
> --- a/drivers/clk/st/clkgen-pll.c
> +++ b/drivers/clk/st/clkgen-pll.c
> @@ -647,6 +647,7 @@ static void __iomem * __init clkgen_get_register_base(
>                 return NULL;
>  =

>         reg =3D of_iomap(pnode, 0);
> +       WARN_ON(!reg);
>  =

>         of_node_put(pnode);
>         return reg;

Shouldn't the caller blow up on NULL pointer access? This patch doesn't
seem useful, sorry.

