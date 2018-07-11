Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E408C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C8920C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uC2764N1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C8920C0D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389762AbeGKQkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 12:40:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387957AbeGKQj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 12:39:58 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64D3820870;
        Wed, 11 Jul 2018 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531326890;
        bh=Qvx/k3wtFZRpZTSAiCIq068TIVvfZyaWo01m5g+TToU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=uC2764N1Q0Rh8arJ7hUsZw2ifsgQAmFDiZ7HiqSh59zxkCH8k8EkIgZs1USPwEzbU
         IDjgpG1fjpc/JtdJYo181wJh37bw+WvDD9+0rF8DW3itjipzs+gmNUqXVINAsNKmr2
         Z8wg5SsNgdhV94b+GOO1UHnXD51KHzFt4udeTqMk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Joel Stanley <joel@jms.id.au>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <CACPK8XfxKhT_ywpo3vqXSEaSPGdM+uhkgpn1R+EP9Z3spxAzXg@mail.gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20180628231540.26633-1-joel@jms.id.au>
 <153089970720.143105.7005759760140367907@swboyd.mtv.corp.google.com>
 <CACPK8XfxKhT_ywpo3vqXSEaSPGdM+uhkgpn1R+EP9Z3spxAzXg@mail.gmail.com>
Message-ID: <153132688979.143105.557909972230566711@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: aspeed: Support HPLL strapping on ast2400
Date:   Wed, 11 Jul 2018 09:34:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joel Stanley (2018-07-10 22:53:52)
> Hi Stephen,
> =

> On 7 July 2018 at 03:55, Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Joel Stanley (2018-06-28 16:15:40)
> >> The HPLL can be configured through a register (SCU24), however some
> >> platforms chose to configure it through the strapping settings and do
> >> not use the register. This was not noticed as the logic for bit 18 in
> >> SCU24 was confused: set means programmed, but the driver read it as set
> >> means strapped.
> >>
> >> This gives us the correct HPLL value on Palmetto systems, from which
> >> most of the peripheral clocks are generated.
> >>
> >> Fixes: 5eda5d79e4be ("clk: Add clock driver for ASPEED BMC SoCs")
> >> Cc: stable@vger.kernel.org # v4.15
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> Signed-off-by: Joel Stanley <joel@jms.id.au>
> >> ---
> >
> > Do you want this merged for -rc5? It sounds like on some systems this is
> > a problem, but I don't know if these systems are supposed to work yet or
> > not, so priority of this fix is not easy for me to understand.
> >
> =

> Sure, some more background:
> =

> We did not notice this until we attempted to use the clock for the mtd
> driver. However, this clock is used for the kernel clocksource, so eg.
> sleep 1 takes two seconds to complete. This affects all of the systems
> I have access to.
> =

> I suggest we merge for4.18, and keep the cc: stable so it can be
> backported to the stable trees.
> =


Ok. Thanks! Applied to clk-fixes.
