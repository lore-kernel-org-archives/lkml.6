Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932488AbeCLQVW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:21:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:27728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbeCLQVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:21:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,462,1515484800";
   d="p7s'?scan'208";a="24977900"
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "daniel.baluta@nxp.com" <daniel.baluta@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio:magnetometer: Remove duplications in iio_chan_spec
Thread-Topic: [PATCH] iio:magnetometer: Remove duplications in iio_chan_spec
Thread-Index: AQHTtlHJMeGXMsbRnU+fA9qYBhoYkKPNRP8A
Date: Mon, 12 Mar 2018 16:21:17 +0000
Message-ID: <1520871676.15766.205.camel@intel.com>
References: <20180306120011.pbnymd7izt2yxljl@smtp.gmail.com>
         <20180307202044.1d6e66f2@archlinux>
In-Reply-To: <20180307202044.1d6e66f2@archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.54.75.31]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-O1TRNIgdIdlolzR0lKJ4"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-O1TRNIgdIdlolzR0lKJ4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-03-07 at 20:20 +0000, Jonathan Cameron wrote:
> On Tue, 6 Mar 2018 09:00:11 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
>=20
> > The magn_3d_channels array has multiple declarations of
> > iio_chan_spec.
> > Most of the iio_chan_spec are very similar, changing only by the
> > .type
> > and .channel2 field. This patch reduces the code duplication by
> > adding a
> > macro that can replace the iio_chan_spec  repetitions in the
> > magn_3d_channels array.

I don't think it was tested otherwise channel registration would have
failed. See below.

> >=20
> > Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
>=20
> Whilst this looks fine to me, I'd like Srinivas to take a look before
> I apply it as this is his driver.  Please do make sure to cc the
> author.
> Whilst many such email addresses bounce as they have moved on they
> don't always.
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/magnetometer/hid-sensor-magn-3d.c | 83 ++++++---------
> > ------------
> >  1 file changed, 19 insertions(+), 64 deletions(-)
> >=20
> > diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > index a1fd9d591818..fff64711a6c8 100644
> > --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> > @@ -74,72 +74,27 @@ static const u32
> > magn_3d_addresses[MAGN_3D_CHANNEL_MAX] =3D {
> >  	HID_USAGE_SENSOR_ORIENT_TRUE_NORTH,
> >  };
> > =20
> > +#define HID_SENSOR_MAGN_3D_AXIS_CHANNEL(channel_type,
> > characteristic)	\
> > +	{							=09
> > \
> > +		.type =3D channel_type,			=09
> > 	\
> > +		.modified =3D 1,				=09
> > 	\
> > +		.channel2 =3D characteristic,		=09
> > 	\
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),=09
> > 	\
> > +		.info_mask_shared_by_type =3D
> > BIT(IIO_CHAN_INFO_OFFSET) | \
> > +					BIT(IIO_CHAN_INFO_SCALE) |
> > 	\
> > +					BIT(IIO_CHAN_INFO_SAMP_FRE
> > Q) |	\
> > +					BIT(IIO_CHAN_INFO_HYSTERES
> > IS),	\
> > +	}							=09
> > \
> > +
> >  /* Channel definitions */
> >  static const struct iio_chan_spec magn_3d_channels[] =3D {
> > -	{
> > -		.type =3D IIO_MAGN,
> > -		.modified =3D 1,
> > -		.channel2 =3D IIO_MOD_X,
> > -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > -		.info_mask_shared_by_type =3D
> > BIT(IIO_CHAN_INFO_OFFSET) |
> > -		BIT(IIO_CHAN_INFO_SCALE) |
> > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > -	}, {
> > -		.type =3D IIO_MAGN,
> > -		.modified =3D 1,
> > -		.channel2 =3D IIO_MOD_Y,
> > -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > -		.info_mask_shared_by_type =3D
> > BIT(IIO_CHAN_INFO_OFFSET) |
> > -		BIT(IIO_CHAN_INFO_SCALE) |
> > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > -	}, {
> > -		.type =3D IIO_MAGN,
> > -		.modified =3D 1,
> > -		.channel2 =3D IIO_MOD_Z,
> > -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > -		.info_mask_shared_by_type =3D
> > BIT(IIO_CHAN_INFO_OFFSET) |
> > -		BIT(IIO_CHAN_INFO_SCALE) |
> > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > -	}, {
> > -		.type =3D IIO_ROT,
> > -		.modified =3D 1,
> > -		.channel2 =3D IIO_MOD_NORTH_MAGN_TILT_COMP,
> > -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > -		.info_mask_shared_by_type =3D
> > BIT(IIO_CHAN_INFO_OFFSET) |
> > -		BIT(IIO_CHAN_INFO_SCALE) |
> > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > -	}, {
> > -		.type =3D IIO_ROT,
> > -		.modified =3D 1,
> > -		.channel2 =3D IIO_MOD_NORTH_TRUE_TILT_COMP,
> > -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > -		.info_mask_shared_by_type =3D
> > BIT(IIO_CHAN_INFO_OFFSET) |
> > -		BIT(IIO_CHAN_INFO_SCALE) |
> > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > -	}, {
> > -		.type =3D IIO_ROT,
> > -		.modified =3D 1,
> > -		.channel2 =3D IIO_MOD_NORTH_MAGN,
> > -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > -		.info_mask_shared_by_type =3D
> > BIT(IIO_CHAN_INFO_OFFSET) |
> > -		BIT(IIO_CHAN_INFO_SCALE) |
> > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > -	}, {
> > -		.type =3D IIO_ROT,
> > -		.modified =3D 1,
> > -		.channel2 =3D IIO_MOD_NORTH_TRUE,
> > -		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
> > -		.info_mask_shared_by_type =3D
> > BIT(IIO_CHAN_INFO_OFFSET) |
> > -		BIT(IIO_CHAN_INFO_SCALE) |
> > -		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > -		BIT(IIO_CHAN_INFO_HYSTERESIS),
> > -	}
> > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_X),
> > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_Y),
> > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_MAGN, IIO_MOD_Z),
> > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT,
> > IIO_MOD_NORTH_MAGN_TILT_COMP),
> > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT,
> > IIO_MOD_NORTH_TRUE_TILT_COMP),
> > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT,
> > IIO_MOD_NORTH_MAGN),
> > +	HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT,
> > IIO_MOD_NORTH_MAGN),
It should be=20
HID_SENSOR_MAGN_3D_AXIS_CHANNEL(IIO_ROT, IIO_MOD_NORTH_TRUE)

