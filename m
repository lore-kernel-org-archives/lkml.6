Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F2ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE3E214DD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="hJOFE9c4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FE3E214DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeIRAZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 20:25:40 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:41876 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeIRAZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 20:25:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HFkPIiS3GJ6HInmMVUsTkdcwicZMxBQKnnzDZF2/Qq0=; b=hJOFE9c4g2xtyE0UBiDeCMIe+
        uk+4TFXt3ur9UCvffioZnMqAUav3E30uO97rwS1l8UDjnQAYitQFZTOT2mox2Lx+e9+Mkw58m/KUA
        JJ0AlEB8a38iz1VjD3nJEa8MTmwY01ETL32h674P1T96MX6IHbw11HHYl+quKmVCT1qMM=;
Received: from pd9e2f8fa.dip0.t-ipconnect.de ([217.226.248.250] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g1yhe-0007yO-7i; Mon, 17 Sep 2018 20:56:58 +0200
Date:   Mon, 17 Sep 2018 20:56:34 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kishon@ti.com, lee.jones@linaro.org, daniel.thompson@linaro.org,
        wsa@the-dreams.de, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH RESEND] phy: phy-twl4030-usb: fix denied runtime access
Message-ID: <20180917205634.6a320cad@aktux>
In-Reply-To: <20180917175131.GA104770@dtor-ws>
References: <20180917052254.12336-1-andreas@kemnade.info>
        <20180917175131.GA104770@dtor-ws>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/_BaF6VuUb2T=xBhucJeMtCQ"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_BaF6VuUb2T=xBhucJeMtCQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Mon, 17 Sep 2018 10:51:31 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Andreas,
>=20
> On Mon, Sep 17, 2018 at 07:22:54AM +0200, Andreas Kemnade wrote:
> > When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
> > the counter will be incremented but the resume callback not called,
> > so enumeration and charging will not start properly.
> > To avoid that happen, wait and try again later.
> >=20
> > Practically this happens when the device is woken up from suspend by
> > plugging in usb.
> >=20
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >  drivers/phy/ti/phy-twl4030-usb.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4=
030-usb.c
> > index a44680d64f9b..1f3cf4e48383 100644
> > --- a/drivers/phy/ti/phy-twl4030-usb.c
> > +++ b/drivers/phy/ti/phy-twl4030-usb.c
> > @@ -552,6 +552,15 @@ static irqreturn_t twl4030_usb_irq(int irq, void *=
_twl)
> > =20
> >  	status =3D twl4030_usb_linkstat(twl);
> > =20
> > +	/* we might get here too early when runtime is not ready yet
> > +	 * and we will get an EACCESS later, so try again later
> > +	 */ =20
>=20
> How exactly can this happen? What disables (and later re-enables)
> runtime PM?=20
If the whole resume process is started by plugging in usb, the
interrupt will be triggered still in the resume process so that=20
runtime resume is not yet possible, pm_runtime_get_sync() returns
EACCESS

> How can we guarantee that the interrupt will be
> re-triggered?
>=20
The interrupt will not be re-triggered but the handler will be
called at some other places...

> > +	if (!pm_runtime_enabled(twl->dev)) {
> > +		cancel_delayed_work(&twl->id_workaround_work);
> > +		schedule_delayed_work(&twl->id_workaround_work, HZ);
> > +		return IRQ_HANDLED;
> > +	}
> > +
... for example by this delayed work which is already there.

Regards,
Andreas

--Sig_/_BaF6VuUb2T=xBhucJeMtCQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE7sDbhY5mwNpwYgrAfb1qx03ikyQFAluf+OIACgkQfb1qx03i
kyRQxRAAp2oiba12dAqVJ0koPsr4bVmUmFxie9a7uIHvqLPGYyWKqcjqhQ26BX/d
+SjniI1RzTuybPRP4+lp/cvl96BHVRJmSj4yMku+oE42BC4JcIX1+v3uTif9oNZ7
io2vF/U/q1cVMLL0NCYLBBIL8K3d51SIBAeHdzD2jGWCcbTlly1zyUR/f15NdKlp
5DJDLcfbLFWpl5zZPac3aKz51ZR6fmqCeKqDdY6vrH1TRXOJpGLiZbtCsO0oGzGj
44wfo0g0FMOiaQ676HLlc49VFJzvArmWI0Q3EPdiyYA9fLbLq7mQwHtGF7FPNf3F
LjShqq0VKYR4QCzTt7qF2Lw8OiVwz7PtRn8j4etwd4czdQS6MKztFZxsilN2qzi3
GekY8iqQYqYqVPXSA25zhkSirEnWIbY6xwMkRJwQu7axfff3Y851rR3jl3M/Ef+y
GEnkCXJIUKenOtZl5T9bqep22FBcq2YO6mHdBIjuK6tW+bYJt5yVmfyBp5lPHMd4
HmwekF2e+XkJhcw8SJ4ELjGQbI+PQ4W4qo8Aqc2wjxXnL55tELpGSlcB53y3JLog
MTNcoB6D837mjjd5NO4lZRTZSp8BfQcDh8jM4DEb9/cpnHon0h+zW/4DRyjjeyE5
rdaMm1RkBPhwIAR0vvGtUYlxCot6QNycF+Lx8xIzIYJFEv4gXi4=
=l+nW
-----END PGP SIGNATURE-----

--Sig_/_BaF6VuUb2T=xBhucJeMtCQ--
