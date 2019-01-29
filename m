Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A553EC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0A62082F
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 21:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548798931;
	bh=vrxCJaOOpOwcogcgyECS3v0aknQ9iQrGQguScjUaK1M=;
	h=Subject:References:Cc:From:In-Reply-To:To:Date:List-ID:From;
	b=u+m1d/pqiq/Y7LFKIyBFCBl5rWuwY/iD/yBJxsmEPquULwe1Sc4NxlgMpmDHh4db3
	 sEK1Hk0Ll6IsbM0Txn2YPgT86McIdii5k1rvMUZwwl5RdqMfbgTMvAwVxN+TVf06zR
	 a8hO6q/tl2k+kCeTYnoxlcOkR3XCu4joHSgG9JuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbfA2Vz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 16:55:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:58000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbfA2Vz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 16:55:29 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F66D2082F;
        Tue, 29 Jan 2019 21:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548798928;
        bh=vrxCJaOOpOwcogcgyECS3v0aknQ9iQrGQguScjUaK1M=;
        h=Subject:References:Cc:From:In-Reply-To:To:Date:From;
        b=U9UxA0cyUrMxiTYxpM3wnnFBmKrfWWxFDHwv/B3kUtMTwSm0zNfd1QcP56IT+Oj9f
         xI3WbrqQOMvOqqDu5iVfsV6GWAgT5DC3rsliyyqgBmQ0RuhknDkh5tnU3eO/Fhw2vI
         t1Kw9jsxJWpxw7811NP5A6jM2tLFkDnmsitOtbBc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: fractional-divider: check parent rate only for general approximation
References: <20190107132124.27788-1-katsuhiro@katsuster.net>
User-Agent: alot/0.8
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190107132124.27788-1-katsuhiro@katsuster.net>
Message-ID: <154879892760.136743.9274469856102314518@swboyd.mtv.corp.google.com>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Date:   Tue, 29 Jan 2019 13:55:27 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Katsuhiro Suzuki (2019-01-07 05:21:24)
> Custom approximation of fractional-divider may not need parent clock
> rate checking. For example Rockchip SoCs work fine using grand parent
> clock rate evne if target rate is greater than parent.
>=20
> This patch removes parent clock rate check from custom approximation.
>=20
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  drivers/clk/clk-fractional-divider.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/clk-fractional-divider.c b/drivers/clk/clk-fract=
ional-divider.c
> index 545dceec0bbf..b0fc5509e0ff 100644
> --- a/drivers/clk/clk-fractional-divider.c
> +++ b/drivers/clk/clk-fractional-divider.c
> @@ -79,13 +79,17 @@ static long clk_fd_round_rate(struct clk_hw *hw, unsi=
gned long rate,
>         unsigned long m, n;
>         u64 ret;
> =20
> -       if (!rate || rate >=3D *parent_rate)
> +       if (!rate)

Is your fraction multiplying the rate up? If it's a divider it shouldn't
be increasing the rate more than whatever the parent is supplying so
this looks odd. How does the grandparent matter here? Maybe you can show
the example in the commit text so we can all understand what's going on
here.

>                 return *parent_rate;
> =20
