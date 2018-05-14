Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753034AbeENHkH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 03:40:07 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:56773 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752490AbeENHjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 03:39:46 -0400
Date: Mon, 14 May 2018 09:39:34 +0200
From: jacopo mondi <jacopo@jmondi.org>
To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>,
        laurent.pinchart@ideasonboard.com, horms@verge.net.au, geert@glider.be,
        magnus.damm@gmail.com, robh+dt@kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: renesas: draak: Describe HDMI input
Message-ID: <20180514073520.GA5956@w540>
References: <1526032802-14376-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526032802-14376-4-git-send-email-jacopo+renesas@jmondi.org>
 <20180513125755.GQ18974@bigcity.dyn.berto.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="GID0FwUMdk1T2AWN"
Content-Disposition: inline
In-Reply-To: <20180513125755.GQ18974@bigcity.dyn.berto.se>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GID0FwUMdk1T2AWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Niklas,

On Sun, May 13, 2018 at 02:57:55PM +0200, Niklas S=C3=B6derlund wrote:
> Hi Jacopo,
>
> Thanks for your patch.
>
> On 2018-05-11 12:00:02 +0200, Jacopo Mondi wrote:
> > Describe HDMI input connected to VIN4 interface for R-Car D3 Draak
> > development board.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 68 ++++++++++++++++++=
++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm6=
4/boot/dts/renesas/r8a77995-draak.dts
> > index d03f194..e0ce462 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
> > @@ -59,6 +59,17 @@
> >  		};
> >  	};
> >
> > +	hdmi-in {
> > +		compatible =3D "hdmi-connector";
> > +		type =3D "a";
> > +
> > +		port {
> > +			hdmi_con_in: endpoint {
> > +				remote-endpoint =3D <&adv7612_in>;
> > +			};
> > +		};
> > +	};
> > +
> >  	memory@48000000 {
> >  		device_type =3D "memory";
> >  		/* first 128MB is reserved for secure area. */
> > @@ -142,6 +153,11 @@
> >  		groups =3D "usb0";
> >  		function =3D "usb0";
> >  	};
> > +
> > +	vin4_pins: vin4 {
> > +		groups =3D "vin4_data24", "vin4_sync", "vin4_clk", "vin4_clkenb";
> > +		function =3D "vin4";
> > +	};
> >  };
> >
> >  &i2c0 {
> > @@ -154,6 +170,35 @@
> >  		reg =3D <0x50>;
> >  		pagesize =3D <8>;
> >  	};
> > +
> > +	hdmi-decoder@4c {
> > +		compatible =3D "adi,adv7612";
> > +		reg =3D <0x4c>;
> > +		default-input =3D <0>;
> > +
> > +		ports {
> > +			#address-cells =3D <1>;
> > +			#size-cells =3D <0>;
> > +
> > +			port@0 {
> > +				reg =3D <0>;
> > +				adv7612_in: endpoint {
> > +					remote-endpoint =3D <&hdmi_con_in>;
> > +				};
> > +			};
> > +
> > +			port@2 {
> > +				reg =3D <2>;
> > +				adv7612_out: endpoint {
> > +					pclk-sample =3D <0>;
> > +					hsync-active =3D <0>;
> > +					vsync-active =3D <0>;
>
> This differs from the Gen2 DT bindings which is a very similar hardware
> setup using the same components. Defining these properties will make the
> bus marked as V4L2_MBUS_PARALLEL instead of V4L2_MBUS_BT656.

And that's what we want....

>
> This will change how the hardware is configured for capture if the media
> bus is in a UYVY format, see VNMC_INF register in rvin_setup(). Maybe
> this it not an issue here but still I'm curious to why this differ
> between Gen2 and Gen3 :-)

Actually this won't impact the VIN configuration as this is the
'remote endpoint' from VIN perspective and the properties used to
configure the interface are the ones in the 'local endpoint'.

>
> > +
> > +					remote-endpoint =3D <&vin4_in>;
> > +				};
> > +			};
> > +		};
> > +	};
> >  };
> >
> >  &i2c1 {
> > @@ -246,3 +291,26 @@
> >  	timeout-sec =3D <60>;
> >  	status =3D "okay";
> >  };
> > +
> > +&vin4 {
> > +	pinctrl-0 =3D <&vin4_pins>;
> > +	pinctrl-names =3D "default";
> > +
> > +	status =3D "okay";
> > +
> > +	ports {
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <0>;
> > +
> > +		port@0 {
> > +			reg =3D <0>;
> > +
> > +			vin4_in: endpoint {
> > +				hsync-active =3D <0>;
> > +				vsync-active =3D <0>;
>
> Comparing this to the Gen2 bindings some properties are missing,
>
> bus-width =3D <24>;
> pclk-sample =3D <1>;
> data-active =3D <1>;

The VIN driver does not parse them, so there is no value in having
them there, if not confusing people as it happened to me reading the
Gen2 DT.

>
> This is not a big deal as the VIN driver don't use these properties so
> no functional change should come of this but still a difference.

Exactly.

On a side note. I have not seen a way to configure the pixel clock
sampling level in the interface datasheet. The register used to
configure synchronism signals polarities is VnDMR2, and there I read
we can configure HSYNC/VSYNC and CLOCKENB (which is data enable, not
pixel clock) polarities. Is it configured through some other
register?
>
> Over all I'm happy with this change but before I add my tag I would like
> to understand why it differs from the Gen2 configuration for the adv7612
> properties.
>
> Also on a side not it is possible with hardware switches on the board
> switch the VIN4 source to a completely different pipeline CVBS connector
> -> adv7180 -> VIN4. But I think it's best we keep the HDMI as default as
> this seems to be how the boards are shipped. But maybe mentioning this
> in the commit message would not hurt if you end-up resending the patch.

Oh I see. SW-49 to SW-52 enables the HDMI input, SW53-SW54 CVBS one.
And actually, reading the 'initial setting of slide switches' in the
Draak board manual, it turns out that the board default configuration
is with CVBS input selected... What should we do here? reflect
defaults in the DT, or prioritize HDMI?

Thanks
   j

>
> > +
> > +				remote-endpoint =3D <&adv7612_out>;
> > +			};
> > +		};
> > +	};
> > +};
> > --
> > 2.7.4
> >
>
> --
> Regards,
> Niklas S=C3=B6derlund

