Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F94C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497CE20844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 14:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYKFrK/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfBFOBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 09:01:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54043 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbfBFOBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 09:01:47 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so2593312wmb.3;
        Wed, 06 Feb 2019 06:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wcz2lGJZud6zm1sgSGU4O7NQG80s6W9F7R/lEOETHFE=;
        b=kYKFrK/aKF50BaAS6jzpEXgbIL67PW07wS8OcIHg3rXopEKOmiq0ghc1aecm2o5e8T
         gL8hvj5WOC+73TCqI2MUw1GtXk0xacVDUX1MrjmwGiEsH3LtyBUSe+B9cAZqzj75dfdP
         ifOmm752DBEC/R3gC9ATFmS9yodESTMR5oVdR9O5KoHCQaWZVQd8F94gOQt1j0zJ3IAj
         wVZXEaCTxojvuD4vm4zXXl5NKqvvwnYA/fGkhUIAJbOBzGGGalZadyicBurxPPu2QiNu
         LwaBUxFFc25GN+9NPCH2iIYJvdiTk2f3m/4t2NOMDMEfOiUv/ZtyTK4skdJCmDhfvDmz
         PbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wcz2lGJZud6zm1sgSGU4O7NQG80s6W9F7R/lEOETHFE=;
        b=kthvd5jrE9fxTkKYlWBg0jjlkiUHaqXlYyjrF6XgS0rixbA6NtgNszPnEfvfI0emKf
         pCUd6WooWHJb2hgeNqWF30wP/4gT5LFxMgRDc2gN/qL4ch14Jr9RpsZbi7BGFHdc+Wk9
         lQaUPHkN0la0GJtG++SCo7u3CkPjQVY60rs/dqyssvQVzlVQbJ3kouiIyhXOnaFIhzby
         2zrMrFOjqo0jJeLLHHbdIy4p42gcXenjh3020D6vcxsRkjITVR07A/LOdgm3+VkSDofA
         6NJCybnbIV1iFmvFOifoPydBvKfXWLbhvyDsjTnFl3Wc9n/Fm5KpEWZpV0mHx+xNJggd
         /CBQ==
X-Gm-Message-State: AHQUAuZ3+YB42cV7iKy1sAMsposr1D0+87AG7Q9FOg7GyWdmsm/1wGqt
        oN0IWDvU6KFuHzkLTU3XEhk=
X-Google-Smtp-Source: AHgI3IYLhdLv9SoVSOxJfzViDGVT7zlYBFlGBRnE4pbf8WM47qso3CEEvYQ89nfDFjtIqqgfHuj7+Q==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr3192374wmj.48.1549461703862;
        Wed, 06 Feb 2019 06:01:43 -0800 (PST)
Received: from localhost (pD9E51040.dip0.t-ipconnect.de. [217.229.16.64])
        by smtp.gmail.com with ESMTPSA id b18sm21816394wrw.83.2019.02.06.06.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 06:01:42 -0800 (PST)
Date:   Wed, 6 Feb 2019 15:01:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        Shardar Mohammed <smohammed@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH V12 3/5] i2c: tegra: Add DMA support
Message-ID: <20190206140141.GO21676@ulmo>
References: <1549406769-27544-1-git-send-email-skomatineni@nvidia.com>
 <1549406769-27544-3-git-send-email-skomatineni@nvidia.com>
 <85b77477-3175-0501-8753-f39d3b60538e@gmail.com>
 <20190206130909.GJ21676@ulmo>
 <20190206131310.GK21676@ulmo>
 <d16dd60a-bfb4-75e8-3d19-97b565c815b0@gmail.com>
 <BYAPR12MB33983A0E93B17808DECFD0F2C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <6edef92d-66a7-0f70-e59e-7381b82516eb@gmail.com>
 <BYAPR12MB339826EB972C5DB7957E8A82C26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
 <BYAPR12MB33989329D0E0C0049F1DEA6EC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QRo3kt64Wi40AlcO"
