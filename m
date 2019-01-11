Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F490C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D24121783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 22:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547247355;
	bh=PB0VTIOgtTZrCNTtouZNVhY3Guv7LCYJnviGb0J8eqE=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=s4jESfvn2XbDUt6aWyXP9AbVebCD852fYCTYTDbUWybO219TcRRtPISnFPy7zYWrv
	 lgpm4WcUldI/NNrbm/xLm4ssUDu8HM25HUNgdtUIfz4oz6rMYuHHO5rIdyDelK3vqZ
	 NgUhxDCbLbsfXWmncCMxIRX72Rhdu5cEUPTO+6Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfAKWzy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 17:55:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbfAKWzx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 17:55:53 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B754720878;
        Fri, 11 Jan 2019 22:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547247352;
        bh=PB0VTIOgtTZrCNTtouZNVhY3Guv7LCYJnviGb0J8eqE=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=Jeq8tqy3iZaIrNp8iz8ByUzidAadBF8jbaKudspImNLgiIXDh+cFmR6eOEuYojZWB
         SfOKAu7jxteaeIrFCKmLxaiw3J77OSVigSWUgZ0tVy4MWie8OlJY2Ffv9+8xGCPXSx
         8ZZSxlRlFZaVgR5GiR/YbyHGQelQqYPXty3XGXHw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/7] drivers: irqchip: add PDC irqdomain for wakeup capable GPIOs
User-Agent: alot/0.8
In-Reply-To: <20190107184836.GG14960@codeaurora.org>
References: <20181219221105.3004-1-ilina@codeaurora.org> <20181219221105.3004-4-ilina@codeaurora.org> <154533717951.79149.1309452983166815703@swboyd.mtv.corp.google.com> <20190107184836.GG14960@codeaurora.org>
Cc:     evgreen@chromium.org, marc.zyngier@arm.com,
        linux-kernel@vger.kernel.org, rplsssn@codeaurora.org,
        linux-arm-msm@vger.kernel.org, thierry.reding@gmail.com,
        bjorn.andersson@linaro.org
To:     Lina Iyer <ilina@codeaurora.org>
Message-ID: <154724735183.169631.5181161977573120432@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 14:55:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2019-01-07 10:48:36)
> On Thu, Dec 20 2018 at 13:19 -0700, Stephen Boyd wrote:
> >Quoting Lina Iyer (2018-12-19 14:11:01)
>=20
> >> +static const struct pdc_gpio_pin_data sdm845_gpio_data =3D {
> >> +       .size =3D ARRAY_SIZE(sdm845_gpio_pdc_map),
> >> +       .map =3D sdm845_gpio_pdc_map,
> >> +};
> >> +
> >> +const struct of_device_id pdc_gpio_match_table[] =3D {
> >> +       { .compatible =3D "qcom,845-pdc", .data =3D &sdm845_gpio_data =
},
> >
> >Why not qcom,sdm845-pdc?
> >
> The compatible matches the compatible specified in the PDC driver. Not
> sure why the 'sdm' was left out at that time.

Are you going to add sdm?

>=20
> >> +       { },
> >> +};
> >
> >I wonder why we wouldn't just put this all into the qcom-pdc.c file at
> >the bottom and then have that IRQCHIP_DECLARE() macros call small
> >functions that pass the pdc to gpio mapping table to qcom_pdc_init()
> >that takes a third argument?
> >
> We could. I feel we would be adding tables like this and it just
> clutters up the driver file. May be in the future we could move to
> target specific data file like the gpios, but that could be excessive
> too. Thought this might be a compromise. I am open to change.

Ok. The benefit to my approach is that we don't do the string match
twice. We do it once and sacrifice a little code space to jump to the
real init function with the data we want. We can then put those chip
tables inside some #ifdef to save space and allow configurations to turn
off everything in EXPERT mode but leave everything default enabled
otherwise.

>=20
> >I really hope that in the future all the gpios can be wakeup capable so
> >that we don't need to have the table at all!
> >
> I doubt there are plans to support that in hardware. We should plan for
> supporting tables like this for other chipsets based on the PDC
> architecture.
>=20

Uh oh. That's sad.

