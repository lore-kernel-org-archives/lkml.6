Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39966C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEF22089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 16:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOOkqBLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAEF22089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbeG0SA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:00:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730205AbeG0SA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:00:28 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE45B2089B;
        Fri, 27 Jul 2018 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532709468;
        bh=tAvZRyxzXAURJ2Yay1vs0wJO/rOmGCB9AmY6IZCPbXI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=cOOkqBLJEhSyzMela7QW05wLSb35lu7v81ugWTIOhVn2jyl0HR6eWJWO9eKu37jl+
         NrRa0t0m59o5x2mkTxIVDr3RrBs2lFsZxUA8dBNktF2q5V/Kde6kp3wZlb4E2I3q7T
         NSIAvJds3t/DyL6VHsly72QhPLOLZNWpb4S8iBdw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1532700112-11852-1-git-send-email-amit.kachhap@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>
References: <1532700112-11852-1-git-send-email-amit.kachhap@arm.com>
Message-ID: <153270946725.48062.11195853363758024681@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: scmi: Fix the rounding of clock rate
Date:   Fri, 27 Jul 2018 09:37:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Daniel Kachhap (2018-07-27 07:01:52)
> This fix rounds the clock rate properly by using quotient and not
> remainder in the calculation. This issue was found while testing HDMI
> in the Juno platform.
> =

> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@arm.com>

Any Fixes: tag here?

> ---
>  drivers/clk/clk-scmi.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
> index bb2a6f2..a985bf5 100644
> --- a/drivers/clk/clk-scmi.c
> +++ b/drivers/clk/clk-scmi.c
> @@ -60,9 +59,9 @@ static long scmi_clk_round_rate(struct clk_hw *hw, unsi=
gned long rate,
>  =

>         ftmp =3D rate - fmin;
>         ftmp +=3D clk->info->range.step_size - 1; /* to round up */
> -       step =3D do_div(ftmp, clk->info->range.step_size);
> +       do_div(ftmp, clk->info->range.step_size);
>  =

> -       return step * clk->info->range.step_size + fmin;
> +       return ftmp * clk->info->range.step_size + fmin;

Good catch.

