Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5D5C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471CA208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Q55E9I2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 471CA208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLCRGL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:06:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726637AbeLCRGL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:06:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE68520661;
        Mon,  3 Dec 2018 17:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543856766;
        bh=FvafjOoO3NBfC7SpPm/WWbi4uIwMgg9iUnFewXPDVSA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=1Q55E9I20V4KOWNon8twbt2RFKEyud2S2EPWCEmK6oozsFGM6tsiH3A+fAjJ/Z6m9
         iOtVFDbn0kpcdCtyB9IUtIpFXm7A7p6hlCt/gR1rmay7yCr2VZjfAK0SwWhZY7cRH/
         P99hrAI8OAL9jHr/Uwa+6gIEHjFuY2P5K6iFfno4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Tony Lindgren <tony@atomide.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181203153910.GA6707@atomide.com>
Cc:     Tero Kristo <t-kristo@ti.com>,
        Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        letux-kernel@openphoenux.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        mturquette@baylibre.com, paul@pwsan.com
References: <20181110203115.13335-1-andreas@kemnade.info>
 <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
 <20181130071534.0a6cd455@kemnade.info>
 <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
 <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
 <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
 <20181130153729.GG53235@atomide.com>
 <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
 <20181203153910.GA6707@atomide.com>
Message-ID: <154385676593.88331.5239924154783168815@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date:   Mon, 03 Dec 2018 09:06:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Lindgren (2018-12-03 07:39:10)
> * Stephen Boyd <sboyd@kernel.org> [181130 23:52]:
> > Quoting Tony Lindgren (2018-11-30 07:37:29)
> > > * Tero Kristo <t-kristo@ti.com> [181130 09:21]:
> > > > On 30/11/2018 09:57, Stephen Boyd wrote:
> > > ...
> > > =

> > > And that way it would just propagate to the parent clock
> > > domain driver and the clock framework does not need to know
> > > about clockdomains. A clockdomain could be just a genpd
> > > domain.
> > > =

> > > Or do you guys have better ideas?
> > > =

> > =

> > Wouldn't the device link in clk framework patches do this for you if we
> > had the RUNTIME_PM flag passed in. If this is about keeping the clock
> > controller active when a consumer device is using it then I think it may
> > work.
> =

> The consumer device stays active just fine with PM runtime
> calls. So yes, the problem is keeping a clock controller forced
> active for the period of consumer device reset. Other than
> that typically autoidle can be just kept enabled.
> =

> Below is a clarified suggested example usage if we wanted to
> use PM runtime on a clock controller device from a consumer
> device reset driver:
> =

> error =3D pm_runtime_get_dev()
> ...
> cdev =3D clk_get_device(clk);
> ...
> error =3D pm_runtime_get(cdev);
> ...
> /* Do the consumer device reset here */
> ...
> pm_runtime_put(cdev);
> pm_runtime_put(dev);
> =


Does the consumer reset use the reset framework or something else? If
the driver is using the reset framework, I would expect the reset
framework to _also_ have device links and keep the clock controller,
i.e. reset provider, active while the reset is being toggled. And this
assumes the reset controller and clock controller code is all rolled up
together in a single driver that can tell itself to deny idle for
certain clks that are associated with whatever resets they affect.