Content-Disposition: inline
In-Reply-To: <BYAPR12MB33989329D0E0C0049F1DEA6EC26F0@BYAPR12MB3398.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QRo3kt64Wi40AlcO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 01:51:12PM +0000, Sowjanya Komatineni wrote:
>=20
> > >>>> That's odd because it suggests that DMA actually completed, but=20
> > >>>> the message didn't.
> > >>>>
> > >>>> I'm not sure I understand how that could happen.
> > >>>>
> > >>>> What's also weird above is that there doesn't seem to be a DMA=20
> > >>>> that is started for that particular message. Or is the timeout=20
> > >>>> message a response to the prior transfer (length 10)? Seems like=
=20
> > >>>> that should not be possible because we get the "transfer complete"=
 message.
> > >>>
> > >>> Wait, those are actually different instances of the I2C=20
> > >>> controller, so the relevant log entries are these:
> > >>>
> > >>> 	[    0.945445] tegra-i2c 7000d000.i2c: starting DMA for length: 16
> > >>> 	[    0.945456] tegra-i2c 7000d000.i2c: unmasked irq: 0c
> > >>> 	...
> > >>> 	[    1.049224] tegra-i2c 7000d000.i2c: i2c transfer timed out
> > >>>
> > >>> And these don't happen if you use higher burst sizes or before the=
=20
> > >>> DMA series?
> > >>
> > >> I tried to enforce DMA without changing bursts:
> > >>
> > >> ----------
> > >> diff --git a/drivers/i2c/busses/i2c-tegra.c=20
> > >> b/drivers/i2c/busses/i2c-tegra.c index c538ed5f8e2c..5d1c54ce7800
> > >> 100644
> > >> --- a/drivers/i2c/busses/i2c-tegra.c
> > >> +++ b/drivers/i2c/busses/i2c-tegra.c
> > >> @@ -6,6 +6,8 @@
> > >>   * Author: Colin Cross <ccross@android.com>
> > >>   */
> > >> =20
> > >> +#define DEBUG
> > >> +
> > >>  #include <linux/clk.h>
> > >>  #include <linux/delay.h>
> > >>  #include <linux/dmaengine.h>
> > >> @@ -1046,8 +1048,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c=
_dev *i2c_dev,
> > >>                 xfer_size =3D msg->len + I2C_PACKET_HEADER_SIZE;
> > >> =20
> > >>         xfer_size =3D ALIGN(xfer_size, BYTES_PER_FIFO_WORD);
> > >> -       i2c_dev->is_curr_dma_xfer =3D (xfer_size > I2C_PIO_MODE_MAX_=
LEN) &&
> > >> -                                   i2c_dev->dma_buf;
> > >> +       i2c_dev->is_curr_dma_xfer =3D !!i2c_dev->dma_buf;
> > >>         tegra_i2c_config_fifo_trig(i2c_dev, xfer_size);
> > >>         dma =3D i2c_dev->is_curr_dma_xfer;
> > >> ----------
> > >>
> > >> Here is the log with this change:
> > >>
> > >> [    0.760796] tegra_rtc 7000e000.rtc: registered as rtc1
> > >> [    0.760850] tegra_rtc 7000e000.rtc: Tegra internal Real Time Clock
> > >> [    0.761050] i2c /dev entries driver
> > >> [    0.918928] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> > >> [    0.918940] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    0.919040] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> > >> [    0.919050] tegra-i2c 7000c000.i2c: starting DMA for length: 8
> > >> [    0.919059] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    0.919322] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> > >> [    0.919335] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> > >> [    0.919343] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    0.919440] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> > >> [    0.919448] tegra-i2c 7000c000.i2c: starting DMA for length: 112
> > >> [    0.919456] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    0.922818] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> > >> [    0.922829] atmel_mxt_ts 0-004c: Family: 160 Variant: 0 Firmware =
V1.0.AA Objects: 18
> > >> [    0.922886] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> > >> [    0.922895] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    0.922993] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> > >> [    0.923002] tegra-i2c 7000c000.i2c: starting DMA for length: 224
> > >> [    0.923011] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    0.933253] tegra-i2c 7000c000.i2c: transfer complete: 11 0 0
> > >> [    0.933287] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> > >> [    0.933297] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    0.933478] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> > >> [    0.933487] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> > >> [    0.933496] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    0.945120] tegra-i2c 7000d000.i2c: starting DMA for length: 16
> > >> [    0.945130] tegra-i2c 7000d000.i2c: unmasked irq: 0c
> > >> [    1.038917] tegra-i2c 7000c000.i2c: DMA transfer timeout
> > >> [    1.038982] atmel_mxt_ts 0-004c: __mxt_read_reg: i2c transfer fai=
led (-110)
> > >> [    1.039000] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> > >> [    1.039006] atmel_mxt_ts 0-004c: Failed to read T44 and T5 (-110)
>=20
>=20
>=20
> > >> [    1.039009] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    1.039148] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> > >> [    1.039157] tegra-i2c 7000c000.i2c: starting DMA for length: 4
> > >> [    1.039166] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    1.039304] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> > >> [    1.039340] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> > >> [    1.039349] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    1.039535] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> > >> [    1.039544] tegra-i2c 7000c000.i2c: starting DMA for length: 12
> > >> [    1.039552] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    1.040055] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> > >> [    1.040083] tegra-i2c 7000c000.i2c: starting DMA for length: 16
> > >> [    1.040092] tegra-i2c 7000c000.i2c: unmasked irq: 0c
> > >> [    1.040301] tegra-i2c 7000c000.i2c: transfer complete: 10 0 0
> > >> [    1.048934] tegra-i2c 7000d000.i2c: i2c transfer timed out
> > >=20
> > > This log shows DMA transfer timeout for atmel read.
> > > Do you see issue if you don=E2=80=99t enforce dma all time and let it=
 choose PIO Vs DMA?
