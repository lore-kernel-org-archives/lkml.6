Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E94ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963AA2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="weSckufE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963AA2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbeJSEdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:33:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725738AbeJSEdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:33:49 -0400
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8588621479;
        Thu, 18 Oct 2018 20:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539894666;
        bh=rj5jV9OQAYq1PRnre9bk/MxrESSL7Oa0YV1Pb26C4bg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=weSckufEM/NtgKiNqCW5Uj+Cj5czqMCnMTO0W1O6iN7Qfz7DJb/X+ehBRslkBcVEO
         6Hi845suJX2QsI8qbQ1V/wDEBRGK+w0Uhxyy9vFir8izTZe+IXPYGVuBsQP+qVBUNr
         uDo1jcaLmYhEvwP9vriVFyiBnxjY709GYla+kJGs=
Received: by mail-ed1-f49.google.com with SMTP id l14-v6so20511500edq.0;
        Thu, 18 Oct 2018 13:31:06 -0700 (PDT)
X-Gm-Message-State: ABuFfojbkNxtNbCjdGp2d6fmlNnzXwv5Ye4BG0MEIpLFUglUsE6okBSY
        9ZAM+PjO4jLoLsWB129H7WgGo4AlW+LEa70h0Bc=
X-Google-Smtp-Source: ACcGV63G+IrWjVZ3Dpmr/XfXw8fKH3WW7NpkdX542hzTL2EvMjVMbsrRYhVBBzC+AfxSNTZzoMjIA3P7fCTkNEm79rs=
X-Received: by 2002:a50:cd57:: with SMTP id d23-v6mr4590683edj.60.1539894665026;
 Thu, 18 Oct 2018 13:31:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181018195411.3449-1-atull@kernel.org> <153989416422.53599.5865157270835783532@swboyd.mtv.corp.google.com>
In-Reply-To: <153989416422.53599.5865157270835783532@swboyd.mtv.corp.google.com>
From:   Alan Tull <atull@kernel.org>
Date:   Thu, 18 Oct 2018 15:30:28 -0500
X-Gmail-Original-Message-ID: <CANk1AXSnZqDX7zoBTGX1Cd8dt76zLk2aqR5-CfP4W87ZFCjvpA@mail.gmail.com>
Message-ID: <CANk1AXSnZqDX7zoBTGX1Cd8dt76zLk2aqR5-CfP4W87ZFCjvpA@mail.gmail.com>
Subject: Re: [PATCH] clk: fixed-rate: fix of_node_get-put imbalance
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        linux-clk@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:22 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Alan Tull (2018-10-18 12:54:11)
> > When the fixed rate clock is created by devicetree,
> > of_clk_add_provider is called.  Add a call to
> > of_clk_del_provider in the remove function to balance
> > it out.
> >
> > Signed-off-by: Alan Tull <atull@kernel.org>
> > ---
>
> Fixes tag? I'll tack one on.

Fixes 435779fe1336 ("clk: fixed-rate: Convert into a module platform driver")

Thanks!
Alan

>
> >  drivers/clk/clk-fixed-rate.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clk/clk-fixed-rate.c b/drivers/clk/clk-fixed-rate.c
> > index b5c46b3f8764..6d6475c32ee5 100644
> > --- a/drivers/clk/clk-fixed-rate.c
> > +++ b/drivers/clk/clk-fixed-rate.c
> > @@ -200,6 +200,7 @@ static int of_fixed_clk_remove(struct platform_device *pdev)
> >  {
> >         struct clk *clk = platform_get_drvdata(pdev);
> >
> > +       of_clk_del_provider(pdev->dev.of_node);
> >         clk_unregister_fixed_rate(clk);
> >
> >         return 0;
