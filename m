Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DFEC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 527FA20859
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547060144;
	bh=Yo4XgfEdJP7yigPzKMv3so1TeUvCm1R9gTMLfMAJzG4=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=KZKENGPuFZP+u3LUD91Az62aQn3fWqUEpADrcXaL3UXKe7joQk7R8QK/6D0YXNfJW
	 bhANmijaVL/BAFvOx3pm2qKi8ew1uhHHwunFn7sh+KBbQhmrkkll1YxEKbE5gkRPJZ
	 jDCHdAayvU/q+hyV7LL4HpRh2Y6ddgwZOtFQkYfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbfAISzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:55:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbfAISzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:55:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 741B420859;
        Wed,  9 Jan 2019 18:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547060142;
        bh=Yo4XgfEdJP7yigPzKMv3so1TeUvCm1R9gTMLfMAJzG4=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=qFIsCcza/UQCpyjORcdqC1xQAPtAZ6EadRTALa0hSSvqxnJwfwTViEzYGsA3wd53t
         /B592wqIH3WFHf47oDr5OLOkY4CDib3MdctbyacjUizBu8Ryj2y1BWpEKjUoRwyd5o
         LHyr1sEQ6rWTisPCCnVkd8jem4DK9YZPuBV5ZkUo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: Fix a missing check on regmap_bulk_read
Cc:     kjlu@umn.edu, Marek Vasut <marek.vasut@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     pakki001@umn.edu
In-Reply-To: <20181224190032.23167-1-pakki001@umn.edu>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181224190032.23167-1-pakki001@umn.edu>
Message-ID: <154706014175.15366.2565561612277733965@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 10:55:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aditya Pakki (2018-12-24 11:00:32)
> Currently, vc5_pll_recalc_rate() may produce incorrect output when
> regmap_bulk_read() fails. The fix checks the return value of the
> latter function and returns 0 in case of failure.
>=20
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/clk/clk-versaclock5.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index decffb3826ec..cd76a893c594 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -413,7 +413,8 @@ static unsigned long vc5_pll_recalc_rate(struct clk_h=
w *hw,
>         u32 div_int, div_frc;
>         u8 fb[5];
> =20
> -       regmap_bulk_read(vc5->regmap, VC5_FEEDBACK_INT_DIV, fb, 5);
> +       if (regmap_bulk_read(vc5->regmap, VC5_FEEDBACK_INT_DIV, fb, 5))
> +               return 0;

There are a bunch of other regmap_*() APIs in here that "could fail".
Why has this one been chosen but the other ones not?

