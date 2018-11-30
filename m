Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C185C04EB9
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FEE2086B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 02:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="s/WE1obc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FEE2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeK3NZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 08:25:37 -0500
Received: from ozlabs.org ([203.11.71.1]:60951 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbeK3NZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 08:25:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 435dMm58x1z9s8F;
        Fri, 30 Nov 2018 13:17:54 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1543544277;
        bh=d+Pc9aSiDeImfL1r3TP6YSypZXsCuwnim+azgtoO2AI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s/WE1obccTBq1C9lm+2fg+ETXdT/YLiNRo8tOFBhhr/ovsAfFoAiFuexxzfHT01rv
         cFkbMgLrrcIbUSvWGeb5N8L1zL7MMx8TN3VBR0ehEgPpkhqIBorYs0WzptCSP0yUml
         pFWhpovhSSwUGzijbqNaogZ8bZqgoj2kO8mDnEf4fF/V9aI9b2+IYXTCxaZI+mFI9n
         Dv5rIEPkLGTEfKXKIls0BqxDHvwv9F38u2bhG35dMYL5ZYnYy1WijmfgsM84w14EKQ
         PF4J0BDGt1oDg3vnxrTH3Xa2j3MZxpwRwoUO0mp1hKJ8jM80ehZIORk5KyC+CjEa6n
         l1krvkNjuqyBQ==
Date:   Fri, 30 Nov 2018 13:17:53 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Abel Vesa <abelvesa@linux.com>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] clk: imx: Use do_div in SCCG due to 64-bit divisor
Message-ID: <20181130131753.7108e52a@canb.auug.org.au>
In-Reply-To: <1543535413-1256-1-git-send-email-abel.vesa@nxp.com>
References: <20181130090325.7526140e@canb.auug.org.au>
        <1543535413-1256-1-git-send-email-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/fQpTVA700y28kyP6Sg5Pi0i"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fQpTVA700y28kyP6Sg5Pi0i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Abel,

On Thu, 29 Nov 2018 23:50:22 +0000 Abel Vesa <abel.vesa@nxp.com> wrote:
>
> --- a/drivers/clk/imx/clk-frac-pll.c
> +++ b/drivers/clk/imx/clk-frac-pll.c
> @@ -116,12 +116,13 @@ static long clk_pll_round_rate(struct clk_hw *hw, u=
nsigned long rate,
>  			       unsigned long *prate)
>  {
>  	u64 parent_rate =3D *prate;
> -	u32 divff, divfi;
> -	u64 temp64;
> +	u64 divff, divfi;
> +	u64 temp64 =3D rate;
> =20
>  	parent_rate *=3D 8;
>  	rate *=3D 2;
> -	divfi =3D rate / parent_rate;
> +	do_div(temp64, parent_rate);
> +	divfi =3D temp64;

Did you mean to lose the doubling of "rate" above?

--=20
Cheers,
Stephen Rothwell

--Sig_/fQpTVA700y28kyP6Sg5Pi0i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlwAndEACgkQAVBC80lX
0GwdLwf/avcEogeT2n0B9lp0v6bXI1hgabzRbQefXRPAuq7Nk5dV7LOWWdYPARR4
jN3V5m6qEqwoXLoi29W1nJ/J1bZzlydOkRtGyMAFpZ4w+a3eQdglj+mUs89yyNpA
Lan9T7MShXbp5hQJFKZwjIkpX52iJx4NJHbJfk0lDIdcuqi6zuH06OQI5DLbSmB5
DSE3ZQ7cAZJG/Y7dMNzlC6TQKRFn6CIb7ywQyCNeGmIyWNiVQmnFuBOhfTGfZPJs
XDetsQ/YbfE6a/GZDvyrmcq1MouLckW+P7FIEruOaEVQxgpprRPPhK7+uJrnV8Gi
0ofE8EWJff3lGvUnt5+V4uFE+1C8nw==
=rBNp
-----END PGP SIGNATURE-----

--Sig_/fQpTVA700y28kyP6Sg5Pi0i--
