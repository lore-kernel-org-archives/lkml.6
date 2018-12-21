Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53589C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E78F21773
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 20:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545424498;
	bh=vwPzy//5Zq8kHAFJXX1ENCRdop7FngE2euBI1e5qEUg=;
	h=Subject:Cc:To:From:In-Reply-To:References:Date:List-ID:From;
	b=ZsvLKZJOXfb9kCXqtwJwYTaXC50EXlU0bnZiKCXcWREUXEwpppTeAKvBt7p84CaFt
	 L2ufWPLJP3SAV+PG4Eme1qtWD4puIipieJb9fRtW0FiMq29SWUxFoTTOKyKlZKIRJZ
	 HWmkeSiBdG+ow6aNOnaBFu307qLWucPg0fcE6mEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390333AbeLUUe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 15:34:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732146AbeLUUe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 15:34:56 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D33D621773;
        Fri, 21 Dec 2018 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545424495;
        bh=vwPzy//5Zq8kHAFJXX1ENCRdop7FngE2euBI1e5qEUg=;
        h=Subject:Cc:To:From:In-Reply-To:References:Date:From;
        b=qxAbeRlcdqBkyIea3IXs7gOpFZ7kAwj8Vp+W8jRlKG12i+iGHUHhpeJudTIXTaa3v
         igAuXQ7m0vYyRDMKUo/9Nhvx7Bh1fNRdbeBII28dSJZuXTv/gmIgP/VO8f+Q9e6ZFT
         Bf7MLO6WJy5cIYwzFI+4p/7/2Z5sj123XS8+4DBg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: Remove global clk traversal on fetch parent index
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>
To:     Derek Basehore <dbasehore@chromium.org>, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181221003100.157581-1-dbasehore@chromium.org>
User-Agent: alot/0.8
References: <20181221003100.157581-1-dbasehore@chromium.org>
Message-ID: <154542449501.13075.1518070014652024380@swboyd.mtv.corp.google.com>
Date:   Fri, 21 Dec 2018 12:34:55 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Derek Basehore (2018-12-20 16:31:00)
> It's not required to traverse the entire clk tree when the parents
> array contains a NULL value. You already have the parent clk_core
> pointer, so you can just compare the parent->name and parent_names[i]
> pointers.

Ok.

>=20
> In cases where clk names are never registered, this can be
> a substantial power improvement since a mux having an unregistered
> parent name will traverse the clk tree on every set_rate. This can
> happen hundreds of times a second on CPU clks.
>=20
> Change-Id: I85499d2e576249568ff508e424ca8d5009e6e2b1

This should go away.

> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/clk/clk.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index af011974d4ec..57a95c713286 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1516,9 +1516,18 @@ static int clk_fetch_parent_index(struct clk_core =
*core,
>         if (!parent)
>                 return -EINVAL;
> =20
> -       for (i =3D 0; i < core->num_parents; i++)
> -               if (clk_core_get_parent_by_index(core, i) =3D=3D parent)
> +       for (i =3D 0; i < core->num_parents; i++) {
> +               if (core->parents[i] =3D=3D parent)
> +                       return i;
> +
> +               if (core->parents[i])
> +                       continue;
> +
> +               if (!strcmp(parent->name, core->parent_names[i])) {
> +                       core->parents[i] =3D parent;
>                         return i;
> +               }
> +       }
> =20

Wow, this looks really familiar. In fact, take a look at commit
da0f0b2c3ad2 ("clk: Correct lookup logic in clk_fetch_parent_index()")
and you'll see that it's almost the same code. The main difference is
that this patch's clk_fetch_parent_index() doesn't call __clk_lookup()
to get a pointer to the clk it already has. And then in commit
470b5e2f97cf ("clk: simplify clk_fetch_parent_index() function") we
consolidated all the logic to simplify things, but it seems that we
became confused that the result of !strcmp(parent, names[i]) is actually
only true when the strings are equal. That was an invalid
transformation. Ouch. But this is a good find!

So this patch is reverting commit 470b5e2f97cf and then optimizing it to
never call __clk_lookup() because it's useless. I'll need to add a
comment and expand on the commit text here so that it's more obvious
what's going on. Otherwise someone will come by and try to consolidate
again and we'll do this all over again.

