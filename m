Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69A6C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E9420834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="apVfSUwK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79E9420834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeLDUsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:48:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbeLDUs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:48:29 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17012081C;
        Tue,  4 Dec 2018 20:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543956509;
        bh=OvBgnq+2LA2p+yjrxYv6kkcxJlY2CrrflOhenOOEWgY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=apVfSUwKhsNa4DY0g0wvy4McqOG68xXVOAt9kZEXBwUUBOjAareqPh09LtKuICbqN
         Cx3O9wd+MWLvk5nXhxvn21OurhSDRsx2RKSq9DeP54DIun/Jxt5aU1T2xM2EdryoER
         zodbzbtiQekhDpef6yVPvijO4kV/mcrkpObTWfH8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <2341ec89691f6221bab6a9696ed0c05c3d3de663.camel@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181204125839.14505-1-narmstrong@baylibre.com>
 <154394543049.88331.11854270462393390489@swboyd.mtv.corp.google.com>
 <5C06D686.50108@baylibre.com>
 <2341ec89691f6221bab6a9696ed0c05c3d3de663.camel@baylibre.com>
Message-ID: <154395650817.88331.14817295166592104160@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: meson-gxbb: switch video clocks mux tables to static
Date:   Tue, 04 Dec 2018 12:48:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2018-12-04 12:05:02)
> On Tue, 2018-12-04 at 20:33 +0100, Neil Armstrong wrote:
> > Le 04/12/2018 18:43, Stephen Boyd a =C3=A9crit :
> > > Quoting Neil Armstrong (2018-12-04 04:58:39)
> > > > @@ -1983,7 +1983,7 @@ static struct clk_fixed_factor gxbb_vclk2_div=
12 =3D
> > > > {
> > > >  };
> > > >  =

> > > >  static u32 mux_table_cts_sel[] =3D { 0, 1, 2, 3, 4, 8, 9, 10, 11, =
12 };
> > > =

> > > I was talking about this mux_table_cts_sel array. Can this be const?
> > > =

> > =

> > Other mux tables aren't const, Jerome so you see a reason why they aren=
't
> > const ?
> =

> I'm surpised we missed that. The PLL params tables of amlogic are all 'st=
atic
> const' but all the mux tables are just 'static' , humm
> =

> [...] 5 min later [...]
> =

> Actually the table field of clk_mux is not const, so giving it a const ta=
ble
> would produce a warning about discarding const qualifier
> =

> I guess there should no problem adding const to the table field of struct
> clk_mux. What do you think Stephen  ?

Yes it would need to be marked const in the struct clk_mux as well. Go
for it to move more things to the RO section.

