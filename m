Return-Path: <maxime.ripard@bootlin.com>
X-Google-Smtp-Source: AIpwx49wbt7HhdzPcwPoeH5hajztmg/1RhFmFG3NMA3tBDuvbyhv1zhOh8nTs4Awfb5BLwc6I3FA
ARC-Seal: i=1; a=rsa-sha256; t=1522747751; cv=none;
        d=google.com; s=arc-20160816;
        b=nKMz0V/q1r0EZ53pm/hGoLJksR/VoBfcOFM1luwxUIYLR1h5JV03Lfl6DC7G46aFN6
         uL44T0Cxs4RqEzlf66Ng4Iy9MlfOe3rMi+qnQyZFrH5D8EWr0EsdEpwVpeuWYBgDwquP
         pH8U4UdBkl+Fj83bOREpR9SjUbFOoy0X5drhbrXdr5fGV3c66XvcANdY8/XwMkBZVlnA
         vxzvuNdLOJ70a6QVSD7uuljCe5DFoTkQ3Utl5L+jIs8o0i4bePmtG55YXbAf8QSkAWf2
         dEw6hWFvqlh3QuVgFMzfJYILcRUGFAxIwYe8w8hosBkF0Rh8DFXWNgXXQj8QLr4+BCAa
         MyJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=VBU0+VpDLvPquDGTXA9ViYN4U+/NTmlBGDcZXMqQ7U4=;
        b=0pG5zLpXiaocVw9LiQPJTuXSdRJPwag/xDmJPuZhxHC3FReKuF07/TU+MJ3pA7dJck
         fGlcMi03I1A7pj5ok+3+y1k8PVtBuURcpmhC9nKNbVWC7zw8oqIOfSFh7vw+WszF9+vR
         vxQv4ejV09wXCpgu7hKunxIfwThB4+lkSudZCX42X595ThjnM8bPop4rN1SX9JDqTkLm
         g/USPEbXNGIaSDUR4PBoT/wWd+9ym96/aZq/MdJEGWbha4NRgCbu8r/E+W35uBCg5sb5
         fd4e2q5AqoPPHYFUIDhA02MIoDMyKfWvyJxCQ2JaVmMv228lKcqz/b+rVqGHy6im+zgD
         zccA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of maxime.ripard@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=maxime.ripard@bootlin.com
Date: Tue, 3 Apr 2018 11:29:10 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bin Liu <b-liu@ti.com>, Chen-Yu Tsai <wens@csie.org>,
	Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH] usb: musb: Support gadget mode when the port is set to
 dual role
Message-ID: <20180403092910.wcgjn3r4job5y5pb@flea>
References: <20180328215213.29538-1-contact@paulk.fr>
 <20180329092326.dayuccomq5zrywqo@flea>
 <1522324644.1746.19.camel@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lilkrb6lwbhrider"
