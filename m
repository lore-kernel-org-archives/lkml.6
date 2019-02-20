Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B4E3C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 254BA2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550662424;
	bh=Fzc6K/4vdGmkqJ9E0Jr/mKiy8L+zWhCwMpgDsVFaFkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PH9S/xvax9vGf8xY7Mr32vCz2SMCopXM8lreXrU9KYkqod9zBatejNwYYH3UaUrao
	 qgUAGCeYzszvvU3qBiiqF3LBTyF/uuN89hJTT3Gly0hudlnqEfu3Js4s4SbmvYj+4M
	 EhKvMED/tKy84Bl16BfHVtBtqXTh0wdjzZm0hU7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfBTLdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:33:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbfBTLdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:33:42 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F92C20851;
        Wed, 20 Feb 2019 11:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550662420;
        bh=Fzc6K/4vdGmkqJ9E0Jr/mKiy8L+zWhCwMpgDsVFaFkY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SBtEJw/tcA4IqHJw4AUTPjBQzmqVPOuwcBcSahaxXwHdBxMyDvV3jyqSqPaCRIPJ0
         wFpiZ1kE9lY99Gn4gqldUJCBZXaHtO6jt9VQouSwmfEGXMupUvEWzyVRkzpBwOWNrj
         PvwiLGDZM9w5qkbtolomeBB1WNYfUpJ3Dvxg5bU8=
Date:   Wed, 20 Feb 2019 11:33:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     Himanshu Jha <himanshujha199640@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "dpfrey@gmail.com" <dpfrey@gmail.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>
Subject: Re: [PATCH] iio/chemical/bme680: Fix SPI read interface
Message-ID: <20190220113334.3ac04bcc@archlinux>
In-Reply-To: <3834f511-7f1b-f94f-6ad6-8e407a6a6e1b@topic.nl>
References: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
        <20190216112722.GA28619@himanshu-Vostro-3559>
        <3834f511-7f1b-f94f-6ad6-8e407a6a6e1b@topic.nl>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 07:03:10 +0000
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> On 16-02-19 12:27, Himanshu Jha wrote:
> > Hello Mike,
> >=20
> > On Fri, Feb 15, 2019 at 02:47:55PM +0100, Mike Looijmans wrote: =20
> >> The SPI interface implementation was completely broken. =20
> >=20
> > My apologies!
> >=20
> > SPI interface caused me a lot of trouble in my project timeline. I tried
> > many different ways to try playing with acpi dsl, printks etc. One
> > of the problem was also that we don't have any facility such `i2cdetect`
> > or instantiate a `new_device` from userspace.
> >=20
> > Are there any methods that one should try to debug SPIs ?
> >   -- excluding the use of Oscilloscope =20
>=20
> Just persisting usually makes it work... Once you're able to read a singl=
e=20
> register, the rest is peanuts...
Agreed on that assessment. It's the first read that sometimes takes ours
of pulling your hair out.

A few comments inline, on the discussion rather than the patch.
Nice work Mike.  We'll definitely want to push this to stable. I'll do
that for v2 if it looks good.  Nothing much will go upstream until
after the merge window closes now anyway which will be about 3 weeks
time.

Jonathan

>=20
> > With all these problems, I referred other drivers from the Bosch family,
> > particularly BME280 which has exactly the same behavior and decided to
> > do the same. I believed that it would also work cleanly for BME680 and
> > now I see the page selection fuzz was the main problem.
> >=20
> > I tried to test it on Beaglebone but everytime something new pops-up
> > with beagle setup such as they moved from capemgr -> uboot overlays.
> > Lack of latest documentation on "What new in this release?" troubled me
> > + most of blogs on setup are outdated.
> >  =20
> >> When using the SPI interface, there are only 7 address bits, the upper=
 bit