> > >=20
> >=20
> > No, there are no timeout errors in PIO mode. I could post full log with=
 the PIO-only mode if you want.
> >
> Yes please post full log of PIO only and DMA only
> Also, in above log, lots of DMA transfer went thru fine except this
> one transfer where DMA timed out.
> DMA completion doesnt happen on DMA submit during this particular
> transaction timeframe for some reason.

Dmitry, can you provide some background information on the setup that
you're using? I vaguely remember something about i2c@7000d000 being
special on older Tegra devices. Perhaps there's something additional
that we need to take into account?

Aha! Look at tegra_i2c_reg_addr() which special-cases I2C_TX_FIFO on
the DVC variant of the controller, which is exactly the one that you
are seeing the timeouts on and it's exactly the register that we use
as destination for the DMA transfer.

I think we need to do something like this:

	slv_config.dst_addr =3D i2c_dev->base_phys + tegra_i2c_reg_addr(i2c_dev, I=
2C_TX_FIFO);

to make sure we pass the right FIFO register address to DMA.

Thierry

--QRo3kt64Wi40AlcO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlxa6MIACgkQ3SOs138+
s6GfARAAutmdp6kHFE0/MnHIachlUMYBkEEvxVNZifDpBwXz8aSkFhC8NRHB66p7
exsR3xKGhg/N0LyTjocrjbLrSnUVKuFjcmQjd2CYABcvdTs9TmO+3fXAI/X40ktt
a5EwE1c0J0UFqdlV1H1WMadJqqqYNLlCyaeB2ZQVqDDjJxVrN2M2rUapAZrhTLKc
DpX/OHv3CkaD958CnsV0xjZcoROIcpNhT0Jxn6JZ/QbaSpMy+4R0T7Q66TDpLIgL
rYS2SYfhZQdSxEhexzKTZyYyCavxuB59HXeYm6TDyE/c5k4sxEiAySpJ9lF2M6/t
nLykJ4z7CWbMLazs3lBmqJ3KSaEAUW0TC/jK3NFPrYOrgPHWGy6IVDSsL90lA+sj
X0q/Wpk6gCL8l7DAjK+BPC83DEBYMhbWLS0OEqc9/NDSgNv8lGpte9vLiczM26m3
DnV2noOD+KwVMI66VfIdB/164WJKEC0jnCcBZ269gPfmktkKJtK3cy9HzlrUSKv5
bAKj276Fgksd2D6eiRcmpVhwZcObu7zSfWT5CHfC59TPk8TAlNv3VY4wh5FWJuDo
WFo+5hWkLtiBabG76plxPV9qv3KOu2SjysFewa6jil2K5b8A6q8DkLGaUKxH9ftr
XTUjIjXJZs0WSlKQNP868IggoCCXDiz+7zhPj7e+hvsstwVwDDM=
=jIyr
-----END PGP SIGNATURE-----

--QRo3kt64Wi40AlcO--