--GID0FwUMdk1T2AWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa+T02AAoJEHI0Bo8WoVY8BdkP/RPpYXFtZq+D6Av1ZueRiVjJ
+Rd+j2J9zgHO9dzIxy7v4MGMnY13aiCu1NF7Tb9XAYlXvOtJ5ahkX9AmQ/fve/Ir
JMxZzCEgNq/z8JsDsml0yjx7KDSXa+MGJND2QpXWszdSKeeGJdQ1dY+B8UPK1Ubu
ZlyJd+WZBZqDu7TRmJAwID94pmqJ9rkWlCqn723BjlofldOIRi/Sp0kDxGqyUQLF
YQ3HDnEpbIaqp4PhdyXMjnnUjw4j6IfQLekL/xAjXN7CnDt+Ii7gXjh3ljpsr87w
m1rFZLeFYfsejrZ6nWPP1OePQtxJd3anKIB24+Vn8KgXTyT1jNNSAWWRLOKUsO5H
NcA/XJc9w0WRMQikpgmLxpRuEjj+Y9NZ6lXZXLoQeZ+GE41mh7C2S6sgI4VCQaHH
HY6hJp5sgAdparut3u8oUQ11aTMSoyW0mZQtJ813MS37p2ld/mIBVm23oliaJf/6
Fjkjk6Z/iLKdUj6xAci7SaYYoifCqOrYrlkYE255MaMKDhz5CKCyhPxKVwM5DV2q
Dv420PLVEDCA2ZPqLZwuuKMhC+IWGoecDTAet0z5p9RnOV9bSo02xgEV/t7Jcwyf
uilb/2PwlyF1AuW72qXEjSwiKnlg1MXI0yQJPbCnTvEm8lsW8IKzCLRQz50QthnH
OXIEFxo1p6krAUxarvQL
=t/+Q
-----END PGP SIGNATURE-----

--GID0FwUMdk1T2AWN--
