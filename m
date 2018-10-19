Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55818ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F0721486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i/PliEip"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F0721486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbeJTHPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:15:39 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42479 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbeJTHPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:15:39 -0400
Received: by mail-io1-f67.google.com with SMTP id n18-v6so23940767ioa.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V6NTIQparOMPx9sx9IqYeTGacmCxgEWqBM1eJiLj60c=;
        b=i/PliEip8BaRyJonZCHOuZ8EGqoXw7PP8wmv4tcNnOyQvMJF+xtW9y7QdvT/KSDN08
         kpvW6Vqu84oroqSQzdMdDGBaW3I98WOBLaiB4LeR8YzPf26jUpkG8T5oatnsf5o8c4zV
         j0tpujAkgnI2fpx1LFEDhpQczzYeP3wfC4tPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V6NTIQparOMPx9sx9IqYeTGacmCxgEWqBM1eJiLj60c=;
        b=ISEsxUnoB+zjBIxajKRnPClmBG3HBvHcOXwMg61weEtTA8S421Y5XHz3dWDSnXPyUy
         EBvRBqrSuQ0TH/6vyMWlU2LzgMEFk8OI/oOGcNUbJnTZS0URPW/QNWkidljtaMLmtnxe
         VuPi7fcPIIGgsieLeJe3O0WsxjyKi7ae92c/A0ckDU2dfGjVjJXHigh6VG7Q53R0KSWl
         a/2qkmt7ladJ1fa3PkYgBUjFjr63CgnNR5YZT/BoMrdxdfInTHzM5xQIi4f5oEosij5b
         OEUOGIhieOcGeDyTj1ckGrjOhhnPi0q3m9g8uOUeDkaQsFrTuiihp0phAzS71iwqhauK
         L9iA==
X-Gm-Message-State: AGRZ1gLQxm346BLRdIkgzJzM6OTDBTLOBKtRvdkp2dmEmJH95RGw9Kvo
        UIp89Qz0V0ImYSIjYWZfE3Ed6cPcQHszHxQGdrj1hw==
X-Google-Smtp-Source: AJdET5cIjgL8IGj7k+o0I1ZkoTaS3lpFEUz3B8vjfR1GQHLy53yejX5PdMpNLGqi7QTnz9TFtyzmaTF2DHoAYB1HMTE=
X-Received: by 2002:a6b:ac45:: with SMTP id v66-v6mr4530142ioe.66.1539990453084;
 Fri, 19 Oct 2018 16:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180831212007.247186-1-dbasehore@chromium.org>
In-Reply-To: <20180831212007.247186-1-dbasehore@chromium.org>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Fri, 19 Oct 2018 16:07:21 -0700
Message-ID: <CAGAzgsqayRfva3om-3juAhE+VDuY0hV6q-DuyiJ-QU=szPSaew@mail.gmail.com>
Subject: Re: [PATCH] clk: fix clk_calc_subtree compute duplications
To:     sboyd@kernel.org
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 2:20 PM Derek Basehore <dbasehore@chromium.org> wrote:
>
> clk_calc_subtree was called at every step up the clk tree in
> clk_calc_new_rates. Since it recursively calls itself for its
> children, this means it would be called once on each clk for each
> step above the top clk is.
>
> This is fixed by adding a non-recursive function called at every
> step in clk_calc_new_rates that fills in new_rate, new_parent, etc.
> Since the clks not called directly for clk_calc_new_rates can only
> change their rate, we only set new_rate in clk_calc_subtree.
> clk_calc_subtree is also only called on the top clk after it's found
> via clk_calc_new_rates to remove the duplicate recursive calls.
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  drivers/clk/clk.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index d31055ae6ec6..52032fb1a8a2 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -1609,11 +1609,18 @@ static int __clk_speculate_rates(struct clk_core *core,
>         return ret;
>  }
>
> -static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
> -                            struct clk_core *new_parent, u8 p_index)
> +static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate)
>  {
>         struct clk_core *child;
>
> +       core->new_rate = new_rate;
> +       hlist_for_each_entry(child, &core->children, child_node)
> +               clk_calc_subtree(child, clk_recalc(child, new_rate));
> +}
> +
> +static void clk_set_change(struct clk_core *core, unsigned long new_rate,
> +                          struct clk_core *new_parent, u8 p_index)
> +{
>         core->new_rate = new_rate;
>         core->new_parent = new_parent;
>         core->new_parent_index = p_index;
> @@ -1621,11 +1628,6 @@ static void clk_calc_subtree(struct clk_core *core, unsigned long new_rate,
>         core->new_child = NULL;
>         if (new_parent && new_parent != core->parent)
>                 new_parent->new_child = core;
> -
> -       hlist_for_each_entry(child, &core->children, child_node) {
> -               child->new_rate = clk_recalc(child, new_rate);
> -               clk_calc_subtree(child, child->new_rate, NULL, 0);
> -       }
>  }
>
>  /*
> @@ -1709,7 +1711,7 @@ static struct clk_core *clk_calc_new_rates(struct clk_core *core,
>                 top = clk_calc_new_rates(parent, best_parent_rate);
>
>  out:
> -       clk_calc_subtree(core, new_rate, parent, p_index);
> +       clk_set_change(core, new_rate, parent, p_index);
>
>         return top;
>  }
> @@ -1910,6 +1912,8 @@ static int clk_core_set_rate_nolock(struct clk_core *core,
>         if (ret)
>                 return ret;
>
> +       clk_calc_subtree(top, top->new_rate);
> +

Oops. This is wrong.  Calling here will overwrite new rate settings
such as when determine_rate/round_rate return something different than
clk_recalc(core, parent_rate). I'm working on a larger patch series
where this will be fixed.

>         /* notify that we are about to change rates */
>         fail_clk = clk_propagate_rate_change(top, PRE_RATE_CHANGE);
>         if (fail_clk) {
> --
> 2.19.0.rc1.350.ge57e33dbd1-goog
>
