Return-Path: <sebastian.reichel@collabora.co.uk>
X-Google-Smtp-Source: AG47ELt1agktqEIej7XLzgfEUtcKtj1rp1WBgxP073OwMIrjJgyr0xZeN9uPPwEScF9IAdhX2WIC
ARC-Seal: i=1; a=rsa-sha256; t=1521813995; cv=none;
        d=google.com; s=arc-20160816;
        b=co+rRe6pqvEO9BCzagJSgKbXB3++SRUxkXVPFWvyz4Rd4TcdazAyKpQrOXkN0D8kZ1
         KXKYTK7mXFkrj4U97jL2gxA/G8t35Zs8IY5fQbbCxoEB2GrhKxlhkmv0uFgUeq2T71EL
         vx1PUGaL+IyIQ8R9Td29hQZM/4EwfcsaZnmj5MwMf6s0oW5YrUDUTHj8KJDcQLSb64Gl
         JR7kQEMc+9jrZUyfbw8+4qRnoabinTGtiD/UOn2VgaNOMDM4EMFzb0AKKZ2QB1ZU3orm
         N5LowQB1q7gjypUCJellxGBZIe7wepjAwMENzDDBcmpRrZa/72gVtvHcB2C/aWxRLCwd
         Zalg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=Gnoymo6uoVEzidHmzOn5r0kxNztLZLSOj1Bje1DUp60=;
        b=SUa2d11wYIsPR42gv3MmbzGNyURkxbN81Gntz3tiEI7LkDCMRPJklYqBl3ykuLtmBL
         Zn+nsL0LMStdUS/ko3aPg+O9EPkpXL+9qvRgV0xRZREH4rm15mBqzKsga9iOMk6lYqkZ
         +PZSO0ggAY4AHp2kkg7XH9wHJp9KOzGhT1lMW1FtfuXdqeusMBoZmwD77FGdALTvQT1H
         u+4nZK0g15kkQe3nod1w/O8sVjYTwbsPTFUeTs5s/FNl9vgr/z3rCLQUoOyiGYKu9ojm
         O0O0xxdd/VTSvqYfPQIvNsD9xIsu+pj9ikDNzCUwJXlbezfLUnQ6+6gtvpGFeJdzEczi
         tiOw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 46.235.227.227 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 46.235.227.227 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Date: Fri, 23 Mar 2018 15:06:32 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>, Nandor Han <nandor.han@ge.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH 1/2] misc: ezport-firmware: new driver
Message-ID: <20180323140631.wt75cwxxrrzdnzse@earth.universe>
References: <20180320172201.2065-1-sebastian.reichel@collabora.co.uk>
 <20180320172201.2065-2-sebastian.reichel@collabora.co.uk>
 <20180323131712.GA32169@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="evha4yhbgfv7a6qq"
Content-Disposition: inline
In-Reply-To: <20180323131712.GA32169@kroah.com>
User-Agent: NeoMutt/20180223
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595478143332183310?=
X-GMAIL-MSGID: =?utf-8?q?1595737632060464869?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--evha4yhbgfv7a6qq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 23, 2018 at 02:17:12PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Mar 20, 2018 at 06:22:00PM +0100, Sebastian Reichel wrote:
> > General Electric Healthcare's PPD has a secondary processor from
> > NXP's Kinetis K20 series. It's firmware can be updated from Linux
> > using the EzPort interface. This driver implements the firmware
> > updating process.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > ---
> >  Documentation/devicetree/bindings/misc/ge-achc.txt |  19 +-
>=20
> Bindings should be in a separate patch, right?

Right.

> > +static int ezport_read_data(struct spi_device *spi, u32 address,
> > +			    u8 *buffer, size_t size)
> > +{
> > +	struct spi_transfer xfers[2] =3D {};
>=20
> You can send SPI data from the stack?

I don't think so:

/**
 * struct spi_transfer - a read/write buffer pair
 * @tx_buf: data to be written (dma-safe memory), or NULL
 * @rx_buf: data to be read (dma-safe memory), or NULL

IIUIC only spi_write_then_read() may use the stack, since the
function copies the provided buffer to a second, DMA capable
buffer. That function is obviously not good for big buffers,
though.

> > +	u8 *query =3D kmalloc(EZPORT_FAST_READ_SIZE, GFP_KERNEL);
> > +	int ret;
> > +
> > +	if (!query)
> > +		return -ENOMEM;
> > +
> > +	query[0] =3D EZPORT_CMD_FAST_READ;
> > +	query[1] =3D address >> 16;
> > +	query[2] =3D address >> 8;
> > +	query[3] =3D address >> 0;
> > +	query[4] =3D EZPORT_DUMMY;
> > +
> > +	xfers[0].len =3D EZPORT_FAST_READ_SIZE;
> > +	xfers[0].tx_buf =3D query;
> > +
> > +	xfers[1].len =3D size;
> > +	xfers[1].rx_buf =3D buffer;
> > +
> > +	ret =3D spi_sync_transfer(spi, xfers, 2);
> > +
> > +	kfree(query);
> > +
> > +	return ret;
> > +}
> > +static DEVICE_ATTR_WO(update_fw);
> > +static DEVICE_ATTR_RO(verify_fw);
>=20
> New sysfs attributes need Documentation/ABI updates please.

Ok.

> Also please fix up the kbuild-reported build errors.

Of course.

> thanks,

Thanks for the review,

-- Sebastian

--evha4yhbgfv7a6qq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq1CeQACgkQ2O7X88g7
+posNQ//RXYEyqUN+5+0VCFjMUul+mHQDLuksYrtpuee06+lKeBF1kvCQRStgNhV
kXzERAm/uJPSLctnqbClLhLxshf7iF1nccYyE/wqLA6jJL5LdswInRZb1iKOgi8R
ivHanKVicNzg7Dz3ev9BpeBe/VQiV5IuVedass0pEAeXIat4+ElN6TLTrb0N8RQv
xIWObaob1b/UZORBAQG9ywE8mi8Vs22Va87/Emx835mSzwvzRlLm7OyjvRsWLxBC
rgu1dOtbcGbNkJV0DROo8/416kPEBT15lII8nYfqAUJKgYjyb/n0pVmtpukvX3aT
yx0fvWaqNzeeZUzzB4+EkmewCIAfnnLpFtkw79Nyg8/oscWCvYxEiKfULDVVvDIe
Z18CJjped5cLNMMnd55N2AMn/MyFfbuOASXJU+L5V48WIvCQ/wn280FFTlFqIACf
u0Jn6m34ZEMIEmoipM/35PPQLo8iq5lSbzieQdkEZgRDTYgCyuGtqWvSLCyfOQmO
uYs0EJD/bKuJSc2cZa/bILAi6Hjtpka2Kd0Ft6glPOCqLufiZWxR/cJ4giBocSwC
X6drsD1HTfQZzskywHq4nge677WQgVUFe/DM2SU0L9uY9cjGexOGmt4c3+OMp077
1A5W//wz6wcdYEY+pzzrFY3LE708aibnadOqfup1AyKEnSVDKuY=
=4QPY
-----END PGP SIGNATURE-----

--evha4yhbgfv7a6qq--