> >> is controlled by a page select register. =20
> >=20
> > Isn't it that upper bit is controlled R/W ? =20
>=20
> I meant the upper 'address' bit here. Bit 7 of the first byte indeed cont=
rols=20
> read/write like on many register-controlled SPI devices (see regmap's sta=
ndard=20
> SPI implementation).
>=20
> > And one question that I have in mind:
> >=20
> > Initially after poweron we are in page 0, and hence we can't access
> > Page 1 which actually has the `spi_mem_page` bit. So, how can we switch
> > to Page 1 eventually since Page 1 covers all the relevant data/config
> > registers ? =20
>=20
> My approach was to just assume that the register would work in either pag=
e,=20
> and that turned out to be correct. Most 'paging' chips work that way. Tho=
ugh=20
> they typically use register 0 or 255 for that.
>=20
> > I assume if you're in Page 0, then you can't access Page 1 registers or
> > simply put those registers are not visible.
> >=20
> > Some inconsistency in datasheet:
> >=20
> > Page 24/50:
> >=20
> > "After power-on, spi_mem_page is in its reset state and page 0 (0x80 to=
 0xFF)
> > will be active. Page 1 (0x00 to 0x7F) will be
> > active on setting spi_mem_page to 1."
> >=20
> > OTOH,
> >=20
> > Page 26/50:
> >=20
> > "5.3.1.4 SPI memory map page selection =E2=80=93 spi_mem_page
> >=20
> > In SPI mode complete memory page is accessed using page 0 & page 1.
> > Register spi_mem_page is used for page selection.
> > After power-on, spi_mem_page is in its reset state and
> > page 0(0x00 to 0x7F) will be active."
> >=20
> >=20
> > That's contradicting! =20
>=20
> They fell into their own trap of calling the high range "page 0" I guess.
>=20
> In this context, it's also meaningless. Upon probe, you cannot really be =
sure=20
> which page is active anyway, and the chip doesn't have a reset GPIO to en=
force=20
> a known startup state. So "assume nothing" is the way forward.
>=20
>=20
> > 	page 0 (0x80 to 0xFF) Vs page 0(0x00 to 0x7F) ?
> >  =20
> >> The core needs access to both
> >> ranges, so implement register read/write for both regions. The regmap
> >> paging functionality didn't agree with a register that needs to be read
> >> and modified, so I implemented a custom paging algorithm.
> >>
> >> This fixes that the device wouldn't even probe in SPI mode. =20
> >=20
> > Most importantly: Does it now work for you ? =20
>=20
> Yes, with these changes the chip works (I have it connected to SPI only).
>=20
> > As I tried you patch and it is not working for me in my QEMU setup.
> >=20
> > 	/sys/bus/iio/devices # lsmod
> > 	Module                  Size  Used by    Tainted: G
> > 	bme680_spi             16384  0
> > 	bme680_core            24576  1 bme680_spi
> > 	/sys/bus/iio/devices # ls
> >=20
> > SPI didn't probe and no logs for any errors/warnings as well. =20
>=20
> Probably it isn't in the devicetree then. Mine looks like this:
>=20
> +&spi1 {
> +       status =3D "okay";
> +       num-cs =3D <2>;
> +
> +       /* Environmental Sensor */
> +       bme680_env: bme680_env@0 {
> +               compatible =3D "bme680";
> +               reg =3D <0>;
> +               spi-max-frequency =3D <10000000>;
> +       };
>=20
>=20
> > Maybe I'll give it try again later on a different board or a native
> > build+boot on the current board.
> >=20
> > Anyway, does anyone has any idea/clues for writing a dt-overlay for
> > am335x-boneblack-wireless.dts to add just a compatible property to
> > probe bme680_spi driver ?
> >  =20
> >> The SPI interface then isn't different from I2C, merged them into the =
core,
> >> and the I2C/SPI named registers are no longer needed.
> >>
> >> Implemented register value caching for the registers to reduce the I2C=
/SPI
> >> data transfers considerably.
> >>
> >> The calibration set reads as all zeroes until some undefined point in =
time,
> >> and I couldn't determine what makes it valid. The datasheet mentions t=
hese
> >> registers but does not provide any hints on when they become valid, an=
d they
> >> aren't even enumerated in the memory map. So check the calibration and
> >> retry reading it from the device after each measurement until it provi=
des
> >> something valid. =20
> >=20
> > Hmm. One point I would point out here is that: if calib constants are
> > invalid then without any doubt readings would wrong/disastrous. But I
> > never saw this issue when testing I2C interface. =20
>=20
> It might be timing related. The SPI bus runs at 10MHz, and my platform is=
 a=20
> ZynqMP.
>=20
> My initial idea was to just read everything from page 0 (only chip-id, re=
set,=20
> and calibration data is there) and then switch to page 1 and remain there=
. But=20
> the calibration data always read zero at probe time. Reading the register=
s=20
> again at a later time made them valid.
>=20
> > As for missing info from datasheet, I mean Bosch doesn't even care to
> > reply or involve in the discussions. This driver was also ported to
> > Zephyr project and Pull request lying stale since November. In the end,
> > developers from Nordic Semiconductor who majorly work on BLE and some
> > other stuff took over their work and are now trying to complete it. =20
>=20
> Yeah, there are only few manufacturers who care about drivers. Most seem =
to=20
> think that a bare-metal app or a dedicated 3.1 kernel is all the world wi=
ll=20
> ever need.
>=20
> Most of our hardware developers have learned that software support is oft=
en=20
> more important than price or features.

Absolutely!

>=20
> > Also, look around BSEC(https://www.bosch-sensortec.com/bst/products/all=
_products/bsecreveals)
> > for more info that you may want to know. And go ahead reverse engineeri=
ng[1]
> > their code to know more OR work around and rely on the heuristics[2] th=
at you
> > observe while testing.
> >=20
> > [1] I saw a code snippet in BSEC which says after measurement is comple=
ted in
> >      FORCED mode and data is ready to read, we need to wait for current
> >      mode go in SLEEP mode before actually reading the data.
> >=20
> > [2] One fellow developer few moths ago explained to play with those cal=
ib
> >      constants as well:
> > https://lore.kernel.org/linux-iio/20181215191743.GA1263@himanshu-Vostro=
-3559/
> >=20
> > Then there are many things to rant about. But currently I'm busy with
> > university exams, so I might not be able to work on this till 10th Marc=
h.
> >  =20
> >> Report temperature in millidegrees Celcius instead of degrees. =20
> >=20
> > Jonathan, I didn't know about this but is there any rationale to report
> > in millidegress ?
> >=20
> > I was under the impression that degC is the standard and you would
> > always want you Fitbit/Smart watch to report in degC. Ofcourse,
> > userspace program can convert millideg -> degC =20
>=20
> All IIO drivers report millidegrees. It's probably related to hwmon.

Indeed.  Good guess :)

