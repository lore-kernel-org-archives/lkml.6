Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A37AC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD9EC262D4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="tBVabdZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD9EC262D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933904AbeFYXq1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:46:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932249AbeFYXqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:46:25 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C109262D3;
        Mon, 25 Jun 2018 23:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529970385;
        bh=IApJM56opbXGllbkdJHlyxcSdyPgHuuMYaTJBbgXw8k=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=tBVabdZ1hzYIag9GWnpNk14giQsVKBNi6su3QlTPx+5u3b+362/xFzO5X/Jyc+/WM
         rhSJTEuAwSeiRv5W/Mvjwn4Shhlbwq0dA9F3+cQg1FKHfHt/dO0b2QPds655zp6Hxl
         LPGpybGKtirBIuyvHWcfrKnTut3w9bVEFGsRSv9M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Matti Vaittinen <mazziesaccount@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180613130338.GH20078@localhost.localdomain>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        broonie@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
 <20180612082354.GG20078@localhost.localdomain>
 <20180613130338.GH20078@localhost.localdomain>
Message-ID: <152997038474.143105.3390705878521933864@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Date:   Mon, 25 Jun 2018 16:46:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-06-13 06:03:38)
> On Tue, Jun 12, 2018 at 11:23:54AM +0300, Matti Vaittinen wrote:
> > =

> > I see. This makes sense. I need to verify from HW colleagues whether
> > this chip has internal oscillator or not. I originally thought we have
> > on-chip oscillator - but as you say, we do have XIN pin in documentatio=
n.
> > So now I am not sure if the test board I have contains oscillator drivi=
ng
> > the clk on PMIC - or if the PMIC has internal oscillator. I'll clarify =
this.
> =

> It really turned out that the PMIC just acts as a clock buffer. So I do
> as you suggested and add lookup for parent clock to the driver. I
> planned to do it so that if no parent is found from DT - then we assume
> the 32.768KHz clock (as described in documentation). Eg, something along
> the lines:
> =

>         init.parent_names =3D of_clk_get_parent_name(pdev->dev.parent->of=
_node, 0);
>         if (init.parent_names) {
>                 init.num_parents =3D 1;
>         } else {
>                 /* If parent is not given from DT we assume the typical u=
se-case with
>                  * 32.768 KHz oscillator for RTC (Maybe we could just err=
or out here?)
>                  */
>                 c->rate =3D BD71837_CLK_RATE;
>                 bd71837_clk_ops.recalc_rate =3D &bd71837_clk_recalc_rate;
>         }

You can also add a clk directly in this driver in that case there isn't
one in DT with the rate and name of your choosing. Then the logic is the
same and we don't need a c->rate variable.