Thanks,
Srinivas
--=-O1TRNIgdIdlolzR0lKJ4
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
aQGEV8ArjHXcotL/yLNh30JyB9sygYzIQadqyFvtvhUyiHwAh7Pf6Gl7Gsz0i/QSq7MK49JvgbUM
F1TCZwc7AgMBAAGjggI9MIICOTAdBgNVHQ4EFgQUf6YLVqF1vjXfk2h4J2GzgJAOB/8wHwYDVR0j
BBgwFoAUHmkqtNwo/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5p
bnRlbC5jb20vcmVwb3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEEuY3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3
dy5pbnRlbC5jb20vcmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJh
c2ljJTIwSXNzdWluZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRl
bC5jb20vMAsGA1UdDwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9
gSiFjp9TgpHACWeB3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMM
MCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBXBgNVHREEUDBOoC0G
CisGAQQBgjcUAgOgHwwdc3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb22BHXNyaW5pdmFzLnBh
bmRydXZhZGFAaW50ZWwuY29tMA0GCSqGSIb3DQEBBQUAA4IBAQDDpWcY9zqtG5P0e1FRJpG/RPQ6
p6sQJHZ5UwykMtYFqBJYOZn9B8koeLEhE4vOAh6v6fgVoCfOvwxJ57BUAdP3jvkbCaLz3r6nUHNr
6w6KwnT9rHykdDjZsRUGs2yP+139qVqoXRHTOLfqvnAzcirjgf4Fz3JRPJZraRWrICBehqhYVfFH
sxxBgOauQ+DTHjZARkomjmrATvlDpLMlN74L/BKZI4rl4R/BjSaLBzAKQnAN0nvWefpPzdeSYuxK
XaN1xDzINPDnmShXSbQzee0h2CvEnIMtPQDM9DJACUi14Cc9y4o7DqRky4r1+XnksN2lKnu83l4E
oSxCkDMhszkFMYICFzCCAhMCAQEwgZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYD
VQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIklu
dGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEECEzMAAK0KIyEkTMbH5OYAAAAArQowCQYF
Kw4DAhoFAKBdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDMx
MjE2MjExNlowIwYJKoZIhvcNAQkEMRYEFB3ZfPGQ9ee0lnZ6JC/BmrGtIRgZMA0GCSqGSIb3DQEB
AQUABIIBAFjelL+dedAgEKbnxIEj5mPQu6fe3j8uD8SqjJhz++pj9jIJH+Lri/6mwynA4gjykKSn
3e9UHsOM6q9UTEqXfRNKqatrgfIPT472ZgqaaD9HObPohPu+FYAQcLMn9ZcZrvLyhBlN5gOmS+5A
WV8eUyT2W1SMISP5V3+oJ4/UvpwxjwQtuBNMoiQBqgUg8utENUBxHZwdH5gyHMX0YsUfLtIKLGTf
FzEWotAVCf3/gQtc1VCM81ip9u7usWZ2mfd/sg+WM9GuYWuw8ejzfEOL+ZWOLOW/nxJA15sz++qx
m+ABTCxXVj55Eq5xdS7K1qlVyIn1je6S8ArSj3WRH5DMuG0AAAAAAAA=


--=-O1TRNIgdIdlolzR0lKJ4--
