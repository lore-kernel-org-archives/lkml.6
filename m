Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6CCC65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039802146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 09:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0XVAg7js"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 039802146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeK3Udj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 15:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:51236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbeK3Udj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 15:33:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7E920863;
        Fri, 30 Nov 2018 09:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543569898;
        bh=Fo35libfAVNgS5fOv7nF4RFOKa3eu31VoDU7+zsoRUk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=0XVAg7jsl3K4IewcJSRnsG8dzHyupS1dhNmdjF/C1V7bS4gIj/hlyscTR6GFv//h0
         bbwWsRNFR+sNIbH5uAxBKyiY42cWBzwRHMdA6io/D6yMKnISBoy7DI0v1eOrdsT/uU
         6sUQ1Kwzwd3ywa8tMPCKgeM1rkzhhBbNGWpJ9/MI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181122212212.16039-1-miquel.raynal@bootlin.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
References: <20181122212212.16039-1-miquel.raynal@bootlin.com>
Message-ID: <154356989722.88331.10134203618475749179@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 0/2] Link consumer with clock driver
Date:   Fri, 30 Nov 2018 01:24:57 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miquel Raynal (2018-11-22 13:22:10)
> Hello,
> =

> While working on suspend to RAM feature, I ran into troubles multiple
> times when clocks where not suspending/resuming at the desired time. I
> had a look at the core and I think the same logic as in the
> regulator's core may be applied here to (very easily) fix this issue:
> using device links.

Thanks! I've wanted to add device links to the clk framework for a while
now but haven't gotten around to it. Can you expand on the scenario that
you've run into where you need this?

> =

> The only additional change I had to do was to always (when available)
> populate the device entry of the core clock structure so that it could
> be used later. This is the purpose of patch 1. Patch 2 actually adds
> support for device links.

That's fine. We should do it into clk_core all the time for other
reasons too.

> =

> As I am not used to hack into the clock subsystem I might have missed
> something big preventing such change but so far I could not see
> anything wrong with it. As this touches core code, I am of course
> entirely open to suggestions.
> =


Two questions:

 1) Do device links work if we make a loop between devices? I'm thinking
 of the case where we have two clock controllers that provide clks to
 each other and could potentially register some clks and then clk_get()
 the ones they depend on. I suspect loops don't work and so we need to
 be aware of this and somehow prevent it.

 2) Do we need to link clk consumers to anything besides the device
 providing the clk they get from clk_get()? Put another way, do we need
 to make links through the clk tree and any potential parent clks of
 whatever the device is using at the time. Would clk tree changing
 topology because some new parent is chosen need to affect
 suspend/resume ordering? Or would that all need to be handled by clk
 framework figuring out the ordering of the tree at suspend/resume time
 and suspending clock controller drivers in the right order?


