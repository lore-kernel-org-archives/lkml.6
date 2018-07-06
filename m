Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269F0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30B022B51
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyDw+szA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30B022B51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933552AbeGFXor (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:41336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933028AbeGFXop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:44:45 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D973122B4B;
        Fri,  6 Jul 2018 23:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530920685;
        bh=p9Ku5DkcnasVEeZ/xXY3TrEXmtB+khb8T0MfWcJd6Ew=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=OyDw+szAIfcHOXMI5hQwR0UeXdOIldgUKnT0jxuvkvg4POJ+YyW/CdGFz2ywIcxuY
         3xlZkICiwojepAwGusWLCO3OcRHPuHkXN7y+7tOoOxjhdPsb5budbizGtlX6r6dZRz
         l+W3HZCCwtM3cMgCZW4jRu8K4ImK9IzFjCaJB2nc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <87tvpl4pql.fsf@bootlin.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Hua Jing <jinghua@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Ken Ma <make@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Neta Zur Hershkovits <neta@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Wilson Ding <dingwei@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
References: <20180619123446.694-1-gregory.clement@bootlin.com>
 <20180619123446.694-2-gregory.clement@bootlin.com>
 <87tvpl4pql.fsf@bootlin.com>
Message-ID: <153092068418.143105.5823916627333449732@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] clk: mvebu: armada-37xx-periph: Fix switching CPU rate from
 300Mhz to 1.2GHz
Date:   Fri, 06 Jul 2018 16:44:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Gregory CLEMENT (2018-06-29 07:44:02)
> Hi,
>  =

>  On mar., juin 19 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wro=
te:
> =

> > Switching the CPU from the L2 or L3 frequencies (300 and 200 Mhz
> > respectively) to L0 frequency (1.2 Ghz) requires a significant amount
> > of time to let VDD stabilize to the appropriate voltage. This amount of
> > time is large enough that it cannot be covered by the hardware
> > countdown register. Due to this, the CPU might start operating at L0
> > before the voltage is stabilized, leading to CPU stalls.
> >
> > To work around this problem, we prevent switching directly from the
> > L2/L3 frequencies to the L0 frequency, and instead switch to the L1
> > frequency in-between. The sequence therefore becomes:
> >
> > 1. First switch from L2/L3(200/300MHz) to L1(600MHZ)
> > 2. Sleep 20ms for stabling VDD voltage
> > 3. Then switch from L1(600MHZ) to L0(1200Mhz).
> =

> Do you have any comment on this fix?
> =


Looks good. Is it crashing right now? I can throw it into clk-fixes if
it's fixing pain.
