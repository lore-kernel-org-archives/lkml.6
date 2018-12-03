Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDB5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30F9A20864
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 22:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lV6HDqE/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F9A20864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLCW2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 17:28:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbeLCW2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 17:28:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6D3B2064A;
        Mon,  3 Dec 2018 22:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543876122;
        bh=XGiQXrRMQGaufxGbz5Xbdb3hIvIJ/43Qjjwpu8sxr/E=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=lV6HDqE/oulB0F0sSL4S6+I3e05leljhJODzanTrK/cnt1x17FbNTYOFKFBYhys+S
         pd+IfVZbw7T8b5Cjw3Qi5NY+J4t1CQTbyro2jx7pbrd/XxoeERXGxAelzMxmA/t0qN
         ptJyTOS8AxEN5RKsfj1MGtNm8LeDK6s/09uQzxNk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Miquel Raynal <miquel.raynal@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181203231655.4e7dc330@xps13>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
References: <20181122212212.16039-3-miquel.raynal@bootlin.com>
 <201811231627.H7ojlKLL%fengguang.wu@intel.com>
 <20181123101132.6be3829c@xps13>
 <154356998033.88331.4426431020982838779@swboyd.mtv.corp.google.com>
 <20181130112052.73d943ec@xps13>
 <154386483105.88331.13970025193347328031@swboyd.mtv.corp.google.com>
 <20181203231655.4e7dc330@xps13>
Message-ID: <154387612188.88331.1486215045607446526@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: core: link consumer with clock driver
Date:   Mon, 03 Dec 2018 14:28:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miquel Raynal (2018-12-03 14:16:55)
> Stephen Boyd <sboyd@kernel.org> wrote on Mon, 03 Dec 2018 11:20:31
> -0800:
> > Quoting Miquel Raynal (2018-11-30 02:20:52)
> > > Stephen Boyd <sboyd@kernel.org> wrote on Fri, 30 Nov 2018 01:26:20
> > > -0800:
> > > > Quoting Miquel Raynal (2018-11-23 01:11:32)  =

> > > =

> > > Because we need the caller's 'struct device' to make the link and
> > > this is not available in __clk_get(). I tried to ad it as parameter b=
ut
> > > I don't think it is possible to retrieve a 'struct device' from the
> > > device name. The functions where this is problematic are:
> > > * clk.c:__of_clk_get_from_provider()
> > > * clkdev.c:clk_get_sys()
> > > =

> > > By the way in my new version I called the helpers:
> > > * clk_{link,unlink}_hierarchy()
> > > * clk_{link,unlink}_consumer()
> > > =

> > > I will send a new version with these helpers, but if you have anything
> > > in mind to help me achieve the above request, I will welcome the idea.
> > >   =

> > =

> > We can do the linking in __clk_get() and __clk_put() if we poke into the
> > struct clk -> struct clk_core and bury the struct device into each
> > clk_core structure.
> > =

> =

> I meant the consumer device's structure. Yes, from a struct clk, the
> first change in patch 1/2 let's us do clk->core->dev to get the clock
> device. But for linking I need both the clock device and the consumer
> device; and the latter will be missing in __clk_get().
> =


Ah ok, sounds like this is how it has to be then.

