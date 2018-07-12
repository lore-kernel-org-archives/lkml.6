Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39DAECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4926208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4926208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732405AbeGLWPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:15:00 -0400
Received: from sauhun.de ([88.99.104.3]:60256 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbeGLWPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:15:00 -0400
Received: from localhost (p5486CFAA.dip0.t-ipconnect.de [84.134.207.170])
        by pokefinder.org (Postfix) with ESMTPSA id C7030574842;
        Fri, 13 Jul 2018 00:03:25 +0200 (CEST)
Date:   Fri, 13 Jul 2018 00:03:25 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Evan Green <evgreen@chromium.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, dianders@chromium.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Fix suspend clock handling
Message-ID: <20180712220325.y42t5pheifzub6m7@ninjato>
References: <20180709234937.176154-1-evgreen@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="idfaxadab3uz5vqy"
Content-Disposition: inline
In-Reply-To: <20180709234937.176154-1-evgreen@chromium.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--idfaxadab3uz5vqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 09, 2018 at 04:49:37PM -0700, Evan Green wrote:
> pm_runtime_suspended can return 0 even if the last runtime power
> management function called in the device was a suspend call. This
> trips up the i2c-qcom-geni's suspend_noirq accounting, which was
> trying to use the function to determine if it should disable clocks
> or if that had already been done.
>=20
> The fix is to track whether or not clocks have been enabled explicitly
> in the driver with a new member. While in there, also honor the return
> value of geni_se_resources_off, which can technically fail.
>=20
> An example of the warning generated during suspend:
> [   68.314733] WARNING: CPU: 0 PID: 1990 at drivers/clk/clk.c:595 clk_cor=
e_disable+0x28/0x200
> [   68.464576] Call trace:
> [   68.554410] [<ffffff80083f0ed0>] clk_core_disable+0x28/0x200
> [   68.560244] [<ffffff80083f349c>] clk_disable+0x38/0x4c
> [   68.565541] [<ffffff8008408910>] geni_se_resources_off+0x40/0x74
> [   68.571731] [<ffffff800862aadc>] geni_i2c_runtime_suspend+0x2c/0x3c
> [   68.578185] [<ffffff800862ae6c>] geni_i2c_suspend_noirq+0x38/0x68
> [   68.584475] [<ffffff800852bd40>] dpm_run_callback+0x104/0x210
> [   68.590404] [<ffffff800852c3d4>] __device_suspend_noirq+0x158/0x1a8
> [   68.596859] [<ffffff800852dff0>] dpm_noirq_suspend_devices+0x180/0x38c
> [   68.603594] [<ffffff80080fdebc>] suspend_devices_and_enter+0x49c/0x964
> [   68.610321] [<ffffff80080fea14>] pm_suspend+0x690/0x6e0
> [   68.615712] [<ffffff80080fc930>] state_store+0xd4/0xf8
> [   68.621014] [<ffffff80088a57f0>] kobj_attr_store+0x18/0x28
> [   68.626672] [<ffffff8008297a54>] sysfs_kf_write+0x5c/0x68
> [   68.632240] [<ffffff8008296a00>] kernfs_fop_write+0x174/0x1b8
> [   68.638177] [<ffffff800821a2c4>] __vfs_write+0x58/0x160
> [   68.643567] [<ffffff800821a5d8>] vfs_write+0xcc/0x184
> [   68.648780] [<ffffff800821a850>] SyS_write+0x64/0xb4
>=20
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> This change applies atop Karthik's patch [1], which as far as I can tell
> technically hasn't landed yet, but also hasn't had feedback in awhile
> either. I opted to submit this as a separate patch, but if the maintainers
> prefer it's fine with me if this get folded in to another spin of the
> base series.
>=20
> [1] https://patchwork.kernel.org/patch/10460819/

Yeah, since the FSI driver seems to be mostly done now, this will be the
next new driver I will have a look at.

If the maintainers of the driver ack or rev this patch, I would then
just fold it into the driver itself when I apply it?

D'accord everyone?


--idfaxadab3uz5vqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltH0CkACgkQFA3kzBSg
KbaVCQ/+OsfMSLp8VGeuD+yB7FloWiAo08IeXuPfri/Hc5yCNmFRGbLYMKfy1Ssj
7XKLnJUU59A4E1vtBGuurch5i/HlOlN3XwVLaTV1abwB574xX6sRbULnHhkA83AW
VkT81yVZPXZ+KPdMyY6j7NFmWaWCfjVe3Sz47pHDbvVgMUVJbRHb0QKa7BGIxN6d
hEBl7f/74yCYMbXWlzkE1BRnfFxqewYc/HyO9uxF3oLNoslWcxbsSKGjuKo+xata
s42hyr7YTohOuoBzR2zNkiEnXoNHtEz3Y2DWT+CgaRpmzBKgkvoS6zwGDdX2t/JO
A4BDG3VYtU8/opOWFwfIGAdbhnxk6kduWNV9xKu07unq7BQVq0IvjgOoZ2F2CoHI
3ZTh2Z0XRJJR9cxOKsjz8mNbkc9g9yTwiZORVQ1SezVIxCAtdcvQZhWewi9ZUbSd
sNx4hp/9Qp5JxDRz8hH/PQ/GdGFlRHLyNM2khXmqOGF7GjK92+/etuc5iekpjiWW
xLMKAEtH2cP5IwXW2jeDNWcenfX6VQcoD8egykAnQE9wrirsu76mErUEqZyQbK7V
JWZ4pGAbr16CRL+enQVxWsml+2Xtpf5/YWOl7pN47dQIBMtdTXrBdLQtYO35TIFY
BewjSgBAaZkwv4T+WbkoU+swC4FhIBx6LRzP0x5pfVxhay8H2fk=
=Hvt8
-----END PGP SIGNATURE-----

--idfaxadab3uz5vqy--
