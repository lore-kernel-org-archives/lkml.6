Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeA3RRu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 12:17:50 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41094 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeA3RRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 12:17:48 -0500
X-Google-Smtp-Source: AH8x22502/44pBG+eEAJfduAY+UXVC98JSbYFPjeCH8TNzVvCKh7nGl72H3GqTlr1/9K8mDodmlw9g==
Date: Tue, 30 Jan 2018 18:17:45 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] platform/x86: dell-laptop: Allocate buffer on heap
 rather than globally
Message-ID: <20180130171745.i5wwcwr4qdbcoxhm@pali>
References: <1517331540-13266-1-git-send-email-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rrg44bu4xniirhrg"
Content-Disposition: inline
In-Reply-To: <1517331540-13266-1-git-send-email-mario.limonciello@dell.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rrg44bu4xniirhrg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tuesday 30 January 2018 10:59:00 Mario Limonciello wrote:
> There may be race conditions with multiple different functions working
> on a module wide buffer causing one function to get the wrong results.

Yes, this is better. We really do not need to allocate shared buffer in
dell-laptop anymore. Before this buffer was specially allocated in first
4GB addresses space because its physical addresses was passed into SMM.
But now this buffer is not used by SMM anymore (another one is allocated
in dell-smbios* code), so in dell-laptop we can really get rid of shared
buffers, which also simplify code. Working with mutexes and concurrency
always leads to problems and it is better to avoid it.

> Suggested-by: Pali Rohar <pali.rohar@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/platform/x86/dell-laptop.c | 188 ++++++++++++++++++++-----------=
------
>  1 file changed, 103 insertions(+), 85 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/de=
ll-laptop.c
> index fc2dfc8..ab58373 100644
> --- a/drivers/platform/x86/dell-laptop.c
> +++ b/drivers/platform/x86/dell-laptop.c
> @@ -78,7 +78,6 @@ static struct platform_driver platform_driver =3D {
>  	}
>  };
> =20
> -static struct calling_interface_buffer *buffer;
>  static struct platform_device *platform_device;
>  static struct backlight_device *dell_backlight_device;
>  static struct rfkill *wifi_rfkill;
> @@ -322,7 +321,8 @@ static const struct dmi_system_id dell_quirks[] __ini=
tconst =3D {
>  	{ }
>  };
> =20
> -static void dell_set_arguments(u32 arg0, u32 arg1, u32 arg2, u32 arg3)
> +static void dell_set_arguments(struct calling_interface_buffer *buffer,
> +			       u32 arg0, u32 arg1, u32 arg2, u32 arg3)

Hm... this function has too many parameters :-(

What about following API?

static struct calling_interface_buffer dell_set_arguments(u32 arg0, u32 arg=
1, u32 arg2, u32 arg3);

It would return filled structure (not a pointer !) and caller would be
able to use it as:

  struct calling_interface_buffer buffer;
  buffer =3D dell_set_arguments(0x2, 0, 0, 0);
  ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);

And maybe after this change, function dell_set_arguments() could have
better name, e.g. dell_prepare_request() (or dell_prepare_request_buffer)
as "set arguments" is not really what would function do (as it return
something).

  struct calling_interface_buffer buffer;
  buffer =3D dell_prepare_request_buffer(0x2, 0, 0, 0);
  ret =3D dell_send_request(&buffer, CLASS_INFO, SELECT_RFKILL);

Andy, any suggestion or opinion?

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--rrg44bu4xniirhrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWnCotwAKCRCL8Mk9A+RD
UnpTAJoDu5Xud7gk8kw6nsvu6LOaDw1UJQCfVfjASVBiI+pmb+g/WPS5FxmfpEw=
=/qJb
-----END PGP SIGNATURE-----

--rrg44bu4xniirhrg--
