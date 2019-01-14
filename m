Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC64BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BDB20657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547504714;
	bh=fXgvGEPvJuxiKA4UO/eJVYuVwSVyczNhU6jRW0Q5AII=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=htBZajDLiYvjkjaSs8b35Uy7zTv+8pgjVGalVq6a2SU/mK7ZIIulngF843CrdHZ9r
	 ZoJ0R5/B7+3zj3woeYtzIq4srZ/bb7VMu5UW/RR11OY5VHUlr+IKaU+r2aqWIXAW34
	 BuOfNGR4yyPTXWxIcp7EDHRyiurZ1IQgbdcdSXFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbfANWZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:25:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:43916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfANWZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:25:12 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58A320657;
        Mon, 14 Jan 2019 22:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547504711;
        bh=fXgvGEPvJuxiKA4UO/eJVYuVwSVyczNhU6jRW0Q5AII=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=O2VKReb573qYJo+Y3K2Bpqf7qOH/TYL4Rhpyy8Zb57QzvfYQH/sZ+PxXN1SFfEYG2
         jGiZTtZUCeeC2JvWHuhISP4PJaMjd6xiOvxtpjikCErYFvHlobmzs5u3R+9DIDycm2
         FLLwuBz9Yfe0Epf+4uaflW/BrpvPs/KJuSjouqg8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] clk: qcom: lpass: Add CLK_IGNORE_UNUSED for lpass clocks
User-Agent: alot/0.8
In-Reply-To: <adc9235a-3700-7730-a473-8a6baf47a1e0@codeaurora.org>
References: <1545306385-31240-1-git-send-email-tdas@codeaurora.org> <154533989563.79149.10213938035592547726@swboyd.mtv.corp.google.com> <b6397ef1-a6df-0040-9dcc-c491b76a2f8f@codeaurora.org> <154689507747.15366.6553307032295093169@swboyd.mtv.corp.google.com> <adc9235a-3700-7730-a473-8a6baf47a1e0@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Message-ID: <154750471090.169631.5712250327468594228@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 14 Jan 2019 14:25:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-01-13 22:12:39)
>=20
>=20
> On 1/8/2019 2:34 AM, Stephen Boyd wrote:
> >=20
> > As far as I know, I'm not suggesting the use of CLK_IS_CRITICAL here.
> > But removing CLK_IS_CRITICAL and relying on some random bootloader
> > behavior also looks wrong. Can you clarify what's going on?
> >=20
>=20
> To enable LPASS clocks the requirement is to enable the GCC_LPASS_SWAY=20
> clock.
> 1) If the LPASS drivers are enabled/probed before the clock late init=20
> the client would take care to maintain the dependency to enable the=20
> GCC_LPASS_SWAY clock before enabling the LPASS clocks.
>=20
> 2) There could be a condition where the LPASS drivers would probe/init=20
> later the clock late_init. When the clock_late_init would try to access=20
> the LPASS clocks, since we cannot maintain the dependency this access=20
> would fail. To avoid this the earlier patch has made the GCC_LPASS_SWAY=20
> clock as CRITICAL.
>=20
> 3) Marking the GCC_LPASS_SWAY clock as CRITICAL has a issue, in the case =

> where the LPASS subsystem would be restarted due to some critical=20
> failure on LPASS. Toggling the restart register of LPASS would clear the =

> hardware state of this clock and thus the next access of the LPASS=20
> clocks would result in failure of the system.
>=20
> 4) To avoid issues happening in (2) and (3) all the LPASS clocks chould=20
> be safely marked as CLK_IGNORE_UNUSED. And lpass drivers would take care =

> of the dependency to enable the required clocks.
>=20

Ok, so why can't we enable/disable the lpass sway clk in the
prepare/unprepare phase of the lpass clk driver paths? Or why can't we
forcibly enable this lpass sway clk after the reset is deasserted? Which
clk controller is the reset part of? GCC or LPASS?

It still sounds like the LPASS clk driver isn't handling dependencies it
has on accessing registers, but maybe we can get away with not handling
the dependency still if we make the reset "do the right thing" and turn
the clk back on so it stays "critical".

