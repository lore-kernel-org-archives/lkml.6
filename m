Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FFEC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB2120844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnBpCXOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB2120844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731704AbeGYXuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729182AbeGYXuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:50:51 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6F920833;
        Wed, 25 Jul 2018 22:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532558223;
        bh=bYkMChIkP+dciOzPj+vO2CS7681GWIQFZAONrnnwQ7I=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=XnBpCXOeOpH/shsYv2aiA/TjFtTuz5E4fpvPFUrchh4M4g+eK4qVBFmHaMzPZJqwK
         SGQCovw5xvHCp2898787L1AsG2v21ZThvvVSHrroP3+jlb+TAatOlHkC8i2VmrPaAZ
         Y13LYnFR6BpCo13P2vejMMIticxsxtpWwYdzoUNM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Russell King <linux@armlinux.org.uk>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <OSBPR01MB1766E6AFE37986B2E2B5E35DF5530@OSBPR01MB1766.jpnprd01.prod.outlook.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1531918658-32278-1-git-send-email-phil.edworthy@renesas.com>
 <20180718130228.GG17271@n2100.armlinux.org.uk>
 <CAMuHMdUjzVBXn-goAwbTBULfo=HrJEY6eBae4w7Z6qA-gScUUw@mail.gmail.com>
 <OSBPR01MB1766E6AFE37986B2E2B5E35DF5530@OSBPR01MB1766.jpnprd01.prod.outlook.com>
Message-ID: <153255822286.48062.3193076486782567960@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH] clk: Add functions to get optional clocks
Date:   Wed, 25 Jul 2018 15:37:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Phil Edworthy (2018-07-18 06:56:26)
> Hi Russell,
> =

> On 18 July 2018 14:19, Geert Uytterhoeven wrote:
> > On Wed, Jul 18, 2018 at 3:02 PM Russell King - ARM Linux  wrote:
> > > On Wed, Jul 18, 2018 at 01:57:38PM +0100, Phil Edworthy wrote:
> > > > Behaves the same as (devm_)clk_get except where there is no clock
> > > > producer. In this case, instead of returning -ENOENT, the function
> > > > returns NULL. This makes error checking simpler and allows
> > > > clk_prepare_enable, etc to be called on the returned reference
> > > > without additional checks.
> > >
> > > How does this work with non-DT systems, where looking a clock up which
> > > isn't yet registered with clkdev returns -ENOENT ?
> > >
> > > (clkdev doesn't know when all clocks are registered with it.)
> > =

> > Good question.
> > =

> > I guess all drivers trying to handle optional clocks this way are alrea=
dy broken
> > on non-DT systems where clocks may be registered late...
> =

> So how do non-DT systems that look a clock up which isn't yet
> registered with clkdev, determine that an optional clock is there
> or not?
> =


Short answer is they don't. I'd still prefer we have this API though.

Can you rework this patch to be a little more invasive into the
clk_get() path, perhaps by reworking __of_clk_get_by_name() a little to
take an 'optional' argument, so that it only returns NULL when the clk
is looked up from DT? The fallback path in clkdev where we have a DT
based system looking up a clk through clkdev lookups doesn't seem to be
a real scenario that we should worry about here. I think sometimes
people use clkdev lookups when they're migrating to DT systems and
things aren't wired up properly in DT, but that isn't the norm.

