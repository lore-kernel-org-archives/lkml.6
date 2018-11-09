Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C434C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D9882086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9882086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeKJBpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 20:45:46 -0500
Received: from sauhun.de ([88.99.104.3]:46340 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbeKJBpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 20:45:46 -0500
Received: from localhost (p54B3380A.dip0.t-ipconnect.de [84.179.56.10])
        by pokefinder.org (Postfix) with ESMTPSA id 3AD753E4482;
        Fri,  9 Nov 2018 17:04:33 +0100 (CET)
Date:   Fri, 9 Nov 2018 17:04:32 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Alok Chauhan <alokc@codeaurora.org>
Subject: Re: [PATCH v2] i2c: i2c-qcom-geni: Fix runtime PM mismatch with
 child devices
Message-ID: <20181109160432.GI1031@kunai>
References: <20181102205732.116851-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4LwthZj+AV2mq5CX"
Content-Disposition: inline
In-Reply-To: <20181102205732.116851-1-swboyd@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4LwthZj+AV2mq5CX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2018 at 01:57:32PM -0700, Stephen Boyd wrote:
> We need to enable runtime PM on this i2c controller before populating
> child devices with i2c_add_adapter(). Otherwise, if a child device uses
> runtime PM and stays runtime PM enabled we'll get the following warning
> at boot.
>=20
>  Enabling runtime PM for inactive device (a98000.i2c) with active children
>  WARNING: CPU: 4 PID: 1 at drivers/base/power/runtime.c:1300 pm_runtime_e=
nable+0xd8/0xf8
>  Modules linked in:
>  CPU: 4 PID: 1 Comm: swapper/0 Not tainted 4.19.0 #6
>  elants_i2c 14-0010: 14-0010 supply vccio not found, using dummy regulator
>  pstate: 60c00089 (nZCv daIf +PAN +UAO)
>  pc : pm_runtime_enable+0xd8/0xf8
>  lr : pm_runtime_enable+0xd8/0xf8
>  sp : ffffffc0de257a30
>  x29: ffffffc0de257a30 x28: 0000000000061a80
>  x27: ffffff9008ea7118
>  x26: ffffffc0d718b058
>  x25: ffffff9008ea7000 x24: ffffffc0d718a8dc
>  x23: ffffffc0d718a8b0 x22: ffffffc0d823dd58
>  x21: 0000000000000000 x20: ffffffc0d823dbc8
>  x19: ffffffc0d823da90 x18: 000000007f743d9a
>  x17: 0000000000000080 x16: 0000000000000003
>  x15: 000000000000003f x14: 0720072007200720
>  x13: 0720072007200720 x12: 0720072007200720
>  x11: 0720072007200720 x10: 0720072007200720
>  x9 : 0720072007200720 x8 : 0720072007200720
>  x7 : ffffff900816da30 x6 : 0000000000000000
>  x5 : 0000000000000080 x4 : 0000000000000003
>  x3 : ffffff900816f304 x2 : ffffffc0de248050
>  x1 : 25045a74f48a7400 x0 : 25045a74f48a7400
>  Call trace:
>   pm_runtime_enable+0xd8/0xf8
>   geni_i2c_probe+0x440/0x460
>   platform_drv_probe+0x74/0xc8
>   really_probe+0x1ac/0x35c
>   driver_probe_device+0xd4/0x118
>   __driver_attach+0xc8/0x118
>   bus_for_each_dev+0xac/0xe8
>   driver_attach+0x38/0x44
>   bus_add_driver+0x15c/0x294
>   driver_register+0x13c/0x198
>   __platform_driver_register+0x88/0x94
>   geni_i2c_driver_init+0x20/0x28
>   do_one_initcall+0x250/0x4ec
>   kernel_init_freeable+0x6f0/0x7c4
>   kernel_init+0x18/0x120
>   ret_from_fork+0x10/0x18
>=20
> Let's move the runtime PM enabling and setup to before we add the
> adapter, so that this device can respond to runtime PM requests from
> children.
>=20
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm=
 GENI I2C controller")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Applied to for-current, thanks!


--4LwthZj+AV2mq5CX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlvlsBAACgkQFA3kzBSg
KbbEaw/5Afvgtkdph1ZdQUggzxqrOSr2UJqPn3Da3LX62IuONadcoe8LeAp44srL
juH1PqXRyZtC7GTmDO07afrY/A+PgFHkIloYOCB/OPv+7WQ+H5aXZuB8qXD9Wl+r
Og76JAUT7/UxAzIUZqNrDkF40i87V7Fh7fuRTIZXF8gl0XWpU5WZSZtAv5rR++Ug
UDncWYzr1QFVIDZg89LW8+jwud368XD8Sx59a19KQ3pBhEqnsJMLnwghO1/4wI/W
xBfsXuEHoLUFywiQTYY2UMqlGZ+Os0a+lQzQ+1JYQTvtk2lxdtQPd+K2j7HwZ9NL
wDIgQWdTJiSSA2Le9YVBhncMrh4lmO7DCV7msAtm/gHGCLFSzITBW9Z7E/xDPpjN
huKuwVbJv0MMYpftWYG7G/YcpSniPi8IEVaZGehS8zpL2NJaZ930Tt4T2FsZ4bpc
GlKA+YA7sPb/n30yfyRPnqOnznBbAlqFXsKcCiSCVyJJqeCW9hgitM6npvhMEaqm
5z9uppIfEnvEG2KHQEQwONLYIeue3ZHnabka95KWolPXsMD7LETEM8fbUFzAbcnY
kndSKU7CEikSlYo2BM3lTAwNGtobAnncIu/Y9Vgleb2hR0k+JtjtzsJmN7kM92aA
hbAMypRhUHWuQsxUawmbQAKHuWOWO+WeNM2k3BdE5AB1Duni36E=
=yLFI
-----END PGP SIGNATURE-----

--4LwthZj+AV2mq5CX--
