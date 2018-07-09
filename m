Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5DFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487D22089B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 487D22089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933717AbeGIPmq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:42:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59051 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932881AbeGIPmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:42:43 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1A9AD20931; Mon,  9 Jul 2018 17:42:42 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id E40E5208FD;
        Mon,  9 Jul 2018 17:42:31 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>,
        Hua Jing <jinghua@marvell.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>, Ken Ma <make@marvell.com>,
        Victor Gu <xigu@marvell.com>,
        Neta Zur Hershkovits <neta@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Wilson Ding <dingwei@marvell.com>,
        linux-arm-kernel@lists.infradead.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 1/2] clk: mvebu: armada-37xx-periph: Fix switching CPU rate from 300Mhz to 1.2GHz
References: <20180619123446.694-1-gregory.clement@bootlin.com>
        <20180619123446.694-2-gregory.clement@bootlin.com>
        <87tvpl4pql.fsf@bootlin.com>
        <153092068418.143105.5823916627333449732@swboyd.mtv.corp.google.com>
Date:   Mon, 09 Jul 2018 17:42:31 +0200
In-Reply-To: <153092068418.143105.5823916627333449732@swboyd.mtv.corp.google.com>
        (Stephen Boyd's message of "Fri, 06 Jul 2018 16:44:44 -0700")
Message-ID: <87va9oct5k.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,
 
 On ven., juil. 06 2018, Stephen Boyd <sboyd@kernel.org> wrote:

> Quoting Gregory CLEMENT (2018-06-29 07:44:02)
>> Hi,
>>  
>>  On mar., juin 19 2018, Gregory CLEMENT <gregory.clement@bootlin.com> wrote:
>> 
>> > Switching the CPU from the L2 or L3 frequencies (300 and 200 Mhz
>> > respectively) to L0 frequency (1.2 Ghz) requires a significant amount
>> > of time to let VDD stabilize to the appropriate voltage. This amount of
>> > time is large enough that it cannot be covered by the hardware
>> > countdown register. Due to this, the CPU might start operating at L0
>> > before the voltage is stabilized, leading to CPU stalls.
>> >
>> > To work around this problem, we prevent switching directly from the
>> > L2/L3 frequencies to the L0 frequency, and instead switch to the L1
>> > frequency in-between. The sequence therefore becomes:
>> >
>> > 1. First switch from L2/L3(200/300MHz) to L1(600MHZ)
>> > 2. Sleep 20ms for stabling VDD voltage
>> > 3. Then switch from L1(600MHZ) to L0(1200Mhz).
>> 
>> Do you have any comment on this fix?
>> 
>
> Looks good. Is it crashing right now? I can throw it into clk-fixes if
> it's fixing pain.

Yes for the SoC capable to run at 1200Mhz it crashes. At the time the
initial support was provided, my SoC version only ran at 1000MHz, so the
problem was not noticed.

Thanks,

Gregory


-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