Content-Disposition: inline
In-Reply-To: <1522324644.1746.19.camel@bootlin.com>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596219936239404188?=
X-GMAIL-MSGID: =?utf-8?q?1596716746176385459?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--lilkrb6lwbhrider
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 29, 2018 at 01:57:24PM +0200, Paul Kocialkowski wrote:
> On Thu, 2018-03-29 at 11:23 +0200, Maxime Ripard wrote:
> > On Wed, Mar 28, 2018 at 11:52:13PM +0200, Paul Kocialkowski wrote:
> > > This allows dual-role ports to be reported as having gadget mode by
> > > the
> > > musb_has_gadget helper. This is required to enable MUSB at all with
> > > MUSB
> > > glue layers that set the port mode to MUSB_PORT_MODE_DUAL_ROLE at
> > > init.
> > >=20
> > > Most notably, this allows calling musb_start when needed in the
> > > virtual
> > > MUSB root HUB, regardless of whether the current mode should be
> > > gadget
> > > or host.
> > >=20
> > > This fixes USB OTG on Allwinner devices that I could test it with,
> > > mainly A20 devices.
> > >=20
> > > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> >=20
> > Surely there's more to it than that. The gadget mode of A20 boards
> > have been working in the past, including when compiling with mUSB
> > setup as dual role.
> >
> > Is this a regression since a particular commit? Or is there another,
> > deeper issue overlooked in the commit log?
>=20
> The root of the issue here is that musb_start is not called at any point
> without this patch. My understanding of the flow is the following: when
> the PHY detects that there was a VBUS/ID change, it will notify its
> listeners (mainly the musb sunxi glue layer). This will then schedule
> the driver's work (sunxi_musb_work), which does nothing since the
> SUNXI_MUSB_FL_ENABLED bit was never set. This bit is only set after
> calling sunxi_musb_enable, which is called from musb_platform_enable,
> that originates from musb_start.
>=20
> Currently I see two places where musb_start is called:
> * musb_virthub
> * musb_gadget
>=20
> In the latter case, it is in turn called from udc_start, which should
> probably (correct me if I'm wrong) happen later in the call chain than
> ID/VBUS change notification time.
>=20
> In the former case, musb_start is called in the root controller hub
> control, when setting the USB_PORT_FEAT_POWER feature. This looks
> perfectly legit and IMO this is where it should be initially calling
> musb_start in the dual role case. The kernel is indeed setting the
> feature, only that it fails to enable musb without this patch.
>=20
> First, I'd like to make sure that this understanding of the flow is
> correct as I may have missed something here. Does it make sense?
>=20
> Then, it seems that the offending commit is: be9d39881fc4f
> ("usb: musb: host: rely on port_mode to call musb_start()")
>=20
> That itself fixed: ae44df2e21b5
> ("usb: musb: call musb_start() only once in OTG mode")
>=20
> Still, this commit was authored in June 2015, so almost 3 years ago.
> In the meantime, the sunxi driver has received feature improvements, so
> it seems hard to believe that it was broken all this time...

I'm not that knowlegdeable about the musb driver, so I can't really
comment on whether what you're saying actually makes sense, but from
what you seem to say, the issue is just happening upon VBUS / ID
notification.

Have you tested without the role switching? For example, trying to
boot while acting as a gadget?

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--lilkrb6lwbhrider
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrDSWUACgkQ0rTAlCFN
r3Q7gQ/7BJcMNegJMeP1qSFmHp2FLfHsrsmzQHx+1O4ilLEDIogfSCo1N1w+6lJY
B7soUSFhAVTgB3X8MulnfGJlB1EF7u/tnJz3/SkRB9lYAJlM/cOSsB2folREfHUC
Q5uPsATtFaI7Hbi98RwL0/bVaY+wyAwIOCKo7e5oVHchqJz4nDYHRUDOZw0A1Hdy
Y+Ph3PjtMhjel2rQT+9RLWu/CNR6yyfbvpEThtY9IzYBq+r1L+XBpOhC9W+CcZfw
bwjiHjoNmZUfn4mEqAaDLoX+BQkVlF9VGyY5L/8sJx4KC76TaSmNt2BIs92JiVZz
PAKcn24Ox3TKPc9Keh+HcfqG/S/ob3a3cQ8pR4F6fa3TRHumr8LsqElAfB5ZNmge
5RwSgkiIFTNFcYHO5Eb04ETkNw8m7JwucI9tlvu7AS0z5Rnbutmn89hRjDc/B2hZ
kb10Buayft1AqxF87FVSybY2jj7CipsKz5CksIJ62/Q2x9/MHHpkvRjmLMMxynlg
SwOsAvbcTsI4g+IN7md/m/ftm7GSiWdK7s7goiDYUz49FXPHFmh6WjqpcE9RrFHF
SSqVpO2IvIb5WRbX+8OjrhTV834OdoMCD3sCqVfmH+GFLnyxxs/Yp+PZgLXtrElQ
bHtVf1B6PMUJ/XDWJFzOUc8jzh/n8OVZNGa+vxGJ/bcKEuB9C+k=
=7LvQ
-----END PGP SIGNATURE-----

--lilkrb6lwbhrider--