>=20
>=20
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> >> ---
> >>   drivers/iio/chemical/bme680.h      |   6 +-
> >>   drivers/iio/chemical/bme680_core.c |  54 ++++++++++++++---
> >>   drivers/iio/chemical/bme680_i2c.c  |  21 -------
> >>   drivers/iio/chemical/bme680_spi.c  | 116 +++++++++++++++++++++++++--=
----------
> >>   4 files changed, 126 insertions(+), 71 deletions(-)
> >>
> >> diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme6=
80.h
> >> index 0ae89b87..4edc5d21 100644
> >> --- a/drivers/iio/chemical/bme680.h
> >> +++ b/drivers/iio/chemical/bme680.h
> >> @@ -2,11 +2,9 @@
> >>   #ifndef BME680_H_
> >>   #define BME680_H_
> >>  =20
> >> -#define BME680_REG_CHIP_I2C_ID			0xD0
> >> -#define BME680_REG_CHIP_SPI_ID			0x50
> >> +#define BME680_REG_CHIP_ID			0xD0
> >>   #define   BME680_CHIP_ID_VAL			0x61
> >> -#define BME680_REG_SOFT_RESET_I2C		0xE0
> >> -#define BME680_REG_SOFT_RESET_SPI		0x60
> >> +#define BME680_REG_SOFT_RESET			0xE0
> >>   #define   BME680_CMD_SOFTRESET			0xB6
> >>   #define BME680_REG_STATUS			0x73
> >>   #define   BME680_SPI_MEM_PAGE_BIT		BIT(4)
> >> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical=
/bme680_core.c
> >> index 70c1fe4..ccde4c6 100644
> >> --- a/drivers/iio/chemical/bme680_core.c
> >> +++ b/drivers/iio/chemical/bme680_core.c
> >> @@ -63,9 +63,23 @@ struct bme680_data {
> >>   	s32 t_fine;
> >>   };
> >>  =20
> >> +static const struct regmap_range bme680_volatile_ranges[] =3D {
> >> +	regmap_reg_range(BME680_REG_MEAS_STAT_0, BME680_REG_GAS_R_LSB),
> >> +	regmap_reg_range(BME680_REG_STATUS, BME680_REG_STATUS),
> >> +	regmap_reg_range(BME680_T2_LSB_REG, BME680_GH3_REG),
> >> +};
> >> +
> >> +static const struct regmap_access_table bme680_volatile_table =3D {
> >> +	.yes_ranges	=3D bme680_volatile_ranges,
> >> +	.n_yes_ranges	=3D ARRAY_SIZE(bme680_volatile_ranges),
> >> +};
> >> +
> >>   const struct regmap_config bme680_regmap_config =3D {
> >>   	.reg_bits =3D 8,
> >>   	.val_bits =3D 8,
> >> +	.max_register =3D 0xef, =20
> >=20
> > Any reason for 0xEF ? =20
>=20
> It's what I calculated the highest possibly address to be. It mostly affe=
cts=20
> debugging (/sys/kernel/debug/regmap).
>=20
>=20
> >> +	.volatile_table =3D &bme680_volatile_table,
> >> +	.cache_type =3D REGCACHE_RBTREE,
> >>   };
> >>   EXPORT_SYMBOL(bme680_regmap_config);
> >>  =20
> >> @@ -316,6 +330,10 @@ static s16 bme680_compensate_temp(struct bme680_d=
ata *data,
> >>   	s64 var1, var2, var3;
> >>   	s16 calc_temp;
> >>  =20
> >> +	/* If the calibration is invalid, attempt to reload it */
> >> +	if (!calib->par_t2)
> >> +		bme680_read_calib(data, calib); =20
> >=20
> > How did you observe this behavior ? Was the readings not correct before=
 ? =20
>=20
> I always read back either zeroes or valid data from the calibration data.=
 If=20
> par_t2 is zero, it nulls the temperature readout, so it must have a non-z=
ero=20
> value to be valid.
>=20
> I think the chips needs at least a 'forced' mode before it actually loads=
=20
> these, or maybe they're just in a memory region that so slow that it take=
s the=20
> chip seconds to read them into its register space.
>=20
> The datasheet doesn't mention much about these registers at all, so this =
is=20
> the best I could come up with.
>=20
>=20
> >  =20
> >>   	var1 =3D (adc_temp >> 3) - (calib->par_t1 << 1);
> >>   	var2 =3D (var1 * calib->par_t2) >> 11;
> >>   	var3 =3D ((var1 >> 1) * (var1 >> 1)) >> 12;
> >> @@ -583,8 +601,7 @@ static int bme680_gas_config(struct bme680_data *d=
ata)
> >>   	return ret;
> >>   }
> >>  =20
> >> -static int bme680_read_temp(struct bme680_data *data,
> >> -			    int *val, int *val2)
> >> +static int bme680_read_temp(struct bme680_data *data, int *val)
> >>   {
> >>   	struct device *dev =3D regmap_get_device(data->regmap);
> >>   	int ret;
> >> @@ -617,10 +634,9 @@ static int bme680_read_temp(struct bme680_data *d=
ata,
> >>   	 * compensate_press/compensate_humid to get compensated
> >>   	 * pressure/humidity readings.
> >>   	 */
> >> -	if (val && val2) {
> >> -		*val =3D comp_temp;
> >> -		*val2 =3D 100;
> >> -		return IIO_VAL_FRACTIONAL;
> >> +	if (val) {
> >> +		*val =3D comp_temp * 10; /* Centidegrees to millidegrees */
> >> +		return IIO_VAL_INT;
> >>   	}
> >>  =20
> >>   	return ret;
> >> @@ -635,7 +651,7 @@ static int bme680_read_press(struct bme680_data *d=
ata,
> >>   	s32 adc_press;
> >>  =20
> >>   	/* Read and compensate temperature to get a reading of t_fine */
> >> -	ret =3D bme680_read_temp(data, NULL, NULL);
> >> +	ret =3D bme680_read_temp(data, NULL);
> >>   	if (ret < 0)
> >>   		return ret;
> >>  =20
> >> @@ -668,7 +684,7 @@ static int bme680_read_humid(struct bme680_data *d=
ata,
> >>   	u32 comp_humidity;
> >>  =20
> >>   	/* Read and compensate temperature to get a reading of t_fine */
> >> -	ret =3D bme680_read_temp(data, NULL, NULL);
> >> +	ret =3D bme680_read_temp(data, NULL);
> >>   	if (ret < 0)
> >>   		return ret;
> >>  =20
> >> @@ -761,7 +777,7 @@ static int bme680_read_raw(struct iio_dev *indio_d=
ev,
> >>   	case IIO_CHAN_INFO_PROCESSED:
> >>   		switch (chan->type) {
> >>   		case IIO_TEMP:
> >> -			return bme680_read_temp(data, val, val2);
> >> +			return bme680_read_temp(data, val);
> >>   		case IIO_PRESSURE:
> >>   			return bme680_read_press(data, val, val2);
> >>   		case IIO_HUMIDITYRELATIVE:
> >> @@ -867,8 +883,28 @@ int bme680_core_probe(struct device *dev, struct =
regmap *regmap,
> >>   {
> >>   	struct iio_dev *indio_dev;
> >>   	struct bme680_data *data;
> >> +	unsigned int val;
> >>   	int ret;
> >>  =20
> >> +	ret =3D regmap_write(regmap, BME680_REG_SOFT_RESET,
> >> +			   BME680_CMD_SOFTRESET);
> >> +	if (ret < 0) {
> >> +		dev_err(dev, "Failed to reset chip\n");
> >> +		return ret;
> >> +	} =20
> >=20
> > FYI Bosch commented to me earlier:
> >=20
> > "It is recommended but not mandatory. The idea behind the soft
> >   reset is to get the driver in sync with the sensor and the
> >   fastest way to do so is via a soft reset."
> >=20
> > But its good to keep it, nevermind .. =20
>=20
> This initialization block was just moved from the SPI and I2C parts into =
the=20
> core, no change in behaviour.
>=20
> >  =20
> >> +	ret =3D regmap_read(regmap, BME680_REG_CHIP_ID, &val);
> >> +	if (ret < 0) {
> >> +		dev_err(dev, "Error reading chip ID\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	if (val !=3D BME680_CHIP_ID_VAL) {
> >> +		dev_err(dev, "Wrong chip ID, got %x expected %x\n",
> >> +				val, BME680_CHIP_ID_VAL);
> >> +		return -ENODEV;
> >> +	}
> >> +
> >>   	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> >>   	if (!indio_dev)
> >>   		return -ENOMEM;
> >> diff --git a/drivers/iio/chemical/bme680_i2c.c b/drivers/iio/chemical/=
bme680_i2c.c
> >> index 06d4be5..cfc4449 100644
> >> --- a/drivers/iio/chemical/bme680_i2c.c
> >> +++ b/drivers/iio/chemical/bme680_i2c.c
> >> @@ -23,8 +23,6 @@ static int bme680_i2c_probe(struct i2c_client *clien=
t,
> >>   {
> >>   	struct regmap *regmap;
> >>   	const char *name =3D NULL;
> >> -	unsigned int val;
> >> -	int ret;
> >>  =20
> >>   	regmap =3D devm_regmap_init_i2c(client, &bme680_regmap_config);
> >>   	if (IS_ERR(regmap)) {
> >> @@ -33,25 +31,6 @@ static int bme680_i2c_probe(struct i2c_client *clie=
nt,
> >>   		return PTR_ERR(regmap);
> >>   	}
> >>  =20
> >> -	ret =3D regmap_write(regmap, BME680_REG_SOFT_RESET_I2C,
> >> -			   BME680_CMD_SOFTRESET);
> >> -	if (ret < 0) {
> >> -		dev_err(&client->dev, "Failed to reset chip\n");
> >> -		return ret;
> >> -	}
> >> -
> >> -	ret =3D regmap_read(regmap, BME680_REG_CHIP_I2C_ID, &val);
> >> -	if (ret < 0) {
> >> -		dev_err(&client->dev, "Error reading I2C chip ID\n");
> >> -		return ret;
> >> -	}
> >> -
> >> -	if (val !=3D BME680_CHIP_ID_VAL) {
> >> -		dev_err(&client->dev, "Wrong chip ID, got %x expected %x\n",
> >> -				val, BME680_CHIP_ID_VAL);
> >> -		return -ENODEV;
> >> -	}
> >> -
> >>   	if (id)
> >>   		name =3D id->name;
> >>  =20
> >> diff --git a/drivers/iio/chemical/bme680_spi.c b/drivers/iio/chemical/=
bme680_spi.c
> >> index c9fb05e..e130715 100644
> >> --- a/drivers/iio/chemical/bme680_spi.c
> >> +++ b/drivers/iio/chemical/bme680_spi.c
> >> @@ -11,28 +11,94 @@
> >>  =20
> >>   #include "bme680.h"
> >>  =20
> >> +struct bme680_spi_bus_context {
> >> +	struct spi_device *spi;
> >> +	u8 current_page;
> >> +};
> >> +
> >> +/*
> >> + * In SPI mode there are only 7 address bits, a "page" register deter=
mines
> >> + * which part of the 8-bit range is active. This function looks at th=
e address
> >> + * and writes the page selection bit if needed
> >> + */
> >> +static int bme680_regmap_spi_select_page(
> >> +	struct bme680_spi_bus_context *ctx, u8 reg)
> >> +{
> >> +	struct spi_device *spi =3D ctx->spi;
> >> +	int ret;
> >> +	u8 buf[2];
> >> +	u8 page =3D (reg & 0x80) ? 0 : 1; /* Page "1" is low range */
> >> +
> >> +	if (page =3D=3D ctx->current_page)
> >> +		return 0;
> >> +
> >> +	/*
> >> +	 * Data sheet claims we're only allowed to change bit 4, so we must =
do
> >> +	 * a read-modify-write on each and every page select
> >> +	 */
> >> +	buf[0] =3D BME680_REG_STATUS;
> >> +	ret =3D spi_write_then_read(spi, buf, 1, buf + 1, 1);
> >> +	if (ret < 0) {
> >> +		dev_err(&spi->dev, "failed to set page %u\n", page);
> >> +		return ret;
> >> +	}
> >> +
> >> +	buf[0] =3D BME680_REG_STATUS;
> >> +	if (page)
> >> +		buf[1] |=3D BME680_SPI_MEM_PAGE_BIT;
> >> +	else
> >> +		buf[1] &=3D ~BME680_SPI_MEM_PAGE_BIT;
> >> +
> >> +	ret =3D spi_write(spi, buf, 2);
> >> +	if (ret < 0) {
> >> +		dev_err(&spi->dev, "failed to set page %u\n", page);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ctx->current_page =3D page;
> >> +
> >> +	return 0;
> >> +} =20
> >=20
> > I will take another look at this later as my head is spinning now ...
> >  =20
> >>   static int bme680_regmap_spi_write(void *context, const void *data,
> >>   				   size_t count)
> >>   {
> >> -	struct spi_device *spi =3D context;
> >> +	struct bme680_spi_bus_context *ctx =3D context;
> >> +	struct spi_device *spi =3D ctx->spi;
> >> +	int ret;
> >>   	u8 buf[2];
> >>  =20
> >>   	memcpy(buf, data, 2);
> >> +
> >> +	ret =3D bme680_regmap_spi_select_page(ctx, buf[0]);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >>   	/*
> >>   	 * The SPI register address (=3D full register address without bit =
7)
> >>   	 * and the write command (bit7 =3D RW =3D '0')
> >>   	 */
> >>   	buf[0] &=3D ~0x80;
> >>  =20
> >> -	return spi_write_then_read(spi, buf, 2, NULL, 0);
> >> +	return spi_write(spi, buf, 2);
> >>   }
> >>  =20
> >>   static int bme680_regmap_spi_read(void *context, const void *reg,
> >>   				  size_t reg_size, void *val, size_t val_size)
> >>   {
> >> -	struct spi_device *spi =3D context;
> >> +	struct bme680_spi_bus_context *ctx =3D context;
> >> +	struct spi_device *spi =3D ctx->spi;
> >> +	int ret;
> >> +	u8 addr =3D *(const u8 *)reg;
> >> +	u8 addr7; =20
> >=20
> > Unused variable. =20
>=20
> Indeed. Will need a v2.
>=20
> >  =20
> >> +	ret =3D bme680_regmap_spi_select_page(ctx, addr);
> >> +	if (ret)
> >> +		return ret;
> >>  =20
> >> -	return spi_write_then_read(spi, reg, reg_size, val, val_size);
> >> +	addr |=3D 0x80; /* bit7 =3D RW =3D '1' */
> >> +
> >> +	return spi_write_then_read(spi, &addr, 1, val, val_size);
> >>   }
> >>  =20
> >>   static struct regmap_bus bme680_regmap_bus =3D {
> >> @@ -45,8 +111,8 @@ static int bme680_regmap_spi_read(void *context, co=
nst void *reg,
> >>   static int bme680_spi_probe(struct spi_device *spi)
> >>   {
> >>   	const struct spi_device_id *id =3D spi_get_device_id(spi);
> >> +	struct bme680_spi_bus_context *bus_context;
> >>   	struct regmap *regmap;
> >> -	unsigned int val;
> >>   	int ret;
> >>  =20
> >>   	spi->bits_per_word =3D 8;
> >> @@ -56,45 +122,21 @@ static int bme680_spi_probe(struct spi_device *sp=
i)
> >>   		return ret;
> >>   	}
> >>  =20
> >> +	bus_context =3D devm_kzalloc(&spi->dev, sizeof(*bus_context), GFP_KE=
RNEL);
> >> +	if (!bus_context)
> >> +		return -ENOMEM;
> >> +
> >> +	bus_context->spi =3D spi;
> >> +	bus_context->current_page =3D 0xff; /* Undefined on warm boot */ =20
> >=20
> > OK. This is what you observed.
> >=20
> > If this patch works as expected then I think a "Fixes:" tag should be
> > added while marking it for stable ?
> >=20
> > Thanks for the patch Mike and apologies again for the whole mess.
> >  =20
>=20
> You're welcome.

Nice work Mike.

Jonathan
