Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75BBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 864C8206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 23:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547681394;
	bh=LSR8tEWUlm1kKOaN4dJsZGlE0DROhmLCC3b9XWPNUfQ=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=URTytmzKJrgcb2ROSVpgv1ZKfRR54OEaHz0G5fMDdWxBXT+ekY7pwIpoRcxozCo5x
	 NQfVm9FTE07LMcUwnQ59dv+BJ+41BrN0xY4tszeP6CaDMoB4niG1Pmzd5V6XC7G2fv
	 utMvBdeIA2+c9XHwJbG9yzqWtddVjJh+SciueZEI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfAPX3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 18:29:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:59754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfAPX3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 18:29:49 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D891D206C2;
        Wed, 16 Jan 2019 23:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547681389;
        bh=LSR8tEWUlm1kKOaN4dJsZGlE0DROhmLCC3b9XWPNUfQ=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=mZhePsvBek3QoTJ1qcNEFW1yBSKGz9phWekg2RhNWym+xTDqPVJCTsmh9CCj/5G7X
         7k80nBKoEx/6HzxUmWl9XFMVSR3gAcWjfPr+aXcwBeCrnvGBTZYo+Hl5ZQV0AgFsPk
         Qxv9kDmKY9V978mz7W4HDhU08+oieJHRb/9eIuVg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: mmp2: avoid disabling the SP clock when unused
User-Agent: alot/0.8
In-Reply-To: <73b20a5caef100d5768679cc395168976e86ed04.camel@v3.sk>
References: <20190116093505.1920945-1-lkundrak@v3.sk> <154765664632.169631.9344557684702266461@swboyd.mtv.corp.google.com> <73b20a5caef100d5768679cc395168976e86ed04.camel@v3.sk>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
To:     Lubomir Rintel <lkundrak@v3.sk>,
        Michael Turquette <mturquette@baylibre.com>
Message-ID: <154768138798.169631.18317264971847478148@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 16 Jan 2019 15:29:47 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2019-01-16 09:26:31)
> On Wed, 2019-01-16 at 08:37 -0800, Stephen Boyd wrote:
> > Quoting Lubomir Rintel (2019-01-16 01:35:05)
> > > There could be vital functionality running on the SP PJ1 core it can =
not be
> > > restarted just by turning the clock back on.
> > >=20
> > > On the OLPC laptop, the keyboard controller code runs there. It
> > > wouldn't be possible to load the driver for it as a module if the clo=
ck
> > > is disabled on boot.
> > >=20
> > > Cc: stable@vger.kernel.org # v4.18+
> > > Fixes: commit fc27c2394d96 ("clk: mmp2: add SP clock")
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > > ---
> > >  drivers/clk/mmp/clk-of-mmp2.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/clk/mmp/clk-of-mmp2.c b/drivers/clk/mmp/clk-of-m=
mp2.c
> > > index f2a1c9bbaa63..3e33f1295f59 100644
> > > --- a/drivers/clk/mmp/clk-of-mmp2.c
> > > +++ b/drivers/clk/mmp/clk-of-mmp2.c
> > > @@ -246,7 +246,7 @@ static struct mmp_param_gate_clk apmu_gate_clks[]=
 =3D {
> > >         {MMP2_CLK_CCIC1, "ccic1_clk", "ccic1_mix_clk", CLK_SET_RATE_P=
ARENT, APMU_CCIC1, 0x1b, 0x1b, 0x0, 0, &ccic1_lock},
> > >         {MMP2_CLK_CCIC1_PHY, "ccic1_phy_clk", "ccic1_mix_clk", CLK_SE=
T_RATE_PARENT, APMU_CCIC1, 0x24, 0x24, 0x0, 0, &ccic1_lock},
> > >         {MMP2_CLK_CCIC1_SPHY, "ccic1_sphy_clk", "ccic1_sphy_div", CLK=
_SET_RATE_PARENT, APMU_CCIC1, 0x300, 0x300, 0x0, 0, &ccic1_lock},
> > > -       {MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT, APMU_SP, 0=
x1b, 0x1b, 0x0, 0, &sp_lock},
> > > +       {MMP2_CLK_SP, "sp_clk", NULL, CLK_SET_RATE_PARENT | CLK_IGNOR=
E_UNUSED, APMU_SP, 0x1b, 0x1b, 0x0, 0, &sp_lock},
> >=20
> > Is it a critical clk that should never be turned off?
>=20
> I don't think it is. It is entirely plausible to have no use for the
> "security processor", and in that case it's just okay to keep the clock
> disabled.

So does the firmware/bootloader leave the clk enabled out of boot and we
shouldn't really touch the on/off bits of the clk hardware from the
kernel? Or do we want to actively manage this clk from a driver
somewhere in the kernel?

