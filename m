Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE95C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D92D206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 01:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="dxa53GyX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfAOBOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 20:14:35 -0500
Received: from onstation.org ([52.200.56.107]:47540 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfAOBOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 20:14:34 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 3FC3014D;
        Tue, 15 Jan 2019 01:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1547514873;
        bh=qCftmhtVIFKupcFHh2NeNcyYWde84otoywov8HX6IqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxa53GyXm3gVkHdi0yS7HJeurPVEzjT4GHNsaMcxzM8OxPsG+0eEZr1kN/0QR8FwS
         VunaFf/iA/Vdc5uhUwJ5aUCVPk9iKaIqZs596QAlrFqMAqeBLtfNZil9hrKLM0xGBw
         z4R0Lz3hc0LjtnqXcUwfHeo6cuSOsv5clBVQRp0I=
Date:   Mon, 14 Jan 2019 20:14:32 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linus.walleij@linaro.org, sboyd@kernel.org, andy.gross@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 03/14] pinctrl: qcom: spmi-gpio: hardcode IRQ counts
Message-ID: <20190115011432.GA7900@basecamp>
References: <20190113154716.5145-1-masneyb@onstation.org>
 <20190113154716.5145-4-masneyb@onstation.org>
 <20190115003428.GJ9278@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115003428.GJ9278@minitux>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 04:34:28PM -0800, Bjorn Andersson wrote:
> > -	npins = platform_irq_count(pdev);
> > -	if (!npins)
> > -		return -EINVAL;
> > -	if (npins < 0)
> > -		return npins;
> > -
> > -	BUG_ON(npins > ARRAY_SIZE(pmic_gpio_groups));
> > +	npins = (u16)(uintptr_t) device_get_match_data(&pdev->dev);
> 
> Why u16, afaict npins is an int? I'm pretty sure you can leave the last
> cast as implicit and as it's not actually a pointer that we're acquiring
> casting it to "unsigned long" is the idiomatic way.
> 
> Apart from this the change looks good.
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I can change it to this:

npins = (uintptr_t) device_get_match_data(&pdev->dev);

I'll send out V5 on Wednesday evening (GMT-5) to give time for any other
reviews that may trickle in.

Thanks Bjorn, Stephen, and Linus for the reviews. This was a fun task; I
learned a lot working on it.

I'll also convert SSBI based on this series.

Brian
