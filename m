Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12BAC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8242183F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 10:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="qkyiYGJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfAHKfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 05:35:48 -0500
Received: from onstation.org ([52.200.56.107]:54862 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbfAHKfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 05:35:48 -0500
Received: from localhost (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 445891AE;
        Tue,  8 Jan 2019 10:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1546943747;
        bh=+KzYZ7ZLUwQUvnzNFFleFj5rK8oYcPYi7iQnO5VkQqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qkyiYGJx6pfEyaID770+5YxtKC8KX9x1oDqlVJbNYIbV46eEP+Col30fH0EEqxXjU
         VgUBzBkUj5lQ/aDVP9qWpjcjQWR0WkRTH+ZzmBbhXEcEW/ZFqVBDurYc2oqzP8E60r
         LPqlzwb1SVZ+VIyEgHclTBa5KwNeDxdC2hS94PzY=
Date:   Tue, 8 Jan 2019 05:35:45 -0500
From:   Brian Masney <masneyb@onstation.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     andy.gross@linaro.org, bjorn.andersson@linaro.org,
        lee.jones@linaro.org, linus.walleij@linaro.org,
        marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] qcom: spmi-gpio: add support for hierarchical IRQ
 chip
Message-ID: <20190108103545.GB3643@basecamp>
References: <20190107021145.6370-1-masneyb@onstation.org>
 <20190107021145.6370-5-masneyb@onstation.org>
 <154689814280.15366.2705028033847856491@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154689814280.15366.2705028033847856491@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 01:55:42PM -0800, Stephen Boyd wrote:
> > +       ret = pmic_gpio_domain_translate(domain, fwspec, &hwirq, &type);
> > +       if (ret)
> > +               return ret;
> > +
> > +       for (i = 0; i < nr_irqs; i++)
> > +               irq_domain_set_info(domain, virq + i, hwirq + i,
> > +                                   &pmic_gpio_irq_chip, state,
> > +                                   handle_level_irq, NULL, NULL);
> > +
> > +       parent_fwspec.fwnode = domain->parent->fwnode;
> > +       parent_fwspec.param_count = 4;
> > +       parent_fwspec.param[0] = 0;
> > +       parent_fwspec.param[1] = fwspec->param[0] + 0xc0 - 1;
> 
> Is the -1 there twice, once in pmic_gpio_domain_translate() and then
> here?

That should be 'hwirq + c0' to improve the code readability.

Brian
