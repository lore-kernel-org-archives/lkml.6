Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E904C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4998A2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546895080;
	bh=fqUgkZCO8NwjdpjcV77f6IGZIEMqltxXOFqnLSY+ObI=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=An/cXbnXzeGd86jy7UmZlnXC8tnXk1p0SRejkoNr6duRa2x+BiR/8EZZuB68FZtWb
	 HmrRg7Rfakm/BU9+7z65GwrY8Ys6TaP/HKBCiK6zSV5ijvjtV5c177DnPWmHtv+wzK
	 QRZ1SaLsMZd/Txiw4qYmqK5Z9BZOn2AyNWTtJ4Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfAGVEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 16:04:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbfAGVEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 16:04:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 515DE2089F;
        Mon,  7 Jan 2019 21:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546895078;
        bh=fqUgkZCO8NwjdpjcV77f6IGZIEMqltxXOFqnLSY+ObI=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=x/HHxvk05N+Iym1BHoyHbye+Mdd8Y5ypUyAkL+6Xz15hhvMjASbSzJ6znX9JkN++X
         7Wd7yDvPP0OT3qrWyI5P+APDVlbT5u3PBDd/zaqBfDsvuYssWS2amCH+8bWOMdv0RM
         +IsLOoRdIhmU0Fb0xV162oP+pUYru3rv/C47hs3M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1] clk: qcom: lpass: Add CLK_IGNORE_UNUSED for lpass clocks
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
In-Reply-To: <b6397ef1-a6df-0040-9dcc-c491b76a2f8f@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1545306385-31240-1-git-send-email-tdas@codeaurora.org> <154533989563.79149.10213938035592547726@swboyd.mtv.corp.google.com> <b6397ef1-a6df-0040-9dcc-c491b76a2f8f@codeaurora.org>
Message-ID: <154689507747.15366.6553307032295093169@swboyd.mtv.corp.google.com>
Date:   Mon, 07 Jan 2019 13:04:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2019-01-06 22:26:00)
> Hello Stephen,
>=20
> On 12/21/2018 2:34 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-12-20 03:46:25)
> >> The LPASS clocks has a dependency on the GCC lpass clocks to be enabled
> >> before accessing them and that was the reason to mark the gcc lpass cl=
ocks
> >> as critical. But in the case where the lpass subsystem would require a
> >> restart, toggling the lpass reset would from HW clear the SW enable bi=
ts
> >> of the GCC lpass clocks. Thus the next time bringing up the lpass subs=
ystem
> >> out of reset would fail.
> >>
> >> Allow the lpass clock driver to enable/disable the gcc lpass clocks and
> >> mark the lpass clocks not be accessed during late_init if no client vo=
te.
> >=20
> > You need to add more details here. It feels like you wrote the beginning
> > of a paragraph and then stopped abruptly, leaving the reader hanging for
> > the whole story. Why is late_init important? Why do we need to leave
> > them on from the bootloader? What if the bootloader doesn't leave them
> > enabled? This is all rather hacky so I'm deeply confused. Does the lpass
> > driver need to get these gcc clks and enable/prepare them during probe?
> > But then it needs to also allow a reset happen and change the clk state?
> >=20
> > I suspect this situation is circling a larger problem where a reset is
> > toggled and that changes some clk state without the clk framework
> > knowing. There's not much we can do about that besides having some
> > mechanism for the clks to know that their state is now out of sync. If
> > that can be done on the provider driver side then we should have an
> > easier time not needing to write a bunch of framework code to handle
> > this. OMAP folks are dealing with the same problems from what I recall.
> >=20
>=20
> Hmm, if I mark the CLK_IS_CRITICAL, I don't see a way to handle it in=20
> provider. Please suggest if you think provider could handle it.

As far as I know, I'm not suggesting the use of CLK_IS_CRITICAL here.
But removing CLK_IS_CRITICAL and relying on some random bootloader
behavior also looks wrong. Can you clarify what's going on?

