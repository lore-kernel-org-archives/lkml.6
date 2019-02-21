Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0447FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FA62083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="YBLfu0jE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfBUQnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:43:45 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:46454 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfBUQno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vQXLBdieBpTD2GOuCk66aWUElR6zPaQeiupK0pPZw8o=; b=YBLfu0jEvyg12mYYunLrvskNW
        QN4TGNYc7cezVSgtriwjM/yzg3q7IQ/QxjR8zmo2b9pEHUh1mBjs5H5VGEqer9QqPcPBw8bozwFfg
        UsSnqGnyh9/N92C9zDHfJqmvGruqtA/vzUq0luL62tQmtc/A8hg/mrrcL9aAlNMSyzOkc=;
Received: from p200300ccfbc7a3007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:fbc7:a300:7ee9:d3ff:fe1f:a246] helo=eeepc.fritz.box)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gwrRh-0002XP-SZ; Thu, 21 Feb 2019 17:43:37 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gwqtz-0004fF-Ea; Thu, 21 Feb 2019 17:08:47 +0100
Date:   Thu, 21 Feb 2019 17:08:40 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>, kishon@ti.com,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        wsa@the-dreams.de, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2] phy: phy-twl4030-usb: fix denied runtime access
Message-ID: <20190221170840.5c970def@kemnade.info>
In-Reply-To: <20190220223132.GV15711@atomide.com>
References: <20180922094405.4067-1-andreas@kemnade.info>
        <20190220223132.GV15711@atomide.com>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/xa./i5MTSts9ASx=BCx8Itv"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xa./i5MTSts9ASx=BCx8Itv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 20 Feb 2019 14:31:32 -0800
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [180922 09:48]:
> > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > the counter will be incremented but the resume callback not called,
> > so enumeration and charging will not start properly.
> > To avoid that happen, disable irq on suspend and recheck on resume.
> >=20
> > Practically this happens when the device is woken up from suspend by
> > plugging in usb.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Changes in v2:
> > * use pm suspend/resume callback instead of delayed_work
> >   as suggested by Dmitry =20
>=20
> Hmm it just occurred to me that this issue too might be fixed with commit
> c6e2bd956936 ("i2c: omap: Use noirq system sleep pm ops to idle device
> for suspend"). Andreas, care to check? That is if this is still an
> issue.
>=20
this one made already its way into 4.20. But for the records, I will
build the latest 5.0-rc and revert it and will check if the problem
still occurs.

I do not think the patch you mentioned has something to do with this
because here solely the problem is about things happen on resume.

But on gta04 we had several irregular behavior regarding to actions
on the other i2c bus where all the sensors and touchscreen are located.
It happens rarely and most often when I am not up to debugging it.
So maybe your patch helps there.

Regards,
Andreas

--Sig_/xa./i5MTSts9ASx=BCx8Itv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAlxuzQkACgkQl4jFM1s/
ye+2/g/+PzYxlaboOKPWnvVCAY6EtXecJFEEydrDdg77y7X92+mxQIZYqTQyoHcT
pwiYgespfie0vCLm4SJgaXq03MJmjlz/HpvVOkz72YSbyEQPnQX5ecKIzA9ys85+
5V5j7h09gBQ0kDte/r7302SjJHrUPC6qkFjJzWMyk9fPyqBufl46rU0SWgQudCKP
oQ3typmDliabNRiPg+oweQoSIsDk0cG3YGY+rLjtMQ+uENlqvyqRDdcBcyGLUNU0
IFMNPyzAP0zaD2raZMkHFIkJT/fF8fhvMLfk/soJXwyFpgsruxrr+GFZ5qbO37Bc
IKFFq36iGF7/oqmd6jx6dBHdG3AqiCJwcKUgu0his6ipF5EdPxYUU1UHvrf3lsWH
oENnwhIKfAYCKBEY3cejrIxyzVk9KDQAC9rajC4dtDzbA6C5fNK0qzaaBxsjxkKp
N0kWy7YxC4+Z5awgcoS2qQSROjjY3jJJzAP3khrA84FtxS/BuF+MrtTuualmGQcN
SRXKN7HOjVENyJdwwAKDGJ5u7ZTA9OvqVP2aG5lHPJxynpyNFzFmn117dqn8Cvl5
Ywbgq8XFMVQKn4wEOaPOvUPuzvXCp8ULmb8t13QduGHTP4Wnsy+KKAe24zXd+Y+R
y7XaWN05EroI86hJeNOVi9TDhwnWciV/nsvO082Qpejxc3gH11g=
=kzqh
-----END PGP SIGNATURE-----

--Sig_/xa./i5MTSts9ASx=BCx8Itv--
