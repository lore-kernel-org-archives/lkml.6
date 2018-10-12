Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA96C6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D29D20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhNvwvxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D29D20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJMCBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbeJMCBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:01:55 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 129F5206B2;
        Fri, 12 Oct 2018 18:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539368887;
        bh=FU+AKeqVz30YHI7xPH/CeBtqjvia9u7upR1ZkKmAVlE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=qhNvwvxSCRDBXS7DP25gGhSwMhCo10r9OtOCs23iFVq25ZrAXhnpyPj/ig1EQS+Wl
         Sd66CbhI5aw/rVZK2m2yDMxYas7nGbxauRDSQm1v9696SB3M0fwhKiBcDrjulIRYGG
         l5n8pXjtEihHXXGu9JJzxhg5MR0+aj9TRWcwEsp0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <153573753043.93865.2420370848457480370@swboyd.mtv.corp.google.com>
Cc:     devicetree@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180717222757.10253-1-alexandre.belloni@bootlin.com>
 <153271100280.48062.2538655794734424353@swboyd.mtv.corp.google.com>
 <20180816114755.GH21707@piout.net>
 <153573753043.93865.2420370848457480370@swboyd.mtv.corp.google.com>
Message-ID: <153936888640.5275.18223880548754104359@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 00/16] clk: at91: Rework DT bindings
Date:   Fri, 12 Oct 2018 11:28:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2018-08-31 10:45:30)
> Quoting Alexandre Belloni (2018-08-16 04:47:55)
> > On 27/07/2018 10:03:22-0700, Stephen Boyd wrote:
> > > Quoting Alexandre Belloni (2018-07-17 15:27:41)
> > > > This is the promised rework of the at91 PMC clocks driver. It is ma=
inly
> > > > necessary to remove the DTC warnings but it also complies with the =
CCF
> > > > rule that there should be one node per controller instead of one no=
de
> > > > per clock.
> > > > =

> > > > This only handles the PMC, I'm planning to also rework the SCKC bin=
dings
> > > > later (without breaking the DT ABI).
> > > > =

> > > > The series is based on top of clk-next plus at91-dt so I don't thin=
k it
> > > > is convenient to have it this cycle. However, I would really like to
> > > > ensure we agree on the new bindings this cycle before converting al=
l the
> > > > other platforms as this is a bit tedious.
> > > > =

> > > > The first two patches are actually fixes and may be considered for =
this
> > > > cycle.
> > > > =

> > > > One nice note:
> > > > at91-sama5d2_xplained.dtb goes from 29351 bytes to 22082 bytes
> > > =

> > > Patches look mostly good. Rob is happy with the bindings and so am I.
> > > =

> > > One general question is why the drivers can't be moved to real platfo=
rm
> > > drivers instead of using OF_CLK_DECLARE?
> > > =

> > =

> > I tried, this makes the clocksource drivers fail with -EPROBE_DEFER and
> > so the kernel just stops there.
> > =

> =

> Ok. We have CLK_OF_DECLARE_DRIVER for that. Can you use that?
> =


I assume this will be resent. I haven't seen anything yet though.

