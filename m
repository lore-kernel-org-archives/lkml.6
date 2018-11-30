Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E65C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739B920989
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 00:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XoVgSvqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739B920989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeK3Lc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 06:32:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbeK3Lc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 06:32:28 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B1620834;
        Fri, 30 Nov 2018 00:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543537506;
        bh=Hf149D386J3Z1OvS6vXza4u+QF3kWg9Vsnd1ZNSFyjk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=XoVgSvqXDtxQXA3tDNR2G8vXGGJjYlBG74Ug/RsGAjRKHgS4Fwh3t1ooPeIrM+TMB
         jPKOu2Oe8JvFzKQmulPOuub2V4KmfizK5vUZgHy6LDZfeSefTp9zoLP/OfG6kpn6wz
         Ls21fKNZCKv7hi40UlmvjvjZfi2Cktr2TLObu9Mo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        letux-kernel@openphoenux.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, paul@pwsan.com, t-kristo@ti.com,
        tony@atomide.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181110203115.13335-3-andreas@kemnade.info>
Cc:     Andreas Kemnade <andreas@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
 <20181110203115.13335-3-andreas@kemnade.info>
Message-ID: <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date:   Thu, 29 Nov 2018 16:25:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andreas Kemnade (2018-11-10 12:31:14)
> Code might use autoidle api with clocks not being omap2 clocks,
> so check if clock type is not basic
> =

> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> New in v2
> ---
>  drivers/clk/ti/autoidle.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
> index 161f67850393..5bdae5552d38 100644
> --- a/drivers/clk/ti/autoidle.c
> +++ b/drivers/clk/ti/autoidle.c
> @@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
>  int omap2_clk_deny_idle(struct clk *clk)
>  {
>         struct clk_hw_omap *c;
> +       struct clk_hw *hw =3D __clk_get_hw(clk);
>  =

> -       c =3D to_clk_hw_omap(__clk_get_hw(clk));
> +       if (clk_hw_get_flags(hw) & CLK_IS_BASIC)

Please try to avoid using CLK_IS_BASIC if at all possible. Can you?
Maybe add some flag in clk_hw_omap() instead?

