Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393B8C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B12020882
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 19:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548876503;
	bh=VnzoG7/iCKa9YCYAgbYp0VXwFOAxlljWOU2eIxuF4sk=;
	h=Subject:From:Cc:References:To:In-Reply-To:Date:List-ID:From;
	b=U8NdlZjipQX1dOpUmwYF8WMlkDLSJW9hprhazVJ4j7C0Ez1VCY7Rta49lBirImy1x
	 c4XPA4yHbF5LGT9F3NXNseruwNyKGMfcZeI8hmbGqv2rAyAT+V58dCaeMI4CcIlBqd
	 oZUF/KZLR8cIIRsR5hyjA5b/lNqVLq0oWKoC2P2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387663AbfA3T2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 14:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:49952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbfA3T2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 14:28:20 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E712087F;
        Wed, 30 Jan 2019 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548876500;
        bh=VnzoG7/iCKa9YCYAgbYp0VXwFOAxlljWOU2eIxuF4sk=;
        h=Subject:From:Cc:References:To:In-Reply-To:Date:From;
        b=AggPMcUF7RLNvhPGgW2gMnw+EwBkDQWOhHiKY2zsUBxusIojzXPAwu5qXHJJ/Qoww
         nskqddWBt++L0xTALced66op570KM9i32NN/1cympGwU7JRCCR2NPXEs7okHEMTILj
         VTeyIQjVs/eWCWh6Ez0TCVZp2nHR7+IotMkSZqo8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] clk: aspeed: Setup video engine clocking
From:   Stephen Boyd <sboyd@kernel.org>
Message-ID: <154887649939.169292.7755423118611897741@swboyd.mtv.corp.google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1544559161-21468-1-git-send-email-eajames@linux.ibm.com> <1544559161-21468-3-git-send-email-eajames@linux.ibm.com> <CACPK8XcY_c9NzNv-WyZcz+mZ5c2jixyCzEQAK-+t0QvQ_uJXwg@mail.gmail.com> <81b100b7-252e-3145-fb34-17a9c0cdd91e@linux.ibm.com>
User-Agent: alot/0.8
To:     Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>
In-Reply-To: <81b100b7-252e-3145-fb34-17a9c0cdd91e@linux.ibm.com>
Date:   Wed, 30 Jan 2019 11:28:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Eddie James (2018-12-14 07:47:53)
>=20
>=20
> On 12/13/2018 07:02 PM, Joel Stanley wrote:
>=20
> >
> >> +       { 0x0, 2 },
> >> +       { 0x1, 2 },
> >> +       { 0x2, 3 },
> >> +       { 0x3, 4 },
> >> +       { 0x4, 5 },
> >> +       { 0x5, 6 },
> >> +       { 0x6, 7 },
> >> +       { 0x7, 8 },
> >> +       { 0 }
> >> +};
> >> @@ -317,6 +338,7 @@ struct aspeed_reset {
> >>          [ASPEED_RESET_PECI]     =3D 10,
> >>          [ASPEED_RESET_I2C]      =3D  2,
> >>          [ASPEED_RESET_AHB]      =3D  1,
> >> +       [ASPEED_RESET_VIDEO]    =3D  6,
> > You've added the reset line to the ASPEED_CLK_GATE_ECLK clock so you
> > do not need to separately expose the reset controller. Instead
> > enabling the clock will deassert the rest line for you.
> >
> > This means you should drop the change from the header too, and it
> > affects the bindings document for the video engine.
>=20
> I want that reset available separately for use in the video engine=20
> actually. I could do without it, but it's somewhat useful.
>=20

Joel, are you happy with these patches? I'm tempted to drop these
changes from my queue because there hasn't been any news in over a
month.

